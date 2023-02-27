USE bank;

# 1. Get the id values of the first 5 clients from district_id with a value equals to 1
SELECT client_id
FROM client
WHERE district_id = 1
LIMIT 5;

# 2. In the client table, get an id value of the last client where the district_id equals to 72
SELECT *
FROM client;

SELECT MAX(client_id)
FROM client
WHERE district_id = 72;

# 3. Get the 3 lowest amounts in the loan table
SELECT amount
FROM loan
ORDER BY amount ASC
LIMIT 3;

# 4. What are the possible values for status, ordered alphabetically in ascending order in the loan table?
SELECT DISTINCT(status)
FROM loan
ORDER BY status ASC;

# 5. What is the loan_id of the highest payment received in the loan table?
SELECT *
FROM loan;

SELECT loan_id
FROM loan
ORDER BY payments ASC
LIMIT 1;

# 6. What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
SELECT *
FROM loan;

SELECT 
    account_id, amount
FROM
    loan
ORDER BY account_id ASC
LIMIT 5;

# 7. What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table?
SELECT *
FROM loan;

SELECT account_id, duration
FROM loan
WHERE duration = 60
ORDER BY amount ASC;

# 8. What are the unique values of k_symbol in the order table?
# Note: There shouldn't be a table name order, since order is reserved from the ORDER BY clause. You have to use backticks to escape the order table name.
SELECT DISTINCT(k_symbol)
FROM bank.order;

# 9. In the order table, what are the order_ids of the client with the account_id 34?
SELECT order_id
FROM bank.order
WHERE account_id = 34;

# 10. In the order table, which account_ids were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
SELECT DISTINCT(account_id)
FROM bank.order
WHERE  
	order_id BETWEEN 29540 AND 29560;

# 11. In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
SELECT *
FROM bank.order;

SELECT amount
FROM bank.order
WHERE account_to = 30067122;

# 12. In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest.
SELECT trans_id, date, type, amount
FROM trans
WHERE account_id = 793
ORDER BY date DESC
LIMIT 10;

# 13. In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order.
SELECT * 
FROM client;

SELECT district_id, COUNT(client_id)
FROM client
WHERE district_id < 10
GROUP BY district_id
ORDER BY district_id ASC;

# 14. In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
SELECT *
FROM card;

SELECT distinct(type), COUNT(type)
FROM card
GROUP BY type
ORDER BY COUNT(type) DESC;

# 15. Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts
SELECT *
FROM loan;

SELECT account_id, SUM(amount) # add the amounts for the the account_ids
FROM loan
GROUP BY account_id 
ORDER BY SUM(amount) DESC
LIMIT 10;

# 16. In the loan table, retrieve the number of loans issued for each day, before (excl) 930907, ordered by date in descending order.
SELECT *
FROM loan;

SELECT date, COUNT(loan_id) AS loans
FROM loan
WHERE date < 930907
GROUP BY date
ORDER BY date DESC;


# 17. In the loan table, for each day in December 1997, count the number of loans issued for each unique loan duration, ordered by date and duration, both in ascending order. You can ignore days without any loans in your output.
SELECT *
FROM loan;

SELECT date, duration, COUNT(loan_id) AS loans
FROM loan
WHERE date = 9712;


# 18. In the trans table, for account_id 396, sum the amount of transactions for each type (VYDAJ = Outgoing, PRIJEM = Incoming). Your output should have the account_id, the type and the sum of amount, named as total_amount. Sort alphabetically by type
SELECT *
FROM trans;

SELECT account_id, type, SUM(amount) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY type
ORDER BY type ASC;

#19. From the previous output, translate the values for type to English, rename the column to transaction_type, round total_amount down to an integer
SELECT 
	account_id, 
	CASE
		WHEN type = "VYDAJ" THEN "OUTGOING"
        WHEN type = "PRIJEM" THEN "INCOMING"
		ELSE "UNKNOWN"
	END AS transaction_type,
	FLOOR(SUM(amount)) AS total_amount
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY account_id, type ASC;

# 20. From the previous result, modify your query so that it returns only one row, with a column for incoming amount, outgoing amount and the difference
SELECT *
FROM trans;

-- Basic solution
SELECT
	account_id,
    FLOOR(SUM(IF(type = "PRIJEM", amount, 0))) AS incoming_amount,
    FLOOR(SUM(IF(type = "VYDAJ", amount, 0))) AS outgoing_amount,
    FLOOR(SUM(IF(type = "PRIJEM", amount, 0))) - FLOOR(SUM(IF(type = "VYDAJ", amount, 0))) AS diff
FROM trans
WHERE account_id = 396
GROUP BY account_id;

-- Using a subquery 
SELECT 
	account_id,
    incoming_amount,
    outgoing_amount,
    incoming_amount - outgoing_amount AS diff
FROM (
	SELECT
		account_id,
		FLOOR(SUM(IF(type = "PRIJEM", amount, 0))) AS incoming_amount,
		FLOOR(SUM(IF(type = "VYDAJ", amount, 0))) AS outgoing_amount
	FROM trans
	WHERE account_id = 396
	GROUP BY account_id
) AS amounts;

# 21.

-- Without subquery
SELECT
	account_id,
    FLOOR(SUM(IF(type = "PRIJEM", amount, 0))) - FLOOR(SUM(IF(type = "VYDAJ", amount, 0))) AS diff
FROM trans
GROUP BY account_id
ORDER BY diff DESC
LIMIT 10;

-- With subquery 
SELECT 
	account_id,
    incoming_amount - outgoing_amount AS diff
FROM (
	SELECT
		account_id,
		FLOOR(SUM(IF(type = "PRIJEM", amount, 0))) AS incoming_amount,
		FLOOR(SUM(IF(type = "VYDAJ", amount, 0))) AS outgoing_amount
	FROM trans
	GROUP BY account_id
) AS amounts
ORDER BY diff DESC
LIMIT 10;

## Disadvantages of non-normalized 
# 1. Data redundancy: Non-normalized databases often have duplicate data stored in multiple places, which can lead to inconsistencies and errors.

# 2. Data inconsistencies: When data is duplicated across multiple records, it can be difficult to ensure that all copies are updated consistently.

# 3. Poor performance: Non-normalized databases can be slower to query and search because of the redundant data.

# 4. Increased storage requirements: Redundant data requires more storage space, which can increase the overall size of the database.

# 5. Difficulty in modification: Modifying non-normalized databases can be complex and time-consuming, as changes need to be made to multiple records to ensure consistency.