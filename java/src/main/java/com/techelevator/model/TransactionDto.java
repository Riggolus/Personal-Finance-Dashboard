package com.techelevator.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class TransactionDto {
    private int accountId;
    private String type;
    private BigDecimal amount;
    private String category;
    private LocalDate date;
    private String notes;


    //Constructors
    public TransactionDto() {}

    public TransactionDto(int accountId, String type, BigDecimal amount, String category, LocalDate date, String notes) {
        this.accountId = accountId;
        this.type = type;
        this.amount = amount;
        this.category = category;
        this.date = date;
        this.notes = notes;
    }

    //Getters and Setters
    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
