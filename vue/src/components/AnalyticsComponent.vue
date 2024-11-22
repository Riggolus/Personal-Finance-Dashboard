<!-- <template>
    <div>
        <h3>Analytics</h3>
        <div id="analytics">
            <div class="analytics">
                <div>Income: ${{ analyticsData.totalAmount }}</div>
                <div>Overall Income: ${{ analyticsData.totalIncome }}</div>
                <div>Overall Expenses: ${{ analyticsData.totalExpense }}</div>
                <div v-for="data in calculatedData">
                    <div>{{ data }}</div>

                </div>
                <button @click="calculateExpensesVsBudget(analyticsData)">Test</button>
                <button @click="testing123">Testing 2</button>
            </div>
        </div>
        <div id="chart">
            <canvas id="myChart"></canvas>
        </div>
    </div>
</template>

<script>
import TransactionsService from "../services/TransactionsService";
import BudgetsService from "../services/BudgetsService";

import { calculateDataV2 } from "../utils/calculateData";


export default {
  props: ["analyticsData"],
  data() {
    return {
      transactions: [],
      budgets: [],
      calculatedData: []
    };
  },
  async created() {
    this.transactions = await TransactionsService.getTransactions();
    this.budgets = await BudgetsService.getBudgets();
    this.calculateExpensesVsBudget
  },
  methods: {
    // Calculating totals for the different expense types
    calculateExpensesVsBudget(analyticsData) {
        console.log("Did this work" + analyticsData.housingTransactions);

        if (!analyticsData.housingTransactions || analyticsData.housingTransactions.length === 0) {
            console.warn("No housing transactions available.");
            return;
        }

        // Calculate total amount for each month
        this.calculatedData = analyticsData.housingTransactions.reduce((acc, curr) => {
            // Parse the date from the transaction
            const date = new Date(curr.date);
            const year = date.getFullYear();
            const month = date.toLocaleString("default", { month: "long" }); // Correctly formats the month name
            
            // Combine year and month for the key
            const yearMonthKey = `${year}-${month}`;
            
            // Initialize the accumulator for this month if it doesn't exist
            if (!acc[yearMonthKey]) {
                acc[yearMonthKey] = 0;
            }

            // Add the current transaction amount
            acc[yearMonthKey] += curr.amount;

            return acc;
        }, {});

        console.log("retest"+this.calculatedData);

        return Object.entries(this.calculatedData).map(([month, amount]) => {
            return { month, total: amount };
            });
        },
    
    
    },
};
</script>


<style>

</style> -->


<template>
    <div>
        <h3>Analytics</h3>
        <div id="analytics">
            <div class="analytics">
                <div>Income: ${{ analyticsData.totalAmount }}</div>
                <div>Overall Income: ${{ analyticsData.totalIncome }}</div>
                <div>Overall Expenses: ${{ analyticsData.totalExpense }}</div>
                <!-- Display calculated data -->
                <div v-for="(data, index) in calculatedData" :key="index">
                    <div>{{ data.month }}: ${{ data.total }}</div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import TransactionsService from "../services/TransactionsService";
import BudgetsService from "../services/BudgetsService";

export default {
  props: ["analyticsData"],
  data() {
    return {
      transactions: [],
      budgets: [],
      calculatedData: [],
      expensesByMonth: [] // Stores expenses grouped by month
    };
  },
  async created() {
    try {
      // Fetch data on component creation
      this.transactions = await TransactionsService.getTransactions();
      this.budgets = await BudgetsService.getBudgets();
      
      // Calculate data after transactions are fetched
      this.calculateExpensesVsIncomeByMonth();

      if (this.analyticsData) {
        this.calculateExpensesVsBudget();
      }
    } catch (error) {
      console.error("Error fetching data:", error);
    }
  },
  watch: {
    // Automatically re-calculate if transactions change
    transactions: {
      handler() {
        this.calculateExpensesVsIncomeByMonth();
      },
      immediate: true // Trigger immediately when the component is created
    },
    // Automatically re-calculate if analyticsData changes
    analyticsData: {
      handler() {
        this.calculateExpensesVsBudget();
      },
      immediate: true // Trigger immediately when the component is created
    }
  },
  methods: {
    calculateExpensesVsBudget() {
      if (!this.analyticsData?.housingTransactions || this.analyticsData.housingTransactions.length === 0) {
        console.warn("No housing transactions available.");
        this.calculatedData = [];
        return;
      }

      const groupedData = this.analyticsData.housingTransactions.reduce((acc, transaction) => {
        const date = new Date(transaction.date);
        const yearMonth = `${date.getFullYear()}-${date.toLocaleString("default", { month: "long" })}`;
        acc[yearMonth] = (acc[yearMonth] || 0) + transaction.amount;
        return acc;
      }, {});

      this.calculatedData = Object.entries(groupedData).map(([month, total]) => ({
        month,
        total
      }));

      console.log("Calculated Data:", this.calculatedData);
    },
    calculateExpensesVsIncomeByMonth() {
      const groupedData = this.transactions.reduce((acc, transaction) => {
        const date = new Date(transaction.date);
        const yearMonth = `${date.getFullYear()}-${date.toLocaleString("default", { month: "long" })}`;
        
        if (transaction.type === "expense") {
          acc[yearMonth] = (acc[yearMonth] || 0) + transaction.amount;
        }
        return acc;
      }, {});

      this.expensesByMonth = Object.entries(groupedData).map(([month, total]) => ({
        month,
        total
      }));

      console.log("Expenses by Month:", this.expensesByMonth);
    }
  }
};
</script>


<style>
/* Optional styling for better visual representation */
#analytics {
  margin: 20px;
}
.analytics div {
  margin-bottom: 10px;
}
</style>
