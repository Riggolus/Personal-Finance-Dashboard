<template>
    <div id="balance"><h3>Total Balance: {{ account.balance }}</h3></div>
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