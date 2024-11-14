package com.techelevator.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class BudgetsDto {
    private int accountId;
    private String category;
    private BigDecimal amountLimit;
    private LocalDate startDate;
    private LocalDate endDate;


    // Constructors
    public BudgetsDto() {}

    public BudgetsDto(String category, BigDecimal amountLimit, LocalDate startDate, LocalDate endDate) {
        this.category = category;
        this.amountLimit = amountLimit;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters and Setters
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public BigDecimal getAmountLimit() {
        return amountLimit;
    }

    public void setAmountLimit(BigDecimal amountLimit) {
        this.amountLimit = amountLimit;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }
}
