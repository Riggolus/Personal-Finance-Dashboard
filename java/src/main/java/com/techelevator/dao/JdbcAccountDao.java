package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Account;
import com.techelevator.model.AccountDto;
import com.techelevator.model.User;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.time.LocalDateTime;

@Component
public class JdbcAccountDao implements AccountDao{

    private final JdbcTemplate jdbcTemplate;
    private final JdbcUserDao jdbcUserDao;

    public JdbcAccountDao(JdbcTemplate jdbcTemplate, JdbcUserDao jdbcUserDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.jdbcUserDao = jdbcUserDao;
    }


    @Override
    public Account getAccountByUserId(int userId) {
        String sql = "SELECT * FROM accounts WHERE user_id = ?;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, userId);
            if (results.next()) {
                return mapRowToAccount(results);
            } else {
                return null;
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
    }

    @Override
    public Account createAccount(AccountDto accountDto, Principal principal) {
        User user = jdbcUserDao.getUserByUsername(principal.getName());
        String sql = "INSERT INTO accounts (user_id, first_name, last_name, email, phone) " +
                "VALUES (?, ?, ?, ?, ?) RETURNING account_id, user_id, first_name, last_name, email, phone, created_at, updated_at";

        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql,
                    user.getId(),
                    accountDto.getFirstName(),
                    accountDto.getLastName(),
                    accountDto.getEmail(),
                    accountDto.getPhone()
            );

            if (results.next()) {
                return mapRowToAccount(results);
            } else {
                throw new DaoException("Failed to create account: no data returned");
            }

        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data Integrity violation", e);
        }
    }

    @Override
    public boolean editAccount(AccountDto accountDto, Principal principal) {
        int rowsAffected = 0;
        User user = jdbcUserDao.getUserByUsername(principal.getName());
        String sql = "UPDATE accounts SET first_name = ?, last_name = ?, email = ?, phone = ? " +
                "WHERE user_id = ?;";
        try {
            rowsAffected = jdbcTemplate.update(sql, accountDto.getFirstName(), accountDto.getLastName(),
                    accountDto.getEmail(), accountDto.getPhone(), user.getId());
            if (rowsAffected != 0) {
                return true;
            } else {
                return false;
            }
        } catch(CannotGetJdbcConnectionException e){
            throw new DaoException("cannot connect to database",e);
        } catch (DataIntegrityViolationException e){
            throw new DaoException("Violation of data integrity", e);
        }
    }

    private Account mapRowToAccount(SqlRowSet rs){
        Account account = new Account();
        account.setAccountId(rs.getInt("account_id"));
        account.setUserId(rs.getInt("user_id"));
        account.setFirstName(rs.getString("first_name"));
        account.setLastName(rs.getString("last_name"));
        account.setEmail(rs.getString("email"));
        account.setPhone(rs.getString("phone"));
        account.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        account.setUpdatedAt(rs.getTimestamp("updated_at").toLocalDateTime());
        return account;
    }
    // Utility method to convert Timestamp to LocalDateTime
//    private LocalDateTime mapTimestampToLocalDateTime(java.sql.Timestamp timestamp) {
//        if (timestamp != null) {
//            return timestamp.toLocalDateTime();
//        } else {
//            return null;
//        }
//    }
}
