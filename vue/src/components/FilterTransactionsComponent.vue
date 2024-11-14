<template>
    <div id="filter-transactions">
        <h3>Filter Transactions</h3>
            <div class="filter-container">
                <label>
                    Date:
                    <input type="date" v-model="filters.date" @change="applyFilters" />
                </label>

                <label for="type">Type:
                    <select name="type" id="type" v-model="filters.type" @change="applyFilters">
                        <option value="">All</option>
                        <option value="expense">Expense</option>
                        <option value="income">Income</option>
                    </select>
                </label>

                <label>Minimum Amount:
                    <input type="number" id="min-amount" 
                    v-model="filters.minAmount" @change="applyFilters"/>
                </label>
                <label>Maximum Amount:
                    <input type="number" id="max-amount" 
                    v-model="filters.maxAmount" @change="applyFilters"/>
                </label>

                <label for="category">Category:
                    <select name="category" id="category" v-if="filters.type == 'income'"
                    v-model="filters.category" @change="applyFilters">
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

                    <select name="category" id="category" v-else-if="filters.type == 'expense'"
                    v-model="filters.category" @change="applyFilters">
                        <optgroup label="Household">
                            <option value="Rent/Mortgage">Rent/Mortgage</option>
                            <option value="Utilities">Utilities</option>
                            <option value="Home Maintenance">Home Maintenance</option>
                            <option value="Property Taxes">Property Taxes</option>
                        </optgroup>

                        <optgroup label="Food">
                            <option value="Groceries">Groceries</option>
                            <option value="Dining Out">Dining Out</option>
                        </optgroup>

                        <optgroup label="Transportation">
                            <option value="Gas">Gas</option>
                            <option value="Public Transportation">Public Transportation</option>
                            <option value="Parking">Parking</option>
                            <option value="Vehicle Maintenance">Vehicle Maintenance</option>
                            <option value="Car Payment">Car Payment</option>
                        </optgroup>

                        <optgroup label="Healthcare">
                            <option value="Health Insurance">Health Insurance</option>
                            <option value="Medical Bills">Medical Bills</option>
                            <option value="Prescriptions">Prescriptions</option>
                            <option value="Fitness">Fitness</option>
                        </optgroup>

                        <optgroup label="Entertainment">
                            <option value="Movies">Movies</option>
                            <option value="Concerts">Concerts</option>
                            <option value="Books">Books</option>
                            <option value="Games">Games</option>
                            <option value="Music">Music</option>
                            <option value="Subscriptions">Subscriptions</option>
                            <option value="Other">Other</option>
                        </optgroup>

                        <optgroup label="Personal">
                            <option value="Clothing">Clothing</option>
                            <option value="Shoes">Shoes</option>
                            <option value="Accessories">Accessories</option>
                            <option value="Jewelry">Jewelry</option>
                            <option value="Cosmetics">Cosmetics</option>
                            <option value="Other">Other</option>
                        </optgroup>

                        <optgroup label="Education">
                            <option value="Tuition">Tuition</option>
                            <option value="Books">Books</option>
                            <option value="Supplies">Supplies</option>
                            <option value="Other">Other</option>
                        </optgroup>

                        <optgroup label="Savings">
                            <option value="Emergency Fund">Emergency Fund</option>
                            <option value="Retirement">Retirement</option>
                            <option value="Investment">Investment</option>
                            <option value="Other">Other</option>
                        </optgroup>

                        <optgroup label="Other">
                            <option value="Other">Other</option>
                        </optgroup>
                    </select>
                </label>
        </div>
    </div>

</template>

<script>
export default {
    data() {
        return {
            filters: {
                date: '',
                type: "",
                minAmount: 0,
                maxAmount: 1000000,
                category: ""
            }
        };
    },
        methods: {
        applyFilters() {
            this.$emit("update-filters", { ...this.filters });
        }
    }
};


</script>

<style scoped>
.filter-container {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
</style>