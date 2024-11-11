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
        this.account = await AccountService.getAccountByUserId(this.$store.state.user.id);
        console.log(this.account);
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
