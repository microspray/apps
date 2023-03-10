SELECT PA.REQUEST_ID,
	SUM(PA.AMOUNT),
	PA.CATEGORY,
	COUNT(*) AS TOTAL_PAYMENT_RECORDS_FOUND
FROM PAYMENTS PA
JOIN REQUESTS R ON R.ID = PA.REQUEST_ID
JOIN PARTNERS_REQUESTS_INVITATIONS PRI ON PRI.REQUEST_ID = R.ID
JOIN ECONSULT_DOCUMENTS ED ON ED.ID = PRI.ECONSULT_DOCUMENT_ID
WHERE PA.CATEGORY != 'category-re'
				AND R.ID != 177677
GROUP BY (PA.REQUEST_ID,
											PA.ID,
											PA.CATEGORY)