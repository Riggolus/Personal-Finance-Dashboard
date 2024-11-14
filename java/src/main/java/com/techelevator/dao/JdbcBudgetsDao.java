package com.techelevator.dao;

import com.techelevator.model.Budgets;
import com.techelevator.model.BudgetsDto;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.sql.Timestamp;
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
        String sql = "INSERT INTO budgets ()"
        return null;
    }

    @Override
    public List<Budgets> getBudgets(Principal principal) {
        return List.of();
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
