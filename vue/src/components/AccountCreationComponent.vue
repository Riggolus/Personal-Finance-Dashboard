<template>
    <div id="create-account">
        <form action="" id="account-form">
            <h2>Create Account</h2>
            <div class="form-group">
                <label for="firstName">First Name</label>
                <input type="text" id="firstName" v-model="account.firstName" required />
            </div>
            <div class="form-group">
                <label for="lastName">Last Name</label>
                <input type="text" id="lastName" v-model="account.lastName" required />
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" v-model="account.email" required />
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="tel" id="phone" v-model="account.phone" required />
            </div>
            <button type="submit" @click="createAccount">Create Account</button>
        </form>
    </div>
</template>

<script>
import AccountService from '../services/AccountService';

export default {
    data() {
        return {
            account: {
                firstName: '',
                lastName: '',
                email: '',
                phone: '',
            }
        }
    },  
    methods: {
        async createAccount() {
            console.log(this.account);
            await AccountService.createAccount(this.account);
            this.$router.push('/dashboard');
        }
    }  
}
</script>