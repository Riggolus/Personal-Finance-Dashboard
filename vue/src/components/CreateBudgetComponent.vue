<template>
    <button @click="budgetForm = !budgetForm" v-if="!budgetForm" >+ Budget</button>
    <button @click="budgetForm = !budgetForm" v-if="budgetForm" >Cancel</button>
    <div id="budget-form" v-if="budgetForm">
        <h3>Create a Budget</h3>
        <div id="budget-form">
            <form action="" id="budget-form">
                <div class="form-group">
                    <label for="category">Category:</label>
                    <select name="category" id="category" v-model="budget.category" >
                        <option value="Housing">Housing</option>
                        <option value="Transportation">Transportation</option>
                        <option value="Food">Food</option>
                        <option value="Entertainment">Entertainment</option>
                        <option value="Other">Other</option>
                    </select>

                    <label for="amountLimit">Amount Limit:</label>
                    <input type="number" id="amountLimit" v-model="budget.amountLimit" required />

                    <label for="startDate">Start Date:</label>
                    <input type="date" id="startDate" v-model="budget.startDate" required />

                    <label for="endDate">End Date:</label>
                    <input type="date" id="endDate" v-model="budget.endDate" required />

                    <button type="submit" @click="createBudget">Create Budget</button>
                </div>           
            </form>
        </div>
    </div>
</template>

<script>
import BudgetsService from '../services/BudgetsService';

export default {
    data() {
        return {
            budgetForm: false,
            budget: {
                category: '',
                amountLimit: 0,
                startDate: '',
                endDate: ''
            }
            
        };
    },
    methods: {
        async createBudget() {
            try {
                const response = await BudgetsService.createBudget(this.budget);
                console.log("Budget created:", response.data);
                this.budgetForm = false;
                this.budget = {
                    category: '',
                    amountLimit: 0,
                    startDate: '',
                    endDate: ''
                };
                this.$emit('budget-created', response.data);
            } catch (error) {
                console.error("Failed to create budget:", error);
            }
        }
    }
}

</script>