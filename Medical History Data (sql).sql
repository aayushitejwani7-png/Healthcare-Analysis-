use project_medical_data_history;
select * from admissions;
select * from doctors;
select * from patients;
select * from province_names;
-- 1 --
select first_name,last_name,gender from patients
where gender = "M";
-- 2 --
select first_name,last_name,allergies from patients
where allergies is null;
-- 3 --
select first_name from patients
where first_name like "C%";
-- 4 --
select first_name,last_name,weight from patients
where weight between 100 and 120;
-- 5 --
update patients
set allergies = "NKA"
where allergies is null;
-- 6 --
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;
-- 7 --
select patients.first_name,patients.last_name,province_names.province_name
from patients
join province_names
on patients.province_id = province_names.province_id;
-- 8 --
select * from patients
where birth_date like "2010%";
-- 9 --
select first_name,last_name,height from patients
order by height desc limit 1;
-- 10 --
select * from patients
where patient_id in (1,45,534,879,1000);
-- 11 --
select count(*) from admissions;
-- 12 --
select * from admissions
where admission_date = discharge_date;
-- 13 --
select count(*) from admissions
where patient_id = 579;
-- 14 --
select distinct city from patients
where province_id = "NS";
-- 15 --
select first_name,last_name,birth_date from patients
where height>160 and weight>70;
-- 16 --
select distinct year(birth_date) from patients
order by year(birth_date);
-- 17 --
SELECT first_name
FROM patients
GROUP BY first_name
HAVING COUNT(first_name) = 1;
-- 18 --
select patient_id,first_name from patients
where first_name like "s%s" and length(first_name)>=6;
-- 19 --
select patients.patient_id,patients.first_name,patients.last_name,admissions.diagnosis
from patients
join admissions
on patients.patient_id = admissions.patient_id
where diagnosis = "dementia";
-- 20 --
select first_name from patients
order by length(first_name) and first_name;
-- 21 --
SELECT 
    SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS total_males,
    SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS total_females
FROM patients;
-- 23 --
SELECT patient_id, diagnosis
FROM admissions
GROUP BY patient_id, diagnosis
HAVING COUNT(*) > 1;
-- 24 --
select city,count(patient_id) as total_patients from patients
group by city
order by total_patients desc ,city asc;
-- 25 --
SELECT first_name, last_name, 'Patient' AS role
FROM patients

UNION

SELECT first_name, last_name, 'Doctor' AS role
FROM doctors;
-- 26 --
select allergies,count(allergies) from patients
group by allergies
order by count(allergies) desc;
-- 27 --
select first_name,last_name,birth_date from patients
where year(birth_date) = 1970 
order by birth_date asc;
-- 28 --
select concat_ws(",",upper(last_name),lower(first_name))from patients
order by first_name desc;
-- 29 --
select province_id,sum(height) as total_height from patients
group by province_id
 having total_height >=7000;
-- 30 --
select max(weight) - min(weight) from patients
where last_name like "Maroni";
-- 31 --
select dayofmonth(birth_date),count(*) as total_ad from patients
group by birth_date
order by total_ad desc;
-- 32 --
SELECT 
    FLOOR(weight/10)*10 AS weight_group,
    COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;
-- 33 --
SELECT 
    patient_id,
    weight,
    height,
    CASE 
        WHEN weight / POWER(height/100.0, 2) >= 30 THEN 1
        ELSE 0
    END AS isObese
FROM patients;
-- 34 --
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    d.specialty
FROM patients p
JOIN admissions a 
    ON p.patient_id = a.patient_id
JOIN doctors d 
    ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
AND d.first_name = 'Lisa';
