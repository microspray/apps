SELECT r.id,
	count(*),
	sum(pa.amount) as amount_invoice_total,
	to_char(pa.created_at, 'yyyy-mm') as month
FROM payments pa
JOIN REQUESTS R ON R.ID = PA.REQUEST_ID
WHERE r.marked_as_test_at is null
and pa.category = 'category-re'
group by r.id, month
order by 1