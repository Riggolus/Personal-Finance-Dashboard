<template>
  <div id="dashboard">
    <div class="home">
      <div id="greeting">
        <h2>Welcome {{ account.firstName }}</h2>
      </div>
      
      <BudgetsComponent id="budgets-component"/>

      <TransactionLoggerComponent id="transaction-logger"/>

      <FilterTransactionsComponent id="filter-transactions" @update-filters="setFilterCriteria" />
      
      <AccountHistoryComponent id="account-history" :filters="filters" />

      <AnalyticsComponent id="analytics-component" :analyticsData="analyticsData" />
    </div>

   
  </div>
</template>

<script>
  import BudgetsComponent from '../components/BudgetsComponent.vue';
  import TransactionLoggerComponent from '../components/TransactionLoggerComponent.vue';
  import AccountHistoryComponent from '../components/AccountHistoryComponent.vue';
  import AccountService from '../services/AccountService';
  import FilterTransactionsComponent from '../components/FilterTransactionsComponent.vue';
  import AnalyticsComponent from '../components/AnalyticsComponent.vue';
  
  import { calculateData } from '../utils/calculateData';

  export default {
    name: 'DashboardView',
    components: {
      BudgetsComponent,
      TransactionLoggerComponent,
      AccountHistoryComponent,
      FilterTransactionsComponent,
      AnalyticsComponent
    },
    data() {
      return {
        account: {},
        filters: {},
        analyticsData: null
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
    },
    async mounted() {
      console.log("Dashboard mounted");
      window.calculateData = calculateData;
      this.analyticsData =  await calculateData();
    }
  }
</script>

<style>
.home {
  display: grid;
  grid-template-columns: 1fr 1fr .5fr;
  grid-gap: 20px;
  grid-template-areas: 
    "greeting budgets-component ."
    "filter-transactions account-history transaction-logger "
    ". account-history ."
    ".analytics-component .";

}

#greeting {
  grid-area: greeting;
}

#budgets-component {
  grid-area: budgets-component;
}

#transaction-logger {
  grid-area: transaction-logger;
}

#filter-transactions {
  grid-area: filter-transactions;
}

#account-history {
  grid-area: account-history;
}

#analytics-component {
  grid-area: analytics-component;
}

</style>
