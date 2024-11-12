package com.techelevator.controller;

import com.techelevator.dao.TransactionDao;
import com.techelevator.model.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/transactions")
@PreAuthorize("isAuthenticated()")
public class TransactionController {

    private final TransactionDao transactionDao;

    @Autowired
    public TransactionController(TransactionDao transactionDao) {
        this.transactionDao = transactionDao;
    }

    @GetMapping
    public List<Transaction> getTransactions(Principal principal){
        return transactionDao.getAllTransactionsFromUser(principal);
    }


}
