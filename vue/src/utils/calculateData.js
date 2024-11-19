export const calculateDataV2 = (transactionData, budgetData) => {

        let totalIncome = 0;
        let totalExpense = 0;

        let housingTransactions = [];
        let transportationTransactions = [];
        let foodTransactions = [];
        let Entertainment = [];
        let otherTrasactions = [];

        // Process the transactions
        transactionData.forEach(transaction => {
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

        // Calculating the total income and expendature per day
        



        const totalBudget = budgetData.reduce((acc, budget) => acc + budget.amountLimit, 0);

        const totalAmount = totalIncome - totalExpense;

        // Return the calculated data
        return { totalIncome, totalExpense, totalAmount, totalBudget, 
            housingTransactions, transportationTransactions, foodTransactions, 
            Entertainment, otherTrasactions };
    }
