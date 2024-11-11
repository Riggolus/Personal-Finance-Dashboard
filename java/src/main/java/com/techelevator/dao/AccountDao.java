package com.techelevator.dao;

import com.techelevator.model.Account;
import com.techelevator.model.AccountDto;

public interface AccountDao {
    Account getAccountByUserId(int userId);

    Account createAccount(AccountDto accountDto);


}
