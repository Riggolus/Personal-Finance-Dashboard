export const calculateDataV2 = (transactionData, budgetData) => {

        let totalIncome = 0;
        let totalExpense = 0;

        let housingTransactions = [];
        let transportationTransactions = [];
        let foodTransactions = [];
        let Entertainment = [];
        let healthCareTransactions = [];
        let otherTrasactions = [];

        // Process the transactions
        transactionData.forEach(transaction => {
            console.log(transaction);
            if (transaction.type === 'income') {
                totalIncome += transaction.amount;
            } else {
                totalExpense += transaction.amount;
            }
            // Categorizing expence by category
            // Need To place them in the parent class based off there category

            //Housing
            if (transaction.category === 'Rent'
            || transaction.category === 'Mortgage' 
            || transaction.category === 'Utilities'
            || transaction.category === 'Home Maintenance'
            || transaction.category === 'Property Taxes'
            ) {
                housingTransactions.push(transaction);
            //Transportation
            } else if (transaction.category === 'Gas'
            || transaction.category === 'Public Transportation'
            || transaction.category === 'Car Payment'
            || transaction.category === 'Parking'
            || transaction.category === 'Vehicle Maintenance'
            ) {
                transportationTransactions.push(transaction);
            //Food
            } else if (transaction.category === 'Groceries'
            || transaction.category === 'Dining Out'
            ) {
                foodTransactions.push(transaction);
            //Entertainment
            } else if (transaction.category === 'Streaming Services'
            || transaction.category === 'Movies/Theater'
            || transaction.category === 'Concerts/Events'
            || transaction.category === 'Games'
            ) {
                Entertainment.push(transaction);
            //Health Care
            } else if (transaction.category === 'Health Insurance'
            || transaction.category === 'Medical Bills'
            || transaction.category === 'Prescriptions'
            || transaction.category === 'Fitness'
            ){
                healthCareTransactions.push(transaction);
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
