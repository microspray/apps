-- COMPLAINT MADE query
SELECT distinct R.id
FROM REQUESTS R
JOIN SYSTEM_LOGS SL ON SL.REQUEST_ID = R.ID
WHERE ((SL.METADATA->'life_cycle'->> 'to') = 'c1' OR (SL.METADATA->'phase'->> 'to') = 'c1')
				and r.created_at between '2021-04-01' and '2021-04-30'