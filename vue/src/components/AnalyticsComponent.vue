<template>
    <div>
        <h3>Analytics</h3>
        <div id="analytics">
            <div class="analytics">
                <button @click="console.log(analyticsData)">Test</button>
                <div>Overall Income: ${{ analyticsData.totalIncome }}</div>
                <div>Overall Expenses: ${{ analyticsData.totalExpense }}</div>
            </div>
        </div>
    </div>
</template>

<script>


export default {
    props: ["analyticsData"],
    
}
</script>

<style>
</style>