<template>
    <div id="main">
        <div id="transaction-logger">
            <button @click="showTransactionForm = !showTransactionForm">
                <div v-if="!showTransactionForm">+ Transaction</div>
                <div v-else>Cancel</div>
            </button>
            <form action="">
                <div v-if="showTransactionForm">
                    <label for="type">Type:</label>
                    <select name="type" id="type" v-model="this.transaction.type">
                        <option value="expense">Expense</option>
                        <option value="income">Income</option>
                    </select>
                    
                    <label for="category">Category:</label>
                        <select name="category" id="category" v-if="this.transaction.type == 'income'">
                            <optgroup label="Income Sources">
                                <option value="salary">Salary</option>
                                <option value="bonus">Bonus</option>
                                <option value="gift">Gift</option>
                                <option value="interest">Interest</option>
                                <option value="investment-return">Investment Return</option>
                                <option value="rental-income">Rental Income</option>
                                <option value="freelance">Freelance</option>
                                <option value="other">Other</option>
                            </optgroup>
                        </select>

                        <select name="category" id="category" v-else-if="this.transaction.type == 'expense'">
                            <optgroup label="Household">
                                <option value="rent-mortgage">Rent/Mortgage</option>
                                <option value="utilities">Utilities</option>
                                <option value="home-maintenance">Home Maintenance</option>
                                <option value="property-taxes">Property Taxes</option>
                            </optgroup>
                            
                            <optgroup label="Food">
                                <option value="groceries">Groceries</option>
                                <option value="dining-out">Dining Out</option>
                            </optgroup>

                            <optgroup label="Transportation">
                                <option value="gas">Gas</option>
                                <option value="public-transportation">Public Transportation</option>
                                <option value="parking">Parking</option>
                                <option value="vehicle-maintenance">Vehicle Maintenance</option>
                                <option value="car-payment">Car Payment</option>
                            </optgroup>

                            <optgroup label="Healthcare">
                                <option value="health-insurance">Health Insurance</option>
                                <option value="medical-bills">Medical Bills</option>
                                <option value="prescriptions">Prescriptions</option>
                                <option value="fitness">Fitness</option>
                            </optgroup>

                            <optgroup label="Entertainment">
                                <option value="streaming-services">Streaming Services</option>
                                <option value="movies-theater">Movies/Theater</option>
                                <option value="concerts-events">Concerts/Events</option>
                                <option value="games">Games</option>
                            </optgroup>
                        </select>

                        <label for="amount">Amount:</label>
                        <input type="number" name="amount" id="amount" v-model="this.transaction.amount" step="0.01">

                        <label for="date">Date:</label>
                        <input type="date" name="date" id="date" v-model="this.transaction.date">

                        <label for="notes">Notes:</label>
                        <textarea name="notes" id="notes" cols="30" rows="10" v-model="this.transaction.notes"></textarea>

                    <button @click="createTransactionForUser">Submit</button>
                </div>
            </form>

            
        </div>
    </div>
</template>

<script>
import TransactionsService from '../services/TransactionsService';

export default {
    data() {
        return {
            showTransactionForm: false,
            transaction: {
                type: '',
                amount: 0,
                category: '',
                date: '',
                notes: ''
            }
    }
    },
    methods: {
        async createTransactionForUser() {
            try {
                const response = await TransactionsService.createTransaction(this.transaction);
            } catch (error) {
                console.error("Failed to create transaction:", error);
            }
        }    
    }
}
</script>

<style scoped>

</style>