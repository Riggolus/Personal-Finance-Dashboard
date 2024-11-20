<template>
    <div id="main">
        <div id="transaction-logger">
            <button @click="showTransactionForm = !showTransactionForm">
                <div v-if="!showTransactionForm">+ Transaction</div>
                <div v-else>Cancel</div>
            </button>
            <form action="" id="transaction-form">
                <div v-if="showTransactionForm">
                    <label for="type" id="type">Type:</label>
                    <select name="type" id="type" v-model="this.transaction.type">
                        <option value="expense">Expense</option>
                        <option value="income">Income</option>
                    </select>
                    
                    <label id="category" for="category" v-show="transaction.type != ''">Category:
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
                                <option value="Rent">Rent</option>
                                <option value="Mortgage">Mortgage</option>
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
                                <option value="Movies/Theater">Movies/Theater</option>
                                <option value="Concerts/Events">Concerts/Events</option>
                                <option value="Games">Games</option>
                            </optgroup>
                            <option value="Other">Other</option>
                        </select>
                    </label>

                    <label for="amount" id="amount">Amount:
                        <input type="number" name="amount" id="amount" v-model="this.transaction.amount" step="0.01">
                    </label>
                    <label for="date" id="date">Date:
                        <input type="date" name="date" id="date" v-model="this.transaction.date">
                    </label>
                    <label for="notes" id="notes">Notes:
                        <textarea name="notes" id="notes" cols="30" rows="10" v-model="this.transaction.notes"></textarea>
                    </label>
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
#transaction-form {
    display: flex;
    flex-direction: column;
    gap: 1rem;

    
}

#transaction-form label {
    display: flex;
    flex-direction: column;
    gap: 0.5rem;
}

#transaction-form button {
    width: 100%;
    padding: 1rem;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

#transaction-form button:hover {
    background-color: #45a049;
}

#transaction-form button:active {
    background-color: #3e8e41;
}

#transaction-form input[type="number"] {
    padding: 0.5rem;
    border-radius: 5px;
    border: 1px solid #ccc;
}

#transaction-form input[type="date"] {
    padding: 0.5rem;
    border-radius: 5px;
    border: 1px solid #ccc;
}

#transaction-form textarea {
    padding: 0.5rem;
    border-radius: 5px;
    border: 1px solid #ccc;
}

#transaction-form select {
    padding: 0.5rem;
    border-radius: 5px;
    border: 1px solid #ccc;
}

#transaction-form select optgroup {
    font-weight: bold;
}

#transaction-form select option {
    padding: 0.5rem;
}

#transaction-form select option:hover {
    background-color: #f9f9f9;
}

#transaction-form select option:checked {
    background-color: #f9f9f9;
}

#transaction-form select option:active {
    background-color: #f0f0f0;
}

#transaction-form select option:focus {
    background-color: #f0f0f0;
}

#transaction-form select option:selected {
    background-color: #f0f0f0;
}

#transaction-form select option:checked {
    background-color: #f0f0f0;
}

#transaction-form select option:disabled {
    background-color: #f0f0f0;
}

#transaction-form select option:enabled {
    background-color: #f0f0f0;
}

#transaction-form select option:read-only {
    background-color: #f0f0f0;
}

#transaction-form select option:read-write {
    background-color: #f0f0f0;
}

#transaction-form select option:required {
    background-color: #f0f0f0;
}

#transaction-form select option:valid {
    background-color: #f0f0f0;
}

#transaction-form select option:invalid {
    background-color: #f0f0f0;
}

#transaction-form select option:in-range {
    background-color: #f0f0f0;
}

#transaction-form select option:out-of-range {
    background-color: #f0f0f0;
}

#transaction-form select option:optional {
    background-color: #f0f0f0;
}

#transaction-form select option:required {
    background-color: #f0f0f0;
}

#transaction-form select option:valid {
    background-color: #f0f0f0;
}

#transaction-form select option:invalid {
    background-color: #f0f0f0;
}

#transaction-form select option:in-range {
    background-color: #f0f0f0;
}

#transaction-form select option:out-of-range {
    background-color: #f0f0f0;
}



</style>