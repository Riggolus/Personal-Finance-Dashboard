<template>
    <div id="create-account" v-if="this.account.accountId == null">
        <form action="" id="account-form">
            <h2 >Lets create an account!</h2>
            <div class="form-group">
                <label for="firstName">First Name </label>
                <input type="text" id="firstName" v-model="account.firstName" required />
            </div>
            <div class="form-group">
                <label for="lastName">Last Name </label>
                <input type="text" id="lastName" v-model="account.lastName" required />
            </div>
            <div class="form-group">
                <label for="email">Email </label>
                <input type="email" id="email" v-model="account.email" required />
            </div>
            <div class="form-group">
                <label for="phone">Phone </label>
                <input type="tel" id="phone" v-model="account.phone" required />
            </div>
            <button type="submit" @click="createAccount">Create Account</button>
        </form>
    </div>
    <div id="create-account" v-else>
        <button @click="showUpdateForm = !showUpdateForm">Update Profile Information</button>
        <div v-show="showUpdateForm">
            <form action="" id="account-form">
                <h2 >Lets update your account!</h2>
                <div class="form-group">
                    <label for="firstName">First Name </label>
                    <input type="text" id="firstName" v-model="account.firstName" required />
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name </label>
                    <input type="text" id="lastName" v-model="account.lastName" required />
                </div>
                <div class="form-group">
                    <label for="email">Email </label>
                    <input type="email" id="email" v-model="account.email" required />
                </div>
                <div class="form-group">
                    <label for="phone">Phone </label>
                    <input type="tel" id="phone" v-model="account.phone" required />
                </div>
                <button type="submit" @click="updateAccount">Update Account</button>
            </form>
        </div>
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
            },
            showUpdateForm: false
        }
    },  
    methods: {
        async createAccount() {
            console.log(this.account);
            await AccountService.createAccount(this.account);
            this.$router.push('home');
        },
        async getAccountInfo() {
            try {
                const response = await AccountService.getAccountByUserId(this.$store.state.user.id);
                this.account = response.data;
                console.log("Account data:", this.account);
            } catch (error) {
                console.error("Failed to fetch account:", error);
            }
        },
        async updateAccount() {
            console.log(this.account);
            await AccountService.updateAccount(this.account);
            !showUpdateForm;
            
        }
    },
    created() {
        console.log(this.$store.state.user.id);
        this.getAccountInfo();
    }  
}
</script>