--PART 2

--The two most important customers of the firm may have been hacked. 
--Verify if there are any fraudulent transactions in their history. 
--For privacy reasons, you only know that their cardholder IDs are 2 and 18.

SELECT ch.cardholder_id, COUNT(t.transaction_id) AS transaction_count
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
WHERE ch.cardholder_id = 2 OR ch.cardholder_id = 18
GROUP BY ch.cardholder_id;
--want transaction amounts?

SELECT t.*, cc.cardholder_id
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
WHERE cc.cardholder_id IN (2, 18)
ORDER BY cc.cardholder_id, t.amount DESC;

--The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. 
--Again, for privacy reasons, you know only that the cardholder ID in question is 25.
SELECT *
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
WHERE cardholder_id = 25
  AND date >= '2018-01-01' AND date < '2018-04-01'
 -- AND amount > 1000; -- Assuming "quite expensive" means over $1000 (these would be the outliers)