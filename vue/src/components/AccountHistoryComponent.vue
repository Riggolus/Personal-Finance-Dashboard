<!-- <template>
    <div id="history">
        <h3>Transaction History</h3>
        <table>
            <tr>
                <th>Date</th>
                <th>Description</th>
                <th>Amount</th>
            </tr>
            <tr v-for="transaction in Transactions">
                <td>{{ transaction.date }}</td>
                <td>{{ transaction.type }}</td>
                <td>{{ transaction.amount }}</td>
            </tr>
        </table>
    </div>
</template>

<script>
import TransactionsService from '../services/TransactionsService';

export default {
    data() {
        return {
            Transactions: []
        }
    },
    methods: {
        async getTransactionsForUser() {
            try {
                const response = await TransactionsService.getTransactions();
                this.Transactions = response.data;
                console.log("Transaction data:", this.Transactions);
            } catch (error) {
                console.error("Failed to fetch transactions:", error);
            }
        }
    },
    created() {
        this.getTransactionsForUser();
    }
    
}
</script>

<style>
</style> -->

<template>
    <div id="history">
      <h3>Transaction History</h3>
      
      <!-- Transaction Calendar -->
      <vue-cal
        :events="transactionEvents"
        default-view="month"
        :time="false"
        :style="{ height: '425px', maxWidth: '100%' }"
        :cell-height="100"                                                  
        :title-length="15"                      
        @event-click ="viewTransaction"
      />
  
      <!-- Modal for Viewing and Editing Transactions -->
      <div v-if="showModal" class="modal">
        <h3>Transaction Details</h3>
        <label for="type">Type:</label>
        <input type="text" v-model="selectedTransaction.type" id="type" disabled />

        <label for="category">Category:</label>
        <input type="text" v-model="selectedTransaction.category" id="category" disabled />

        <label for="amount">Amount:</label>
        <input type="number" v-model="selectedTransaction.amount" id="amount" />
  
        <label for="date">Date:</label>
        <input type="date" v-model="selectedTransaction.date" id="date" />
  
        <button @click="updateTransaction">Save Changes</button>
        <button @click="closeModal">Close</button>
      </div>
  
      <!-- Transaction Table -->
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="transaction in Transactions" :key="transaction.id">
            <td>{{ transaction.date }}</td>
            <td>{{ transaction.type }}</td>
            <td>{{ transaction.amount }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script>
  import VueCal from 'vue-cal';
  import 'vue-cal/dist/vuecal.css';
  import TransactionsService from '../services/TransactionsService';
  
  export default {
    components: { VueCal },
    data() {
      return {
        Transactions: [],
        transactionEvents: [],
        showModal: false,
        selectedTransaction: null
      };
    },
    methods: {
      async getTransactionsForUser() {
        try {
          const response = await TransactionsService.getTransactions();
          this.Transactions = response.data;
          this.transactionEvents = this.Transactions.map(transaction => ({
            id: transaction.id,
            start: transaction.date,
            end: transaction.date,
            title: `${transaction.type}: $${transaction.amount}`,
            data: transaction
          }));
        } catch (error) {
          console.error("Failed to fetch transactions:", error);
        }
      },
      viewTransaction(event) {
        this.selectedTransaction = { ...event.data }; // Clone data to avoid modifying event directly
        console.log("Selected transaction:", this.selectedTransaction);
        this.showModal = true;
      },
      closeModal() {
        this.showModal = false;
        this.selectedTransaction = null;
      },
      async updateTransaction() {
        try {
          await TransactionsService.updateTransaction(this.selectedTransaction);
          await this.getTransactionsForUser(); // Refresh transactions after update
          this.closeModal();
        } catch (error) {
          console.error("Failed to update transaction:", error);
        }
      },
    },
    created() {
      this.getTransactionsForUser();
    }
  };
  </script>
  
  <style>
    .modal {
    /* Basic modal styling */
    position: fixed;
    top: 10%;  /* Adjust this to position it closer or farther from the top */
    left: 50%;
    transform: translateX(-50%); /* Centers the modal horizontally */
    background: white;
    padding: 20px;
    border: 1px solid #ccc;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    z-index: 1000;  /* Ensure the modal is above other elements */
    width: 60%; /* Adjust width as needed */
    max-width: 600px; /* Max width for larger screens */
    overflow: auto; /* Allow scrolling if content overflows */
    transition: opacity 0.3s ease-in-out;
}

.modal h3 {
    margin-top: 0;
}

.modal label {
    display: block;
    margin-bottom: 8px;
}

.modal input,
.modal textarea {
    width: 100%;
    margin-bottom: 16px;
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 4px;
}

.modal button {
    padding: 10px 15px;
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.modal button:hover {
    background-color: #0056b3;
}
  
  </style>
  