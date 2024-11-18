<template>
<div id="Budget-component">
    <CreateBudgetComponent />
    <div id="currentBudgets">
        <h3>Current Budgets</h3>
        <div id="budgets">
            <div class="budget" v-for="budget in budgets" :key="budget.id">
                {{ budget.category }}: ${{ budget.amountLimit }}
            </div>
        </div>
    </div>
</div>
</template>

<script>
import BudgetsService from '../services/BudgetsService';
import CreateBudgetComponent from './CreateBudgetComponent.vue';

export default {
    components: {
        CreateBudgetComponent
    },
    data() {
        return {
            budgets: []
        }
    },
    methods: {
        async getBudgets() {
            try {
                const response = await BudgetsService.getBudgets();
                this.budgets = response.data;
                console.log("Budgets data:", this.budgets);
            } catch (error) {
                console.error("Failed to fetch budgets:", error);
            }
        }
    },
    created() {
        this.getBudgets();
    }
}
</script>

<style>
</style>