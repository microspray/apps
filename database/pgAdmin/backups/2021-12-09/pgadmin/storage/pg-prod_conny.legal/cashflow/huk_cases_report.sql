SELECT r.id, to_char(pri.created_at, 'dd.mm.yyyy') as creation_date
from REQUESTS r
JOIN PARTNERS_REQUESTS_INVITATIONS PRI ON PRI.REQUEST_ID = R.ID
JOIN Partners pt ON pt.ID = PRI.partner_id
where r.marked_as_test_at is null
and pt.slug = 'huk-coburg'
order by 1