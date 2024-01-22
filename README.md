# Module-7-Challenge

Part 1:
Some fraudsters hack a credit card by making several small transactions (generally less than $2.00), which are typically ignored by cardholders.

-- How can you isolate (or group) the transactions of each cardholder?
--Count the transactions that are less than $2.00 per cardholder.
--Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.

SELECT ch.cardholder_id, COUNT(t.transaction_id) AS transaction_count
FROM transaction t
JOIN credit_card cc ON t.card_number = cc.card_number
JOIN card_holder ch ON cc.cardholder_id = ch.cardholder_id
WHERE t.amount < 2.00
GROUP BY ch.cardholder_id;