<template>
    <div>
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