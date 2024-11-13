<template>
    <div id="history">
        <div id="history-title-bar">
        <h3>Transaction History</h3>
        <button v-if="!calendarMode" @click="calendarMode = !calendarMode">Calendar View</button>
        <button v-if="calendarMode" @click="calendarMode = !calendarMode">Table View</button> 
        </div>
      <div id="calendar-view" v-if="calendarMode">
      <!-- Transaction Calendar -->
      <vue-cal
        :events="transactionEvents"
        default-view="month"
        :time="false"
        :style="{ height: '425px', maxWidth: '100%' }"
        :cell-height="100"                                                  
        :title-length="15"                      
        @event-click ="viewTransaction"
        :event-style="event => ({ backgroundColor: event.color })"
      />
  
      <!-- Modal for Viewing and Editing Transactions -->
      <div v-if="showModal" class="modal">
        <h3>Transaction Details</h3>
        <div id="transaction-details" v-if="!editTransactionDetails">
            <div id="selected-type">
                <h3>Type: {{selectedTransaction.type.charAt(0).toUpperCase() + selectedTransaction.type.slice(1)}}</h3>
            </div>
            <div id="selected-category">Category: {{ selectedTransaction.category }}</div>
            
            <div id="selected-amount">Amount: ${{ selectedTransaction.amount }}</div>
    
            <div id="selected-date">Date: {{ selectedTransaction.date }}</div>
            
            <div id="selected-notes">Notes: {{ selectedTransaction.notes }}</div>

            <button id="edit-transaction" @click="updateTransactionForm" v-if="!editTransactionDetails">Edit</button>
            
        </div>
        <div id="edit-transaction-form" v-if="editTransactionDetails">
            <form action="">
                // Add form fields for editing transaction details
                <label for="type">Type:</label>
                <select name="type" id="type" v-model="selectedTransaction.type">
                    <option value="income">Income</option>
                    <option value="expense">Expense</option>
                </select>

                <label for="category">Category:</label>
                <select name="category" id="category" v-if="selectedTransaction.type == 'income'"
                        v-model="selectedTransaction.category">
                            <optgroup label="Income Sources">
                                <option value="Salary">Salary</option>
                                <option value="Bonus">Bonus</option>
                                <option value="Gift">Gift</option>
                                <option value="Interest">Interest</option>
                                <option value="Investment Return">Investment Return</option>
                                <option value="Rental Income">Rental Income</option>
                                <option value="Freelance">Freelance</option>
                                <option value="Other">Other</option>
                            </optgroup>
                        </select>
                <select name="category" id="category" v-else-if="selectedTransaction.type == 'expense'"
                 v-model="selectedTransaction.category" >
                    <optgroup label="Housing">
                        <option value="Rent">Rent</option>
                        <option value="Mortgage">Mortgage</option>
                        <option value="Utilities">Utilities</option>
                        <option value="Home Repairs">Home Repairs</option>
                    </optgroup>

                    <optgroup label="Transportation">
                        <option value="Car Payment">Car Payment</option>
                        <option value="Gas">Gas</option>
                        <option value="Public Transportation">Public Transportation</option>
                        <option value="Car Repairs">Car Repairs</option>
                    </optgroup>

                    <optgroup label="Food">
                        <option value="Groceries">Groceries</option>
                        <option value="Restaurants">Restaurants</option>
                        <option value="Fast Food">Fast Food</option>
                        <option value="Coffee Shops">Coffee Shops</option>
                    </optgroup>

                    <optgroup label="Entertainment">
                        <option value="Streaming Services">Streaming Services</option>
                        <option value="Movies Theater">Movies/Theater</option>
                        <option value="Concerts Events">Concerts/Events</option>
                        <option value="Games">Games</option>
                    </optgroup>
                    <option value="Other">Other</option>
                </select>

                <label for="amount">Amount:</label>
                <input type="number" name="amount" id="amount" v-model="selectedTransaction.amount" step="0.01">

                <label for="date">Date:</label>
                <input type="date" name="date" id="date" v-model="selectedTransaction.date">

                <label for="notes">Notes:</label>
                <textarea name="notes" id="notes" cols="30" rows="10" v-model="selectedTransaction.notes"></textarea>

                <button @click="updateTransaction">Update</button>

            </form>
        </div>
        <button id="close-transaction" @click="closeModal">Close</button>
      </div>
    </div>



    <!-- Transaction Table -->
    <div v-if="!calendarMode">
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="transaction in Transactions" :key="transaction.id" @click="console.log(transaction.notes)">
            <td>{{ transaction.date }}</td>
            <td>{{ transaction.amount }}</td>
            
          </tr>
        </tbody>
      </table>
    </div>
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
        selectedTransaction: null,
        editTransactionDetails: false,
        calendarMode: false
      };
    },
    methods: {
        async getTransactionsForUser() {
            try {
                const response = await TransactionsService.getTransactions();
                this.Transactions = response.data;
                this.transactionEvents = this.Transactions.map(transaction => {
                const sign = transaction.type === 'income' ? '+' : '-';
                const color = transaction.type === 'income' ? 'green' : 'red'; // Set color for income or expense

                return {
                    id: transaction.id,
                    start: transaction.date,
                    end: transaction.date,
                    title: `${sign} $${transaction.amount}`,
                    data: transaction,
                    color: color // Add color to event data
                };
                });
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
        this.editTransactionDetails = false;
      },
      updateTransactionForm() {
        this.editTransactionDetails = true;
      },
        async updateTransaction() {
            console.log("Updating transaction:", this.selectedTransaction);
            try {
            await TransactionsService.updateTransaction(this.selectedTransaction);
            this.closeModal();
            this.getTransactionsForUser();
            } catch (error) {
            console.error("Failed to update transaction:", error);
            }
        }
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

.vuecal-event {
  transition: background-color 0.3s ease, transform 0.3s ease;
}

.vuecal-event:hover {
  background-color: #ddd; /* Change background color on hover */
  transform: scale(1.05); /* Slightly enlarge the event on hover */
}
  
  </style>
  