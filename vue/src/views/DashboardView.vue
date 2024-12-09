<template>
  <div id="dashboard">
    <div class="home">
      
      <BudgetsComponent id="budgets-component"/>

      <TransactionLoggerComponent id="transaction-logger"/>

      <FilterTransactionsComponent id="filter-transactions" @update-filters="setFilterCriteria" />
      
      <AccountHistoryComponent id="account-history" :filters="filters" />

      <AnalyticsComponent id="analytics-component" :analyticsData="analyticsData" />

      <AssistantComponent />

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
  import TransactionsService from '../services/TransactionsService';
  import BudgetsService from '../services/BudgetsService';
  import AssistantComponent from '../components/AssistantComponent.vue';

  
  import { calculateDataV2 } from '../utils/calculateData';


  export default {
    name: 'DashboardView',
    components: {
      BudgetsComponent,
      TransactionLoggerComponent,
      AccountHistoryComponent,
      FilterTransactionsComponent,
      AnalyticsComponent,
      AssistantComponent
    },
    data() {
      return {
        account: {},
        filters: {},
        transactions: [],
        budgets: [],
        analyticsData: {
          totalIncome: 0,
          totalExpense: 0
        }
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
      try {
        console.log("Dashboard mounted");

        // Step 1: Fetch transactions and budgets from the server
        const responseTransactions = await TransactionsService.getTransactions();
        const responseBudgets = await BudgetsService.getBudgets();

        this.transactions = responseTransactions.data;
        this.budgets = responseBudgets.data;

        // Step 2: Call calculateDataV2 with the fetched data
        this.analyticsData = await calculateDataV2(this.transactions, this.budgets);

        console.log("Analytics data:", this.analyticsData);
      } catch (error) {
        console.error("Error fetching transactions or budgets:", error);
      }
    }
  }
</script>

<style>
.home {
  display: grid;
  grid-template-columns: .25fr 1fr .33fr;
  grid-gap: 20px;
  grid-template-areas: 
    "budgets-component analytics-component analytics-component"
    "filter-transactions account-history transaction-logger "
    ". account-history .";

  padding: 20px;
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
