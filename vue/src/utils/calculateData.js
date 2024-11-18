import TransactionsService from "../services/TransactionsService";
import BudgetsService from "../services/BudgetsService";

export const calculateData = async () => {

    try {
        const response = await TransactionsService.getTransactions(); // Wait for the API call
        // Gonna get teh data for budgets
        const responseBudget = await BudgetsService.getBudgets();

        const transactions = response.data;
        const budgets = responseBudget.data;

        let totalIncome = 0;
        let totalExpense = 0;

        let housingTransactions = [];
        let transportationTransactions = [];
        let foodTransactions = [];
        let Entertainment = [];
        let otherTrasactions = [];

        // Process the transactions
        transactions.forEach(transaction => {
            if (transaction.type === 'income') {
                totalIncome += transaction.amount;
            } else {
                totalExpense += transaction.amount;
            }
            // Categorizing expence by category
            if (transaction.category === 'Housing') {
                housingTransactions.push(transaction);
            } else if (transaction.category === 'Transportation') {
                transportationTransactions.push(transaction);
            } else if (transaction.category === 'Food') {
                foodTransactions.push(transaction);
            } else if (transaction.category === 'Entertainment') {
                Entertainment.push(transaction);
            } else {
                otherTrasactions.push(transaction);
            }
        });

        const totalBudget = budgets.reduce((acc, budget) => acc + budget.amountLimit, 0);

        const totalAmount = totalIncome - totalExpense;

        // Return the calculated data
        return { totalIncome, totalExpense, totalAmount, totalBudget, 
            housingTransactions, transportationTransactions, foodTransactions, 
            Entertainment, otherTrasactions };
    } catch (error) {
        console.error("Error fetching transactions:", error);
        return { totalIncome: 0, totalExpense: 0, totalAmount: 0 };
    }
};
    
