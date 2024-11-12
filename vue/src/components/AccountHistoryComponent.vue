<template>
    <div id="history">
        <h3>Transaction History</h3>
        <table>
            <tr>
                <th>Date</th>
                <th>Description</th>
                <th>Amount</th>
            </tr>
            <tr v-for="transaction in Transactions">
                <td>{{ transaction.date }}</td>
                <td>{{ transaction.type }}</td>
                <td>{{ transaction.amount }}</td>
            </tr>
        </table>
    </div>
</template>

<script>
import TransactionsService from '../services/TransactionsService';

export default {
    data() {
        return {
            account: {
                firstName: 'Nikolas',
                lastName: 'Knappen',
                balance: 0
            },
            Transactions: []
        }
    },
    methods: {
        async getTransactionsForUser() {
            try {
                const response = await TransactionsService.getTransactions();
                this.Transactions = response.data;
                console.log("Transaction data:", this.Transactions);
            } catch (error) {
                console.error("Failed to fetch transactions:", error);
            }
        }
    },
    created() {
        this.getTransactionsForUser();
    }
    
}
</script>

<style>
</style>