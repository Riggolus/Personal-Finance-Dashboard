package com.techelevator.dao;

import com.techelevator.model.Transaction;
import com.techelevator.model.TransactionDto;

import java.security.Principal;
import java.util.List;

public interface TransactionDao {

    List<Transaction> getAllTransactionsFromUser(Principal principal);

    Transaction createTransaction(TransactionDto transactionDto, Principal principal);

    boolean updateTransaction(Transaction transaction);

    boolean deleteTransaction(int transactionId);
}
