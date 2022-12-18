
select sum(fi.spend), fi.date_start::date from facebook_ads.insights fi 
LEFT JOIN facebook_ads.ads fa ON fa.id::text = fi.ad_id
LEFT JOIN facebook_ads.campaigns fc ON fc.id::text = fa.campaign_id
 GROUP BY (fi.date_start::date), fc.name, NULL::bigint, 'facebook'::text, (
                CASE
                    WHEN fc.name ~~ ANY (ARRAY['%Mietpreisbremse%'::text, '%mietpreisbremse%'::text, '%rent_control%'::text, '%mpb%'::text]) THEN 'rent_control'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Mieterhöhung%'::text, '%Mieterhoehung%'::text, '%mieterhoehung%'::text, '%mieterhöhung%'::text, '%rent_increase%'::text]) THEN 'rent_increase'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Kundigung%'::text, '%Kündigung%'::text, '%kündigung%'::text, '%kundigung%'::text]) THEN 'termination_protection'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Schönheitsreparaturen%'::text, '%Schoenheitsreparaturen%'::text, '%schoenheitsreparaturen%'::text, '%schönheitsreparaturen%'::text, '%cosmetic_repairs%'::text, '%shr%'::text]) THEN 'cosmetic_repairs'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Mietminderung%'::text, '%mietminderung%'::text, '%rent_reduction%'::text, '%mm%'::text, '%mangel%'::text, '%mängel%'::text]) THEN 'rent_reduction'::text
                    WHEN fc.name ~~ ANY (ARRAY['%mehrabfindung%'::text, '%mehrabf%'::text, '%abfindung%'::text, '%compensation%'::text]) THEN 'compensation'::text
                    WHEN fc.name ~~ ANY (ARRAY['%internetkosten%'::text, '%wik%'::text, '%Internetkosten%'::text]) THEN 'internet_cost'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Erbrecht%'::text, '%erbrecht%'::text, '%erbexperten%'::text]) THEN 'heritage'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Corona%'::text]) THEN 'mieterschutz_corona'::text
                    WHEN fc.name ~~ ANY (ARRAY['%WMC%'::text, '%mieterschutz%'::text]) THEN 'mieterschutz'::text
                    WHEN fc.name ~~ ANY (ARRAY['%mietendeckel%'::text, '%Mietendeckel%'::text]) THEN 'mietendeckel'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Schutzbrief%'::text, '%schutzbrief%'::text]) THEN 'arbeitnehmerschutz'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Kscore%'::text, '%kscore%'::text]) THEN 'kscore'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Kautionsrueckforderung%'::text]) THEN 'kautionsrueckforderung'::text
                    WHEN fc.name ~~ ANY (ARRAY['%Kindesunterhalt%'::text]) THEN 'kindesunterhalt'::text
                    ELSE 'brand'::text
                END)
ORDER by date_start::date DESC