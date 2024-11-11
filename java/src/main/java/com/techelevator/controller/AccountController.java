package com.techelevator.controller;


import com.techelevator.dao.AccountDao;
import com.techelevator.model.Account;
import com.techelevator.model.AccountDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;

@RestController
@CrossOrigin
@RequestMapping("/account")
@PreAuthorize("isAuthenticated()")
public class AccountController {

    private final AccountDao accountDao;

    @Autowired
    public AccountController(AccountDao accountDao) {
        this.accountDao = accountDao;
    }

    @GetMapping("/{userId}")
    public Account accountByUserId(@PathVariable("userId") int userId) {
        Account account = accountDao.getAccountByUserId(userId);
        return account;
    }

    @PostMapping
    public Account createAccount(@RequestBody AccountDto accountDto, Principal principal) {
        Account account = accountDao.createAccount(accountDto, principal);
        return account;
    }

}
