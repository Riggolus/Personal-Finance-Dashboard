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
            <canvas id="incomeVsExpenseChart"></canvas>
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
    LinearScale,
    registerables,
    TimeScale
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
      incomeVsExpenseChart: null,
      chartData: {
        labels: [],
        datasets: [
        {
            label: "Income",
            data: [], // Y-axis data
            borderColor: "blue", // Line color
            fill: false
          },
          {
            label: "Expenses",
            data: [],
            borderColor: "red",
            fill: false
          }
        ]
      },
    };
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

        this.expensesByMonth = Object.entries(expenseData)
        .map(([month, total]) => ({
          month,
          total,
        }))
        .sort((a, b) => new Date(a.month) - new Date(b.month)); // Sort by month in ascending order

      this.incomeByMonth = Object.entries(incomeData)
        .map(([month, total]) => ({
          month,
          total,
        }))
        .sort((a, b) => new Date(a.month) - new Date(b.month)); // Sort by month in ascending order


        console.log("Expenses by Month:", this.expensesByMonth);
        console.log("Income by Month:", this.incomeByMonth);
        
        
        this.$nextTick(() => {
            this.renderIncomeVsExpensesChart();
        });

        },
        renderIncomeVsExpensesChart() {
            const dates = this.expensesByMonth.map(data => data.month);
            const income = this.incomeByMonth.map(data => data.total);
            const expenses = this.expensesByMonth.map(data => data.total);

            console.log("Dates:", dates);
            console.log("Income:", income);
            console.log("Expenses:", expenses);

            if (this.incomeVsExpenseChart) {
                this.incomeVsExpenseChart.destroy();
            }

            const ctx = document.getElementById("incomeVsExpenseChart").getContext("2d");

            ChartJS.register(...registerables, TimeScale, LinearScale);

            this.incomeVsExpenseChart = new ChartJS(ctx, {
                type: 'line',
                data: {
                    labels: dates,
                    datasets: [
                        {
                            label: "Income",
                            data: income,
                            borderColor: "green",
                            fill: false
                        },
                        {
                            label: "Expenses",
                            data: expenses,
                            borderColor: "red",
                            fill: false
                        }
                    ]
                },
                options: {
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
                            beginAtZero: true
                        }
                    }
                }
            });
        },

  },
    
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
