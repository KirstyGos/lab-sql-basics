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
SELECT *
FROM order;


SELECT account_id, type, ROUND(amount)
CASE
WHEN type = "VYDAJ" THEN "Otgoing"
ELSE "Incoming"
END AS  transaction_type
FROM trans
WHERE account_id = 396
GROUP BY account_id, type
ORDER BY account_id, type ASC;



## Disadvantages of non-normalized 
# 1. Data redundancy: Non-normalized databases often have duplicate data stored in multiple places, which can lead to inconsistencies and errors.

# 2. Data inconsistencies: When data is duplicated across multiple records, it can be difficult to ensure that all copies are updated consistently.

# 3. Poor performance: Non-normalized databases can be slower to query and search because of the redundant data.

# 4. Increased storage requirements: Redundant data requires more storage space, which can increase the overall size of the database.

# 5. Difficulty in modification: Modifying non-normalized databases can be complex and time-consuming, as changes need to be made to multiple records to ensure consistency.