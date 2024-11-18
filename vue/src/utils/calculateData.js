import TransactionsService from "../services/TransactionsService";

export const calculateData = async () => {

    try {
        const response = await TransactionsService.getTransactions(); // Wait for the API call
        const transactions = response.data;

        let totalIncome = 0;
        let totalExpense = 0;

        // Process the transactions
        transactions.forEach(transaction => {
            if (transaction.type === 'income') {
                totalIncome += transaction.amount;
            } else {
                totalExpense += transaction.amount;
            }
        });

        const totalAmount = totalIncome - totalExpense;

        // Return the calculated data
        return { totalIncome, totalExpense, totalAmount };
    } catch (error) {
        console.error("Error fetching transactions:", error);
        return { totalIncome: 0, totalExpense: 0, totalAmount: 0 };
    }
};
    
