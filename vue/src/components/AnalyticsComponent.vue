<template>
    <div>
        <h3>Analytics</h3>
        <div id="analytics">
            <div class="analytics">
                <div>Income: ${{ analyticsData.totalAmount }}</div>
                <div>Overall Income: ${{ analyticsData.totalIncome }}</div>
                <div>Overall Expenses: ${{ analyticsData.totalExpense }}</div>
                
                
                
            </div>
        </div>
        <div id="expenses-vs-income">
            <Line :data="chartData" :options="chartOptions"></Line>
        </div>
    </div>
</template>

<script>
import TransactionsService from "../services/TransactionsService";

import { Line } from "vue-chartjs";
import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    LineElement,
    PointElement,
    CategoryScale,
    LinearScale
} from "chart.js";
import { callback } from "chart.js/helpers";

ChartJS.register(Title, Tooltip, Legend, LineElement, PointElement, CategoryScale, LinearScale);

export default {
  props: ["analyticsData"],
  components: {
    Line
  },
  data() {
    return {
      transactions: [],
      calculatedData: [],
      expensesByMonth: [], // Stores expenses grouped by month
      incomeByMonth: [],
      chartData: {
      labels: ["January", "February", "March", 
        "April", "May", "June", "July", 
        "August", "September", "October", 
        "November", "December"],
        datasets: [
        {
            label: "Sales",
            data: [300, 500, 400, 700, 600], // Y-axis data
            borderColor: "blue", // Line color
            fill: false
          },
          {
            label: "Expenses",
            data: [200, 400, 350, 550, 500],
            borderColor: "red",
            fill: false
          }
        ]
      },
      chartOptions: {
        responsive: true,
        plugins: {
          legend: {
            display: true,
            position: "top"
          },
          tooltip: {
            callbacks: {
              label: function(tooltipItem) {
                return `$${tooltipItem.raw}`;
              }
            }
          }
       },
        scales: {
          x: {
            title: {
              display: true,
              text: "Month"
            }
          },
          y: {
            title: {
              display: true,
              text: "Amount ($)"
            },
            beginAtZero: true,
          }
        }
     }
    }
  },
  async created() {
    this.getTransactionsForUser();
    try {
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
        this.calculateExpensesByMonth();
      },
      immediate: true 
    },
    analyticsData: {
      handler() {
        this.calculateExpensesVsBudget();
      },
      immediate: true 
    }
  },
  methods: {
    getTransactionsForUser() {
        TransactionsService.getTransactions()
            .then((response) => {
            this.transactions = response.data;
            })
            .catch((error) => {
            console.error("Error fetching transactions:", error);
            });
      
    },
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
    calculateExpensesByMonth() {
        const expenseData = {};
        const incomeData = {};

        // Iterate over each transaction
        this.transactions.forEach(transaction => {
            const date = new Date(transaction.date);
            const yearMonth = `${date.getFullYear()}-${date.toLocaleString("default", { month: "long" })}`;

            // Handle expense transactions
            if (transaction.type === "expense") {
            if (!expenseData[yearMonth]) {
                expenseData[yearMonth] = 0;
            }
            expenseData[yearMonth] += transaction.amount;
            }
            // Handle income transactions
            else if (transaction.type === "income") {
            if (!incomeData[yearMonth]) {
                incomeData[yearMonth] = 0;
            }
            incomeData[yearMonth] += transaction.amount;
            }
        });

        // Transform grouped data into arrays
        this.expensesByMonth = Object.entries(expenseData).map(([month, total]) => ({
            month,
            total,
        }));

        this.incomeByMonth = Object.entries(incomeData).map(([month, total]) => ({
            month,
            total,
        }));

        console.log("Expenses by Month:", this.expensesByMonth);
        console.log("Income by Month:", this.incomeByMonth);
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
