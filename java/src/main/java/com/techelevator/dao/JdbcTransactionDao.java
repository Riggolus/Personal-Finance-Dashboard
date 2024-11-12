package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Transaction;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcTransactionDao implements TransactionDao{
    private final JdbcTemplate jdbcTemplate;
    private final UserDao userDao;
    private final AccountDao accountDao;

    public JdbcTransactionDao(JdbcTemplate jdbcTemplate, UserDao userDao, AccountDao accountDao){
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
        this.accountDao = accountDao;
    }

    @Override
    public List<Transaction> getAllTransactionsFromUser(Principal principal) {
        List<Transaction> transactions= new ArrayList<>();
        //meaty way of getting account Id that I'm proud of
        int accountId =  accountDao.getAccountByUserId(userDao.getUserByUsername(principal.getName()).getId()).getAccountId();
        String sql = "SELECT * FROM transactions WHERE account_id = ? " +
                "ORDER BY date;";
        try{
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, accountId);
            while (results.next()) {
                Transaction transaction = mapToRow(results);
                transactions.add(transaction);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Cannot connect to database");
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data Integrity Violation");
        }

        return transactions;
    }


    public Transaction mapToRow(SqlRowSet sqlRowSet){
        Transaction transaction = new Transaction();
        transaction.setTransactionId(sqlRowSet.getInt("transaction_id"));
        transaction.setAccountId(sqlRowSet.getInt("account_id"));
        transaction.setType(sqlRowSet.getString("type"));
        transaction.setAmount(sqlRowSet.getBigDecimal("amount"));
        transaction.setCategory(sqlRowSet.getString("category"));
        transaction.setDate(sqlRowSet.getDate("date").toLocalDate());
        transaction.setNotes(sqlRowSet.getString("notes"));

        // Time is a flat circle
        Timestamp createdAtTimestamp = sqlRowSet.getTimestamp("created_at");
        Timestamp updatedAtTimestamp = sqlRowSet.getTimestamp("updated_at");

        if (createdAtTimestamp != null) {
            transaction.setCreateAt(createdAtTimestamp.toLocalDateTime());
        }
        if (updatedAtTimestamp != null) {
            transaction.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        return transaction;
    }
}
