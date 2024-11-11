<template>
    <div id="main">
        <div id="expense">
            <button @click="showExpenseForm">Log Expense</button>
            <form action="submit" v-if="expenseForm">
                <h3>test expense</h3>
            </form>
        </div>
        <div id="earnings">
            <button @click="showEarningsForm">Log Earnings</button>
            <form action="submit" v-if="earningsForm">
                <h3>test earnings</h3>
            </form>

        </div>
    </div>
</template>

<script>
export default {
    data() {
        return {
            expenseForm: false,
            earningsForm: false
        }
    },
    methods: {
        showExpenseForm() {
            this.expenseForm = true;
            this.earningsForm = false;
        },
        showEarningsForm() {
            this.earningsForm = true;
            this.expenseForm = false;
        }
    }
}
</script>

<style scoped>
#main {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 20px;
    padding: 20px;
}


button {
    background-color: #007bff;
    color: white;
    padding: 10px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}
</style>