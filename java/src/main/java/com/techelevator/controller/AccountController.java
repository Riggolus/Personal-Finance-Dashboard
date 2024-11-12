package com.techelevator.controller;


import com.techelevator.dao.AccountDao;
import com.techelevator.dao.UserDao;
import com.techelevator.model.Account;
import com.techelevator.model.AccountDto;
import com.techelevator.model.User;
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
    private final UserDao userDao;

    @Autowired
    public AccountController(AccountDao accountDao, UserDao userDao) {

        this.accountDao = accountDao;
        this.userDao = userDao;
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

    @PutMapping
    public Boolean editAccount(@RequestBody AccountDto accountDto, Principal principal){
        return accountDao.editAccount(accountDto, principal);
    }

}
