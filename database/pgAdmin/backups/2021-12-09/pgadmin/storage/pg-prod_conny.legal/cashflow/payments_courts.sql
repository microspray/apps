select court_instance, sum(amount) from payments
where payment_date between '20210228' and '20210401' 
and direction = 'direction-ein'
and category = 'category-za'
and payment_type <> 'type-frmd'
and payment_type <> 'type-aggregate'
group by court_instance
order by court_instance;

select payment_type, sum(amount) from payments
where payment_date between '20210228' and '20210401'
and payment_type = 'type-pau'
and category = 'category-za'
and amount in (24, 36, 48, 72, 96, 108, 120)
group by payment_type;