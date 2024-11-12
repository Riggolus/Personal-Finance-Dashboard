<template>
  <div id="dashboard">
    <div class="home">
      <div id="greeting">
        <h2>Welcome {{ account.firstName }}</h2>
      </div>
      
      <AccountSummaryComponent />

      <TransactionLoggerComponent />
      
      <AccountHistoryComponent />
    </div>

   
  </div>
</template>

<script>
  import AccountSummaryComponent from '../components/AccountSummaryComponent.vue';
  import TransactionLoggerComponent from '../components/TransactionLoggerComponent.vue';
  import AccountHistoryComponent from '../components/AccountHistoryComponent.vue';
  import AccountService from '../services/AccountService';

  export default {
    name: 'DashboardView',
    components: {
      AccountSummaryComponent,
      TransactionLoggerComponent,
      AccountHistoryComponent
    },
    data() {
      return {
        account: {
          
        },
        
      }
    },
    methods: {
      async getAccount() {
        try {
          const response = await AccountService.getAccountByUserId(this.$store.state.user.id);
          this.account = response.data; // Access the actual account data
          console.log("Account data:", this.account);

          // Log the specific values of firstName and lastName
          console.log("First Name:", this.account.firstName);
          console.log("Last Name:", this.account.lastName);

          // Redirect if either name field is missing or empty
          if (this.account.firstName == null || this.account.firstName === "" ||
              this.account.lastName == null || this.account.lastName === "") {
            console.log("Redirecting to settings because name fields are missing.");
            this.$router.push('/settings');
          }
        } catch (error) {
          console.error("Failed to fetch account:", error);
        }
      }
    },
    created() {
      console.log(this.$store.state.user.id);
      this.getAccount();
      
    }
  }
</script>

<style>


</style>
