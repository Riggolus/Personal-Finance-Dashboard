package com.techelevator.controller;


import com.techelevator.dao.AccountDao;
import com.techelevator.model.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.web.bind.annotation.*;

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

}
