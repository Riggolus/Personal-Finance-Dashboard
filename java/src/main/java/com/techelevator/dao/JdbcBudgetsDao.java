package com.techelevator.dao;

import com.techelevator.exception.DaoException;
import com.techelevator.model.Budgets;
import com.techelevator.model.BudgetsDto;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Component
public class JdbcBudgetsDao implements BudgetsDao{
    private final JdbcTemplate jdbcTemplate;
    private final UserDao userDao;
    private final AccountDao accountDao;

    public JdbcBudgetsDao(JdbcTemplate jdbcTemplate, UserDao userDao, AccountDao accountDao) {
        this.jdbcTemplate = jdbcTemplate;
        this.userDao = userDao;
        this.accountDao = accountDao;
    }

    @Override
    public Budgets createBudget(BudgetsDto budgetsDto) {
        Budgets budget = new Budgets();
        String sql = "INSERT INTO budgets (account_id, category, amount_limit, " +
                "start_date, end_date) VALUES (?,?,?,?,?);";
        try {
            int budgetId = jdbcTemplate.queryForObject(sql, int.class, budgetsDto.getAccountId(),
                     budgetsDto.getCategory(), budgetsDto.getAmountLimit(), budgetsDto.getStartDate(),
                    budgetsDto.getEndDate());
            budget = getBudgetByBudgetId(budgetId);
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        } catch (DataIntegrityViolationException e) {
            throw new DaoException("Data integrity violation", e);
        }
        return budget;
    }

    @Override
    public Budgets getBudgetByBudgetId(int budgetId) {
        Budgets budgets = null;
        String sql = "SELECT * FROM budgets WHERE budget_id = ?;";
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, budgetId);
            if (results.next()){
                budgets = mapToRow(results);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
        return budgets;
    }

    @Override
    public List<Budgets> getBudgets(Principal principal) {
        List<Budgets> budgetsList = new ArrayList<>();
        String sql = "SELECT * FROM budgets WHERE account_id = ?;";
        int accountId =  accountDao.getAccountByUserId(userDao.getUserByUsername(principal.getName()).getId()).getAccountId();
        try {
            SqlRowSet results = jdbcTemplate.queryForRowSet(sql, accountId);
            while (results.next()){
                Budgets budgets = mapToRow(results);
                budgetsList.add(budgets);
            }
        } catch (CannotGetJdbcConnectionException e) {
            throw new DaoException("Unable to connect to server or database", e);
        }
        return budgetsList;
    }

    @Override
    public boolean updateBudget(Budgets budgets) {
        return false;
    }

    @Override
    public boolean deleteBudget(int budgetId) {
        return false;
    }

    public Budgets mapToRow(SqlRowSet sqlRowSet){
        Budgets budgets = new Budgets();
        budgets.setBudgetId(sqlRowSet.getInt("budget_id"));
        budgets.setAccountId(sqlRowSet.getInt("account_id"));
        budgets.setCategory(sqlRowSet.getString("category"));
        budgets.setAmountLimit(sqlRowSet.getBigDecimal("amount_limit"));
        budgets.setStartDate(sqlRowSet.getDate("start_date").toLocalDate());
        budgets.setEndDate(sqlRowSet.getDate("end_date").toLocalDate());

        Timestamp createdAtTimestamp = sqlRowSet.getTimestamp("created_at");
        Timestamp updatedAtTimestamp = sqlRowSet.getTimestamp("updated_at");

        if (createdAtTimestamp != null) {
            budgets.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        if (updatedAtTimestamp != null) {
            budgets.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        return budgets;
    }
}
