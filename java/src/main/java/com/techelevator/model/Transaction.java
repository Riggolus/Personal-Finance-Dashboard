package com.techelevator.model;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class Transaction {
    private int transactionId;
    private int accountId;
    private String type;
    private BigDecimal amount;
    private String category;
    private LocalDate date;
    private String notes;
    private LocalDateTime createAt;
    private LocalDateTime updatedAt;

    //Constructors
    public Transaction() {}

    public Transaction(int transactionId, int accountId, String type, BigDecimal amount, String category, LocalDate date, String notes) {
        this.transactionId = transactionId;
        this.accountId = accountId;
        this.type = type;
        this.amount = amount;
        this.category = category;
        this.date = date;
        this.notes = notes;
    }

    //Getters and Setters

    public int getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(int transactionId) {
        this.transactionId = transactionId;
    }

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

    public LocalDateTime getCreateAt() {
        return createAt;
    }

    public void setCreateAt(LocalDateTime createAt) {
        this.createAt = createAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
