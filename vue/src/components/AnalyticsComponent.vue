<template>
    <div>
        <h3>Analytics</h3>
        <div id="analytics">
            <div class="analytics">
                <button @click="console.log(analyticsData)">Test</button>
                <div>Income: ${{ analyticsData.totalAmount }}</div>
                <div>Overall Income: ${{ analyticsData.totalIncome }}</div>
                <div>Overall Expenses: ${{ analyticsData.totalExpense }}</div>
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

import {
  Chart,
  LineController, // Add this
  LineElement,     // Add this
  PointElement,    // Add this
  BarController,
  BarElement,
  CategoryScale,
  LinearScale,
  Title,
  Tooltip,
  Legend,
} from "chart.js";

// Register components
Chart.register(
  LineController, // Register LineController
  LineElement,    // Register LineElement
  PointElement,   // Register PointElement
  BarController,
  BarElement,
  CategoryScale,
  LinearScale,
  Title,
  Tooltip,
  Legend
);

export default {
  props: ["analyticsData"],
  data() {
    return {
      chart: null,
      transactions: [],
      budgets: [],
    };
  },
  async created() {
    this.transactions = await TransactionsService.getTransactions();
    this.budgets = await BudgetsService.getBudgets();
  },
  mounted() {
    this.createChart();
  },

  methods: {
    createChart() {
        // Parse transactions to extract labels, incomes, and expenses
        const labels = this.transactions.map((t) => t.date); // Assuming `t.date` is the transaction date
        const incomes = this.transactions.map((t) =>
        t.type === "income" ? t.amount : 0
        ); // Assuming `t.amount` holds the transaction value
        const expenses = this.transactions.map((t) =>
        t.type === "expense" ? t.amount : 0
        );

        const ctx = document.getElementById("myChart").getContext("2d");
        this.chart = new Chart(ctx, {
        type: "line",
        data: {
            labels, // X-axis labels (dates)
            datasets: [
            {
                label: "Income",
                data: incomes, // Income values
                backgroundColor: "rgba(54, 162, 235, 0.2)",
                borderColor: "rgba(54, 162, 235, 1)",
                borderWidth: 2,
                tension: 0.3, // Smooth line
                fill: false,
            },
            {
                label: "Expenses",
                data: expenses, // Expense values
                backgroundColor: "rgba(255, 99, 132, 0.2)",
                borderColor: "rgba(255, 99, 132, 1)",
                borderWidth: 2,
                tension: 0.3,
                fill: false,
            },
            ],
        },
        options: {
            responsive: true,
            plugins: {
            legend: {
                position: "top",
            },
            title: {
                display: true,
                text: "Income vs Expenses Over Time",
            },
            },
            scales: {
            x: {
                title: {
                display: true,
                text: "Date",
                },
            },
            y: {
                beginAtZero: true,
                title: {
                display: true,
                text: "Amount ($)",
                },
            },
            },
        },
        });
    },
    },

};
</script>


<style>
#chart {
  max-width: 600px;
  margin: 0 auto;
}
</style>





<!-- //   },
//   watch: {
//     analyticsData: {
//       handler: function () {
//         this.updateChart();
//       },
//       deep: true,
//     },
//   },
//   mounted() {
//     this.createChart();
//   },
//   methods: {
//     createChart() {
//       const ctx = document.getElementById("myChart").getContext("2d");
//       this.chart = new Chart(ctx, {
//         type: "bar",
//         data: {
//           labels: ["Income", "Expenses"],
//           datasets: [
//             {
//               label: "Income vs Expenses",
//               data: [
//                 this.analyticsData.totalIncome || 0,
//                 this.analyticsData.totalExpense || 0,
//               ],
//               backgroundColor: [
//                 "rgba(54, 162, 235, 0.2)",
//                 "rgba(255, 99, 132, 0.2)",
//               ],
//               borderColor: [
//                 "rgba(54, 162, 235, 1)",
//                 "rgba(255, 99, 132, 1)",
//               ],
//               borderWidth: 1,
//             },
//           ],
//         },
//         options: {
//           responsive: true,
//           scales: {
//             y: {
//               beginAtZero: true,
//             },
//           },
//         },
//       });
//     },
//     updateChart() {
//       this.chart.data.datasets[0].data = [
//         this.analyticsData.totalIncome || 0,
//         this.analyticsData.totalExpense || 0,
//       ];
//       this.chart.update();
//     }, -->