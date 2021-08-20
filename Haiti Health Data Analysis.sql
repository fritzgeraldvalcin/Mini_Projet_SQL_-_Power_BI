use mini_project

  -- 1. Calculate the number of health facilities per commune.
SELECT COUNT(facdesc) as "health_facilities", vilcomn as "commune"
FROM spa
GROUP BY vilcomn
ORDER BY health_facilities desc;

-- 2. Calculate the number of health facilities by commune and by type of health facility.
SELECT COUNT(facdesc) as "health_facilities",vilcomn as "Commune",facdesc_1 as "type"
FROM spa
GROUP BY vilcomn, facdesc_1
ORDER BY facdesc_1;

-- 3. Calculate the number of health facilities by municipality and by department.
SELECT COUNT(facdesc) as "health_facilities", vilcomn, departn
FROM spa
GROUP BY vilcomn, departn
ORDER BY departn;

-- 4. Calculate the number of sites by type (mga) and by department.
SELECT COUNT(facdesc) as "number_of_site", departn as "department",mga
FROM spa
GROUP BY mga, departn
ORDER BY mga;
	
-- 5. Calculate the number of sites with an ambulance by municipality and by department (ambulance = 1.0).
SELECT COUNT(facdesc) as "number_of_site", vilcomn as "municipality",departn as "department"
FROM spa
WHERE ambulance = 1.0
GROUP BY departn, vilcomn
ORDER BY departn;

-- 6. Calculate the number of hospitals per 10k inhabitants per department.
 SELECT c.adm2_en  , d.adm1_en  ,s.facdesc, count(s.facdesc) as 'number_of_hospital'
 FROM commune as c
 INNER JOIN departement as d
 on c.adm1code = d.adm1code
 INNER JOIN spa as s
 on s.adm2code = c.adm2code
 INNER JOIN factype as f
 on f.factype = s.factype
 WHERE ambulance = 1.0
 GROUP by d.adm1_en,c.adm2_en

-- 7. Calculate the number of sites per 10k inhabitants per department * Question 9.
SELECT count(facdesc_1)* 10000 /sum(c.IHSI_UNFPA_2019) as 'Number_sites' ,d.adm1_en 
FROM factype as f
INNER JOIN commune as c
on c.IHSI_UNFPA_2019
INNER JOIN departement as d
on d.adm1code = c.adm1code
GROUP by d.adm1_en

-- 8. Calculate the number of bed per 1k inhabitants per department.
SELECT count(facdesc_1)* 10000 /sum(c.IHSI_UNFPA_2019) as 'number_of_Bed' ,d.adm1_en
FROM factype as f
INNER JOIN commune as c
on c.IHSI_UNFPA_2019
INNER JOIN departement as d
on d.adm1code = c.adm1code
GROUP by d.adm1_en

-- 9. How many communes have fewer dispensaries than hospitals?
SELECT adm1_en as Departement , ROUND(SUM(p.num_beds*1000/IHSI_UNFPA_2019)),2) as Number_of_bed_1k_habitants  
FROM Haiti_Health_Data_Analysis.dbo.Departement AS c
INNER JOIN Haiti_Health_Data_Analysis.dbo.spa  AS p ON c.adm1code = p.adm1code
GROUP BY adm1_en,IHSI_UNFPA_2019
select * from commune


-- 10. How many deaths per month?

select * from covid_case
-- 11. How many prevalences per month?
select count(cas_confirmes), month(document_date) as "month", round(sum(taux_de_letalite)/count(taux_de_letalite),4) as 'death_percent'
from covid_case
group by month(document_date) 

-- 12. How many prevalences per department?



-- 13. What is the variation in prevalence per week?
SELECT sum(cas_confirmes) /10 , departement
FROM covid_case
GROUP by departement

-- 14. How many Prevalence by department
SELECT sum(cas_confirmes) /1 , departement
FROM covid_case
GROUP by departement

