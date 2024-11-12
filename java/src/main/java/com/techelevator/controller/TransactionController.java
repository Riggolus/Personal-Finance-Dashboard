package com.techelevator.controller;

import com.techelevator.dao.TransactionDao;
import com.techelevator.model.Transaction;
import com.techelevator.model.TransactionDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping
    public Transaction createTransaction(@RequestBody TransactionDto transactionDto, Principal principal){
        return transactionDao.createTransaction(transactionDto, principal);
    }

    @PutMapping
    public boolean updateTransaction(@RequestBody Transaction transaction){
        return  transactionDao.updateTransaction(transaction);
    }


}
