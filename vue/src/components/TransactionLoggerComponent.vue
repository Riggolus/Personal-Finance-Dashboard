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
                        <select name="category" id="category" v-if="this.transaction.type == 'income'"
                        v-model="this.transaction.category">
                            <optgroup label="Income Sources">
                                <option value="Salary">Salary</option>
                                <option value="Bonus">Bonus</option>
                                <option value="Gift">Gift</option>
                                <option value="Interest">Interest</option>
                                <option value="Investment Return">Investment Return</option>
                                <option value="Rental Income">Rental Income</option>
                                <option value="Freelance">Freelance</option>
                                <option value="Other">Other</option>
                            </optgroup>
                        </select>

                        <select name="category" id="category" v-else-if="this.transaction.type == 'expense'"
                        v-model="this.transaction.category">
                            <optgroup label="Household">
                                <option value="Rent/Mortgage">Rent/Mortgage</option>
                                <option value="Utilities">Utilities</option>
                                <option value="Home Maintenance">Home Maintenance</option>
                                <option value="Property Taxes">Property Taxes</option>
                            </optgroup>
                            
                            <optgroup label="Food">
                                <option value="Groceries">Groceries</option>
                                <option value="Dining Out">Dining Out</option>
                            </optgroup>

                            <optgroup label="Transportation">
                                <option value="Gas">Gas</option>
                                <option value="Public Transportation">Public Transportation</option>
                                <option value="Parking">Parking</option>
                                <option value="Vehicle Maintenance">Vehicle Maintenance</option>
                                <option value="Car Payment">Car Payment</option>
                            </optgroup>

                            <optgroup label="Healthcare">
                                <option value="Health Insurance">Health Insurance</option>
                                <option value="Medical Bills">Medical Bills</option>
                                <option value="Prescriptions">Prescriptions</option>
                                <option value="Fitness">Fitness</option>
                            </optgroup>

                            <optgroup label="Entertainment">
                                <option value="Streaming Services">Streaming Services</option>
                                <option value="Movies Theater">Movies/Theater</option>
                                <option value="Concerts Events">Concerts/Events</option>
                                <option value="Games">Games</option>
                            </optgroup>
                            <option value="Other">Other</option>
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
            console.log(this.transaction);
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