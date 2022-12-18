SELECT  life_cycle_id, product_name, count(created_at) FROM public.requests
where life_cycle_id IN ('s8t', 'as', 'ein', 'court_prep', 'court_1', 'bill', 'bill_court')
AND product_name = 'girokosten' 
GROUP BY life_cycle_id, product_name