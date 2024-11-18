<template>
    <button @click="budgetForm = !budgetForm" v-if="!budgetForm" >+ Budget</button>
    <button @click="budgetForm = !budgetForm" v-if="budgetForm" >Cancel</button>
    <div id="budget-form" v-if="budgetForm">
        <h3>Create a Budget</h3>
        <div id="budget-form">
            <form action="" id="budget-form">
            
            
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
            // budget = {
            //     category: '',
            //     amountLimit: 0,
            //     startDate: '',
            //     endDate: ''
            
        };
    }
}

</script>