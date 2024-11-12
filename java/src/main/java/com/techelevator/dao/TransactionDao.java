package com.techelevator.dao;

import com.techelevator.model.Transaction;

import java.security.Principal;
import java.util.List;

public interface TransactionDao {

    List<Transaction> getAllTransactionsFromUser(Principal principal);

}
