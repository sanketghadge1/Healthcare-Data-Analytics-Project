create database Healthcare;
use Healthcare;


create table Cpatients(
PatientID int primary key NOT NULL,
Gender varchar (20) NOT NULL,
DateOfBirth date NOT NULL,
Age int NOT NULL,
InsuranceProvider	varchar(50) NOT NULL,
State varchar (20) NOT NULL,
City varchar(20) NOT NULL,
Country varchar(20) NOT NULL,
MedicalHistory varchar(30) NOT NULL,
Race varchar(20) NOT NULL,
Ethnicity varchar(20) NOT NULL,
MaritalStatus varchar(20) NOT NULL,
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
ChronicConditions varchar(30) NOT NULL,
Allergies varchar(20) NOT NULL

);

SELECT * FROM Cdoctors;
select * from Cpatients;

drop table cpatients;
use healthcare;
CREATE TABLE Cvisit(
VisitID int,
PatientID int,
DoctorID int,
VisitDate date,
Diagnosis varchar(30),
Visittype varchar(30),
VisitStatus varchar(30),
DiagnosisCode varchar(30),
ReasonforVisit varchar(30),
PrescribedMedications varchar(50)
);

create table Ctreatment(
TreatmentID int,
visitid int,
MedicationPrescribed varchar(50),
TreatmentCost int,
TreatmentType varchar(30),
TreatmentName varchar(30),
Status varchar(30),
Cost int,
Outcome varchar(30),
 TreatmentDescription varchar(30)
 );
select * from Ctreatment;
select* from cvisit;
use healthcare;

create table Clabresults(
LabResultID int,
VisitID int,
TestName varchar(30),
TestDate date,
NormalRange varchar(30),
TestResult varchar(30),
ReferenceRange varchar(30)
);
select* from clabresults;

CREATE TABLE Cdoctors(
DOCTORID INT,
DOCTORNAME VARCHAR(20),
SPECIALITY VARCHAR(20),
YearsOfExperience int,
HospitalAffiliation varchar(20),
HospitalClinic varchar(30),
SPECIALIZATION VARCHAR(30)
);


##########################

SELECT COUNT(PatientID) AS Total_Patients FROM Cpatients;
SELECT COUNT(DOCTORID)AS TOTAL_DOCTORS FROM CDOCTORS;
SELECT SUM(Cost) AS TOTALREVENUE_GENERATED FROM ctreatment;


SELECT AVG(Age) AS Average_Age FROM cpatients;
select avg(treatmentcost) as Average_treatmentcost from ctreatment;



############### DIAGNOSIS WISE PATIENTS#############

SELECT Diagnosis, COUNT(*) AS patients
FROM cvisit
GROUP BY Diagnosis
ORDER BY patients DESC
LIMIT 5;


############ gender and diagnosis wise number of patients#############
select  p.Gender, v.Diagnosis,
count(p.Gender) as total_patient
 from
cpatients as p
inner join cvisit as v
on p.PatientID = v.patientid
group by  p. Gender, v.Diagnosis
order by Gender asc;

############## GENDER WISE counts#########

SELECT 
    Gender,
    COUNT(*) AS Total_Count
FROM 
    cpatients
GROUP BY 
    Gender;

############ STATE AND GENDER WISE PATIEND#################
SELECT 
    State, 
    Gender, 
    COUNT(*) AS Count
FROM 
    cpatients
GROUP BY 
    State, Gender
ORDER BY 
    State, Gender;


################ AGE GROUP DISTRIBUTION##########
SELECT 
    CASE 
        WHEN Age BETWEEN 0 AND 18 THEN '0-18'
        WHEN Age BETWEEN 19 AND 35 THEN '19-35'
        WHEN Age BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+' 
    END AS Age_Group,
    COUNT(*) AS Total_Patients
FROM 
    cpatients
GROUP BY 
    Age_Group
ORDER BY 
    Age_Group;


########## MOST COMMON SPECIALIZATION BY VISIT COUNT###############
SELECT 
    d.Specialization, 
    COUNT(v.VisitID) AS Visit_Count
FROM 
cdoctors d
JOIN 
cvisit v ON d.DoctorID = v.DoctorID
GROUP BY 
    d.Specialization
ORDER BY 
    Visit_Count DESC;

##### TOP 5 EXPENSIVE TREATMENT#######
SELECT 
    TreatmentType, 
    AVG(Cost) AS Average_Cost
FROM 
    ctreatment
GROUP BY 
    TreatmentType
ORDER BY 
    Average_Cost DESC
LIMIT 5;


########## TOTAL AMOUNT SPEND BY EACH PATIENT###########

SELECT 
    p.FirstName AS Patient_Name, 
    SUM(t.Cost) AS Total_Treatment_Cost
FROM 
    cpatients as p
JOIN 
    cvisit as  v 
    ON p.PatientID = v.PatientID
JOIN 
    ctreatment t ON v.VisitID = t.VisitID
GROUP BY 
    p.FirstName
ORDER BY 
    Total_Treatment_Cost DESC;

#############END###########



  
  




















