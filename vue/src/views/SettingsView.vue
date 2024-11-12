<template>
    <h1>This is where the user will be able to adjust their settings</h1>
    <AccountCreationComponent />
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