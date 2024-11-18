<template>

</template>

<script>
import TransactionsService from '../services/TransactionsService';

export default {
    data() {
        return {
            transactions: []
        }
    },
    methods: {
        async getTransactions() {
            try {
                const response = await TransactionsService.getTransactions();
                this.transactions = response.data;
                console.log("Transactions data:", this.transactions);
            } catch (error) {
                console.error("Failed to fetch transactions:", error);
            }
        }
    },
    created() {
        this.getTransactionMetrics();
    }
}
</script>

<style>
</style>