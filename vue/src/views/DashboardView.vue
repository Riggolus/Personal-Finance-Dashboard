<template>
  <div id="dashboard">
    <div class="home">
      <div id="greeting">
        <h2>Welcome {{ account.firstName }}</h2>
      </div>
      
      <AccountSummaryComponent />

      <TransactionLoggerComponent />

      <FilterTransactionsComponent @update-filters="setFilterCriteria" />
      
      <AccountHistoryComponent :filters="filters" />
    </div>

   
  </div>
</template>

<script>
  import AccountSummaryComponent from '../components/AccountSummaryComponent.vue';
  import TransactionLoggerComponent from '../components/TransactionLoggerComponent.vue';
  import AccountHistoryComponent from '../components/AccountHistoryComponent.vue';
  import AccountService from '../services/AccountService';
  import FilterTransactionsComponent from '../components/FilterTransactionsComponent.vue';


  export default {
    name: 'DashboardView',
    components: {
      AccountSummaryComponent,
      TransactionLoggerComponent,
      AccountHistoryComponent,
      FilterTransactionsComponent
    },
    data() {
      return {
        account: {},
        filters: {}
      }
    },
    methods: {
      async getAccount() {
        try {
          const response = await AccountService.getAccountByUserId(this.$store.state.user.id);
          this.account = response.data;

          if (this.account.firstName == null || this.account.firstName === "" ||
              this.account.lastName == null || this.account.lastName === "") {
            console.log("Redirecting to settings because name fields are missing.");
            this.$router.push('/settings');
          }
        } catch (error) {
          console.error("Failed to fetch account:", error);
        }
      },
      setFilterCriteria(newFilters) {
        this.filters = newFilters;
      }
    },
    created() {
      console.log(this.$store.state.user.id);
      this.getAccount();    
    }
  }
</script>

<style>
  .home {
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-gap: 20px;
    grid-template-areas: "greeting account-summary"
                         "transaction-logger transaction-logger"
                         "filter-transactions account-history";
  }

  #greeting {
    grid-area: greeting;
  }

  #account-summary {
    grid-area: account-summary;
  }

  #transaction-logger {
    grid-area: transaction-logger
  }

  #filter-transactions {
    grid-area: filter-transactions;
  }

  #account-history {
    grid-area: account-history;
  }



</style>
