package com.techelevator.controller;

import com.techelevator.dao.BudgetsDao;
import com.techelevator.model.Budgets;
import com.techelevator.model.BudgetsDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/budgets")
@PreAuthorize("isAuthenticated()")
public class BudgetsController {

    private final BudgetsDao budgetsDao;

    @Autowired
    public BudgetsController(BudgetsDao budgetsDao){
        this.budgetsDao = budgetsDao;
    }

    @PostMapping
    public Budgets createBudget(@RequestBody BudgetsDto budgetsDto, Principal principal){
        return budgetsDao.createBudget(budgetsDto, principal);
    }

    @GetMapping
    public List<Budgets> getBudgets(Principal principal){
        return budgetsDao.getBudgets(principal);
    }

}
