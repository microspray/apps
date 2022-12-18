				
-- COMPLAINT SENT
SELECT distinct r.id
FROM REQUESTS R
JOIN SYSTEM_LOGS SL ON SL.REQUEST_ID = R.ID
WHERE (SL.METADATA->>'status') = 'as'
				and r.created_at between '2021-04-01' and '2021-04-30'