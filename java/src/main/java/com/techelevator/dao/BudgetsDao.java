package com.techelevator.dao;

import com.techelevator.model.Budgets;
import com.techelevator.model.BudgetsDto;

import java.security.Principal;
import java.util.List;

public interface BudgetsDao {
    Budgets createBudget(BudgetsDto budgetsDto, Principal principal);

    List<Budgets> getBudgets(Principal principal);

    Budgets getBudgetByBudgetId(int BudgetId);

    boolean updateBudget(Budgets budgets);

    boolean deleteBudget(int budgetId);
}
