<template>
    <div id="history">
        <h3>Transaction History</h3>
        <table>
            <tr>
                <th>Date</th>
                <th>Description</th>
                <th>Amount</th>
            </tr>
            <tr v-for="transaction in history">
                <td>{{ transaction.date }}</td>
                <td>{{ transaction.description }}</td>
                <td>{{ transaction.amount }}</td>
            </tr>
        </table>
    </div>
</template>

<script>


export default {
    data() {
        return {
            account: {
                firstName: 'Nikolas',
                lastName: 'Knappen',
                balance: 0
            },
            history: [
                {
                    date: '2020-01-01',
                    description: 'Initial Deposit',
                    amount: 1000
                },
                {
                    date: '2020-01-02',
                    description: 'Coffee',
                    amount: -5
                },
                {
                    date: '2020-01-03',
                    description: 'Paycheck',
                    amount: 2000
                }
            ]
        }
    },
    
}
</script>

<style>
</style>