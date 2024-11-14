<template>
    <div id="balance"><h3>Total Balance: {{ account.balance }}</h3></div>
    <p>This is part of the Account Summary Component which still needs work and is holding mock data</p>
</template>

<script>
export default {
    data() {
        return {
            account: {
                firstName: 'Nikolas',
                lastName: 'Knappen',
                balance: 0
            }
        }
    },
    
}
</script>

<style>
</style>