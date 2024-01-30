--PART 1

-- How can you isolate (or group) the transactions of each cardholder?
--Count the transactions that are less than $2.00 per cardholder.
--Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

CREATE VIEW small_transactions_by_cardholder AS
(SELECT ch.cardholder_id, COUNT(t.transaction_id) AS transaction_count
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
WHERE t.amount < 2.00
GROUP BY ch.cardholder_id);

-- There is no evidence to suggest a credit card has been hacked. 
-- We have 1 full year of transaction data (Jan-Dec 2018), and the most transactions made under $2.00 was a count of 26. 
-- Over the course of a year, this doesn't seem to be a lot or raise concern.
-- Merchant categorys include coffee shop, bar, restaurant, pub, food truck - these places could sell water or pop (for example) for under $2.00

--What are the top 100 highest transactions made between 7:00 am and 9:00 am?
CREATE VIEW top_100_transactions_7to9 AS
(SELECT t.*
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
WHERE EXTRACT(HOUR FROM t.date) BETWEEN 7 AND 9
ORDER BY t.amount DESC
LIMIT 100);
-- Do you see any anamalous transactions that could be fradulent?
-- Yes, the top 10 transactions ($748-1894) seem unusually high to spend between 7-9AM at a coffee shop, bar, restaurant, pub, or food truck

--Is there a higher number of fradulent transactions made during this time frame versus the rest of the day?
CREATE VIEW top_100_transactions_not_from_7to9 AS
(SELECT t.*
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
WHERE EXTRACT(HOUR FROM t.date) NOT BETWEEN 7 AND 9
ORDER BY t.amount DESC
LIMIT 100);
-- No, although there are expensive charges (>$1000) - there are many more transactions within this range in other parts of the day.
-- ^ Versus, 90% of transactions being ~$20 or less iat 7-9AM, the top 10 transactions really stood out as outliers. 
-- It also makes sense for charges to be a greater expense in the afternoon and evening (vs 7-9am) - where large dinner parties may be had with expensive food and alcohol bills.
-- We are also looking at 2 hours of data, verus the remaining 22 hours of the day - where there is more opportunity to capture expensive bills, and again, afternoon/ evening makes more sense to be spending high amounts.

-- What are the top 5 mercchants prone to being hacked using small transactions?
CREATE VIEW top_5_merchants_small_transactions AS
(SELECT m.merchant_name, COUNT(t.transaction_id) AS transaction_count
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
JOIN merchant m ON t.merchant_id = m.merchant_id
WHERE t.amount < 2.00
GROUP BY m.merchant_name
ORDER BY transaction_count DESC
LIMIT 5);
-- Wood-Ramirez
--Hood-Phillips
--Banker Inc
--Mcdaniel, Hines and Mcfarland
--Hamilton-Mcfarland