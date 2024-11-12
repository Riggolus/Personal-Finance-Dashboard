<template>
    <div>
        <h2>Lets create an account!</h2>
        <AccountCreationComponent />
    </div>
</template>

<script>
    import AccountCreationComponent from '../components/AccountCreationComponent.vue';

    export default {
        name: 'SettingsView',
        components: {
            AccountCreationComponent
        },
        data() {
            return {
                account: {
                }
            }
        },
    }
</script>

<style></style>