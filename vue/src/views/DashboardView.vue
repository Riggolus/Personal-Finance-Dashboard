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

  export default {
    name: 'DashboardView',
    components: {
      AccountSummaryComponent,
      TransactionLoggerComponent,
      AccountHistoryComponent
    },
    data() {
      return {
        user: {
          username: '',
          password: ''
        },
        account: {
          firstName: 'Nikolas',
          lastName: 'Knappen',
          balance: 0
        },
        
      }
    },
  }
</script>

<style>


</style>
