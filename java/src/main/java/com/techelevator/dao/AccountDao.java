package com.techelevator.dao;

import com.techelevator.model.Account;
import com.techelevator.model.AccountDto;

import java.security.Principal;

public interface AccountDao {
    Account getAccountByUserId(int userId);

    Account createAccount(AccountDto accountDto, Principal principal);


}
