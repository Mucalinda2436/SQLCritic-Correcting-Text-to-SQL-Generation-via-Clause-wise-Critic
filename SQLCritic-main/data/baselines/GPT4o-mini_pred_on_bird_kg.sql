SELECT MAX(`Free Meal Count (K-12)` / `Enrollment (K-12)`) AS HighestEligibleFreeRate FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.County = 'Alameda' AND `Enrollment (K-12)` > 0;
SELECT CDSCode, `School Name`, `Enrollment (Ages 5-17)`, `Free Meal Count (Ages 5-17`, (`Free Meal Count (Ages 5-17)` / NULLIF(`Enrollment (Ages 5-17)`, 0)) AS EligibleFreeRate FROM frpm WHERE `School Type` = 'Continuation School' ORDER BY EligibleFreeRate ASC LIMIT 3;
SELECT s.Zip FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.County Name = 'Fresno' AND f.`Charter School (Y/N)` = 1;
SELECT s.MailStreet, s.MailStrAbr, s.MailCity, s.MailZip, s.MailState FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`FRPM Count (K-12)` = ( SELECT MAX(`FRPM Count (K-12)`) FROM frpm ) LIMIT 1;
SELECT s.Phone FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE f.`Charter School (Y/N)` = 1 AND s.OpenDate > '2000-01-01';
SELECT COUNT(*) AS NumberOfSchools FROM satscores s JOIN schools sch ON s.cds = sch.CDSCode WHERE s.AvgScrMath < 400 AND sch.Virtual = 'F';
SELECT s.CDSCode, s.School AS School_Name, s.County AS County_Name, s.District AS District_Name, s.City AS City_Name FROM satscores st JOIN schools s ON st.cds = s.CDSCode WHERE st.NumTstTakr > 500 AND s.Magnet = 1;
SELECT s.Phone FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE ss.NumTstTakr = ( SELECT MAX(NumTstTakr) FROM satscores WHERE AvgScrMath + AvgScrRead + AvgScrWrite > 1500 ) AND (ss.AvgScrMath > 500 OR ss.AvgScrRead > 500 OR ss.AvgScrWrite > 500) LIMIT 1;
SELECT s.NumTstTakr FROM satscores s JOIN frpm f ON s.cds = f.CDSCode WHERE f.`FRPM Count (K-12)` = ( SELECT MAX(`FRPM Count (K-12)`) FROM frpm );
SELECT COUNT(*) AS charter_funded_count FROM satscores s JOIN schools sch ON s.cds = sch.CDSCode WHERE s.AvgScrMath > 560 AND sch.Charter = 1;
SELECT frpm.`FRPM Count (Ages 5-17)` FROM frpm JOIN satscores ON frpm.CDSCode = satscores.cds WHERE satscores.AvgScrRead = ( SELECT MAX(AvgScrRead) FROM satscores )
SELECT f.CDSCode FROM frpm f WHERE (COALESCE(f.`Enrollment (K-12)`, 0) + COALESCE(f.`Enrollment (Ages 5-17)`, 0)) > 500;
SELECT MAX( `Free Meal Count (Ages 5-17)` / `Enrollment (Ages 5-17)` ) AS HighestEligibleFreeRate FROM satscores s JOIN frpm f ON s.cds = f.CDSCode WHERE (s.NumGE1500 * 1.0 / s.NumTstTakr) > 0.3 AND `Enrollment (Ages 5-17)` > 0; -- To avoid division by zero
SELECT s.Phone FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE ss.NumTstTakr > 0 -- To avoid division by zero ORDER BY (ss.NumGE1500 * 1.0 / ss.NumTstTakr) DESC LIMIT 3;
SELECT s.NCESSchool, f.`Enrollment (Ages 5-17)` FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode ORDER BY f.`Enrollment (Ages 5-17` DESC LIMIT 5;
SELECT s.District AS DistrictName, AVG(sc.AvgScrRead) AS AvgReadingScore FROM satscores sc JOIN schools s ON sc.cds = s.CDSCode WHERE s.StatusType = 'Active' -- Replace with the exact status type that indicates an active district GROUP BY s.District ORDER BY AvgReadingScore DESC LIMIT 1;
SELECT COUNT(*) AS NumberOfSchools FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.District LIKE '%Alameda%' AND ss.NumTstTakr < 100;
SELECT frpm.`Charter School Number` FROM satscores JOIN schools ON satscores.cds = schools.CDSCode JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE satscores.AvgScrWrite = 499;
SELECT COUNT(*) AS SchoolCount FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.County = 'Contra Costa' AND s.FundingType = 'Directly Funded' -- Replace 'Directly Funded' with the actual identifier AND ss.NumTstTakr <= 250;
SELECT sch.Phone FROM schools sch JOIN satscores sat ON sch.CDSCode = sat.cds WHERE sat.AvgScrMath = ( SELECT MAX(AvgScrMath) FROM satscores );
SELECT COUNT(*) FROM frpm WHERE `County Name` = 'Amador' AND `Low Grade` = '9' AND `High Grade` = '12';
SELECT COUNT(*) AS SchoolsCount FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.County = 'Los Angeles' AND f.`Free Meal Count (K-12)` > 500 AND f.`FRPM Count (K-12)` < 700;
SELECT s.School AS School_Name, ss.NumTstTakr AS Number_of_Test_Takers FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE s.County = 'Contra Costa' ORDER BY ss.NumTstTakr DESC LIMIT 1;
SELECT s.School AS School_Name, s.Street || ', ' || s.City || ', ' || s.State || ' ' || s.Zip AS Full_Street_Address FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE (f."Enrollment (K-12)" - f."Enrollment (Ages 5-17)") > 30;
SELECT f.`School Name` FROM frpm f JOIN satscores s ON f.CDSCode = s.cds WHERE f.`Percent (%) Eligible Free (K-12)` > 0.1 AND s.NumTstTakr > 0 AND (s.AvgScrRead >= 1500 OR s.AvgScrMath >= 1500 OR s.AvgScrWrite >= 1500);
SELECT s.County, s.FundingType FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE s.County = 'Riverside' AND ss.AvgScrMath > 400;
SELECT s.School AS School_Name, s.Street || ', ' || s.City || ', ' || s.State || ' ' || s.Zip AS Full_Communication_Address FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`County Name` = 'Monterey' AND f.`School Type` LIKE '%High%' -- Assuming 'High' indicates it's a high school AND f.`FRPM Count (Ages 5-17)` > 800;
SELECT s.School AS School_Name, ss.AvgScrWrite AS Avg_Writing_Score, s.Phone AS Communication_Number FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE (s.OpenDate > '1991-12-31' OR s.ClosedDate < '2000-01-01')
SELECT f.CDSCode, s.School AS SchoolName, s.DOCType, (f."Enrollment (K-12)" - f."Enrollment (Ages 5-17)") AS EnrollmentDifference FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f."Charter School (Y/N)" = 0 -- Assuming locally funded means not a charter school ), AverageDifference AS ( SELECT AVG(EnrollmentDifference) AS AvgDifference FROM SchoolDifferences ) SELECT sd.SchoolName, sd.DOCType FROM SchoolDifferences sd JOIN AverageDifference ad ON sd.EnrollmentDifference > ad.AvgDifference
SELECT s.OpenDate FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE f.Enrollment (K-12) = ( SELECT MAX(f2."Enrollment (K-12)") FROM frpm f2 ) LIMIT 1;
SELECT s.City, SUM(f.`Enrollment (K-12)`) AS Total_Enrollment FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode GROUP BY s.City ORDER BY Total_Enrollment ASC LIMIT 5;
SELECT f.CDSCode, f.`School Name`, f.`Enrollment (K-12)`, f.`Free Meal Count (K-12)`, CASE WHEN f.`Enrollment (K-12)` > 0 THEN (f.`Free Meal Count (K-12)` / f.`Enrollment (K-12)`) ELSE 0 END AS `Eligible Free Rate` FROM frpm AS f JOIN schools AS s ON f.CDSCode = s.CDSCode ORDER BY f.`Enrollment (K-12)` DESC LIMIT 2 OFFSET 9; -- OFFSET 9 to skip the first 9 entries, LIMIT 2 to get the 10th and 11th
SELECT s.CDSCode, s.School, f.`FRPM Count (K-12)`, f.`Enrollment (K-12)`, (f.`FRPM Count (K-12)` / f.`Enrollment (K-12)`) AS `Eligible Free or Reduced Price Meal Rate` FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.Charter = 66 -- Assuming '66' corresponds to the ownership code for charters ORDER BY f.`FRPM Count (K-12)` DESC LIMIT 5;
SELECT s.School AS School_Name, s.Website AS Website_Address FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`Free Meal Count (Ages 5-17)` BETWEEN 1900 AND 2000;
SELECT f.CDSCode, (f.`Free Meal Count (Ages 5-17)` / f.`Enrollment (Ages 5-17)`) AS FreeMealRate FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.AdmFName1 = 'Kacey' AND s.AdmLName1 = 'Gibson';
SELECT s.AdmEmail1 AS AdminEmail FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`Charter School (Y/N)` = 1 ORDER BY f.`Enrollment (K-12)` ASC LIMIT 1;
SELECT CASE WHEN AdmFName1 IS NOT NULL AND AdmLName1 IS NOT NULL THEN AdmFName1 || ' ' || AdmLName1 WHEN AdmFName2 IS NOT NULL AND AdmLName2 IS NOT NULL THEN AdmFName2 || ' ' || AdmLName2 WHEN AdmFName3 IS NOT NULL AND AdmLName3 IS NOT NULL THEN AdmFName3 || ' ' || AdmLName3 ELSE 'No Administrator' END AS FullName FROM schools s JOIN satscores sa ON s.CDSCode = sa.cds WHERE sa.NumTstTakr IS NOT NULL AND sa.NumGE1500 IS NOT NULL ORDER BY sa.NumTstTakr DESC LIMIT 1;
SELECT s.Street, s.City, s.Zip, s.State FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE ss.NumTstTakr > 0 -- Ensure we avoid division by zero ORDER BY (ss.NumGE1500 * 1.0 / ss.NumTstTakr) ASC -- Calculate excellence rate and sort ascending LIMIT 1; -- Limit to the first result which will be the lowest excellence rate
SELECT s.Website FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE s.County = 'Los Angeles' AND ss.NumTstTakr BETWEEN 2000 AND 3000;
SELECT AVG(s.NumTstTakr) AS AvgNumTestTakers FROM schools AS sch JOIN satscores AS s ON sch.CDSCode = s.cds WHERE sch.City = 'Fresno' AND sch.OpenDate BETWEEN '1980-01-01' AND '1980-12-31';
SELECT s.Phone FROM schools s JOIN satscores sa ON s.CDSCode = sa.cds WHERE s.District = 'Fresno Unified' ORDER BY sa.AvgScrRead ASC LIMIT 1;
SELECT s.School AS SchoolName, ss.AvgScrRead AS AverageReadingScore FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.Virtual = 'F' ORDER BY ss.AvgScrRead DESC LIMIT 5;
SELECT s.`Educational Option Type` FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE ss.AvgScrMath = ( SELECT MAX(AvgScrMath) FROM satscores )
SELECT s.county AS County, ss.AvgScrMath AS AverageMathScore FROM satscores AS ss JOIN frpm AS f ON ss.cds = f.CDSCode WHERE (AvgScrRead + AvgScrMath + AvgScrWrite) = ( SELECT MIN((AvgScrRead + AvgScrMath + AvgScrWrite) / 3.0) FROM satscores WHERE AvgScrRead IS NOT NULL AND AvgScrMath IS NOT NULL AND AvgScrWrite IS NOT NULL )
SELECT s.City, sa.AvgScrWrite, sa.NumTstTakr FROM satscores sa JOIN schools s ON sa.cds = s.CDSCode WHERE sa.NumTstTakr >= 1500 ), MaxTakers AS ( SELECT MAX(NumTstTakr) AS MaxTestTakers FROM EligibleSchools ) SELECT AVG(AvgScrWrite) AS AverageWritingScore, City FROM EligibleSchools WHERE NumTstTakr = (SELECT MaxTestTakers FROM MaxTakers) GROUP BY City
SELECT s.School AS School_Name, AVG(sa.AvgScrWrite) AS Average_Writing_Score FROM schools s JOIN satscores sa ON s.CDSCode = sa.cds WHERE s.AdmFName1 = 'Ricci' AND s.AdmLName1 = 'Ulrich' -- Assuming the first admin in the fields would be Ricci Ulrich GROUP BY s.School;
SELECT s.School AS School_Name, f."Enrollment (K-12)" AS Enrollment_Count FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.DOC = '31' ORDER BY f."Enrollment (K-12)" DESC LIMIT 1;
SELECT COUNT(*) / 12.0 AS MonthlyAverageSchoolsOpened FROM schools WHERE OpenDate >= '1980-01-01' AND OpenDate <= '1980-12-31' AND County = 'Alameda' AND DOC = '52';
SELECT SUM(CASE WHEN DOC = '54' THEN 1 ELSE 0 END) AS Unified_School_Count, SUM(CASE WHEN DOC = '52' THEN 1 ELSE 0 END) AS Elementary_School_Count, CASE WHEN SUM(CASE WHEN DOC = '52' THEN 1 ELSE 0 END) > 0 THEN SUM(CASE WHEN DOC = '54' THEN 1 ELSE 0 END) * 1.0 / SUM(CASE WHEN DOC = '52' THEN 1 ELSE 0 END) ELSE NULL END AS Ratio FROM schools WHERE County = 'Orange' AND DOC IN ('52', '54');
SELECT County, School, ClosedDate FROM schools WHERE ClosedDate IS NOT NULL ), CountedClosedSchools AS ( SELECT County, COUNT(*) AS ClosedSchoolCount FROM ClosedSchools GROUP BY County ORDER BY ClosedSchoolCount DESC LIMIT 1 ) -- Step 2: Select the names of the closed schools from the top county SELECT cs.School, cs.ClosedDate FROM ClosedSchools cs JOIN CountedClosedSchools ccs ON cs.County = ccs.County
SELECT s.School AS SchoolName, s.Street AS PostalStreet, s.City AS City, s.State AS State, ss.AvgScrMath, ROW_NUMBER() OVER (ORDER BY ss.AvgScrMath DESC) AS Rank FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode ) SELECT SchoolName, PostalStreet, City, State FROM RankedSchools WHERE Rank = 6
SELECT s.MailStreet, s.School FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode ORDER BY ss.AvgScrRead ASC LIMIT 1;
SELECT COUNT(*) AS TotalSchools FROM schools s JOIN satscores sa ON s.CDSCode = sa.cds WHERE s.MailCity = 'Lakeport' AND (COALESCE(sa.AvgScrRead, 0) + COALESCE(sa.AvgScrMath, 0) + COALESCE(sa.AvgScrWrite, 0)) >= 1500;
SELECT SUM(ss.NumTstTakr) AS TotalTestTakers FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.MailCity = 'Fresno';
SELECT School, MailZip FROM schools WHERE (AdmFName1 = 'Avetik' AND AdmLName1 = 'Atoian') OR (AdmFName2 = 'Avetik' AND AdmLName2 = 'Atoian') OR (AdmFName3 = 'Avetik' AND AdmLName3 = 'Atoian');
SELECT (SELECT COUNT(*) FROM schools WHERE MailState = 'CA' AND County = 'Colusa') * 1.0 / (SELECT COUNT(*) FROM schools WHERE MailState = 'CA' AND County = 'Humboldt') AS Colusa_to_Humboldt_Ratio
SELECT COUNT(*) AS ActiveSchoolsCount FROM schools WHERE StatusType = 'Active' AND MailState = 'CA' AND County = 'San Joaquin';
SELECT s.Phone, s.Ext FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode ORDER BY ss.AvgScrWrite DESC LIMIT 1 OFFSET 332; -- OFFSET 332 gives us the 333rd record (0-based index)
SELECT School, Phone, Ext FROM schools WHERE Zip = '95203-3704';
SELECT Website FROM schools WHERE (AdmFName1 = 'Mike' AND AdmLName1 = 'Larson') OR (AdmFName2 = 'Mike' AND AdmLName2 = 'Larson') OR (AdmFName3 = 'Mike' AND AdmLName3 = 'Larson') OR (AdmFName1 = 'Dante' AND AdmLName1 = 'Alvarez') OR (AdmFName2 = 'Dante' AND AdmLName2 = 'Alvarez') OR (AdmFName3 = 'Dante' AND AdmLName3 = 'Alvarez');
SELECT Website FROM schools WHERE Charter = 1 AND Virtual = 'P' AND County = 'San Joaquin';
SELECT COUNT(*) AS CharterSchoolCount FROM schools WHERE Charter = 1 AND DOC = 52 AND City = 'Hickman';
SELECT COUNT(*) AS TotalNonCharteredSchools FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.Charter = 0 AND f.`County Name` = 'Los Angeles' AND f.`Percent (%) Eligible Free (K-12)` < 0.18;
SELECT CONCAT(s.AdmFName1, ' ', s.AdmLName1) AS AdministratorName1, CONCAT(s.AdmFName2, ' ', s.AdmLName2) AS AdministratorName2, CONCAT(s.AdmFName3, ' ', s.AdmLName3) AS AdministratorName3, s.School AS SchoolName, s.City AS City FROM schools s WHERE s.Charter = 1 AND s.CharterNum = '00D2';
SELECT COUNT(*) AS TotalSchools FROM schools WHERE MailCity = 'Hickman' AND CharterNum = '00D4';
SELECT (COUNT(CASE WHEN FundingType = 'Locally Funded' THEN 1 END) * 100.0 / COUNT(*)) AS Percentage_Locally_Funded FROM schools WHERE County = 'Santa Clara';
SELECT COUNT(*) FROM schools WHERE FundingType = 'Directly Funded' AND County = 'Stanislaus' AND OpenDate BETWEEN '2000-01-01' AND '2005-12-31';
SELECT COUNT(*) AS TotalClosed FROM schools WHERE ClosedDate BETWEEN '1989-01-01' AND '1989-12-31' AND City = 'San Francisco' AND FundingType LIKE '%Community College District%';
SELECT County, COUNT(*) AS ClosureCount FROM schools WHERE ClosedDate BETWEEN '1980-01-01' AND '1989-12-31' AND SOC = '11' GROUP BY County ORDER BY ClosureCount DESC LIMIT 1;
SELECT s.NCESDist FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.SOC = '31';
SELECT StatusType, COUNT(*) AS SchoolCount FROM schools WHERE County = 'Alpine' AND StatusType IN ('Active', 'Closed') AND District LIKE '%District Community Day School%' GROUP BY StatusType;
SELECT `District Code` FROM schools WHERE City = 'Fresno' AND Magnet = 0;
SELECT SUM(f.`Enrollment (Ages 5-17)`) AS TotalEnrollmentAges5To17 FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`Academic Year` = '2014-2015' AND s.EdOpsCode = 'SSS' AND (s.County LIKE '%Fremont%' OR s.District LIKE '%Fremont%');
SELECT f.`FRPM Count (Ages 5-17)` FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.SchoolType = 'Youth Authority School' AND s.MailStreet = 'PO Box 1040';
SELECT MIN(f.`Low Grade`) AS LowestGrade FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.EdOpsCode = 'SPECON' AND s.NCESDist = '613360';
SELECT s.School, f.`Low Grade`, f.`High Grade` FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`County Code` = '37' AND f.`NSLP Provision Status` = 'Breakfast Provision 2';
SELECT s.City FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`NSLP Provision Status` = '2' AND f.`Low Grade` = '9' AND f.`High Grade` = '12' AND s.County = 'Merced' AND s.EILCode = 'HS';
SELECT s.School Name, f.`Percent (%) Eligible FRPM (Ages 5-17)` FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE f.`Low Grade` = 'K' AND f.`High Grade` = '9' AND s.County = 'Los Angeles';
SELECT f.`Low Grade`, f.`High Grade`, COUNT(*) AS GradeSpanCount FROM frpm AS f JOIN schools AS s ON f.CDSCode = s.CDSCode WHERE s.City = 'Adelanto' GROUP BY f.`Low Grade`, f.`High Grade` ORDER BY GradeSpanCount DESC LIMIT 1;
SELECT County, COUNT(*) AS SchoolCount FROM schools WHERE Virtual = 'F' AND (County = 'San Diego' OR County = 'Santa Barbara') GROUP BY County;
SELECT School, Latitude, SchoolType FROM schools WHERE Latitude = (SELECT MAX(Latitude) FROM schools);
SELECT s.City, s.School AS SchoolName, f.`Low Grade` AS LowestGrade FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.State = 'CA' ORDER BY s.Latitude ASC LIMIT 1;
SELECT `Low Grade`, `High Grade` FROM schools WHERE Longitude = (SELECT MAX(Longitude) FROM schools);
SELECT COUNT(DISTINCT s.CDSCode) AS NumberOfMagnetSchoolsWithMultipleProvisions FROM schools s INNER JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.Magnet = 1 AND f.`Low Grade` = 'K' AND f.`High Grade` <= '8' AND f.`Educational Option Type` IS NOT NULL -- Ensuring there are 'Provision Types' AND (SELECT COUNT(DISTINCT `Educational Option Type`) FROM frpm f2 WHERE f2.CDSCode = f.CDSCode) > 1
SELECT AdmFName1 AS FirstName, District Name FROM schools WHERE AdmFName1 IS NOT NULL UNION ALL SELECT AdmFName2 AS FirstName, District Name FROM schools WHERE AdmFName2 IS NOT NULL UNION ALL SELECT AdmFName3 AS FirstName, District Name FROM schools WHERE AdmFName3 IS NOT NULL ) SELECT FirstName, COUNT(*) AS NameCount, GROUP_CONCAT(DISTINCT District) AS Districts FROM AdminFirstNames GROUP BY FirstName ORDER BY NameCount DESC LIMIT 2
SELECT f.`District Code`, (f.`Free Meal Count (K-12)` / f.`Enrollment (K-12)` * 100) AS `Percent (%) Eligible Free (K-12)` FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.AdmFName1 = 'Alusine' OR s.AdmFName2 = 'Alusine' OR s.AdmFName3 = 'Alusine';
SELECT s.AdmLName1 AS Administrator_Last_Name, f.`District Name`, f.`County Name`, f.`School Name` FROM schools AS s JOIN frpm AS f ON s.CDSCode = f.CDSCode WHERE f.`Charter School Number` = '40';
SELECT AdmEmail1, AdmEmail2, AdmEmail3 FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE s.County = 'San Bernardino' AND s.District = 'San Bernardino City Unified' AND s.OpenDate BETWEEN '2009-01-01' AND '2010-12-31' AND (s.SOC = '62' OR s.DOC = '54');
SELECT s.AdmEmail1 -- Assuming we want the first administrator's email , s.School -- To provide the name of the school FROM satscores ss JOIN schools s ON ss.cds = s.CDSCode WHERE ss.NumTstTakr > 0 AND (ss.AvgScrRead >= 1500 OR ss.AvgScrMath >= 1500 OR ss.AvgScrWrite >= 1500) -- Filter for scores >= 1500 ORDER BY ss.NumTstTakr DESC -- Order by number of test takers in descending order LIMIT 1; -- Get only the top result
SELECT COUNT(DISTINCT d.account_id) AS account_count FROM disp d JOIN client c ON d.client_id = c.client_id JOIN district di ON c.district_id = di.district_id WHERE di.A3 = 'East Bohemia' -- Assuming 'East Bohemia' is correctly represented in your database. AND d.type = 'POPLATEK PO OBRATU'; -- This corresponds to 'issuance after transaction'.
SELECT COUNT(DISTINCT a.account_id) AS eligible_accounts FROM account a JOIN district d ON a.district_id = d.district_id JOIN loan l ON a.account_id = l.account_id WHERE d.A3 = 'Prague'; -- A3 contains the data for region
SELECT CASE WHEN AVG(A12) > AVG(A13) THEN '1995 has a higher unemployment rate' WHEN AVG(A12) < AVG(A13) THEN '1996 has a higher unemployment rate' ELSE 'Both years have the same unemployment rate' END AS Result, AVG(A12) AS Average_1995_Employment_Rate, AVG(A13) AS Average_1996_Employment_Rate FROM district;
SELECT COUNT(*) AS num_districts FROM district WHERE A11 > 6000 AND A11 < 10000;
SELECT COUNT(*) AS male_customer_count FROM client c JOIN district d ON c.district_id = d.district_id WHERE c.gender = 'M' AND d.A3 = 'North Bohemia' AND d.A11 > 8000;
SELECT c.client_id, c.birth_date, d.A11 AS average_salary, a.account_id FROM client c JOIN district d ON c.district_id = d.district_id JOIN disp disp ON disp.client_id = c.client_id JOIN account a ON a.account_id = disp.account_id WHERE c.gender = 'F' ) SELECT account_id, MIN(average_salary) AS lowest_average_salary, MAX(average_salary) AS highest_average_salary, (MAX(average_salary) - MIN(average_salary)) AS salary_gap FROM OldestFemales WHERE birth_date = (SELECT MIN(birth_date) FROM OldestFemales) -- Oldest female clients GROUP BY account_id
SELECT a.account_id FROM account a JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id JOIN district ds ON c.district_id = ds.district_id WHERE c.birth_date = (SELECT MIN(birth_date) FROM client) AND ds.A11 = (SELECT MAX(A11) FROM district);
SELECT COUNT(DISTINCT c.client_id) AS owner_count FROM client c JOIN disp d ON c.client_id = d.client_id JOIN account a ON d.account_id = a.account_id WHERE a.frequency = 'POPLATEK TYDNE' AND d.type = 'Owner';
SELECT c.client_id, c.gender FROM client c JOIN disp d ON c.client_id = d.client_id WHERE d.type = 'Disponent';
SELECT a.account_id, MIN(l.amount) AS lowest_approved_amount FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.date >= '1997-01-01' AND l.date < '1998-01-01' AND a.frequency = 'POPLATEK TYDNE' GROUP BY a.account_id ORDER BY lowest_approved_amount ASC LIMIT 1; -- To get only the account with the lowest approved loan
SELECT a.account_id, l.amount FROM account a JOIN loan l ON a.account_id = l.account_id WHERE l.duration > 12 AND strftime('%Y', a.date) = '1993' ORDER BY l.amount DESC LIMIT 1;
SELECT COUNT(DISTINCT c.client_id) AS female_customers_before_1950_in_slokolov FROM client c JOIN disp d ON c.client_id = d.client_id JOIN account a ON d.account_id = a.account_id JOIN district dist ON c.district_id = dist.district_id WHERE c.gender = 'F' AND c.birth_date < '1950-01-01' AND dist.A2 = 'Slokolov';
SELECT DISTINCT t.account_id FROM trans t WHERE t.date = ( SELECT MIN(date) FROM trans WHERE strftime('%Y', date) = '1995' )
SELECT a.account_id FROM account a JOIN loan l ON a.account_id = l.account_id WHERE a.date < '1997-01-01' GROUP BY a.account_id HAVING SUM(l.amount) > 3000;
SELECT c.client_id FROM client c JOIN disp d ON c.client_id = d.client_id JOIN card ca ON d.disp_id = ca.disp_id WHERE ca.issued = '1994-03-03';
SELECT a.date AS account_opened_date FROM trans t JOIN account a ON t.account_id = a.account_id WHERE t.amount = 840 AND t.date = '1998-10-14';
SELECT a.district_id FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.date = '1994-08-25';
SELECT MAX(t.amount) AS biggest_transaction FROM trans t JOIN disp d ON t.account_id = d.account_id JOIN card c ON d.disp_id = c.disp_id WHERE c.issued = '1996-10-21';
SELECT gender FROM client WHERE district_id = ( SELECT district_id FROM district ORDER BY A11 DESC LIMIT 1 ) ORDER BY birth_date LIMIT 1;
SELECT l.account_id, MAX(l.amount) AS max_amount FROM loan l GROUP BY l.account_id ), ClientFirstTransaction AS ( SELECT t.amount, t.date FROM trans t JOIN account a ON t.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id JOIN MaxLoan ml ON a.account_id = ml.account_id WHERE t.date > a.date ORDER BY t.date ASC ) SELECT amount FROM ClientFirstTransaction LIMIT 1
SELECT COUNT(DISTINCT c.client_id) AS number_of_women_clients FROM client c JOIN account a ON c.client_id = a.account_id JOIN district d ON c.district_id = d.district_id WHERE c.gender = 'F' AND d.A2 = 'Jesenik';
SELECT d.disp_id FROM trans t JOIN disp d ON t.account_id = d.account_id WHERE t.amount = 5100 AND t.date = '1998-09-02';
SELECT district_id FROM district WHERE A2 = 'Litomerice';
SELECT d.A2 FROM client c JOIN disp di ON c.client_id = di.client_id JOIN account a ON di.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE c.gender = 'F' AND c.birth_date = '1976-01-29';
SELECT c.birth_date FROM loan l JOIN disp d ON l.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE l.amount = 98832 AND l.date = '1996-01-03';
SELECT a.account_id FROM account a JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id JOIN district dist ON c.district_id = dist.district_id WHERE dist.A3 = 'Prague' ORDER BY a.date LIMIT 1;
SELECT district_id FROM district WHERE A3 = 'South Bohemia' ORDER BY A4 DESC LIMIT 1 ), MaleClientCount AS ( SELECT COUNT(*) AS male_count FROM client WHERE gender = 'M' AND district_id = (SELECT district_id FROM MaxInhabitants) ), TotalClientCount AS ( SELECT COUNT(*) AS total_count FROM client WHERE district_id = (SELECT district_id FROM MaxInhabitants) ) SELECT (CAST(male_count AS REAL) / NULLIF(total_count, 0)) * 100 AS percentage_male_clients FROM MaleClientCount, TotalClientCount
SELECT client_id FROM disp d JOIN loan l ON d.account_id = l.account_id WHERE l.date = '1993-07-05';
SELECT (SUM(CASE WHEN status = 'A' THEN amount ELSE 0 END) * 100.0 / NULLIF(SUM(amount), 0)) AS percentage_fully_paid FROM loan;
SELECT DISTINCT account_id FROM loan WHERE amount < 100000 ), active_accounts AS ( SELECT DISTINCT account_id FROM loan WHERE amount < 100000 AND status = 'C' ) SELECT (COUNT(a.account_id) * 100.0 / NULLIF((SELECT COUNT(*) FROM accounts_under_100k), 0)) AS percentage_active FROM active_accounts a
SELECT a.account_id, d.A2 AS district_name, d.A3 AS district_region FROM account a JOIN district d ON a.district_id = d.district_id JOIN trans t ON a.account_id = t.account_id WHERE strftime('%Y', a.date) = '1993' AND t.operation = 'POPLATEK PO OBRATU';
SELECT a.account_id, a.frequency FROM account a JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id JOIN district dist ON c.district_id = dist.district_id WHERE dist.A2 = 'east Bohemia' AND a.date BETWEEN '1995-01-01' AND '2000-12-31';
SELECT a.account_id, a.date FROM account a JOIN district d ON a.district_id = d.district_id WHERE d.A2 = 'Prachatice';
SELECT d.district_id, d.A2 AS district, d.A3 AS region FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.loan_id = 4990;
SELECT a.account_id, d.A2 AS district, d.A3 AS region FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.amount > 300000;
SELECT l.loan_id, d.district_id, d.A11 AS average_salary FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.duration = 60;
SELECT d.district_id, ((d.A13 - d.A12) / d.A12) * 100 AS unemployment_increment_rate FROM loan l JOIN account a ON l.account_id = a.account_id JOIN client c ON a.district_id = c.district_id JOIN district d ON c.district_id = d.district_id WHERE l.status = 'D';
SELECT district_id FROM district WHERE A2 = 'Decin' ), accounts_1993 AS ( SELECT * FROM account WHERE strftime('%Y', date) = '1993' ) SELECT (COUNT(a.account_id) * 100.0 / NULLIF(COUNT(NULLIF(a.district_id, dd.district_id)), 0)) AS percentage_decin_accounts FROM accounts_1993 a LEFT JOIN decin_district dd ON a.district_id = dd.district_id WHERE dd.district_id IS NOT NULL
SELECT account_id FROM account WHERE frequency = 'POPLATEK MESICNE';
SELECT d.district_id, COUNT(DISTINCT a.account_id) AS female_account_count FROM client c JOIN disp di ON c.client_id = di.client_id JOIN account a ON di.account_id = a.account_id JOIN district d ON c.district_id = d.district_id WHERE c.gender = 'F' GROUP BY d.district_id ORDER BY female_account_count DESC LIMIT 10;
SELECT d.A2 AS district_name, SUM(t.amount) AS total_withdrawals FROM trans t JOIN account a ON t.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE t.type = 'VYDAJ' AND t.date LIKE '1996-01%' GROUP BY d.A2 ORDER BY total_withdrawals DESC LIMIT 10;
SELECT COUNT(a.account_id) AS accounts_without_credit_cards FROM account a JOIN district d ON a.district_id = d.district_id LEFT JOIN card c ON a.account_id = c.account_id WHERE d.A3 = 'South Bohemia' AND c.card_id IS NULL;
SELECT d.district_id, d.A3 AS district_name, COUNT(l.loan_id) AS active_loans FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.status IN ('C', 'D') GROUP BY d.district_id ORDER BY active_loans DESC LIMIT 1;
SELECT AVG(l.amount) AS average_loan_amount FROM loan l JOIN account a ON l.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.gender = 'M';
SELECT A2 AS district_name, A13 AS unemployment_rate FROM district WHERE A13 = (SELECT MAX(A13) FROM district);
SELECT COUNT(*) AS number_of_accounts FROM account WHERE district_id = ( SELECT district_id FROM district ORDER BY A16 DESC LIMIT 1 );
SELECT COUNT(DISTINCT a.account_id) AS num_negative_balance_accounts FROM trans t JOIN account a ON t.account_id = a.account_id WHERE t.operation = 'VYBER KARTOU' AND a.frequency = 'POPLATEK MESICNE' AND t.balance < 0;
SELECT COUNT(DISTINCT l.account_id) AS approved_loans_count FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.amount >= 250000 AND a.frequency = 'POPLATEK MESICNE' AND l.date BETWEEN '1995-01-01' AND '1997-12-31' AND l.status = 'approved'; -- Assuming 'approved' is a valid status for filtering
SELECT COUNT(DISTINCT a.account_id) AS running_contracts_count FROM account a JOIN loan l ON a.account_id = l.account_id WHERE l.status = 'C' AND a.district_id = 1; -- Assuming district_id 1 corresponds to Branch location 1
SELECT COUNT(*) AS male_client_count FROM client WHERE gender = 'M' AND district_id = ( SELECT district_id FROM district ORDER BY A15 DESC LIMIT 1 OFFSET 1 );
SELECT COUNT(*) AS high_level_disponent_count FROM card c JOIN disp d ON c.card_id = d.disp_id WHERE c.type = 'gold' AND d.type = 'disponent';
SELECT COUNT(*) AS number_of_accounts FROM account WHERE district_id = (SELECT district_id FROM district WHERE A2 = 'Pisek');
SELECT d.district_id FROM district d JOIN account a ON d.district_id = a.district_id JOIN trans t ON a.account_id = t.account_id WHERE strftime('%Y', t.date) = '1997' AND t.amount > 10000 GROUP BY d.district_id HAVING SUM(t.amount) > 10000;
SELECT DISTINCT a.account_id FROM account a JOIN `order` o ON a.account_id = o.account_id JOIN district d ON a.district_id = d.district_id WHERE o.k_symbol = 'SIPO' AND d.A2 = 'Pisek';
SELECT disp.account_id FROM disp JOIN card ON disp.card_id = card.card_id WHERE card.type IN ('gold', 'junior') GROUP BY disp.account_id HAVING COUNT(DISTINCT card.type) = 2;
SELECT strftime('%Y-%m', date) AS month, -- Get the year and month from the date AVG(amount) AS average_amount -- Calculate the average amount FROM trans WHERE date >= '2021-01-01' AND date < '2022-01-01' -- Filter for the year 2021 AND operation = 'VYBER KARTOU' -- Filter for credit card withdrawal transactions GROUP BY month -- Group results by month ORDER BY month; -- Order results by month
SELECT a.account_id, SUM(t.amount) AS total_spent, strftime('%Y-%m', t.date) AS month FROM account a JOIN card c ON a.account_id = c.account_id JOIN trans t ON a.account_id = t.account_id WHERE t.type = 'VYBER KARTOU' -- Assuming this refers to credit card transactions AND strftime('%Y', t.date) = '1998' GROUP BY a.account_id, month ), AverageSpending AS ( SELECT AVG(total_spent) AS avg_spent FROM MonthlySpending ) SELECT ms.account_id FROM MonthlySpending ms JOIN AverageSpending a ON ms.total_spent < a.avg_spent GROUP BY ms.account_id
SELECT DISTINCT c.client_id, c.gender, c.birth_date FROM client c INNER JOIN disp d ON c.client_id = d.client_id INNER JOIN account a ON d.account_id = a.account_id INNER JOIN card ca ON d.disp_id = ca.disp_id INNER JOIN loan l ON a.account_id = l.account_id WHERE c.gender = 'F';
SELECT COUNT(DISTINCT a.account_id) AS female_clients_in_south_bohemia FROM client c JOIN district d ON c.district_id = d.district_id JOIN account a ON a.district_id = d.district_id WHERE c.gender = 'F' AND d.A3 = 'south Bohemia';
SELECT a.account_id FROM account a JOIN district d ON a.district_id = d.district_id WHERE d.A2 = 'Tabor' AND a.frequency = 'OWNER';
SELECT DISTINCT a.frequency -- Assuming 'frequency' refers to account types FROM account a JOIN district d ON a.district_id = d.district_id WHERE a.frequency <> 'OWNER' -- Only non-eligible account types AND d.A11 > 8000 AND d.A11 <= 9000; -- Average income filter
SELECT COUNT(DISTINCT a.account_id) AS account_count FROM account a JOIN district d ON a.district_id = d.district_id JOIN trans t ON a.account_id = t.account_id WHERE d.A3 = 'North Bohemia' AND t.bank = 'AB';
SELECT DISTINCT district.A2 FROM trans JOIN account ON trans.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE trans.type = 'VYDAJ';
SELECT AVG(d.A15) AS average_crimes FROM district d JOIN account a ON d.district_id = a.district_id WHERE d.A15 > 4000 AND a.date >= '1997-01-01';
SELECT COUNT(c.card_id) AS eligible_classic_cards FROM card c JOIN disp d ON c.disp_id = d.disp_id JOIN account a ON d.account_id = a.account_id WHERE c.type = 'classic' AND a.type = 'OWNER';
SELECT district_id FROM district WHERE A2 = 'Hl.m. Praha';
SELECT (COUNT(CASE WHEN type = 'gold' AND issued < '1998-01-01' THEN 1 END) * 100.0 / COUNT(*)) AS percent_gold_before_1998 FROM card;
SELECT c.client_id, c.gender, c.birth_date FROM loan l JOIN account a ON l.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE l.amount = (SELECT MAX(amount) FROM loan);
SELECT d.A15 FROM account a JOIN district d ON a.district_id = d.district_id WHERE a.account_id = 532;
SELECT a.district_id FROM `order` o JOIN account a ON o.account_id = a.account_id WHERE o.order_id = 33333;
SELECT trans.trans_id, trans.date, trans.amount, trans.balance, trans.k_symbol, trans.bank, trans.account FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN trans ON account.account_id = trans.account_id WHERE client.client_id = 3356 AND trans.operation = 'VYBER';
SELECT COUNT(DISTINCT a.account_id) AS count_of_accounts FROM account a JOIN loan l ON a.account_id = l.account_id WHERE a.frequency = 'POPLATEK TYDNE' AND l.amount < 200000;
SELECT c.client_id, ca.type FROM client c JOIN disp d ON c.client_id = d.client_id JOIN card ca ON d.disp_id = ca.disp_id WHERE c.client_id = 13539;
SELECT d.A3 AS region FROM client c JOIN district d ON c.district_id = d.district_id WHERE c.client_id = 3541;
SELECT d.district_id, COUNT(DISTINCT a.account_id) AS number_of_accounts FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.status = 'A' GROUP BY d.district_id ORDER BY number_of_accounts DESC LIMIT 1;
SELECT c.client_id, c.gender, c.birth_date FROM `order` o JOIN account a ON o.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE o.order_id = 32423;
SELECT trans.* FROM trans JOIN account ON trans.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE account.district_id = 5;
SELECT district_id FROM district WHERE A2 = 'Jesenik';
SELECT DISTINCT c.client_id FROM card AS ca JOIN disp AS di ON ca.disp_id = di.disp_id JOIN client AS c ON di.client_id = c.client_id WHERE ca.type = 'junior' AND ca.issued >= '1997-01-01';
SELECT (COUNT(CASE WHEN c.gender = 'F' THEN 1 END) * 100.0) / COUNT(*) AS female_percentage FROM client c JOIN district d ON c.district_id = d.district_id WHERE d.A11 > 10000;
SELECT ((SUM(CASE WHEN l.date BETWEEN '1997-01-01' AND '1997-12-31' THEN l.amount ELSE 0 END) - SUM(CASE WHEN l.date BETWEEN '1996-01-01' AND '1996-12-31' THEN l.amount ELSE 0 END)) * 100.0) / NULLIF(SUM(CASE WHEN l.date BETWEEN '1996-01-01' AND '1996-12-31' THEN l.amount ELSE 0 END), 0) ) AS growth_rate FROM client c JOIN disp d ON c.client_id = d.client_id JOIN account a ON d.account_id = a.account_id JOIN loan l ON a.account_id = l.account_id WHERE c.gender = 'M';
SELECT COUNT(*) AS credit_card_withdrawals FROM trans WHERE operation = 'VYBER KARTOU' AND date > '1995-01-01';
SELECT (SELECT A16 FROM district WHERE A3 = 'North Bohemia') - (SELECT A16 FROM district WHERE A3 = 'East Bohemia') AS crime_difference
SELECT COUNT(*) AS disposition_count FROM disp d JOIN account a ON a.account_id = d.account_id WHERE a.account_id BETWEEN 1 AND 10;
SELECT COUNT(*) AS statement_requests_count FROM trans WHERE account_id = 3 AND type = 'statement';
SELECT strftime('%Y', c.birth_date) AS birth_year FROM account a JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE a.account_id = 130;
SELECT COUNT(DISTINCT a.account_id) AS count_accounts FROM account a JOIN disp d ON a.account_id = d.account_id WHERE d.type = 'owner' AND a.frequency = 'POPLATEK PO OBRATU';
SELECT d.client_id, SUM(l.amount) AS total_loan, -- Total amount of loans taken SUM(CASE WHEN l.status = 'paid' THEN l.amount ELSE 0 END) AS total_paid, -- Total amount paid SUM(l.amount) - SUM(CASE WHEN l.status = 'paid' THEN l.amount ELSE 0 END) AS total_debt -- Amount still owed FROM disp d JOIN loan l ON d.account_id = l.account_id WHERE d.client_id = 992 GROUP BY d.client_id;
SELECT account_id FROM disp WHERE client_id = 4;
SELECT c.type FROM card c INNER JOIN disp d ON c.disp_id = d.disp_id WHERE d.client_id = 9;
SELECT SUM(t.amount) AS total_amount FROM trans t JOIN disp d ON t.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.client_id = 617 AND strftime('%Y', t.date) = '1998';
SELECT c.client_id FROM client c JOIN district d ON c.district_id = d.district_id JOIN account a ON a.district_id = d.district_id WHERE c.birth_date BETWEEN '1983-01-01' AND '1987-12-31' AND d.A2 LIKE '%East Bohemia%'; -- Assuming A2 in district contains the district name
SELECT c.client_id, l.amount FROM client c JOIN disp d ON c.client_id = d.client_id JOIN loan l ON d.account_id = l.account_id WHERE c.gender = 'F' ORDER BY l.amount DESC LIMIT 3;
SELECT COUNT(DISTINCT c.client_id) AS male_customers_count FROM client c JOIN disp d ON c.client_id = d.client_id JOIN account a ON d.account_id = a.account_id JOIN trans t ON a.account_id = t.account_id WHERE c.gender = 'M' AND c.birth_date BETWEEN '1974-01-01' AND '1976-12-31' AND t.type = 'SIPO' -- Assuming 'SIPO' refers to household payments AND t.amount > 4000;
SELECT COUNT(*) FROM account WHERE district_id = (SELECT district_id FROM district WHERE A2 = 'Beroun') AND date > '1996-12-31';
SELECT COUNT(DISTINCT c.client_id) AS female_junior_card_count FROM client c JOIN disp d ON c.client_id = d.client_id JOIN card ca ON d.disp_id = ca.disp_id WHERE c.gender = 'F' AND ca.type = 'junior credit card';
SELECT COUNT(CASE WHEN c.gender = 'F' THEN 1 END) * 100.0 / COUNT(*) AS female_percentage FROM client AS c JOIN disp AS d ON c.client_id = d.client_id JOIN account AS a ON d.account_id = a.account_id JOIN district AS dst ON c.district_id = dst.district_id WHERE dst.A3 = 'Prague'; -- Assuming 'Prague' is the identifier for the Prague district
SELECT (COUNT(CASE WHEN c.gender = 'M' THEN 1 END) * 100.0 / COUNT(*)) AS male_percentage FROM account a JOIN client c ON a.district_id = c.district_id WHERE a.frequency = 'POPLATEK TYDNE';
SELECT COUNT(DISTINCT c.client_id) AS client_count FROM client c JOIN disp d ON c.client_id = d.client_id JOIN account a ON d.account_id = a.account_id WHERE a.frequency = 'POPLATEK TYDNE';
SELECT a.account_id, l.amount FROM account a JOIN loan l ON a.account_id = l.account_id WHERE l.duration > 24 -- Loan duration more than 24 months AND a.date < '1997-01-01' -- Account opening date before 1997 ORDER BY l.amount ASC -- Order by approved amount in ascending LIMIT 1; -- Get the lowest approved amount
SELECT c.client_id, c.district_id, strftime('%Y', 'now') - strftime('%Y', c.birth_date) AS age, d.A11 AS average_salary FROM client c JOIN district d ON c.district_id = d.district_id WHERE c.gender = 'F' ), Oldest_Female_Clients AS ( SELECT client_id, age, average_salary FROM Client_Ages WHERE age = (SELECT MAX(age) FROM Client_Ages WHERE average_salary = (SELECT MIN(average_salary) FROM Client_Ages)) ) SELECT a.account_id FROM disp d JOIN account a ON d.account_id = a.account_id JOIN Oldest_Female_Clients ofc ON d.client_id = ofc.client_id WHERE ofc.average_salary = (SELECT MIN(average_salary) FROM Client_Ages)
SELECT COUNT(*) FROM client c JOIN district d ON c.district_id = d.district_id WHERE strftime('%Y', c.birth_date) = '1920' AND d.A3 = 'East Bohemia';
SELECT COUNT(*) AS num_loan_accounts FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.duration = 24 AND l.status = 'PREPAYMENT' -- Replace 'PREPAYMENT' with actual status value if needed AND a.frequency = 'POPLATEK TYDNE';
SELECT AVG(l.amount) AS average_loan_amount FROM loan l JOIN account a ON l.account_id = a.account_id JOIN trans t ON a.account_id = t.account_id WHERE l.status = 'C' AND t.operation = 'POPLATEK PO OBRATU';
SELECT c.client_id, c.district_id FROM client c JOIN disp d ON c.client_id = d.client_id LEFT JOIN `order` o ON d.account_id = o.account_id WHERE o.order_id IS NULL; -- Ensuring that the client has no orders
SELECT c.client_id, (strftime('%Y', 'now') - strftime('%Y', c.birth_date) - (strftime('%m', 'now') < strftime('%m', c.birth_date) OR (strftime('%m', 'now') = strftime('%m', c.birth_date) AND strftime('%d', 'now') < strftime('%d', c.birth_date)))) AS age FROM client c JOIN disp d ON c.client_id = d.client_id JOIN card ca ON d.disp_id = ca.disp_id JOIN loan l ON d.account_id = l.account_id WHERE ca.type = 'gold';
SELECT bond_type, COUNT(bond_type) AS bond_count FROM bond GROUP BY bond_type ORDER BY bond_count DESC LIMIT 1;
SELECT COUNT(DISTINCT m.molecule_id) AS chlorine_molecule_count FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '-' AND a.element = 'cl';
SELECT AVG(oxygen_count) AS average_oxygen_atoms FROM ( SELECT COUNT(a.atom_id) AS oxygen_count FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id WHERE b.bond_type = '-' AND a.element = 'O' GROUP BY b.molecule_id ) AS oxygen_counts;
SELECT AVG(single_bond_count) AS avg_single_bond_carcinogenic FROM ( SELECT m.molecule_id, COUNT(c.bond_id) AS single_bond_count FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id JOIN connected c ON b.bond_id = c.bond_id WHERE m.label = '+' AND b.bond_type = '-' GROUP BY m.molecule_id ) AS subquery;
SELECT COUNT(a.atom_id) AS sodium_non_carcinogenic_count FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'na' AND m.label = '-';
SELECT DISTINCT m.molecule_id, m.label FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '#' AND m.label = '+';
SELECT (SUM(CASE WHEN a.element = 'c' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.atom_id)) AS carbon_percentage FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_type = ' = ' GROUP BY m.molecule_id;
SELECT COUNT(*) AS triple_bond_count FROM bond WHERE bond_type = '#';
SELECT COUNT(*) AS non_bromine_count FROM atom WHERE element != 'br';
SELECT COUNT(*) AS carcinogenic_count FROM molecule WHERE molecule_id BETWEEN 'TR000' AND 'TR099' AND label = '+';
SELECT DISTINCT a.molecule_id FROM atom a WHERE a.element = 'si';
SELECT a.element FROM connected c JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE c.bond_id = 'TR004_8_9';
SELECT DISTINCT a.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON a.atom_id IN (c.atom_id, c.atom_id2) WHERE b.bond_type = ' = ';
SELECT m.label, COUNT(*) as label_count FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'h' GROUP BY m.label ORDER BY label_count DESC LIMIT 1;
SELECT DISTINCT b.bond_type FROM atom a JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id WHERE a.element = 'te';
SELECT c.atom_id, c.atom_id2 FROM connected c JOIN bond b ON c.bond_id = b.bond_id WHERE b.bond_type = '-';
SELECT c.atom_id, c.atom_id2 FROM connected c JOIN molecule m ON c.bond_id IN ( SELECT b.bond_id FROM bond b WHERE b.molecule_id = m.molecule_id ) WHERE m.label = '-';
SELECT element, COUNT(*) AS element_count FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '-' GROUP BY element ORDER BY element_count ASC LIMIT 1;
SELECT b.bond_type FROM connected c JOIN bond b ON c.bond_id = b.bond_id WHERE (c.atom_id = 'TR004_8' AND c.atom_id2 = 'TR004_20') OR (c.atom_id = 'TR004_20' AND c.atom_id2 = 'TR004_8');
SELECT DISTINCT label FROM molecule WHERE molecule_id NOT IN ( SELECT DISTINCT molecule_id FROM atom WHERE element = 'Sn' ) AND label IN ('+', '-');
SELECT COUNT(DISTINCT a.atom_id) AS atom_count FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_type = '-' AND a.element IN ('i', 's');
SELECT c.atom_id, c.atom_id2 FROM connected AS c JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_type = '#';
SELECT DISTINCT c.atom_id2 FROM connected c JOIN atom a1 ON c.atom_id = a1.atom_id JOIN molecule m ON a1.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR181';
SELECT molecule_id FROM molecule WHERE label = '+' ), -- Step 2: Counting Carcinogenic Molecules with Fluorine molecules_with_fluorine AS ( SELECT DISTINCT c.molecule_id FROM carcinogenic_molecules c JOIN atom a ON c.molecule_id = a.molecule_id WHERE a.element = 'f' ), -- Step 3: Counting Total Carcinogenic Molecules total_carcinogenic_count AS ( SELECT COUNT(*) AS total_count FROM carcinogenic_molecules ), -- Step 4: Counting Carcinogenic Molecules without Fluorine molecules_without_fluorine AS ( SELECT COUNT(*) AS count_without_f FROM carcinogenic_molecules c WHERE c.molecule_id NOT IN (SELECT molecule_id FROM molecules_with_fluorine) ) -- Step 5: Calculate Percentage SELECT (m.count_without_f * 100.0) / t.total_count AS percent_no_fluorine FROM molecules_without_fluorine m, total_carcinogenic_count t
SELECT m.molecule_id FROM molecule m WHERE m.label = '+' ), TripleBonds AS ( SELECT DISTINCT c.molecule_id FROM connected c JOIN bond b ON c.bond_id = b.bond_id WHERE b.bond_type = '#' ) SELECT (COUNT(DISTINCT tb.molecule_id) * 100.0 / COUNT(cm.molecule_id)) AS percentage FROM CarcinogenicMolecules cm LEFT JOIN TripleBonds tb ON cm.molecule_id = tb.molecule_i
SELECT DISTINCT element FROM atom WHERE molecule_id = 'TR000' ORDER BY element LIMIT 3;
SELECT c.atom_id, c.atom_id2 FROM connected AS c JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_id = 'TR001_2_6' AND b.molecule_id = 'TR001';
SELECT COUNT(CASE WHEN label = '+' THEN 1 END) AS carcinogenic_count, COUNT(CASE WHEN label = '-' THEN 1 END) AS non_carcinogenic_count, COUNT(CASE WHEN label = '+' THEN 1 END) - COUNT(CASE WHEN label = '-' THEN 1 END) AS difference FROM molecule;
SELECT atom_id, atom_id2 FROM connected WHERE bond_id = 'TR_000_2_5';
SELECT c.bond_id FROM connected c WHERE c.atom_id2 = ( SELECT atom_id2 FROM connected WHERE atom_id = 'TR000_2' );
SELECT DISTINCT m.molecule_id, m.label FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = ' = ' ORDER BY m.label ASC LIMIT 5;
SELECT (SUM(CASE WHEN b.bond_type = ' = ' THEN 1 ELSE 0 END) * 100.0 / COUNT(b.bond_id)) AS percent FROM bond b WHERE b.molecule_id = 'TR008';
SELECT (SUM(CASE WHEN label = '+' THEN 1 ELSE 0 END) * 100.0 / COUNT(molecule_id)) AS percent FROM molecule;
SELECT (SUM(CASE WHEN element = 'h' THEN 1 ELSE 0 END) * 100.0 / COUNT(atom_id)) AS percent FROM atom WHERE molecule_id = 'TR206';
SELECT bond.bond_type FROM bond JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.molecule_id = 'TR000';
SELECT a.element, m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.molecule_id = 'TR060';
SELECT b.bond_type, COUNT(b.bond_type) AS bond_count, m.label FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.molecule_id = 'TR018' GROUP BY b.bond_type ORDER BY bond_count DESC LIMIT 1;
SELECT DISTINCT m.molecule_id, m.label FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id AND b.bond_type = '-' JOIN connected c ON b.bond_id = c.bond_id WHERE m.label = '-' ORDER BY m.molecule_id LIMIT 3;
SELECT bond_id FROM bond WHERE molecule_id = 'TR006' ORDER BY bond_id LIMIT 2;
SELECT COUNT(DISTINCT bond_id) AS bond_count FROM connected WHERE (atom_id = 'TR009_12' OR atom_id2 = 'TR009_12');
SELECT COUNT(DISTINCT m.molecule_id) AS carcinogenic_bromine_molecules FROM molecule m JOIN atom a ON a.molecule_id = m.molecule_id WHERE m.label = '+' AND a.element = 'br';
SELECT b.bond_type, c.atom_id, c.atom_id2 FROM bond b JOIN connected c ON b.bond_id = c.bond_id WHERE b.bond_id = 'TR001_6_9';
SELECT m.molecule_id, m.label FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.atom_id = 'TR001_10';
SELECT COUNT(DISTINCT b.molecule_id) AS molecule_count FROM bond b WHERE b.bond_type = '#';
SELECT COUNT(*) AS connection_count FROM connected WHERE atom_id = 'TR%_19' OR atom_id2 = 'TR%_19';
SELECT DISTINCT a.element FROM atom AS a JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR004';
SELECT COUNT(*) AS non_carcinogenic_count FROM molecule WHERE label = '-';
SELECT DISTINCT m.molecule_id FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.atom_id IN ( SELECT atom_id FROM atom WHERE SUBSTR(atom_id, 7, 2) BETWEEN '21' AND '25' ) AND m.label = '+';
SELECT DISTINCT b.bond_id FROM atom a1 JOIN connected c ON a1.atom_id = c.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN bond b ON c.bond_id = b.bond_id WHERE a1.element = 'p' AND a2.element = 'n';
SELECT b.molecule_id, COUNT(b.bond_id) AS double_bond_count FROM bond b WHERE b.bond_type = '=' GROUP BY b.molecule_id ), MaxDoubleBonds AS ( SELECT molecule_id, double_bond_count FROM DoubleBondCounts ORDER BY double_bond_count DESC LIMIT 1 ) SELECT m.molecule_id, m.label, dbc.double_bond_count, CASE WHEN m.label = '+' THEN 'Yes' ELSE 'No' END AS is_carcinogenic FROM MaxDoubleBonds dbc JOIN molecule m ON dbc.molecule_id = m.molecule_id
SELECT COUNT(c.bond_id) * 1.0 / COUNT(DISTINCT a.atom_id) AS average_bonds FROM atom a LEFT JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 WHERE a.element = 'i'
SELECT b.bond_type, b.bond_id FROM bond b JOIN connected c ON b.bond_id = c.bond_id WHERE c.atom_id IN ( SELECT atom_id FROM atom WHERE SUBSTR(atom_id, 7, 2) = '45' );
SELECT a.element FROM atom a LEFT JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 WHERE c.atom_id IS NULL AND c.atom_id2 IS NULL;
SELECT DISTINCT a1.atom_id AS atom1, a2.atom_id AS atom2 FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_type = '#' AND b.molecule_id = 'TR447';
SELECT a.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_id = 'TR144_8_19';
SELECT m.molecule_id, m.label, COUNT(b.bond_id) AS double_bond_count FROM molecule AS m JOIN bond AS b ON m.molecule_id = b.molecule_id WHERE m.label = '+' AND b.bond_type = ' = ' GROUP BY m.molecule_id ORDER BY double_bond_count DESC LIMIT 1;
SELECT element FROM atom WHERE molecule_id IN ( SELECT molecule_id FROM molecule WHERE label = '+' ) GROUP BY element ORDER BY COUNT(*) ASC LIMIT 1;
SELECT a2.* FROM connected c JOIN atom a1 ON a1.atom_id = c.atom_id JOIN atom a2 ON a2.atom_id = c.atom_id2 WHERE a1.element = 'pb';
SELECT DISTINCT a.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id WHERE b.bond_type = '#';
SELECT b.bond_id, a1.element AS element1, a2.element AS element2, COUNT(*) AS count_combination FROM connected c JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN bond b ON c.bond_id = b.bond_id GROUP BY a1.element, a2.element ), MaxCount AS ( -- Find the maximum count of any combination of elements SELECT MAX(count_combination) AS max_count FROM ElementCounts ), TotalBonds AS ( -- Count the total number of bonds SELECT COUNT(bond_id) AS total_bonds FROM bond ) SELECT -- Calculate the percentage of bonds with the most common combination of elements (CAST(mc.max_count AS FLOAT) / tb.total_bonds) * 100 AS percentage_of_common_bonds FROM MaxCount mc, TotalBonds tb
SELECT (CAST(SUM(CASE WHEN m.label = '+' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(b.bond_id)) AS proportion FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-';
SELECT COUNT(*) AS total_atoms FROM atom WHERE element IN ('c', 'h');
SELECT c.atom_id2 FROM atom a JOIN connected c ON a.atom_id = c.atom_id WHERE a.element = 's';
SELECT DISTINCT b.bond_type FROM atom a JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id WHERE a.element = 'Sn';
SELECT COUNT(DISTINCT a.element) AS number_of_elements FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-';
SELECT COUNT(DISTINCT c.atom_id) AS total_atoms FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_type = '#' AND (a.element = 'p' OR a.element = 'br');
SELECT b.bond_id FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE m.label = '+';
SELECT DISTINCT m.molecule_id FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '-' AND m.label = '-';
SELECT (COUNT(CASE WHEN a.element = 'cl' THEN 1 END) * 100.0) / COUNT(a.atom_id) AS percent_cl FROM atom a JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-' GROUP BY m.molecule_id;
SELECT molecule_id, label FROM molecule WHERE molecule_id IN ('TR000', 'TR001', 'TR002');
SELECT molecule_id FROM molecule WHERE label = '-';
SELECT COUNT(*) AS total_carcinogenic_molecules FROM molecule WHERE molecule_id BETWEEN 'TR000' AND 'TR030' AND label = '+';
SELECT b.molecule_id, b.bond_type FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE m.molecule_id BETWEEN 'TR000' AND 'TR050';
SELECT a1.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a1 ON c.atom_id = a1.atom_id WHERE b.bond_id = 'TR001_10_11' UNION SELECT a2.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_id = 'TR001_10_11';
SELECT COUNT(DISTINCT c.bond_id) AS iodine_bond_count FROM connected c JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE a.element = 'i';
SELECT m.label, COUNT(m.molecule_id) AS molecule_count FROM atom a JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE a.element = 'ca' GROUP BY m.label ORDER BY m.label;
SELECT atom_id, atom_id2 FROM connected WHERE bond_id = 'TR001_1_8';
SELECT DISTINCT m.molecule_id FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id WHERE m.label = '-' AND a.element = 'c' AND b.bond_type = '#' LIMIT 2;
SELECT (COUNT(a.atom_id) * 100.0 / NULLIF(COUNT(DISTINCT c.atom_id), 0)) AS percentage FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 WHERE m.label = '+' AND a.element = 'cl';
SELECT a.element FROM atom a WHERE a.molecule_id = 'TR001';
SELECT molecule_id FROM bond WHERE bond_type = ' = ';
SELECT c.atom_id, c.atom_id2 FROM bond b JOIN connected c ON b.bond_id = c.bond_id WHERE b.bond_type = '#';
SELECT DISTINCT a.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_id = 'TR005_16_26';
SELECT COUNT(DISTINCT m.molecule_id) AS non_carcinogenic_single_bond_count FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE m.label = '-' AND b.bond_type = '-';
SELECT m.label FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_id = 'TR001_10_11';
SELECT b.bond_id, CASE WHEN m.label = '+' THEN 'Carcinogenic' WHEN m.label = '-' THEN 'Non-carcinogenic' ELSE 'Unknown' END AS carcinogenic_status FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '#';
SELECT a.element, COUNT(*) as element_count FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '+' AND a.atom_id IN ( SELECT atom_id FROM atom WHERE substr(atom_id, 7, 1) = '4' ) GROUP BY a.element;
SELECT (SUM(element = 'h') * 1.0 / COUNT(*)) AS hydrogen_ratio, m.label FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.molecule_id = 'TR006';
SELECT DISTINCT m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element = 'ca';
SELECT atom_id FROM atom WHERE element = 'te' ), -- Step 2: Find connections for those tellurium atoms connected_pairs AS ( SELECT c.atom_id, c.atom_id2, b.bond_type FROM connected c JOIN tellurium_atoms ta ON c.atom_id = ta.atom_id OR c.atom_id2 = ta.atom_id JOIN bond b ON c.bond_id = b.bond_id ) -- Step 3: Select distinct bond types for those connections SELECT DISTINCT bond_type FROM connected_pairs
SELECT a1.element AS atom_1_element, a2.element AS atom_2_element FROM bond b JOIN atom a1 ON a1.atom_id = SUBSTR(b.bond_id, 7, 2) JOIN atom a2 ON a2.atom_id = SUBSTR(b.bond_id, 10, 2) WHERE b.bond_id = 'TR001_10_11';
SELECT DISTINCT molecule_id FROM bond WHERE bond_type = '#';
SELECT (COUNT(CASE WHEN bond.bond_type = ' = ' THEN 1 END) * 100.0 / COUNT(bond.bond_id)) AS percent_double_bond FROM bond WHERE bond.molecule_id = 'TR047';
SELECT m.label FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.atom_id = 'TR001_1';
SELECT label FROM molecule WHERE molecule_id = 'TR151';
SELECT DISTINCT a.element FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = 'TR151' AND a.element IN ('cl', 'br', 'pb');
SELECT COUNT(*) AS carcinogenic_count FROM molecule WHERE label = '+';
SELECT a.atom_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE substr(m.molecule_id, 3, 3) BETWEEN '010' AND '050' AND a.element = 'c';
SELECT COUNT(DISTINCT a.atom_id) AS atom_count FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.label = '+';
SELECT DISTINCT b.bond_id FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE m.label = '+' AND b.bond_type = ' = ';
SELECT COUNT(a.atom_id) AS hydrogen_atom_count FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'h' AND m.label = '+';
SELECT DISTINCT m.molecule_id FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN molecule m ON a1.molecule_id = m.molecule_id OR a2.molecule_id = m.molecule_id WHERE b.bond_id = 'TR00_1_2' AND (a1.atom_id = 'TR00_1' OR a2.atom_id = 'TR00_1');
SELECT DISTINCT a.atom_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'c' AND m.label = '-';
SELECT (COUNT(DISTINCT a.molecule_id) * 100.0 / NULLIF((SELECT COUNT(DISTINCT molecule_id) FROM molecule WHERE label = '+'), 0)) AS percentage_hydrogen_carcinogenic FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.label = '+' AND a.element = 'h';
SELECT label FROM molecule WHERE molecule_id = 'TR124';
SELECT a.atom_id, a.element FROM atom a INNER JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR186';
SELECT bond_type FROM bond WHERE bond_id = 'TR007_4_19';
SELECT * FROM bond WHERE bond_id = 'TR001_2_4';
SELECT label FROM molecule WHERE molecule_id = 'TR006';
SELECT m.molecule_id, a.element FROM molecule m INNER JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '+';
SELECT b.bond_id, b.bond_type, a1.atom_id AS atom1_id, a2.atom_id AS atom2_id FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id WHERE b.bond_type = '-';
SELECT m.label AS molecule_label, GROUP_CONCAT(DISTINCT a.element) AS elements FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '#' GROUP BY m.molecule_id;
SELECT a.element FROM connected c JOIN atom a ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 WHERE c.bond_id = 'TR000_2_3';
SELECT COUNT(DISTINCT c.bond_id) AS num_bonds FROM connected c JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id WHERE a1.element = 'cl' OR a2.element = 'cl';
SELECT atom_id FROM atom WHERE molecule_id = 'TR346'
SELECT COUNT(DISTINCT m.molecule_id) AS total_double_bond_molecules, SUM(CASE WHEN m.label = '+' THEN 1 ELSE 0 END) AS carcinogenic_molecules FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = ' = ';
SELECT COUNT(DISTINCT m.molecule_id) AS molecule_count FROM molecule m WHERE m.molecule_id NOT IN ( SELECT DISTINCT a.molecule_id FROM atom a WHERE a.element = 's' ) AND m.molecule_id NOT IN ( SELECT DISTINCT b.molecule_id FROM bond b WHERE b.bond_type = ' = ' );
SELECT m.label FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_id = 'TR001_2_4';
SELECT COUNT(*) AS atom_count FROM atom WHERE molecule_id = 'TR005';
SELECT COUNT(*) AS single_bond_count FROM bond WHERE bond_type = '-';
SELECT DISTINCT m.molecule_id, m.label FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'cl' AND m.label = '+';
SELECT DISTINCT m.molecule_id, m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element = 'c' AND m.label = '-';
SELECT (COUNT(DISTINCT a.molecule_id) * 100.0 / COUNT(DISTINCT m.molecule_id)) AS percentage FROM molecule m LEFT JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '+' AND a.element = 'cl';
SELECT molecule_id FROM bond WHERE bond_id = 'TR001_1_7';
SELECT COUNT(DISTINCT a.element) AS number_of_elements FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.bond_id = 'TR001_3_4';
SELECT b.bond_type FROM connected c JOIN bond b ON c.bond_id = b.bond_id WHERE (c.atom_id = 'TR000_1' AND c.atom_id2 = 'TR000_2') OR (c.atom_id = 'TR000_2' AND c.atom_id2 = 'TR000_1');
SELECT m.molecule_id, m.label FROM atom AS a1 JOIN atom AS a2 ON a1.molecule_id = a2.molecule_id JOIN molecule AS m ON a1.molecule_id = m.molecule_id WHERE a1.atom_id = 'TR000_2' AND a2.atom_id = 'TR000_4';
SELECT element FROM atom WHERE atom_id = 'TR000_1';
SELECT label FROM molecule WHERE molecule_id = 'TR000';
SELECT (COUNT(DISTINCT c.atom_id) * 100.0 / COUNT(DISTINCT a.atom_id)) AS percentage FROM connected c JOIN bond b ON c.bond_id = b.bond_id JOIN atom a ON c.atom_id = a.atom_id WHERE b.bond_type = '-';
SELECT COUNT(DISTINCT m.molecule_id) AS carcinogenic_nitrogen_molecule_count FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '+' AND a.element = 'n';
SELECT DISTINCT m.molecule_id, m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id WHERE a.element = 's' AND b.bond_type = ' = '
SELECT m.molecule_id, COUNT(a.atom_id) AS atom_count FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '-' GROUP BY m.molecule_id HAVING COUNT(a.atom_id) > 5;
SELECT DISTINCT a.element FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id OR c.atom_id2 = a.atom_id WHERE b.molecule_id = 'TR024' AND b.bond_type = '=';
SELECT m.molecule_id, m.label, COUNT(a.atom_id) AS atom_count FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE m.label = '+' GROUP BY m.molecule_id, m.label ORDER BY atom_count DESC LIMIT 1;
SELECT DISTINCT m.molecule_id FROM molecule m WHERE m.label = '+' ), hydrogen_atoms AS ( SELECT a.molecule_id FROM atom a WHERE a.element = 'h' ), triple_bonded_hydrogens AS ( SELECT DISTINCT c.molecule_id FROM connected c JOIN bond b ON c.bond_id = b.bond_id JOIN hydrogen_atoms h ON c.atom_id = h.atom_id OR c.atom_id2 = h.atom_id WHERE b.bond_type = '#' ) SELECT (COUNT(DISTINCT tb.molecule_id) * 100.0 / COUNT(DISTINCT cm.molecule_id)) AS percentage FROM carcinogenic_molecules cm LEFT JOIN triple_bonded_hydrogens tb ON cm.molecule_id = tb.molecule_id
SELECT COUNT(*) AS carcinogenic_count FROM molecule WHERE label = '+';
SELECT COUNT(DISTINCT b.molecule_id) AS single_bond_molecule_count FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '-' AND m.molecule_id BETWEEN 'TR004' AND 'TR010';
SELECT COUNT(*) AS carbon_count FROM atom WHERE molecule_id = 'TR008' AND element = 'c';
SELECT a.element FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.atom_id = 'TR004_7' AND m.label = '-';
SELECT COUNT(DISTINCT m.molecule_id) AS total_molecules_with_double_bonded_oxygen FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id JOIN connected c ON b.bond_id = c.bond_id JOIN atom a1 ON c.atom_id = a1.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id WHERE a1.element = 'o' AND a2.element = 'o' AND b.bond_type = ' = ';
SELECT COUNT(DISTINCT m.molecule_id) AS non_carcinogenic_triple_bond_molecules FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '#' AND m.label = '-';
SELECT a.element, b.bond_type FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON c.bond_id = b.bond_id WHERE m.molecule_id = 'TR016';
SELECT a.atom_id FROM atom a JOIN connected c ON a.atom_id = c.atom_id JOIN bond b ON c.bond_id = b.bond_id WHERE b.molecule_id = 'TR012' AND a.element = 'c' AND b.bond_type = ' = ';
SELECT a.atom_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.label = '+' AND a.element = 'o';
SELECT id, name, artist, rarity, cardKingdomFoilId, cardKingdomId FROM cards WHERE cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL;
SELECT * FROM cards WHERE borderColor = 'borderless' AND (cardKingdomFoilId IS NULL OR cardKingdomId IS NULL);
SELECT name FROM cards WHERE faceConvertedManaCost = ( SELECT MAX(faceConvertedManaCost) FROM cards );
SELECT * FROM cards WHERE frameVersion = '2015' AND edhrecRank < 100;
SELECT c.* FROM cards c INNER JOIN legalities l ON c.uuid = l.uuid WHERE c.rarity = 'mythic' AND l.status = 'Banned' AND l.format = 'gladiator';
SELECT l.format, l.status FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE (c.type LIKE '%Artifact%' OR c.types LIKE '%Artifact%') AND c.side IS NULL AND l.format = 'vintage';
SELECT c.id, c.artist FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE (c.power = '*' OR c.power IS NULL) AND l.format = 'commander' AND l.status = 'Legal';
SELECT c.name AS card_name, c.uuid, r.text AS ruling_text, c.hasContentWarning FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.artist = 'Stephen Daniele' AND c.hasContentWarning = 1;
SELECT uuid FROM cards WHERE name = 'Sublime Epiphany' AND number = '74s';
SELECT c.name, c.artist, c.isPromo FROM cards c JOIN (SELECT uuid, COUNT(*) as ruling_count FROM rulings GROUP BY uuid ORDER BY ruling_count DESC LIMIT 1) r ON c.uuid = r.uuid;
SELECT fd.language FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.name = 'Annul' AND c.number = '29';
SELECT cards.name, cards.uuid FROM cards JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE foreign_data.language = 'Japanese';
SELECT (COUNT(DISTINCT CASE WHEN fd.language = 'Chinese Simplified' THEN fd.uuid END) * 100.0) / COUNT(DISTINCT c.uuid) AS percentage_of_cards_in_chinese_simplified FROM cards c LEFT JOIN foreign_data fd ON c.uuid = fd.uuid;
SELECT s.code, s.name, s.totalSetSize FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Italian';
SELECT COUNT(DISTINCT type) AS card_type_count FROM cards WHERE artist = 'Aaron Boyd';
SELECT keywords FROM cards WHERE name = 'Angel of Mercy';
SELECT COUNT(*) FROM cards WHERE power = '*';
SELECT promoTypes FROM cards WHERE name = 'Duress';
SELECT borderColor FROM cards WHERE name = "Ancestor's Chosen";
SELECT originalType FROM cards WHERE name = 'Ancestor\'s Chosen';
SELECT uuid FROM cards WHERE name = 'Angel of Mercy';
SELECT COUNT(DISTINCT cards.uuid) AS restricted_cards_with_text_boxes FROM legalities JOIN cards ON legalities.uuid = cards.uuid WHERE legalities.status = 'restricted' AND cards.isTextless = 0;
SELECT uuid FROM cards WHERE name = 'Condemn';
SELECT COUNT(*) FROM legalities JOIN cards ON legalities.uuid = cards.uuid WHERE legalities.status = 'restricted' AND cards.isStarter = 1;
SELECT l.status FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.name = 'Cloudchaser Eagle';
SELECT type FROM cards WHERE name = 'Benalish Knight';
SELECT l.format, l.status FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.name = 'Benalish Knight';
SELECT DISTINCT c.artist FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE fd.language = 'Phyrexian';
SELECT (COUNT(CASE WHEN borderColor = 'borderless' THEN 1 END) * 1.0 / COUNT(*)) * 100 AS percentage_borderless_cards FROM cards;
SELECT COUNT(DISTINCT c.uuid) AS reprinted_german_cards_count FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE f.language = 'German' AND c.isReprint = 1;
SELECT COUNT(*) FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.borderColor = 'borderless' AND fd.language = 'Russian';
SELECT (COUNT(CASE WHEN f.language = 'French' THEN 1 END) * 100.0 / COUNT(*)) AS Percentage_French_Story_Spotlight FROM foreign_data f JOIN cards c ON f.uuid = c.uuid WHERE c.isStorySpotlight = 1;
SELECT COUNT(*) FROM cards WHERE toughness = '99';
SELECT name FROM cards WHERE artist = 'Aaron Boyd';
SELECT COUNT(*) FROM cards WHERE borderColor = 'black' AND availability = 'mtgo';
SELECT id FROM cards WHERE convertedManaCost = 0;
SELECT layout FROM cards WHERE keywords LIKE '%flying%';
SELECT COUNT(*) FROM cards WHERE originalType = 'Summon - Angel' AND subtypes != 'Angel';
SELECT id FROM cards WHERE hasFoil = 1 AND cardKingdomFoilId IS NOT NULL AND cardKingdomId IS NOT NULL;
SELECT id FROM cards WHERE duelDeck = 'a';
SELECT edhrecRank FROM cards WHERE frameVersion = '2015';
SELECT DISTINCT c.artist FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE fd.language = 'Chinese Simplified';
SELECT c.* FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE c.availability = 'paper' AND f.language = 'Japanese';
SELECT COUNT(*) AS banned_white_border_count FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE l.status = 'Banned' AND c.borderColor = 'white';
SELECT c.uuid, f.language FROM cards c JOIN legalities l ON c.uuid = l.uuid JOIN foreign_data f ON c.uuid = f.uuid WHERE l.format = 'legacy';
SELECT uuid FROM cards WHERE name = 'Beacon of Immortality';
SELECT COUNT(DISTINCT c.uuid) AS card_count, l.status AS legality_status FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.frameVersion = 'future' GROUP BY l.status;
SELECT c.name, c.colors FROM cards AS c JOIN sets AS s ON c.setCode = s.code WHERE s.code = 'OGW';
SELECT c.name, c.convertedManaCost, st.language, st.translation FROM cards c JOIN sets s ON c.setCode = s.code JOIN set_translations st ON c.setCode = st.setCode WHERE s.code = '10E' AND c.convertedManaCost = 5;
SELECT c.name, r.date FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.originalType = 'Creature - Elf';
SELECT cards.id, cards.colors, legalities.format FROM cards LEFT JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.id BETWEEN 1 AND 20;
SELECT c.id, c.name, c.colors, c.originalType, f.language, f.flavorText, f.text FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE c.originalType = 'Artifact' AND c.colors LIKE '%B%';
SELECT c.name FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.rarity = 'uncommon' ORDER BY r.date ASC LIMIT 3;
SELECT COUNT(*) FROM cards WHERE artist = 'John Avon' AND hasFoil = 1 AND cardKingdomId NOT IN (/* insert criteria for powerful cardKingdomIds here */);
SELECT COUNT(*) FROM cards WHERE borderColor = 'white' AND cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL;
SELECT COUNT(*) FROM cards WHERE artist = 'UDON' AND availability = 'mtgo' AND hand = '-1';
SELECT COUNT(*) FROM cards WHERE frameVersion = '1993' AND availability = 'paper' AND hasContentWarning = 1;
SELECT manaCost FROM cards WHERE layout = 'normal' AND frameVersion = '2003' AND borderColor = 'black' AND availability LIKE '%paper%' AND availability LIKE '%mtgo%';
SELECT SUM(convertedManaCost) AS total_unconverted_mana FROM cards WHERE artist = 'Rob Alexander';
SELECT DISTINCT type FROM cards WHERE availability = 'arena';
SELECT DISTINCT s.code AS set_code FROM set_translations st JOIN sets s ON st.setCode = s.code WHERE st.language = 'Spanish';
SELECT (COUNT(CASE WHEN hand = '+3' THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM cards WHERE frameEffects = 'legendary';
SELECT (COUNT(*) * 100.0 / SUM(total_count)) AS percentage_with_text, GROUP_CONCAT(id) AS ids_with_text FROM ( SELECT id, 1 AS total_count FROM cards WHERE isStorySpotlight = 1 AND isTextless = 0 ), ( SELECT COUNT(*) AS total_count FROM cards WHERE isStorySpotlight = 1 ) ;
SELECT COUNT(*) AS total_count FROM cards ), spanish_cards AS ( SELECT DISTINCT uuid FROM foreign_data WHERE language = 'Spanish' ), spanish_count AS ( SELECT COUNT(*) AS spanish_count FROM spanish_cards ) SELECT (SELECT spanish_count FROM spanish_count) * 100.0 / (SELECT total_count FROM total_cards) AS percentage_of_spanish_cards, c.name FROM spanish_cards s JOIN cards c ON s.uuid = c.uuid ORDER BY c.name
SELECT st.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.baseSetSize = 309;
SELECT COUNT(*) FROM set_translations st JOIN sets s ON st.setCode = s.code WHERE st.language = 'Portuguese (Brasil)' AND s.block = 'Commander';
SELECT c.id FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.types LIKE '%Creature%' AND l.status = 'legal';
SELECT DISTINCT c.type FROM cards AS c JOIN foreign_data AS f ON c.uuid = f.uuid WHERE f.language = 'German';
SELECT COUNT(*) FROM cards WHERE (power IS NULL OR power = '*') AND text IS NOT NULL AND text != '';
SELECT COUNT(DISTINCT c.id) AS num_cards FROM cards c JOIN legalities l ON c.uuid = l.uuid JOIN rulings r ON c.uuid = r.uuid LEFT JOIN foreign_data fd ON c.uuid = fd.uuid WHERE l.format = 'pre-modern' AND l.status = 'legal' AND r.text = 'This is a triggered mana ability' AND fd.uuid IS NULL; -- Check that there are no entries in foreign_data
SELECT c.id FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.artist = 'Erica Yang' AND c.availability = 'paper' AND l.format = 'pauper';
SELECT artist FROM cards WHERE text = "Das perfekte Gegenmittel zu einer dichten Formation";
SELECT fd.name AS foreign_name FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE fd.language = 'French' AND c.type = 'Creature' AND c.layout = 'normal' AND c.borderColor = 'black' AND c.artist = 'Matthew D. Wilson';
SELECT COUNT(DISTINCT c.uuid) AS rare_card_count FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.rarity = 'rare' AND r.date = '2009-10-01';
SELECT st.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.block = 'Ravnica' AND s.baseSetSize = 180;
SELECT (COUNT(CASE WHEN cards.hasContentWarning = 0 THEN 1 END) * 100.0) / COUNT(*) AS percentage FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE legalities.format = 'commander' AND legalities.status = 'legal';
SELECT * FROM cards WHERE power IS NULL OR power = '*' ), -- Step 2: Count of French cards without power french_cards_without_power AS ( SELECT COUNT(*) AS french_card_count FROM foreign_data fd JOIN cards_without_power cp ON fd.uuid = cp.uuid WHERE fd.language = 'French' ) -- Step 3: Calculate total card count without power SELECT (SELECT french_card_count FROM french_cards_without_power) * 100.0 / COUNT(*) AS percentage FROM cards_without_power
SELECT s.code, st.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Japanese' ), JapaneseExpansionSets AS ( SELECT js.code FROM JapaneseSets js JOIN sets s ON js.code = s.code WHERE s.type = 'expansion' ) SELECT (COUNT(js.code) * 1.0 / NULLIF(COUNT(DISTINCT js.code), 0)) * 100 AS percentage FROM JapaneseSets js WHERE js.code IN (SELECT code FROM JapaneseExpansionSets)
SELECT availability FROM cards WHERE artist = 'Daren Bader';
SELECT COUNT(*) FROM cards WHERE colors IS NOT NULL AND colors <> '' AND borderColor = 'borderless' AND edhrecRank > 12000;
SELECT COUNT(CASE WHEN isOversized = 1 THEN 1 END) AS oversized_count, COUNT(CASE WHEN isReprint = 1 THEN 1 END) AS reprinted_count, COUNT(CASE WHEN isPromo = 1 THEN 1 END) AS promo_count FROM cards;
SELECT name, uuid FROM cards WHERE (power IS NULL OR power = '*') AND promoTypes = 'arenaleague' ORDER BY name LIMIT 3;
SELECT fd.language FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE fd.multiverseid = 149934;
SELECT id FROM cards WHERE cardKingdomFoilId IS NOT NULL AND cardKingdomId IS NOT NULL ORDER BY cardKingdomFoilId ASC LIMIT 3;
SELECT (COUNT(CASE WHEN isTextless = 1 AND layout = 'normal' THEN 1 END) * 100.0) / COUNT(*) AS proportion FROM cards;
SELECT number FROM cards WHERE otherFaceIds IS NULL AND subtypes LIKE '%Angel%' AND subtypes LIKE '%Wizard%'
SELECT code, name FROM sets WHERE mtgoCode IS NULL OR mtgoCode = '' ORDER BY name ASC LIMIT 3;
SELECT st.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.mcmName = 'Archenemy' AND s.code = 'ARC';
SELECT s.name AS set_name, st.translation AS set_translation FROM sets s LEFT JOIN set_translations st ON s.code = st.setCode WHERE s.id = 5;
SELECT st.language, s.type FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.id = 206;
SELECT s.id, s.name FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Italian' AND s.block = 'Shadowmoor' ORDER BY s.name LIMIT 2;
SELECT s.id FROM sets s JOIN foreign_data fd ON s.code = fd.setCode WHERE s.isForeignOnly = 1 AND s.isFoilOnly = 1 AND fd.language = 'Japanese';
SELECT s.name, COUNT(c.id) AS card_count FROM sets s JOIN cards c ON s.code = c.setCode JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Russian' GROUP BY s.code ORDER BY card_count DESC LIMIT 1;
SELECT (COUNT(CASE WHEN f.language = 'Chinese Simplified' AND c.isOnlineOnly = 1 THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM cards c LEFT JOIN foreign_data f ON c.uuid = f.uuid;
SELECT COUNT(DISTINCT s.id) AS number_of_sets FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Japanese' AND (s.mtgoCode IS NULL OR s.mtgoCode = '')
SELECT COUNT(*) AS count, GROUP_CONCAT(id) AS card_ids FROM cards WHERE borderColor = 'black';
SELECT id FROM cards WHERE frameEffects = 'extendedart'
SELECT * FROM cards WHERE borderColor = 'black' AND isFullArt = 1;
SELECT code FROM sets WHERE id = 174;
SELECT name FROM sets WHERE code = 'ALL';
SELECT uuid FROM cards WHERE name = 'A Pedra Fellwar';
SELECT code FROM sets WHERE releaseDate = '2007-07-13';
SELECT baseSetSize, code FROM sets WHERE block IN ('Masques', 'Mirage');
SELECT code FROM sets WHERE type = 'expansion';
SELECT foreign_data.name AS foreign_name, cards.type FROM cards JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.watermark = 'boros';
SELECT fd.language, fd.flavorText, c.type FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.watermark = 'colorpie';
SELECT (COUNT(CASE WHEN convertedManaCost = 10 THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM cards WHERE setCode = (SELECT code FROM sets WHERE name = 'Abyssal Horror');
SELECT code FROM sets WHERE type = 'commander';
SELECT fd.flavorText, c.type FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.watermark = 'abzan';
SELECT fd.language, c.types FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.watermark = 'azorius';
SELECT COUNT(*) FROM cards WHERE artist = 'Aaron Miller' AND cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL;
SELECT COUNT(*) AS card_count FROM cards WHERE availability LIKE '%paper%' AND hand LIKE '+%';
SELECT name FROM cards WHERE isTextless = 0;
SELECT convertedManaCost FROM cards WHERE name = 'Ancestor\'s Chosen';
SELECT COUNT(*) FROM cards WHERE borderColor = 'white' AND (power = '*' OR power IS NULL);
SELECT name FROM cards WHERE isPromo = 1 AND side IS NOT NULL;
SELECT types, subtypes, supertypes FROM cards WHERE name = 'Molimo, Maro-Sorcerer';
SELECT purchaseUrls FROM cards WHERE promoTypes = 'bundle';
SELECT COUNT(DISTINCT artist) AS unique_artist_count FROM cards WHERE borderColor = 'black' AND availability LIKE '%arena%' AND availability LIKE '%mtgo%';
SELECT name, convertedManaCost FROM cards WHERE name IN ('Serra Angel', 'Shrine Keeper');
SELECT artist FROM cards WHERE flavorName = 'Battra, Dark Destroyer';
SELECT name FROM cards WHERE frameVersion = '2003' ORDER BY convertedManaCost DESC LIMIT 3;
SELECT st.translation FROM set_translations st JOIN sets s ON st.setCode = s.code JOIN ( SELECT c.uuid FROM cards c WHERE c.name = 'Ancestor\'s Chosen' ) AS card_info ON s.code IN ( SELECT l.uuid FROM legalities l WHERE l.uuid = card_info.uuid ) WHERE st.language = 'Italian';
SELECT COUNT(*) FROM set_translations WHERE setCode IN ( SELECT DISTINCT substr(printings, instr(printings, '-') + 1) FROM cards WHERE name = 'Angel of Mercy' );
SELECT c.name FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Hauptset Zehnte Edition';
SELECT uuid FROM cards WHERE name = 'Ancestor\'s Chosen';
SELECT COUNT(*) FROM cards JOIN sets ON cards.setCode = sets.code WHERE sets.name = 'Hauptset Zehnte Edition' AND cards.artist = 'Adam Rex';
SELECT baseSetSize FROM sets WHERE name = 'Hauptset Zehnte Edition';
SELECT st.translation FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.name = 'Eighth Edition' AND st.language = 'Simplified Chinese';
SELECT uuid FROM cards WHERE name = 'Angel of Mercy';
SELECT setCode FROM cards WHERE name = 'Ancestor''s Chosen';
SELECT type FROM sets WHERE name = 'Hauptset Zehnte Edition';
SELECT COUNT(*) FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.block = 'Ice Age' AND st.language = 'Italian';
SELECT s.isForeignOnly FROM cards c JOIN sets s ON c.setCode = s.code WHERE c.name = 'Adarkar Valkyrie';
SELECT COUNT(*) AS sets_with_italian_translation_and_under_10_base_set_size FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language = 'Italian' AND sets.baseSetSize < 10;
SELECT COUNT(*) FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Coldsnap' AND c.borderColor = 'black';
SELECT c.name FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Coldsnap' AND c.convertedManaCost = ( SELECT MAX(convertedManaCost) FROM cards WHERE setCode = s.code );
SELECT DISTINCT artist FROM cards WHERE uuid IN ( SELECT uuid FROM legalities WHERE uuid IN ( SELECT uuid FROM cards WHERE setCode = ( SELECT code FROM sets WHERE name = 'Coldsnap' ) ) ) AND artist IN ('Jeremy Jarvis', 'Aaron Miller', 'Chippy');
SELECT cards.* FROM cards JOIN sets ON sets.code = cards.setCode WHERE sets.name = 'Coldsnap' AND cards.number = '4';
SELECT COUNT(*) FROM cards WHERE convertedManaCost > 5 AND uuid IN (SELECT uuid FROM sets WHERE code = 'Coldsnap') AND (power = '*' OR power IS NULL);
SELECT fd.flavorText FROM cards AS c JOIN foreign_data AS fd ON c.uuid = fd.uuid WHERE c.name = "Ancestor's Chosen" AND fd.language = "Italian";
SELECT uuid FROM cards WHERE name = "Ancestor's Chosen";
SELECT fd.type FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.name = 'Ancestor''s Chosen' AND fd.language = 'German';
SELECT r.text FROM rulings AS r JOIN cards AS c ON r.uuid = c.uuid JOIN sets AS s ON c.uuid = s.code WHERE s.name = 'Coldsnap' AND r.language = 'Italian';
SELECT code FROM sets WHERE name = 'Coldsnap';
SELECT rulings.date FROM rulings JOIN cards ON rulings.uuid = cards.uuid WHERE cards.name = 'Reminisce';
SELECT (COUNT(CASE WHEN c.convertedManaCost = 7 THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Coldsnap';
SELECT (COUNT(CASE WHEN cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS percentage_incredibly_powerful FROM cards WHERE setCode = 'Coldsnap';
SELECT code FROM sets WHERE releaseDate = '2017-07-14';
SELECT keyruneCode FROM sets WHERE code = 'PKHC';
SELECT mcmId FROM sets WHERE code = 'SS2';
SELECT mcmName FROM sets WHERE releaseDate = '2017-06-09';
SELECT type FROM sets WHERE name = 'From the Vault: Lore';
SELECT parentCode FROM sets WHERE name = 'Commander 2014 Oversized';
SELECT c.id, c.name, c.artist, r.text AS ruling_text, CASE WHEN c.hasContentWarning = 1 THEN 'This card has missing or degraded properties and values.' ELSE 'This card does not have missing or degraded properties and values.' END AS content_warning_status FROM cards c LEFT JOIN rulings r ON c.uuid = r.uuid WHERE c.artist = 'Jim Pavelec';
SELECT s.releaseDate FROM sets s JOIN cards c ON c.setCode = s.code -- Assuming there's a setCode in cards referring to the sets table WHERE c.name = 'Evacuation';
SELECT code FROM sets WHERE name = 'Rinascita di Alara'
SELECT type FROM sets WHERE name = 'Huitième édition';
SELECT st.translation FROM set_translations st JOIN sets s ON st.setCode = s.code JOIN cards c ON s.code = (SELECT setCode FROM cards WHERE name = 'Tendo Ice Bridge') WHERE st.language = 'French';
SELECT COUNT(*) FROM set_translations WHERE setCode = ( SELECT code FROM sets WHERE name = 'Salvat 2011' );
SELECT st.translation AS japanese_set_name FROM cards c JOIN sets s ON c.setCode = s.code -- assuming setCode exists in cards JOIN set_translations st ON s.code = st.setCode WHERE c.name = 'Fellwar Stone' AND st.language = 'Japanese';
SELECT c.name, c.convertedManaCost FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Journey into Nyx Hero''s Path' ORDER BY c.convertedManaCost DESC LIMIT 1;
SELECT releaseDate FROM sets WHERE name = 'Ola de frío';
SELECT sets.type FROM cards JOIN card_sets ON cards.uuid = card_sets.card_uuid JOIN sets ON card_sets.set_code = sets.code WHERE cards.name = 'Samite Pilgrim';
SELECT COUNT(*) FROM cards WHERE setCode = (SELECT code FROM sets WHERE name = 'World Championship Decks 2004') AND convertedManaCost = 3;
SELECT st.translation FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.name = 'Mirrodin' AND st.language = 'Chinese Simplified';
SELECT (COUNT(CASE WHEN s.isNonFoilOnly = 1 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_non_foil FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid JOIN sets s ON c.setCode = s.code WHERE fd.language = 'Japanese';
SELECT (SUM(CASE WHEN c.isOnlineOnly = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS percentage_online_only FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE f.language = 'Portuguese (Brazil)';
SELECT availability FROM cards WHERE artist = 'Aleksi Briclot' AND isTextless = 1;
SELECT id FROM sets WHERE baseSetSize = (SELECT MAX(baseSetSize) FROM sets);
SELECT artist FROM cards WHERE otherFaceIds IS NULL ORDER BY convertedManaCost DESC LIMIT 1
SELECT frameEffects, COUNT(*) AS effect_count FROM cards WHERE cardKingdomFoilId IS NOT NULL AND cardKingdomId IS NOT NULL GROUP BY frameEffects ORDER BY effect_count DESC LIMIT 1;
SELECT COUNT(*) FROM cards WHERE (power IS NULL OR power = '*') AND hasFoil = 0 AND duelDeck = 'a';
SELECT id FROM sets WHERE type = 'commander' ORDER BY totalSetSize DESC LIMIT 1;
SELECT c.uuid, c.name, c.convertedManaCost FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE l.format = 'duel' ORDER BY c.convertedManaCost DESC LIMIT 10;
SELECT uuid, originalReleaseDate FROM cards WHERE rarity = 'mythic' ORDER BY originalReleaseDate LIMIT 1 ) -- Step 2: Use the result to find legal play formats for the oldest mythic card SELECT l.format FROM legalities l JOIN OldestMythicCard omc ON l.uuid = omc.uuid
SELECT COUNT(*) FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE c.artist = 'Volkan Baga' AND f.language = 'French';
SELECT COUNT(*) FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.rarity = 'rare' AND c.type LIKE '%Enchantment%' AND c.name = 'Abundance' AND l.status = 'Legal' GROUP BY c.uuid HAVING COUNT(DISTINCT l.format) = (SELECT COUNT(DISTINCT format) FROM legalities WHERE uuid = c.uuid);
SELECT l.format, c.name, COUNT(*) AS banned_count FROM legalities l JOIN cards c ON l.uuid = c.uuid WHERE l.status = 'banned' GROUP BY l.format ORDER BY banned_count DESC LIMIT 1;
SELECT st.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.name = 'Battlebond';
SELECT artist, COUNT(*) AS card_count FROM cards GROUP BY artist ), LeastIllustrator AS ( SELECT artist FROM ArtistCardCount ORDER BY card_count ASC LIMIT 1 ) SELECT DISTINCT a.artist, l.format FROM cards a JOIN legalities l ON a.uuid = l.uuid WHERE a.artist = (SELECT artist FROM LeastIllustrator)
SELECT legalities.status FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.frameVersion = '1997' AND cards.artist = 'D. Alexander Gregory' AND legalities.format = 'legacy' AND cards.hasContentWarning = 1;
SELECT c.name, l.format FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.edhrecRank = 1 AND l.status = 'banned';
SELECT strftime('%Y', releaseDate) AS Year, COUNT(*) AS SetCount FROM sets WHERE releaseDate BETWEEN '2012-01-01' AND '2015-12-31' GROUP BY Year ), AverageSetCount AS ( SELECT AVG(SetCount) AS AnnualAverage FROM YearlySetCounts ), CommonLanguage AS ( SELECT language, COUNT(*) AS LanguageCount FROM foreign_data GROUP BY language ORDER BY LanguageCount DESC LIMIT 1 ) SELECT (SELECT AnnualAverage FROM AverageSetCount) AS AnnualAverageSets, (SELECT language FROM CommonLanguage) AS CommonLanguag
SELECT DISTINCT artist FROM cards WHERE borderColor = 'black' AND availability = 'arena';
SELECT uuid FROM legalities WHERE format = 'oldschool' AND (status = 'banned' OR status = 'restricted');
SELECT COUNT(*) AS number_of_cards FROM cards WHERE artist = 'Matthew D. Wilson' AND availability = 'paper';
SELECT r.date, r.text FROM rulings r JOIN cards c ON r.uuid = c.uuid WHERE c.artist = 'Kev Walker' ORDER BY r.date DESC;
SELECT c.name FROM cards c JOIN sets s ON s.code = c.setCode WHERE s.name = 'Hour of Devastation';
SELECT s.name FROM sets s LEFT JOIN set_translations st_japanese ON s.code = st_japanese.setCode AND st_japanese.language = 'Japanese' JOIN set_translations st_korean ON s.code = st_korean.setCode AND st_korean.language = 'Korean' WHERE st_japanese.id IS NULL;
SELECT DISTINCT frameVersion FROM cards
SELECT DisplayName, Reputation FROM users WHERE DisplayName IN ('Harlan', 'Jarrod Dixon');
SELECT DisplayName FROM users WHERE strftime('%Y', CreationDate) = '2014';
SELECT COUNT(*) AS NumberOfUsers FROM users WHERE LastAccessDate > '2014-09-01 00:00:00';
SELECT DisplayName FROM users WHERE Views = (SELECT MAX(Views) FROM users);
SELECT COUNT(*) AS UserCount FROM users WHERE UpVotes > 100 AND DownVotes > 1;
SELECT COUNT(*) AS UserCount FROM users WHERE Views > 10 AND CreationDate > '2013-01-01';
SELECT COUNT(*) AS NumberOfPosts FROM posts WHERE OwnerUserId = ( SELECT Id FROM users WHERE DisplayName = 'csgillespie' );
SELECT p.Title FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'csgillespie';
SELECT u.DisplayName FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE p.Title = 'Eliciting priors from experts';
SELECT p.Title FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'csgillespie' ORDER BY p.ViewCount DESC LIMIT 1;
SELECT u.DisplayName FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE p.FavoriteCount = ( SELECT MAX(FavoriteCount) FROM posts );
SELECT SUM(CommentCount) AS TotalComments FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie');
SELECT Id FROM users WHERE DisplayName = 'csgillespie';
SELECT u.DisplayName FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Title = 'Examples for teaching: Correlation does not mean causation';
SELECT Id FROM users WHERE DisplayName = 'csgillespie';
SELECT DISTINCT u.DisplayName FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE p.ClosedDate IS NOT NULL;
SELECT COUNT(*) AS PostCount FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE u.Age > 65 AND p.Score >= 20;
SELECT u.Location FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE p.Title = 'Eliciting priors from experts';
SELECT p.Body FROM tags t JOIN posts p ON t.ExcerptPostId = p.Id WHERE t.TagName = 'bayesian';
SELECT ExcerptPostId FROM tags ORDER BY Count DESC LIMIT 1
SELECT Id FROM users WHERE DisplayName = 'csgillespie';
SELECT Id FROM users WHERE DisplayName = 'csgillespie';
SELECT COUNT(*) AS BadgeCount FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'csgillespie' AND strftime('%Y', b.Date) = '2011';
SELECT u.DisplayName FROM users u JOIN ( SELECT UserId, COUNT(*) AS BadgeCount FROM badges GROUP BY UserId ) b ON u.Id = b.UserId WHERE b.BadgeCount = ( SELECT MAX(BadgeCount) FROM ( SELECT UserId, COUNT(*) AS BadgeCount FROM badges GROUP BY UserId ) )
SELECT AVG(p.Score) AS AverageScore FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'csgillespie';
SELECT AVG(BadgeCount) AS AverageBadges FROM ( SELECT COUNT(b.Id) AS BadgeCount FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Views > 200 GROUP BY b.UserId ) AS UserBadgeCounts;
SELECT Id FROM users WHERE Age > 65 ), PostsWithHighScore AS ( SELECT Id, OwnerUserId FROM posts WHERE Score > 20 ), ElderUserPosts AS ( SELECT p.Id FROM PostsWithHighScore p JOIN ElderUsers e ON p.OwnerUserId = e.Id ) SELECT (COUNT(e.Id) * 100.0 / COUNT(p.Id)) AS ElderUserPostPercentage FROM PostsWithHighScore p LEFT JOIN ElderUserPosts e ON p.Id = e.Id
SELECT COUNT(*) AS VoteCount FROM votes WHERE UserId = 58 AND DATE(CreationDate) = '2010-07-19';
SELECT v.CreationDate FROM votes v WHERE v.PostId IN ( SELECT PostId FROM votes GROUP BY PostId HAVING COUNT(Id) = ( SELECT MAX(voteCount) FROM ( SELECT COUNT(Id) AS voteCount FROM votes GROUP BY PostId ) ) )
SELECT COUNT(*) AS RevivalBadgeCount FROM badges WHERE Name = 'Revival';
SELECT p.Title FROM posts p JOIN comments c ON p.Id = c.PostId WHERE c.Score = (SELECT MAX(Score) FROM comments);
SELECT COUNT(*) AS CommentCount FROM comments WHERE PostId = (SELECT Id FROM posts WHERE ViewCount = 1910);
SELECT p.FavoriteCount FROM posts p JOIN comments c ON p.Id = c.PostId WHERE c.UserId = 3025 AND c.CreationDate = '2014-04-23 20:29:39.0';
SELECT c.Text FROM posts p JOIN comments c ON p.Id = c.PostId WHERE p.ParentId = 107829 LIMIT 1;
SELECT p.ClosedDate IS NULL AS WellFinished FROM comments c JOIN posts p ON c.PostId = p.Id WHERE c.UserId = 23853 AND c.CreationDate = '2013-07-12 09:08:18.0';
SELECT OwnerUserId FROM posts WHERE Id = 65041;
SELECT COUNT(*) AS PostCount FROM posts WHERE OwnerUserId = ( SELECT Id FROM users WHERE DisplayName = 'Tiago Pasqualini' );
SELECT u.DisplayName FROM votes v JOIN users u ON v.UserId = u.Id WHERE v.Id = 6347;
SELECT COUNT(v.Id) AS VoteCount FROM votes v JOIN posts p ON v.PostId = p.Id WHERE p.Title LIKE '%data visualization%';
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'DatEpicCoderGuyWhoPrograms';
SELECT (SELECT COUNT(*) FROM posts WHERE OwnerUserId = 24) AS PostCount, (SELECT COUNT(*) FROM votes WHERE PostId IN (SELECT Id FROM posts WHERE OwnerUserId = 24)) AS VoteCount, (SELECT COUNT(*) FROM posts WHERE OwnerUserId = 24) * 1.0 / CASE WHEN (SELECT COUNT(*) FROM votes WHERE PostId IN (SELECT Id FROM posts WHERE OwnerUserId = 24)) = 0 THEN NULL ELSE (SELECT COUNT(*) FROM votes WHERE PostId IN (SELECT Id FROM posts WHERE OwnerUserId = 24)) END AS PostVoteRatio
SELECT ViewCount FROM posts WHERE Title = 'Integration of Weka and/or RapidMiner into Informatica PowerCenter/Developer';
SELECT Text FROM comments WHERE Score = 17;
SELECT Id, DisplayName, WebsiteUrl FROM users WHERE WebsiteUrl = 'http://stackoverflow.com';
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'SilentGhost';
SELECT UserDisplayName FROM comments WHERE Text = 'thank you user93!';
SELECT Id FROM users WHERE DisplayName = 'A Lion';
SELECT u.DisplayName, u.Reputation FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE p.Title = 'Understanding what Dassault iSight is doing?';
SELECT Id FROM posts WHERE Title = 'How does gentle boosting differ from AdaBoost?';
SELECT u.DisplayName FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Necromancer' LIMIT 10;
SELECT u.DisplayName AS EditorDisplayName FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Title = 'Open source tools for visualizing multi-dimensional data';
SELECT Id FROM users WHERE DisplayName = 'Vebjorn Ljosa';
SELECT SUM(p.Score) AS TotalScore, u.WebsiteUrl FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE u.DisplayName = 'Yevgeny';
SELECT c.* FROM comments c JOIN posts p ON c.PostId = p.Id -- Joining comments with posts WHERE p.Title = 'Why square the difference instead of taking the absolute value in standard deviation?
SELECT SUM(v.BountyAmount) AS TotalBountyAmount FROM posts p JOIN votes v ON p.Id = v.PostId WHERE p.Title LIKE '%data%';
SELECT u.DisplayName FROM votes v JOIN posts p ON v.PostId = p.Id JOIN users u ON v.UserId = u.Id WHERE p.Title LIKE '%variance%' AND v.BountyAmount = 50;
SELECT p.Title, c.Text AS CommentText, c.Score AS CommentScore, AVG(p.ViewCount) OVER() AS AvgViewCount FROM posts p LEFT JOIN comments c ON p.Id = c.PostId WHERE p.Tags LIKE '%humor%' GROUP BY p.Id, c.Id;
SELECT COUNT(*) AS TotalComments FROM comments WHERE UserId = 13;
SELECT Id, Reputation FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users);
SELECT Id FROM users WHERE Views = (SELECT MIN(Views) FROM users WHERE Views IS NOT NULL);
SELECT COUNT(DISTINCT UserId) AS NumberOfUsers FROM badges WHERE Name = 'Supporter' AND strftime('%Y', Date) = '2011';
SELECT COUNT(*) AS UserCount FROM ( SELECT UserId FROM badges GROUP BY UserId HAVING COUNT(Name) > 5 ) AS MoreThanFiveBadges;
SELECT COUNT(DISTINCT u.Id) AS UserCount FROM users u JOIN badges b ON u.Id = b.UserId WHERE u.Location = 'New York' AND b.Name IN ('Teacher', 'Supporter') GROUP BY u.Id HAVING COUNT(DISTINCT b.Name) = 2;
SELECT u.Id AS UserId, u.Reputation FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE p.Id = 1;
SELECT DISTINCT u.Id, u.DisplayName FROM users u JOIN posts p ON u.Id = p.OwnerUserId JOIN ( SELECT PostId FROM postHistory GROUP BY PostId HAVING COUNT(*) = 1 ) ph ON p.Id = ph.PostId WHERE p.ViewCount >= 1000;
SELECT u.DisplayName, COUNT(c.Id) AS CommentCount, b.Name AS BadgeName, b.Date AS BadgeDate FROM users u JOIN comments c ON u.Id = c.UserId LEFT JOIN badges b ON u.Id = b.UserId GROUP BY u.Id HAVING CommentCount = (SELECT MAX(CommentCount) FROM (SELECT UserId, COUNT(Id) AS CommentCount FROM comments GROUP BY UserId));
SELECT COUNT(DISTINCT u.Id) AS NumberOfUsers FROM users u JOIN badges b ON u.Id = b.UserId WHERE u.Location = 'India' AND b.Name = 'Teacher';
SELECT COUNT(CASE WHEN strftime('%Y', Date) = '2010' AND Name = 'Students' THEN 1 END) AS count_2010, COUNT(CASE WHEN strftime('%Y', Date) = '2011' AND Name = 'Students' THEN 1 END) AS count_2011, COUNT(Name) AS total_count FROM badges;
SELECT PostHistoryTypeId FROM postHistory WHERE PostId = 3720;
SELECT pl.RelatedPostId, p.ViewCount as Popularity FROM postLinks pl JOIN posts p ON pl.RelatedPostId = p.Id WHERE pl.PostId = 61217; SELECT ViewCount FROM posts WHERE Id = 61217;
SELECT p.Score, pl.LinkTypeId FROM posts p LEFT JOIN postLinks pl ON p.Id = pl.PostId WHERE p.Id = 395;
SELECT Id AS PostId, OwnerUserId AS UserId FROM posts WHERE Score > 60;
SELECT SUM(FavoriteCount) AS TotalFavorites FROM posts WHERE OwnerUserId = 686 AND strftime('%Y', CreationDate) = '2011';
SELECT OwnerUserId, COUNT(*) AS PostCount FROM posts GROUP BY OwnerUserId HAVING COUNT(*) > 10
SELECT COUNT(DISTINCT UserId) AS NumberOfUsers FROM badges WHERE Name = 'Announcer';
SELECT Name FROM badges WHERE Date = '2010-07-19 19:39:08';
SELECT COUNT(*) AS PositiveCommentCount FROM comments WHERE Score > 60;
SELECT Text FROM comments WHERE CreationDate = '2010-07-19 19:25:47';
SELECT COUNT(*) AS PostCount FROM posts WHERE Score = 10;
SELECT b.Name FROM badges b WHERE b.UserId IN ( SELECT u.Id FROM users u WHERE u.Reputation = ( SELECT MAX(Reputation) FROM users ) )
SELECT u.Reputation FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Date = '2010-07-19 19:39:08';
SELECT badges.Name FROM badges INNER JOIN users ON badges.UserId = users.Id WHERE users.DisplayName = 'Pierre';
SELECT b.Date FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Location = 'Rochester, NY';
SELECT (COUNT(DISTINCT b.UserId) * 100.0 / COUNT(DISTINCT u.Id)) AS TeacherBadgePercentage FROM users u LEFT JOIN badges b ON u.Id = b.UserId AND b.Name = 'Teacher';
SELECT (COUNT(CASE WHEN u.Age BETWEEN 13 AND 18 THEN 1 END) * 100.0) / COUNT(DISTINCT b.UserId) AS TeenagerPercentage FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Organizer';
SELECT c.Score FROM comments c WHERE c.PostId = ( SELECT p.Id FROM posts p WHERE p.CreaionDate = '2010-07-19 19:19:56' );
SELECT Id FROM posts WHERE CreationDate = '2010-07-19 19:37:33';
SELECT u.Age FROM users u JOIN badges b ON u.Id = b.UserId WHERE u.Location = 'Vienna, Austria';
SELECT COUNT(DISTINCT u.Id) AS AdultSupporterCount FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Supporter' AND u.Age BETWEEN 19 AND 65;
SELECT SUM(u.Views) AS TotalViews FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Date = '2010-07-19 19:39:08';
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Reputation = (SELECT MIN(Reputation) FROM users WHERE Reputation IS NOT NULL);
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'Sharpie';
SELECT COUNT(DISTINCT users.Id) AS EldersWithSupporterBadge FROM badges JOIN users ON badges.UserId = users.Id WHERE badges.Name = 'Supporter' AND users.Age > 65;
SELECT DisplayName FROM users WHERE Id = 30;
SELECT COUNT(*) AS NumberOfUsersFromNewYork FROM users WHERE Location = 'New York';
SELECT COUNT(*) FROM votes WHERE strftime('%Y', CreationDate) = '2010';
SELECT COUNT(*) FROM users WHERE Age >= 19 AND Age <= 65;
SELECT DisplayName FROM users WHERE Views = (SELECT MAX(Views) FROM users);
SELECT (COUNT(CASE WHEN strftime('%Y', CreationDate) = '2010' THEN Id END) * 1.0 / COUNT(CASE WHEN strftime('%Y', CreationDate) = '2011' THEN Id END)) AS ratio FROM votes;
SELECT t.TagName FROM tags t JOIN postTags pt ON t.Id = pt.TagId -- Assuming a table named postTags that links posts and tags JOIN posts p ON pt.PostId = p.Id WHERE p.OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'John Stauffer');
SELECT Id FROM users WHERE DisplayName = 'Daniel Vassallo';
SELECT COUNT(v.Id) AS NumberOfVotes FROM users u JOIN votes v ON u.Id = v.UserId WHERE u.DisplayName = 'Harlan';
SELECT Id FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'slashnick') ORDER BY AnswerCount DESC LIMIT 1;
SELECT DisplayName, SUM(ViewCount) AS TotalViewCount FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName IN ('Harvey Motulsky', 'Noah Snyder') GROUP BY users.DisplayName ORDER BY TotalViewCount DESC LIMIT 1;
SELECT COUNT(*) AS PostCount FROM posts p JOIN users u ON p.OwnerUserId = u.Id LEFT JOIN votes v ON p.Id = v.PostId WHERE u.DisplayName = 'Matt Parker' GROUP BY p.Id HAVING COUNT(v.Id) > 4;
SELECT COUNT(c.Id) AS NegativeCommentCount FROM comments c JOIN posts p ON c.PostId = p.Id JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'Neil McGuigan' AND c.Score < 60;
SELECT DISTINCT t.TagName FROM users u JOIN posts p ON u.Id = p.OwnerUserId LEFT JOIN comments c ON p.Id = c.PostId JOIN tags t ON t.ExcerptPostId = p.Id WHERE u.DisplayName = 'Mark Meckes' AND c.Id IS NULL; -- Ensure there are no comments for the posts
SELECT u.DisplayName FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Organizer';
SELECT (COUNT(CASE WHEN t.TagName = 'r' THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM posts p JOIN users u ON p.OwnerUserId = u.Id LEFT JOIN postTags pt ON p.Id = pt.PostId -- Assuming there is a linking table for post and tags LEFT JOIN tags t ON pt.TagId = t.Id -- Assuming there is a TagId in postTags relation WHERE u.DisplayName = 'Community';
SELECT SUM(CASE WHEN u.DisplayName = 'Mornington' THEN p.ViewCount ELSE 0 END) - SUM(CASE WHEN u.DisplayName = 'Amos' THEN p.ViewCount ELSE 0 END) AS ViewCountDifference FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName IN ('Mornington', 'Amos');
SELECT COUNT(DISTINCT UserId) AS UserCount FROM badges WHERE Name = 'commentator' AND strftime('%Y', Date) = '2014';
SELECT COUNT(*) AS NumberOfPosts FROM posts WHERE CreationDate BETWEEN '2010-07-21 00:00:00' AND '2010-07-21 23:59:59';
SELECT DisplayName, Age FROM users WHERE Views = (SELECT MAX(Views) FROM users);
SELECT LastEditDate, LastEditorUserId FROM posts WHERE Title = 'Detecting a given face in a database of facial images';
SELECT COUNT(*) FROM comments WHERE UserId = 13 AND Score < 60;
SELECT p.Title AS PostTitle, u.DisplayName AS UserDisplayName FROM posts p JOIN comments c ON p.Id = c.PostId JOIN users u ON c.UserId = u.Id WHERE c.Score > 60;
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Location = 'North Pole' AND strftime('%Y', b.Date) = '2011';
SELECT users.DisplayName, users.WebsiteUrl FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE posts.FavoriteCount > 150;
SELECT p.Id, p.LastEditDate, (SELECT COUNT(*) FROM postHistory ph WHERE ph.PostId = p.Id) AS PostHistoryCount FROM posts p WHERE p.Title = 'What is the best introductory Bayesian statistics textbook?';
SELECT u.LastAccessDate, u.Location FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Outliers';
SELECT p2.Title FROM posts p1 JOIN postLinks pl ON p1.Id = pl.PostId JOIN posts p2 ON pl.RelatedPostId = p2.Id WHERE p1.Title = 'How to tell if something happened in a data set which monitors a value over time';
SELECT p.Id AS PostId, b.Name AS BadgeName FROM users u JOIN posts p ON u.Id = p.OwnerUserId JOIN badges b ON u.Id = b.UserId WHERE u.DisplayName = 'Samuel' AND YEAR(p.CreaionDate) = 2013 AND YEAR(b.Date) = 2013;
SELECT OwnerDisplayName FROM posts WHERE ViewCount = ( SELECT MAX(ViewCount) FROM posts );
SELECT u.DisplayName, u.Location FROM posts p JOIN tags t ON p.Id = t.ExcerptPostId JOIN users u ON p.OwnerUserId = u.Id WHERE t.TagName = 'hypothesis-testing';
SELECT relatedPosts.Title, postLinks.LinkTypeId FROM posts AS originalPost JOIN postLinks ON originalPost.Id = postLinks.PostId JOIN posts AS relatedPosts ON postLinks.RelatedPostId = relatedPosts.Id WHERE originalPost.Title = 'What are principal component scores?';
SELECT p2.OwnerDisplayName FROM posts p1 JOIN posts p2 ON p1.ParentId = p2.Id WHERE p1.Score = (SELECT MAX(Score) FROM posts WHERE ParentId IS NOT NULL) AND p1.ParentId IS NOT NULL;
SELECT u.DisplayName, u.WebsiteUrl FROM votes v JOIN users u ON v.UserId = u.Id WHERE v.VoteTypeId = 8 AND v.BountyAmount = ( SELECT MAX(BountyAmount) FROM votes WHERE VoteTypeId = 8 );
SELECT Title FROM posts ORDER BY ViewCount DESC LIMIT 5;
SELECT COUNT(*) AS TagCount FROM tags WHERE Count BETWEEN 5000 AND 7000;
SELECT OwnerUserId FROM posts WHERE FavoriteCount = (SELECT MAX(FavoriteCount) FROM posts);
SELECT Age FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users);
SELECT COUNT(DISTINCT p.Id) AS PostCount FROM posts p JOIN votes v ON p.Id = v.PostId WHERE YEAR(p.CreationDate) = 2011 AND v.BountyAmount = 50;
SELECT Id FROM users WHERE Age = (SELECT MIN(Age) FROM users);

SELECT AVG(MonthlyLinkCount) AS AverageMonthlyLinks FROM (SELECT strftime('%Y-%m', CreationDate) AS YearMonth, COUNT(Id) AS MonthlyLinkCount FROM postLinks PL JOIN posts P ON PL.PostId = P.Id WHERE strftime('%Y', PL.CreationDate) = '2010' AND P.AnswerCount <= 2 GROUP BY strftime('%Y-%m', CreationDate) ) AS MonthlyCounts;
SELECT p.Id FROM votes v JOIN posts p ON v.PostId = p.Id WHERE v.UserId = 1465 ORDER BY p.FavoriteCount DESC LIMIT 1;
SELECT p.Title FROM posts p JOIN postLinks pl ON p.Id = pl.PostId WHERE pl.CreationDate = ( SELECT MIN(CreationDate) FROM postLinks );
SELECT u.DisplayName FROM users u JOIN ( SELECT UserId, COUNT(Name) AS BadgeCount FROM badges GROUP BY UserId HAVING COUNT(Name) = ( SELECT MAX(BadgeCount) FROM ( SELECT COUNT(Name) AS BadgeCount FROM badges GROUP BY UserId ) ) ) AS maxBadges ON u.Id = maxBadges.UserId;
SELECT Id FROM users WHERE DisplayName = 'chl';
SELECT MIN(p.CreaionDate) AS FirstPostDate FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE u.Age = ( SELECT MIN(Age) FROM users )
SELECT u.DisplayName FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Name = 'Autobiographer' AND b.Date = (SELECT MIN(Date) FROM badges WHERE Name = 'Autobiographer');
SELECT COUNT(DISTINCT u.Id) AS UserCount FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE u.Location = 'United Kingdom' AND p.FavoriteCount >= 4;
SELECT MAX(Age) AS OldestAge FROM users;
SELECT DisplayName FROM users ORDER BY Reputation DESC LIMIT 1;
SELECT COUNT(*) FROM users WHERE Reputation > 2000 AND Views > 1000;
SELECT DisplayName FROM users WHERE Age BETWEEN 19 AND 65;
SELECT COUNT(*) AS PostCount FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Jay Stevens') AND strftime('%Y', CreationDate) = '2010';
SELECT p.Id, p.Title FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'Harvey Motulsky' ORDER BY p.ViewCount DESC LIMIT 1;
SELECT Id, Title FROM posts WHERE Score = (SELECT MAX(Score) FROM posts);
SELECT Id FROM users WHERE DisplayName = 'Stephen Turner';
SELECT DISTINCT u.DisplayName FROM posts p INNER JOIN users u ON p.OwnerUserId = u.Id WHERE p.ViewCount > 20000 AND YEAR(p.CreaionDate) = 2011;
SELECT p.Id, u.DisplayName AS OwnerDisplayName FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE strftime('%Y', p.CreaionDate) = '2010' AND p.FavoriteCount = ( SELECT MAX(FavoriteCount) FROM posts WHERE strftime('%Y', CreationDate) = '2010' )
SELECT (COUNT(CASE WHEN u.Reputation > 1000 THEN p.Id END) * 100.0 / COUNT(p.Id)) AS percentage FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE strftime('%Y', p.CreaionDate) = '2011';
SELECT (COUNT(CASE WHEN Age BETWEEN 13 AND 18 THEN 1 END) * 100.0 / COUNT(Id)) AS PercentageOfTeenageUsers FROM users;
SELECT p.ViewCount AS Total_Views, u.DisplayName AS Last_User FROM posts p LEFT JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Title = 'Computer Game Datasets';
SELECT COUNT(*) AS TotalAboveAverageViews FROM posts WHERE ViewCount > (SELECT AVG(ViewCount) FROM posts);
SELECT Id FROM posts WHERE Score = (SELECT MAX(Score) FROM posts);
SELECT COUNT(*) FROM posts WHERE ViewCount > 35000 AND CommentCount = 0;
SELECT u.DisplayName, u.Location FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Id = 183;
SELECT b.* FROM badges AS b JOIN users AS u ON b.UserId = u.Id WHERE u.DisplayName = 'Emmett' ORDER BY b.Date DESC LIMIT 1;
SELECT COUNT(*) AS NumberOfAdultUsers FROM users WHERE Age BETWEEN 19 AND 65 AND UpVotes > 5000;
SELECT julian_day(b.Date) - julian_day(u.CreationDate) AS DaysToGetBadge FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'Zolomon';
SELECT Id FROM users ORDER BY CreationDate DESC LIMIT 1 ) SELECT (SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM LatestUser)) AS NumberOfPosts, (SELECT COUNT(*) FROM comments WHERE UserId = (SELECT Id FROM LatestUser)) AS NumberOfComment
SELECT c.Text AS CommentText, c.UserDisplayName, c.CreationDate, p.Id AS PostId FROM comments c JOIN posts p ON c.PostId = p.Id WHERE p.Title = 'Analysing wind data with R' ORDER BY c.CreationDate DESC LIMIT 1 ) SELECT CommentText, UserDisplayName FROM LatestComment
SELECT COUNT(DISTINCT UserId) AS NumberOfUsers FROM badges WHERE Name = 'Citizen Patrol';
SELECT COUNT(p.Id) AS PostCount FROM posts p JOIN post_tags pt ON p.Id = pt.PostId JOIN tags t ON pt.TagId = t.Id WHERE t.TagName = 'careers';
SELECT Reputation, Views FROM users WHERE DisplayName = 'Jarrod Dixon';
SELECT Id INTO @PostId FROM posts WHERE Title = 'Clustering 1D data'
SELECT CreationDate FROM users WHERE DisplayName = 'IrishStat';
SELECT COUNT(DISTINCT PostId) AS NumberOfPostsWithBountyOver30 FROM votes WHERE BountyAmount >= 30;
SELECT Id FROM users ORDER BY Reputation DESC LIMIT 1 ), UserPosts AS ( SELECT COUNT(*) AS TotalPosts, SUM(CASE WHEN Score >= 50 THEN 1 ELSE 0 END) AS PostsWithScoreAbove50 FROM posts WHERE OwnerUserId = (SELECT Id FROM MostInfluentialUser) ) SELECT (CAST(PostsWithScoreAbove50 AS FLOAT) / TotalPosts) * 100 AS PercentageAbove50 FROM UserPosts
SELECT COUNT(*) AS PostCount FROM posts WHERE Score < 20;
SELECT COUNT(*) AS NumberOfTags FROM tags WHERE Id < 15 AND Count <= 20;
SELECT ExcerptPostId, WikiPostId FROM tags WHERE TagName = 'sample';
SELECT u.Reputation, u.UpVotes FROM comments c JOIN users u ON c.UserId = u.Id WHERE c.Text = 'fine, you win :)';
SELECT c.Text FROM comments c JOIN posts p ON c.PostId = p.Id WHERE p.Title LIKE '%linear regression%'
SELECT c.* FROM comments c JOIN posts p ON c.PostId = p.Id WHERE p.ViewCount BETWEEN 100 AND 150 ORDER BY c.Score DESC LIMIT 1;
SELECT u.CreationDate, u.Age FROM comments c JOIN users u ON c.UserId = u.Id WHERE c.Text LIKE '%http://%';
SELECT COUNT(DISTINCT p.Id) AS LowViewCountPostCount FROM comments c JOIN posts p ON c.PostId = p.Id WHERE c.Score = 0 AND p.ViewCount < 5;
SELECT COUNT(c.Id) AS ZeroScoreCommentCount FROM posts p JOIN comments c ON p.Id = c.PostId WHERE p.CommentCount = 1 AND c.Score = 0;
SELECT COUNT(DISTINCT u.Id) AS NumberOfUsers FROM comments c JOIN users u ON c.UserId = u.Id WHERE c.Score = 0 AND u.Age = 40;
SELECT c.Id AS CommentId, c.Text, c.CreationDate FROM posts p JOIN comments c ON p.Id = c.PostId WHERE p.Title = 'Group differences on a five point Likert item';
SELECT UserId FROM comments WHERE Text = 'R is also lazy evaluated.';
SELECT * FROM comments WHERE UserId = ( SELECT Id FROM users WHERE DisplayName = 'Harvey Motulsky' );
SELECT u.DisplayName FROM comments c JOIN users u ON c.UserId = u.Id WHERE c.Score BETWEEN 1 AND 5 AND u.DownVotes = 0;
SELECT DISTINCT c.UserId FROM comments c WHERE c.Score BETWEEN 5 AND 10 ), UsersWithZeroUpVotes AS ( SELECT sf.UserId FROM ScoreFilteredComments sf JOIN users u ON sf.UserId = u.Id WHERE u.UpVotes = 0 ) SELECT (COUNT(uwz.UserId) * 100.0 / COUNT(sf.UserId)) AS percentage FROM ScoreFilteredComments sf LEFT JOIN UsersWithZeroUpVotes uwz ON sf.UserId = uwz.UserId
SELECT sp.power_name FROM superhero sh JOIN hero_power hp ON sh.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sh.superhero_name = '3-D Man';
SELECT COUNT(*) AS superhero_count FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sp.power_name = 'Super Strength';
SELECT COUNT(*) FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sp.power_name = 'Super Strength' AND s.height_cm > 200;
SELECT s.full_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id GROUP BY s.id HAVING COUNT(hp.power_id) > 15;
SELECT id FROM colour WHERE colour = 'Blue'
SELECT c.colour FROM superhero s JOIN colour c ON s.skin_colour_id = c.id WHERE s.superhero_name = 'Apocalypse';
SELECT COUNT(DISTINCT sh.id) AS number_of_superheroes_with_agility FROM superhero sh JOIN colour eye_col ON sh.eye_colour_id = eye_col.id JOIN hero_power hp ON sh.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE eye_col.colour = 'Blue' AND sp.power_name = 'Agility';
SELECT s.superhero_name FROM superhero s JOIN colour c_eye ON s.eye_colour_id = c_eye.id JOIN colour c_hair ON s.hair_colour_id = c_hair.id WHERE c_eye.colour = 'Blue' AND c_hair.colour = 'Blond';
SELECT COUNT(*) AS superhero_count FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics';
SELECT s.full_name FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics' ORDER BY s.height_cm DESC LIMIT 1;
SELECT p.publisher_name FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE s.superhero_name = 'Sauron';
SELECT COUNT(*) AS blue_eyed_marvel_heroes FROM superhero s JOIN colour c ON s.eye_colour_id = c.id JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics' AND c.colour = 'Blue';
SELECT AVG(height_cm) AS average_height FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics';
SELECT (COUNT(DISTINCT hp.hero_id) * 100.0 / COUNT(DISTINCT sh.id)) AS super_strength_percentage FROM superhero sh JOIN publisher p ON sh.publisher_id = p.id LEFT JOIN hero_power hp ON sh.id = hp.hero_id LEFT JOIN superpower sp ON hp.power_id = sp.id WHERE p.publisher_name = 'Marvel Comics' AND (sp.power_name = 'Super Strength' OR sp.power_name IS NULL)
SELECT COUNT(*) FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'DC Comics';
SELECT p.publisher_name FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id JOIN publisher p ON s.publisher_id = p.id WHERE a.attribute_name = 'Speed' AND ha.attribute_value = ( SELECT MIN(attribute_value) FROM hero_attribute JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' );
SELECT COUNT(*) AS gold_eyed_marvel_superheroes FROM superhero s JOIN colour c ON s.eye_colour_id = c.id JOIN publisher p ON s.publisher_id = p.id WHERE c.colour = 'Gold' AND p.publisher_name = 'Marvel Comics';
SELECT publisher.publisher_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.superhero_name = 'Blue Beetle II';
SELECT COUNT(*) AS blonde_heroes_count FROM superhero WHERE hair_colour_id = (SELECT id FROM colour WHERE colour = 'Blond');
SELECT sh.superhero_name, sh.full_name, ha.attribute_value FROM superhero sh JOIN hero_attribute ha ON sh.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Intelligence' AND ha.attribute_value = ( SELECT MIN(attribute_value) FROM hero_attribute ha2 JOIN attribute a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'Intelligence' );
SELECT r.race FROM superhero AS s JOIN race AS r ON s.race_id = r.id WHERE s.superhero_name = 'Copycat';
SELECT COUNT(DISTINCT sh.id) AS superhero_count FROM superhero sh JOIN hero_attribute ha ON sh.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Durability' AND ha.attribute_value < 50;
SELECT s.superhero_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sp.power_name = 'Death Touch';
SELECT COUNT(*) AS female_superheroes_with_strength_100 FROM superhero s JOIN gender g ON s.gender_id = g.id JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE g.gender = 'Female' AND a.attribute_name = 'Strength' AND ha.attribute_value = 100;
SELECT s.superhero_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id GROUP BY s.id, s.superhero_name ORDER BY COUNT(hp.power_id) DESC LIMIT 1;
SELECT COUNT(*) AS vampire_superhero_count FROM superhero WHERE race_id = (SELECT id FROM race WHERE race = 'Vampire');
SELECT * FROM table
SELECT (SELECT COUNT(*) FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'DC Comics') AS dc_count, (SELECT COUNT(*) FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics') AS marvel_count, (SELECT COUNT(*) FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics') - (SELECT COUNT(*) FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'DC Comics') AS difference
SELECT id FROM publisher WHERE publisher_name = 'Star Trek';
SELECT AVG(attribute_value) AS average_attribute_value FROM hero_attribute;
SELECT COUNT(*) AS total_superheroes_without_full_name FROM superhero WHERE full_name IS NULL;
SELECT c.colour FROM superhero s JOIN colour c ON s.eye_colour_id = c.id WHERE s.id = 75;
SELECT sp.power_name FROM superhero AS sh JOIN hero_power AS hp ON sh.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE sh.superhero_name = 'Deathlok';
SELECT AVG(weight_kg) AS average_weight FROM superhero WHERE gender_id = 2;
SELECT DISTINCT sp.power_name FROM superhero sh JOIN gender g ON sh.gender_id = g.id JOIN hero_power hp ON sh.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE g.gender = 'Male' LIMIT 5;
SELECT s.superhero_name FROM superhero s JOIN race r ON s.race_id = r.id WHERE r.race = 'Alien';
SELECT superhero_name FROM superhero WHERE height_cm BETWEEN 170 AND 190 AND eye_colour_id IS NULL;
SELECT sp.power_name FROM hero_power hp JOIN superhero sh ON hp.hero_id = sh.id JOIN superpower sp ON hp.power_id = sp.id WHERE sh.id = 56;
SELECT s.full_name FROM superhero s JOIN race r ON s.race_id = r.id WHERE r.race = 'Demi-God' LIMIT 5; -- To list down at least five full names
SELECT id FROM alignment WHERE alignment = 'Bad';
SELECT r.race FROM superhero s JOIN race r ON s.race_id = r.id WHERE s.weight_kg = 169;
SELECT colour.colour FROM superhero JOIN colour ON superhero.hair_colour_id = colour.id WHERE superhero.height_cm = 185 AND superhero.race_id = (SELECT id FROM race WHERE race = 'human');
SELECT c.colour AS eye_colour FROM superhero s JOIN colour c ON s.eye_colour_id = c.id WHERE s.weight_kg = (SELECT MAX(weight_kg) FROM superhero);
SELECT (COUNT(CASE WHEN publisher_id = 13 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_marvel_heroes FROM superhero WHERE height_cm BETWEEN 150 AND 180;
SELECT s.full_name FROM superhero s JOIN gender g ON s.gender_id = g.id WHERE g.gender = 'Male' AND s.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero);
SELECT sp.power_name, COUNT(hp.hero_id) AS power_count FROM hero_power hp JOIN superpower sp ON hp.power_id = sp.id GROUP BY sp.id, sp.power_name ORDER BY power_count DESC LIMIT 1;
SELECT id FROM superhero WHERE superhero_name = 'Abomination';
SELECT sp.power_name FROM hero_power hp JOIN superpower sp ON hp.power_id = sp.id WHERE hp.hero_id = 1;
SELECT id FROM superpower WHERE power_name = 'stealth';
SELECT s.full_name FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE a.attribute_name = 'strength' AND ha.attribute_value = ( SELECT MAX(attribute_value) FROM hero_attribute ha2 JOIN attribute a2 ON ha2.attribute_id = a2.id WHERE a2.attribute_name = 'strength' )
SELECT (COUNT(CASE WHEN skin_colour_id IS NULL THEN 1 END) * 1.0) / COUNT(*) AS average_no_skin_colour FROM superhero;
SELECT COUNT(*) AS superhero_count FROM superhero WHERE publisher_id = ( SELECT id FROM publisher WHERE publisher_name = 'Dark Horse Comics' );
SELECT s.superhero_name, MAX(ha.attribute_value) AS max_durability FROM superhero s JOIN publisher p ON s.publisher_id = p.id JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE p.publisher_name = 'Dark Horse Comics' AND a.attribute_name = 'durability' GROUP BY s.id ORDER BY max_durability DESC LIMIT 1;
SELECT c.colour FROM superhero s JOIN colour c ON s.eye_colour_id = c.id WHERE s.full_name = 'Abraham Sapien';
SELECT s.superhero_name FROM superhero AS s JOIN hero_power AS hp ON s.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE sp.power_name = 'Flight';
SELECT eye_colour.colour AS eye_colour, hair_colour.colour AS hair_colour, skin_colour.colour AS skin_colour FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN publisher ON superhero.publisher_id = publisher.id JOIN colour AS eye_colour ON superhero.eye_colour_id = eye_colour.id JOIN colour AS hair_colour ON superhero.hair_colour_id = hair_colour.id JOIN colour AS skin_colour ON superhero.skin_colour_id = skin_colour.id WHERE gender.gender = 'Female' AND publisher.publisher_name = 'Dark Horse Comics';
SELECT s1.superhero_name, s1.full_name, p.publisher_name FROM superhero AS s1 JOIN superhero AS s2 ON s1.eye_colour_id = s2.eye_colour_id AND s1.hair_colour_id = s2.hair_colour_id AND s1.skin_colour_id = s2.skin_colour_id JOIN publisher AS p ON s1.publisher_id = p.id WHERE s1.id <> s2.id; -- Ensures that we're not matching the same superhero
SELECT r.race FROM superhero s JOIN race r ON s.race_id = r.id WHERE s.superhero_name = 'A-Bomb';
SELECT (COUNT(CASE WHEN c.colour = 'Blue' THEN 1 END) * 100.0 / COUNT(*)) AS blue_female_percentage FROM superhero s JOIN gender g ON s.gender_id = g.id JOIN colour c ON s.eye_colour_id = c.id WHERE g.gender = 'Female';
SELECT s.superhero_name, r.race FROM superhero s JOIN race r ON s.race_id = r.id WHERE s.full_name = 'Charles Chandler';
SELECT g.gender FROM superhero s JOIN gender g ON s.gender_id = g.id WHERE s.superhero_name = 'Agent 13';
SELECT s.superhero_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sp.power_name = 'Adaptation';
SELECT COUNT(hp.power_id) AS number_of_powers FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id WHERE s.superhero_name = 'Amazo';
SELECT sp.power_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE s.full_name = 'Hunter Zolomon';
SELECT superhero.height_cm FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Amber';
SELECT s.superhero_name FROM superhero s JOIN colour c1 ON s.eye_colour_id = c1.id AND c1.colour = 'Black' JOIN colour c2 ON s.hair_colour_id = c2.id AND c2.colour = 'Black';
SELECT e.colour AS eye_colour FROM superhero s JOIN colour skin ON s.skin_colour_id = skin.id JOIN colour e ON s.eye_colour_id = e.id WHERE skin.colour = 'Gold';
SELECT s.full_name FROM superhero s JOIN race r ON s.race_id = r.id WHERE r.race = 'Vampire';
SELECT s.superhero_name FROM superhero s JOIN alignment a ON s.alignment_id = a.id WHERE a.alignment = 'Neutral';
SELECT MAX(attribute_value) AS max_strength FROM hero_attribute JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Strength';
SELECT r.race AS Race, a.alignment AS Alignment FROM superhero s JOIN race r ON s.race_id = r.id JOIN alignment a ON s.alignment_id = a.id WHERE s.superhero_name = 'Cameron Hicks';
SELECT ( (SELECT COUNT(*) FROM superhero s JOIN gender g ON s.gender_id = g.id JOIN publisher p ON s.publisher_id = p.id WHERE g.gender = 'Female' AND p.publisher_name = 'Marvel Comics') / (SELECT COUNT(*) FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics') ) * 100 AS percent_female_heroes
SELECT AVG(s.weight_kg) AS average_weight FROM superhero s JOIN race r ON s.race_id = r.id WHERE r.race = 'Alien';
SELECT (SUM(CASE WHEN full_name = 'Emil Blonsky' THEN weight_kg ELSE 0 END) - SUM(CASE WHEN full_name = 'Charles Chandler' THEN weight_kg ELSE 0 END)) AS weight_difference FROM superhero WHERE full_name IN ('Emil Blonsky', 'Charles Chandler');
SELECT AVG(height_cm) AS average_height FROM superhero;
SELECT sp.power_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE s.superhero_name = 'Abomination';
SELECT COUNT(*) FROM superhero WHERE race_id = 21 AND gender_id = 1;
SELECT s.superhero_name, ha.attribute_value FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE a.attribute_name = 'Speed' ORDER BY ha.attribute_value DESC LIMIT 1;
SELECT COUNT(*) AS number_of_neutral_superheroes FROM superhero WHERE alignment_id = 3;
SELECT a.attribute_name, ha.attribute_value FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id JOIN attribute a ON ha.attribute_id = a.id WHERE s.superhero_name = '3-D Man';
SELECT superhero_name FROM superhero WHERE eye_colour_id = 7 AND hair_colour_id = 9;
SELECT s.superhero_name, p.publisher_name FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE s.superhero_name IN ('Hawkman', 'Karate Kid', 'Speedy');
SELECT COUNT(*) AS superheroes_without_publisher FROM superhero WHERE publisher_id IS NULL;
SELECT (COUNT(CASE WHEN eye_colour_id = 7 THEN 1 END) * 100.0 / COUNT(*)) AS percentage_blue_eyes FROM superhero;
SELECT (SELECT COUNT(*) FROM superhero WHERE gender_id = 1) * 1.0 / (SELECT COUNT(*) FROM superhero WHERE gender_id = 2) AS male_to_female_ratio
SELECT superhero_name, height_cm FROM superhero WHERE height_cm = (SELECT MAX(height_cm) FROM superhero);
SELECT id FROM superpower WHERE power_name = 'cryokinesis';
SELECT superhero_name FROM superhero WHERE id = 294;
SELECT full_name FROM superhero WHERE weight_kg IS NULL OR weight_kg = 0;
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.full_name = 'Karen Beecher-Duncan';
SELECT sp.power_name FROM superhero AS sh JOIN hero_power AS hp ON sh.id = hp.hero_id JOIN superpower AS sp ON hp.power_id = sp.id WHERE sh.full_name = 'Helen Parr';
SELECT r.race FROM superhero s JOIN race r ON s.race_id = r.id WHERE s.weight_kg = 108 AND s.height_cm = 188;
SELECT p.publisher_name FROM superhero s JOIN publisher p ON s.publisher_id = p.id WHERE s.id = 38;
SELECT r.race FROM hero_attribute ha JOIN superhero s ON ha.hero_id = s.id JOIN race r ON s.race_id = r.id WHERE ha.attribute_value = ( SELECT MAX(attribute_value) FROM hero_attribute );
SELECT a.alignment, sp.power_name FROM superhero s JOIN alignment a ON s.alignment_id = a.id JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE s.superhero_name = 'Atom IV';
SELECT superhero.full_name FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Blue' LIMIT 5; -- Limiting the output to at least five full names of superheroes with blue eyes
SELECT AVG(ha.attribute_value) AS average_attribute_value FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id WHERE s.alignment_id = 3;
SELECT colour.colour FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN colour ON superhero.skin_colour_id = colour.id WHERE hero_attribute.attribute_value = 100;
SELECT COUNT(*) AS good_female_superheroes FROM superhero AS s JOIN gender AS g ON s.gender_id = g.id JOIN alignment AS a ON s.alignment_id = a.id WHERE g.id = 2 AND a.id = 1;
SELECT s.superhero_name FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id WHERE ha.attribute_value BETWEEN 75 AND 80;
SELECT r.race FROM superhero s JOIN colour c ON s.hair_colour_id = c.id JOIN gender g ON s.gender_id = g.id JOIN race r ON s.race_id = r.id WHERE c.colour = 'blue' AND g.gender = 'male';
SELECT (COUNT(CASE WHEN g.gender = 'Female' THEN 1 END) * 100.0) / COUNT(s.id) AS female_percentage FROM superhero s JOIN gender g ON s.gender_id = g.id WHERE s.alignment_id = 2; -- Bad superheroes
SELECT (SELECT COUNT(*) FROM superhero WHERE (weight_kg IS NULL OR weight_kg = 0) AND eye_colour_id = 7) AS blue_eyes_count, (SELECT COUNT(*) FROM superhero WHERE (weight_kg IS NULL OR weight_kg = 0) AND eye_colour_id = 1) AS no_eye_colour_count, ((SELECT COUNT(*) FROM superhero WHERE (weight_kg IS NULL OR weight_kg = 0) AND eye_colour_id = 7) - (SELECT COUNT(*) FROM superhero WHERE (weight_kg IS NULL OR weight_kg = 0) AND eye_colour_id = 1)) AS difference
SELECT ha.attribute_value FROM superhero AS s JOIN hero_attribute AS ha ON s.id = ha.hero_id JOIN attribute AS a ON ha.attribute_id = a.id WHERE s.superhero_name = 'Hulk' AND a.attribute_name = 'Strength';
SELECT id FROM superhero WHERE superhero_name = 'Ajax';
SELECT COUNT(*) AS green_skinned_villains_count FROM superhero s JOIN colour c ON s.skin_colour_id = c.id JOIN alignment a ON s.alignment_id = a.id WHERE c.colour = 'Green' AND a.alignment = 'Bad';
SELECT COUNT(*) AS female_superhero_count FROM superhero s JOIN gender g ON s.gender_id = g.id JOIN publisher p ON s.publisher_id = p.id WHERE g.gender = 'Female' AND p.publisher_name = 'Marvel Comics';
SELECT s.superhero_name FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower p ON hp.power_id = p.id WHERE p.power_name = 'Wind Control' ORDER BY s.superhero_name;
SELECT g.gender FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id JOIN gender g ON s.gender_id = g.id WHERE sp.power_name = 'Phoenix Force';
SELECT superhero.superhero_name, superhero.full_name, superhero.weight_kg FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'DC Comics' ORDER BY superhero.weight_kg DESC LIMIT 1;
SELECT AVG(s.height_cm) AS average_height FROM superhero s JOIN race r ON s.race_id = r.id JOIN publisher p ON s.publisher_id = p.id WHERE r.race <> 'Human' AND p.publisher_name = 'Dark Horse Comics';
SELECT COUNT(DISTINCT sh.id) AS fastest_superhero_count FROM superhero sh JOIN hero_attribute ha ON sh.id = ha.hero_id WHERE ha.attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Speed') AND ha.attribute_value = 100;
SELECT p.publisher_name, COUNT(s.id) AS superhero_count FROM publisher p LEFT JOIN superhero s ON p.id = s.publisher_id WHERE p.publisher_name IN ('DC Comics', 'Marvel Comics') GROUP BY p.publisher_name;
SELECT id FROM superhero WHERE superhero_name = 'Black Panther';
SELECT colour.colour AS eye_colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.superhero_name = 'Abomination';
SELECT superhero_name, full_name, height_cm FROM superhero WHERE height_cm = (SELECT MAX(height_cm) FROM superhero);
SELECT superhero_name FROM superhero WHERE full_name = 'Charles Chandler';
SELECT (COUNT(CASE WHEN g.gender = 'Female' THEN 1 END) * 100.0 / COUNT(s.id)) AS female_percentage FROM superhero s JOIN publisher p ON s.publisher_id = p.id JOIN gender g ON s.gender_id = g.id WHERE p.publisher_name = 'George Lucas';
SELECT (COUNT(CASE WHEN a.alignment = 'Good' THEN 1 END) * 100.0 / COUNT(s.id)) AS good_superhero_percentage FROM superhero s JOIN alignment a ON s.alignment_id = a.id JOIN publisher p ON s.publisher_id = p.id WHERE p.publisher_name = 'Marvel Comics';
SELECT COUNT(*) AS total_superheroes FROM superhero WHERE full_name LIKE 'John%';
SELECT hero_id FROM hero_attribute WHERE attribute_value = ( SELECT MIN(attribute_value) FROM hero_attribute );
SELECT full_name FROM superhero WHERE superhero_name = 'Alien';
SELECT s.full_name FROM superhero s JOIN colour c ON s.eye_colour_id = c.id WHERE s.weight_kg < 100 AND c.colour = 'brown';
SELECT ha.attribute_value FROM superhero s JOIN hero_attribute ha ON s.id = ha.hero_id WHERE s.superhero_name = 'Aquababy';
SELECT s.weight_kg AS weight, r.race AS race FROM superhero s JOIN race r ON s.race_id = r.id WHERE s.id = 40;
SELECT AVG(height_cm) AS average_height FROM superhero JOIN alignment ON superhero.alignment_id = alignment.id WHERE alignment.alignment = 'neutral';
SELECT hp.hero_id FROM hero_power hp JOIN superpower sp ON hp.power_id = sp.id JOIN superhero sh ON hp.hero_id = sh.id WHERE sp.power_name = 'Intelligence';
SELECT c.colour FROM superhero s JOIN colour c ON s.eye_colour_id = c.id WHERE s.superhero_name = 'Blackwulf';
SELECT sp.power_name FROM superhero sh JOIN hero_power hp ON sh.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sh.height_cm > (SELECT AVG(height_cm) * 0.8 FROM superhero);
SELECT raceId FROM races WHERE year = (SELECT year FROM races WHERE round = 18 LIMIT 1);
SELECT d.surname FROM qualifying q JOIN races r ON q.raceId = r.raceId JOIN drivers d ON q.driverId = d.driverId WHERE r.round = 19 AND q.q2 IS NOT NULL ORDER BY q.q2 ASC LIMIT 1;
SELECT DISTINCT r.year FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.location = 'Shanghai';
SELECT r.url FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name = 'Circuit de Barcelona-Catalunya';
SELECT r.name FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.country = 'Germany';
SELECT circuits.name AS circuit_name, results.position AS finishing_position FROM constructors JOIN constructorResults ON constructors.constructorId = constructorResults.constructorId JOIN races ON constructorResults.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId WHERE constructors.name = 'Renault'
SELECT COUNT(*) AS race_count FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.year = 2010 AND c.country NOT IN ('Asia', 'Europe'); -- Assuming 'country' field contains relevant country names to filter.
SELECT races.name FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Spain';
SELECT c.lat, c.lng FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.name = 'Australian Grand Prix';
SELECT r.* FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name = 'Sepang International Circuit';
SELECT r.time FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name = 'Sepang International Circuit';
SELECT c.lat, c.lng FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.name = 'Abu Dhabi Grand Prix';
SELECT c.nationality FROM constructorResults cr JOIN constructors c ON cr.constructorId = c.constructorId WHERE cr.raceId = (SELECT raceId FROM races WHERE year = (SELECT year FROM seasons ORDER BY year DESC LIMIT 1) AND round = 24) AND cr.points = 1;
SELECT q.q1 FROM qualifying q JOIN drivers d ON q.driverId = d.driverId WHERE d.forename = 'Bruno' AND d.surname = 'Senna' AND q.raceId = 354;
SELECT d.nationality FROM qualifying q JOIN drivers d ON q.driverId = d.driverId WHERE q.raceId = 355 AND q.q2 = '0:01:40';
SELECT d.number FROM qualifying q JOIN drivers d ON q.driverId = d.driverId WHERE q.raceId = 903 AND q.q3 = '0:01:54';
SELECT COUNT(DISTINCT r.driverId) AS drivers_not_finished FROM results r JOIN races ra ON r.raceId = ra.raceId JOIN status s ON r.statusId = s.statusId WHERE ra.year = 2007 AND ra.name = 'Bahrain Grand Prix' AND s.status = 'Not Finished'; -- Adjust the status text accordingly based on your `status` table's values.
SELECT s.* FROM seasons s JOIN races r ON s.year = r.year WHERE r.raceId = 901;
SELECT raceId FROM races WHERE date = '2015-11-29'
SELECT d.forename, d.surname, d.dob FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = 592 AND r.time IS NOT NULL ORDER BY d.dob ASC LIMIT 1;
SELECT d.forename, d.surname, d.url FROM lapTimes lt JOIN drivers d ON lt.driverId = d.driverId WHERE lt.raceId = 161 AND lt.time = '0:01:27';
SELECT d.nationality FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = 933 AND r.fastestLap = ( SELECT MAX(fastestLap) FROM results WHERE raceId = 933 );
SELECT raceId, circuitId FROM races WHERE name = 'Malaysian Grand Prix';
SELECT raceId FROM races WHERE round = 9;
SELECT driverId FROM drivers WHERE forename = 'Lucas' AND surname = 'di Grassi';
SELECT d.nationality FROM qualifying q JOIN drivers d ON q.driverId = d.driverId WHERE q.raceId = 347 AND q.q2 = '0:01:15';
SELECT d.code FROM races AS r JOIN qualifying AS q ON r.raceId = q.raceId JOIN drivers AS d ON q.driverId = d.driverId WHERE r.round = 45 AND q.q3 = '0:01:33';
SELECT r.time FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE d.forename = 'Bruce' AND d.surname = 'McLaren' AND r.raceId = 743;
SELECT raceId FROM races WHERE year = 2006 AND name = 'San Marino Grand Prix';
SELECT s.* FROM seasons s JOIN races r ON s.year = r.year WHERE r.raceId = 901;
SELECT COUNT(DISTINCT driverId) AS finished_drivers_count FROM results WHERE raceId IN ( SELECT raceId FROM races WHERE date = '2015-11-29' ) AND position > 0;
SELECT d.driverId, d.forename, d.surname, d.dob FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = 872 ORDER BY d.dob DESC LIMIT 1;
SELECT d.forename, d.surname FROM lapTimes lt JOIN drivers d ON lt.driverId = d.driverId WHERE lt.raceId = 348 AND lt.time = ( SELECT MIN(time) FROM lapTimes WHERE raceId = 348 );
SELECT d.nationality FROM results r JOIN lapTimes lt ON r.raceId = lt.raceId AND r.driverId = lt.driverId JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = 348 AND lt.milliseconds = ( SELECT MIN(milliseconds) FROM lapTimes WHERE raceId = 348 );
SELECT driverId FROM drivers WHERE forename = 'Paul' AND surname = 'di Resta' ), -- Step 2: Get the fastest lap speeds for races 853 and 854 for Paul di Resta fastest_lap_data AS ( SELECT r.raceId, r.fastestLapSpeed FROM results r INNER JOIN driver_info d ON r.driverId = d.driverId WHERE r.raceId IN (853, 854) ) -- Step 3: Calculate the percentage difference SELECT (f1.fastestLapSpeed - f2.fastestLapSpeed) * 100.0 / f2.fastestLapSpeed AS percentage_difference FROM (SELECT fastestLapSpeed FROM fastest_lap_data WHERE raceId = 853) AS f1, (SELECT fastestLapSpeed FROM fastest_lap_data WHERE raceId = 854) AS f2
SELECT raceId FROM races WHERE date = '1983-07-16' ), -- Step 2: Get the counts of completed and total drivers from results driver_completion AS ( SELECT COUNT(CASE WHEN r.time IS NOT NULL THEN 1 END) AS completed_drivers, COUNT(r.driverId) AS total_drivers FROM results r JOIN race_info ri ON r.raceId = ri.raceId ) -- Step 3: Select the completion rate SELECT (completed_drivers * 100.0 / NULLIF(total_drivers, 0)) AS completion_rate FROM driver_completion
SELECT circuitId FROM circuits WHERE country = 'Singapore';
SELECT COUNT(*) AS number_of_races FROM races WHERE year = 2005
SELECT raceId, date, strftime('%Y', date) AS raceYear, strftime('%m', date) AS raceMonth FROM races ORDER BY date LIMIT 1 ) -- Step 2: Select the first recorded race and other races in the same month and year SELECT r.* FROM races r JOIN FirstRace fr ON strftime('%Y', r.date) = fr.raceYear AND strftime('%m', r.date) = fr.raceMont
SELECT name, date FROM races WHERE year = 1999 AND round = ( SELECT MAX(round) FROM races WHERE year = 1999 );
SELECT year, COUNT(raceId) AS race_count FROM races GROUP BY year ORDER BY race_count DESC LIMIT 1;
SELECT name FROM races WHERE year = 2017
SELECT c.name AS circuit_name, c.location AS circuit_location, r.year, r.round, r.date FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.name = 'European Grand Prix' ORDER BY r.year ASC, r.round ASC LIMIT 1;
SELECT MAX(s.year) AS last_season FROM races r JOIN circuits c ON r.circuitId = c.circuitId JOIN seasons s ON r.year = s.year WHERE c.name = 'Brands Hatch' AND r.name LIKE '%British Grand Prix%';
SELECT COUNT(DISTINCT s.year) AS seasonsHosted FROM circuits c JOIN races r ON c.circuitId = r.circuitId JOIN seasons s ON r.year = s.year WHERE c.name LIKE '%Silverstone%' AND r.name LIKE '%British Grand Prix%';
SELECT d.forename, d.surname, r.position FROM races r JOIN results res ON r.raceId = res.raceId JOIN drivers d ON res.driverId = d.driverId WHERE r.year = 2010 AND r.name = 'Singapore Grand Prix' ORDER BY res.position;
SELECT d.forename || ' ' || d.surname AS full_name, SUM(r.points) AS total_points FROM results r JOIN drivers d ON r.driverId = d.driverId GROUP BY d.driverId ORDER BY total_points DESC LIMIT 1;
SELECT d.forename || ' ' || d.surname AS driver_name, r.points FROM results r JOIN races ra ON r.raceId = ra.raceId JOIN drivers d ON r.driverId = d.driverId WHERE ra.year = 2017 AND ra.name = 'Chinese Grand Prix' ORDER BY r.points DESC LIMIT 3;
SELECT lt.lap AS best_lap, lt.time AS best_lap_time, d.forename || ' ' || d.surname AS driver_name, r.name AS race_name, r.date AS race_date FROM lapTimes lt JOIN drivers d ON lt.driverId = d.driverId JOIN races r ON lt.raceId = r.raceId WHERE lt.time = ( SELECT MIN(time) FROM lapTimes )
SELECT AVG(milliseconds) AS average_lap_time FROM lapTimes WHERE driverId = (SELECT driverId FROM drivers WHERE driverRef = 'vettel') AND raceId = (SELECT raceId FROM races WHERE year = 2009 AND round = 2);
SELECT (COUNT(CASE WHEN r.position > 1 THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM results r JOIN drivers d ON r.driverId = d.driverId JOIN races ra ON r.raceId = ra.raceId WHERE d.surname = 'Hamilton' AND ra.year >= 2010;
SELECT d.forename || ' ' || d.surname AS driverName, d.nationality, COUNT(ds.wins) AS totalWins, AVG(ds.points) AS averagePoints FROM drivers d JOIN driverStandings ds ON d.driverId = ds.driverId WHERE ds.wins > 0 GROUP BY d.driverId ORDER BY totalWins DESC LIMIT 1;
SELECT forename, surname, (2022 - CAST(strftime('%Y', dob) AS INTEGER) + 1) AS age FROM drivers WHERE dob = ( SELECT MAX(dob) FROM drivers WHERE nationality = 'Japanese' ) AND nationality = 'Japanese';
SELECT c.circuitId, c.circuitRef, c.name, c.location, c.country, COUNT(r.raceId) AS race_count FROM circuits c JOIN races r ON c.circuitId = r.circuitId JOIN seasons s ON r.year = s.year WHERE r.year BETWEEN 1990 AND 2000 GROUP BY c.circuitId HAVING COUNT(r.raceId) = 4;
SELECT circuits.name AS circuit_name, circuits.location AS circuit_location, races.name AS race_name FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.year = 2006 AND circuits.country = 'USA';
SELECT r.name AS race_name, c.name AS circuit_name, c.location FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE strftime('%Y', r.date) = '2005' AND strftime('%m', r.date) = '09';
SELECT r.raceId, r.year, r.name FROM results res JOIN drivers d ON res.driverId = d.driverId JOIN races r ON res.raceId = r.raceId WHERE d.forename = 'Alex' AND d.surname = 'Yoong' AND res.position < 10;
SELECT circuitId FROM circuits WHERE name = 'Sepang International Circuit';
SELECT r.name AS raceName, r.year FROM drivers d JOIN results res ON d.driverId = res.driverId JOIN races r ON res.raceId = r.raceId WHERE d.forename = 'Michael' AND d.surname = 'Schumacher' AND res.fastestLap IS NOT NULL ORDER BY res.fastestLapTime LIMIT 1;
SELECT driverId FROM drivers WHERE forename = 'Eddie' AND surname = 'Irvine' ), -- Step 2: Get all raceIds for the year 2000 Year2000Races AS ( SELECT raceId FROM races WHERE year = 2000 ) -- Step 3: Get results for Eddie Irvine in year 2000 SELECT AVG(r.points) AS average_points FROM results r JOIN EddieIrvine ei ON r.driverId = ei.driverId JOIN Year2000Races yr ON r.raceId = yr.raceId
SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton';
SELECT r.name AS race_name, r.date AS race_date, c.country AS hosting_country FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.year = 2017 ORDER BY r.date;
SELECT r.name AS race_name, r.year, c.location, COUNT(res.laps) AS total_laps FROM races r JOIN results res ON r.raceId = res.raceId JOIN circuits c ON r.circuitId = c.circuitId GROUP BY r.raceId ORDER BY total_laps DESC LIMIT 1;
SELECT (COUNT(CASE WHEN c.country = 'Germany' THEN 1 END) * 100.0 / COUNT(*)) AS percentage FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.name = 'European Grand Prix';
SELECT lat, lng FROM circuits WHERE name = 'Silverstone';
SELECT name, lat FROM circuits WHERE name IN ('Silverstone Circuit', 'Hockenheimring', 'Hungaroring') ORDER BY lat DESC LIMIT 1;
SELECT circuitRef FROM circuits WHERE name = 'Marina Bay Street Circuit';
SELECT country FROM circuits WHERE alt = (SELECT MAX(alt) FROM circuits);
SELECT COUNT(*) AS drivers_without_code FROM drivers WHERE code IS NULL OR code = '';
SELECT nationality FROM drivers WHERE dob = (SELECT MIN(dob) FROM drivers) LIMIT 1;
SELECT surname FROM drivers WHERE nationality = 'italian';
SELECT url FROM drivers WHERE forename = 'Anthony' AND surname = 'Davidson';
SELECT driverRef FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton';
SELECT c.name FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.year = 2009 AND r.round = 5; -- This is the round number for the 2009 Spanish Grand Prix
SELECT DISTINCT r.year FROM circuits c JOIN races r ON c.circuitId = r.circuitId WHERE c.name = 'Silverstone';
SELECT r.name AS race_name, r.date AS race_date, r.time AS race_time, r.url AS race_url, c.name AS circuit_name, c.location AS circuit_location, c.country AS circuit_country FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name LIKE '%Silverstone%' OR c.circuitRef LIKE '%Silverstone%';
SELECT r.date, r.time FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name = 'Abu Dhabi Circuit' AND r.year BETWEEN 2010 AND 2019;
SELECT COUNT(*) AS numberOfRaces FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE c.country = 'Italy';
SELECT r.date FROM circuits c JOIN races r ON c.circuitId = r.circuitId WHERE c.name = 'Barcelona-Catalunya';
SELECT c.url FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.year = 2009 AND r.name LIKE '%Spanish Grand Prix%';
SELECT MIN(fastestLapTime) AS fastestLapTime FROM results WHERE driverId = ( SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton' ) AND fastestLapTime IS NOT NULL;
SELECT d.forename, d.surname FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.fastestLapSpeed IS NOT NULL ORDER BY r.fastestLapSpeed DESC LIMIT 1;
SELECT d.driverRef FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = ( SELECT raceId FROM races WHERE name = 'Australian Grand Prix' AND year = 2008 ) AND r.positionOrder = 1;
SELECT r.raceId, r.name AS race_name, r.date FROM drivers d JOIN results res ON d.driverId = res.driverId JOIN races r ON res.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton';
SELECT r.year, r.name AS race_name, r.date, res.rank FROM results res JOIN drivers d ON res.driverId = d.driverId JOIN races r ON res.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY res.rank ASC LIMIT 1;
SELECT MAX(r.fastestLapSpeed) AS fastestLapSpeed FROM results r JOIN races ra ON r.raceId = ra.raceId WHERE ra.year = 2009 AND ra.name LIKE '%Spanish Grand Prix%';
SELECT DISTINCT r.year FROM drivers d JOIN results res ON d.driverId = res.driverId JOIN races r ON res.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton';
SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton';
SELECT raceId FROM races WHERE year = 2008 AND name LIKE '%Australian Grand Prix%';
SELECT COUNT(DISTINCT r.driverId) AS finished_drivers FROM results r JOIN races ra ON r.raceId = ra.raceId WHERE ra.year = 2008 AND ra.name = 'Australian Grand Prix' AND r.time IS NOT NULL;
SELECT lt.lap, lt.time, lt.milliseconds FROM races r JOIN drivers d ON d.forename = 'Lewis' AND d.surname = 'Hamilton' JOIN lapTimes lt ON lt.driverId = d.driverId WHERE r.year = 2008 AND r.name = 'Australian Grand Prix' AND r.raceId = lt.raceId ORDER BY lt.milliseconds ASC LIMIT 1;
SELECT raceId FROM races WHERE year = 2008 AND name LIKE '%Australian Grand Prix%';
SELECT d.forename || ' ' || d.surname AS champion_name, d.url AS champion_url FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.raceId = ( SELECT raceId FROM races WHERE year = 2008 AND name LIKE 'Australian Grand Prix' ) AND r.position = 1;
SELECT COUNT(DISTINCT d.driverId) AS usa_driver_count FROM results r JOIN drivers d ON r.driverId = d.driverId JOIN races ra ON r.raceId = ra.raceId WHERE d.nationality = 'American' AND ra.year = 2008 AND ra.name = 'Australian Grand Prix';
SELECT COUNT(DISTINCT r.driverId) AS participated_drivers FROM results r JOIN races rac ON r.raceId = rac.raceId WHERE rac.year = 2008 AND rac.name LIKE '%Australian Grand Prix%' AND r.time IS NOT NULL AND r.driverId IN ( SELECT driverId FROM results GROUP BY driverId );
SELECT SUM(r.points) AS total_points FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton';
SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton';
SELECT * FROM table
SELECT raceId FROM races WHERE year = 2008 AND round = 1; -- Assuming round 1 is the Australian Grand Prix
SELECT COUNT(*) AS numberOfCircuits FROM circuits WHERE location = 'Melbourne' AND country = 'Australia';
SELECT lat, lng FROM circuits WHERE country = 'USA';
SELECT COUNT(*) AS numberOfBritishDriversBornAfter1980 FROM drivers WHERE nationality = 'British' AND dob > '1980-01-01';
SELECT AVG(cr.points) AS average_points FROM constructors c JOIN constructorResults cr ON c.constructorId = cr.constructorId WHERE c.nationality = 'British';
SELECT c.constructorId, c.name, SUM(cr.points) AS total_points FROM constructorResults cr JOIN constructors c ON cr.constructorId = c.constructorId GROUP BY c.constructorId ORDER BY total_points DESC LIMIT 1;
SELECT c.name FROM constructors c JOIN constructorResults cr ON c.constructorId = cr.constructorId WHERE cr.raceId = 291 AND cr.points = 0;
SELECT COUNT(DISTINCT c.constructorId) AS JapaneseConstructorsWithZeroPointsInTwoRaces FROM constructors c JOIN constructorResults cr ON c.constructorId = cr.constructorId WHERE c.nationality = 'Japanese' AND cr.points = 0 GROUP BY c.constructorId HAVING COUNT(DISTINCT cr.raceId) = 2;
SELECT c.constructorId, c.name, cs.wins, cs.points, cs.raceId FROM constructorStandings cs JOIN constructors c ON cs.constructorId = c.constructorId WHERE cs.position = 1 ORDER BY cs.raceId;
SELECT COUNT(DISTINCT r.constructorId) AS french_constructors_with_over_50_laps FROM results r JOIN constructors c ON r.constructorId = c.constructorId WHERE c.nationality = 'French' AND r.laps > 50;
SELECT driverId FROM drivers WHERE nationality = 'Japanese' ), relevant_races AS ( SELECT raceId FROM races WHERE year BETWEEN 2007 AND 2009 ), driver_results AS ( SELECT r.driverId, COUNT(r.resultId) AS total_races, COUNT(CASE WHEN r.time IS NOT NULL THEN 1 END) AS completed_races FROM results r JOIN relevant_races rr ON r.raceId = rr.raceId JOIN japanese_drivers jd ON r.driverId = jd.driverId GROUP BY r.driverId ) SELECT SUM(completed_races) * 100.0 / NULLIF(SUM(total_races), 0) AS race_completion_percentage FROM driver_results
SELECT r.year, AVG( (CAST(SUBSTR(res.time, 1, 2) AS INTEGER) * 3600) + -- Hours to seconds (CAST(SUBSTR(res.time, 4, 2) AS INTEGER) * 60) + -- Minutes to seconds CAST(SUBSTR(res.time, 7, 2) AS INTEGER) + -- Seconds (CAST(SUBSTR(res.time, 10, 3) AS INTEGER) / 1000) -- Milliseconds to seconds ) AS avg_time_seconds FROM results res JOIN races r ON res.raceId = r.raceId WHERE res.position = 1 -- Only consider the winner's time GROUP BY r.year ORDER BY r.year;
SELECT d.forename, d.surname FROM drivers d JOIN results r ON d.driverId = r.driverId WHERE d.dob > '1975-01-01' AND r.position = 2;
SELECT COUNT(DISTINCT d.driverId) AS ItalianDriversNotFinished FROM drivers d JOIN results r ON d.driverId = r.driverId WHERE d.nationality = 'Italy' AND r.time IS NULL;
SELECT d.forename, d.surname FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.fastestLapTime = (SELECT MIN(fastestLapTime) FROM results)
SELECT driverId FROM driverStandings JOIN races ON driverStandings.raceId = races.raceId WHERE races.year = 2009 ORDER BY driverStandings.points DESC LIMIT 1;
SELECT AVG(fastestLapSpeed) AS average_fastest_lap_speed FROM results WHERE raceId = ( SELECT raceId FROM races WHERE year = 2009 AND name = 'Spanish Grand Prix' );
SELECT r.name, r.year FROM results res JOIN races r ON res.raceId = r.raceId WHERE res.milliseconds IS NOT NULL GROUP BY res.raceId ORDER BY MIN(res.milliseconds) LIMIT 1;
SELECT driverId FROM drivers WHERE dob < '1985-01-01' ), QualifiedDrivers AS ( SELECT l.driverId FROM lapTimes l JOIN races r ON l.raceId = r.raceId WHERE l.driverId IN (SELECT driverId FROM EligibleDrivers) AND r.year BETWEEN 2000 AND 2005 AND l.lap > 50 ), TotalDrivers AS ( SELECT driverId FROM drivers WHERE dob BETWEEN '2000-01-01' AND '2005-12-31' ) SELECT (COUNT(DISTINCT q.driverId) * 100.0 / NULLIF(COUNT(DISTINCT d.driverId), 0)) AS Percentage FROM QualifiedDrivers q, TotalDrivers d
SELECT COUNT(DISTINCT d.driverId) AS FrenchDriversCount FROM lapTimes lt JOIN drivers d ON lt.driverId = d.driverId WHERE d.nationality = 'French' AND (CAST(SUBSTR(lt.time, 1, 2) AS INTEGER) * 60 + CAST(SUBSTR(lt.time, 4, 2) AS INTEGER)) < 120;
SELECT code FROM drivers WHERE nationality = 'America';
SELECT raceId FROM races WHERE year = 2009;
SELECT COUNT(DISTINCT driverId) AS numberOfDrivers FROM results WHERE raceId = 18;
SELECT driverId, dob, nationality FROM drivers ORDER BY dob DESC LIMIT 3 ) SELECT driverId, (SELECT COUNT(*) FROM YoungestDrivers WHERE nationality IN ('Netherlands', 'Dutch')) AS Netherlandic_Count FROM YoungestDrivers
SELECT driverRef FROM drivers WHERE forename = 'Robert' AND surname = 'Kubica';
SELECT COUNT(*) AS numberOfDrivers FROM drivers WHERE nationality = 'Australian' AND strftime('%Y', dob) = '1980';
SELECT d.driverId, d.forename, d.surname, MIN(lt.time) AS earliestLapTime FROM drivers d JOIN lapTimes lt ON d.driverId = lt.driverId WHERE d.nationality = 'German' AND d.dob BETWEEN '1980-01-01' AND '1990-12-31' GROUP BY d.driverId, d.forename, d.surname ORDER BY earliestLapTime LIMIT 3;
SELECT driverRef FROM drivers WHERE nationality = 'German' ORDER BY dob ASC LIMIT 1;
SELECT d.driverId, d.code FROM drivers d JOIN results r ON d.driverId = r.driverId WHERE strftime('%Y', d.dob) = '1971' AND r.fastestLapTime IS NOT NULL;
SELECT d.driverId, d.forename, d.surname, lt.time, MAX(lt.time) AS latestLapTime FROM drivers d JOIN lapTimes lt ON d.driverId = lt.driverId WHERE d.nationality = 'Spanish' AND d.dob < '1982-01-01' GROUP BY d.driverId ORDER BY latestLapTime DESC LIMIT 10;
SELECT races.year FROM results JOIN races ON results.raceId = races.raceId WHERE results.fastestLapTime IS NOT NULL ORDER BY results.fastestLapTime LIMIT 1;
SELECT r.year, MAX(lt.milliseconds) AS max_lap_time FROM lapTimes lt JOIN races r ON lt.raceId = r.raceId GROUP BY r.year ORDER BY max_lap_time ASC LIMIT 1;
SELECT lt.driverId FROM lapTimes lt WHERE lt.lap = 1 ORDER BY lt.milliseconds ASC LIMIT 5;
SELECT COUNT(*) AS disqualifiedFinishers FROM results r JOIN status s ON r.statusId = s.statusId WHERE r.raceId BETWEEN 50 AND 100 AND r.time IS NOT NULL AND s.statusId = 2;
SELECT name, location, lat, lng, COUNT(*) AS timesHeld FROM circuits WHERE country = 'Austria' GROUP BY name, location, lat, lng;
SELECT r.round AS race_number, COUNT(res.resultId) AS finsher_count FROM results res JOIN races r ON res.raceId = r.raceId WHERE res.time IS NOT NULL GROUP BY r.raceId ORDER BY finsher_count DESC LIMIT 1;
SELECT d.driverRef, d.nationality, d.dob FROM qualifying q JOIN drivers d ON q.driverId = d.driverId WHERE q.raceId = 23 AND q.q2 IS NOT NULL;
SELECT driverId FROM drivers ORDER BY dob DESC LIMIT 1;
SELECT COUNT(DISTINCT r.driverId) AS disqualified_american_drivers FROM results r JOIN drivers d ON r.driverId = d.driverId WHERE r.statusId = 2 AND d.nationality = 'American';
SELECT c.name AS constructor_name, c.url AS introduction_website, SUM(cs.points) AS total_points FROM constructors c JOIN constructorStandings cs ON c.constructorId = cs.constructorId WHERE c.nationality = 'Italian' GROUP BY c.constructorId, c.name, c.url ORDER BY total_points DESC LIMIT 1;
SELECT c.url FROM constructors c JOIN constructorStandings cs ON c.constructorId = cs.constructorId GROUP BY c.constructorId ORDER BY SUM(cs.wins) DESC LIMIT 1;
SELECT driverId, MAX(time) AS slowest_time FROM lapTimes WHERE raceId = ( SELECT raceId FROM races WHERE name LIKE '%French Grand Prix%' ) AND lap = 3 GROUP BY driverId ORDER BY slowest_time DESC LIMIT 1;
SELECT r.name AS race_name, MIN((CAST(STRFTIME('%H', lt.time) AS INTEGER) * 3600000) + (CAST(STRFTIME('%M', lt.time) AS INTEGER) * 60000) + (CAST(STRFTIME('%S', lt.time) AS INTEGER) * 1000) + (CAST(STRFTIME('%f', lt.time) AS INTEGER) * 1000)) ) AS fastest_lap_time_milliseconds FROM lapTimes lt JOIN races r ON lt.raceId = r.raceId WHERE lt.lap = 1 GROUP BY lt.raceId ORDER BY fastest_lap_time_milliseconds LIMIT 1;
SELECT AVG(fastestLapTime) AS average_fastest_lap_time FROM results WHERE raceId = ( SELECT raceId FROM races WHERE year = 2006 AND name = 'United States Grand Prix' ) AND positionOrder < 11;
SELECT d.driverId, d.forename, d.surname, AVG( CAST(SUBSTR(ps.duration, 1, INSTR(ps.duration, ':') - 1) AS INTEGER) * 60 + CAST(SUBSTR(ps.duration, INSTR(ps.duration, ':') + 1) AS REAL) AS REAL ) AS averagePitStopDuration FROM drivers d JOIN pitStops ps ON d.driverId = ps.driverId WHERE d.nationality = 'German' AND d.dob BETWEEN '1980-01-01' AND '1985-12-31' GROUP BY d.driverId, d.forename, d.surname ORDER BY averagePitStopDuration ASC LIMIT 5;
SELECT d.forename || ' ' || d.surname AS champion_name, r.time AS finish_time FROM races r JOIN results res ON r.raceId = res.raceId JOIN drivers d ON res.driverId = d.driverId WHERE r.year = 2008 AND r.name LIKE '%Canadian Grand Prix%' -- Match the exact name of the race AND res.position = 1; -- Winner's position
SELECT c.constructorRef, c.url FROM results r JOIN constructors c ON r.constructorId = c.constructorId WHERE r.raceId = ( SELECT raceId FROM races WHERE year = 2009 AND name = 'Singapore Grand Prix' ) AND r.position = 1; -- assuming position 1 corresponds to champion
SELECT forename || ' ' || surname AS full_name, dob FROM drivers WHERE nationality = 'Austrian' AND dob BETWEEN '1981-01-01' AND '1991-12-31';
SELECT forename || ' ' || surname AS full_name, url, dob FROM drivers WHERE nationality = 'German' AND dob BETWEEN '1971-01-01' AND '1985-12-31' ORDER BY dob DESC;
SELECT location, country, lat, lng FROM circuits WHERE name = 'Hungaroring';
SELECT SUM(cr.points) AS total_points, c.name AS constructor_name, c.nationality AS constructor_nationality FROM races r JOIN constructorResults cr ON r.raceId = cr.raceId JOIN constructors c ON cr.constructorId = c.constructorId WHERE r.year BETWEEN 1980 AND 2010 AND r.name LIKE '%Monaco Grand Prix%' GROUP BY cr.constructorId ORDER BY total_points DESC LIMIT 1;
SELECT AVG(r.points) AS average_score FROM results r JOIN races ra ON r.raceId = ra.raceId JOIN drivers d ON r.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' AND ra.name LIKE '%Turkish Grand Prix%';
SELECT AVG(race_count) AS annual_average_races FROM ( SELECT year, COUNT(raceId) AS race_count FROM races WHERE year BETWEEN 2000 AND 2010 GROUP BY year ) AS yearly_races;
SELECT nationality, COUNT(*) AS driver_count FROM drivers GROUP BY nationality ORDER BY driver_count DESC LIMIT 1;
SELECT COUNT(r.resultId) AS number_of_victories FROM driverStandings d JOIN results r ON d.driverId = r.driverId WHERE d.position = 91 AND r.position = 1;
SELECT r.name FROM results AS res JOIN races AS r ON res.raceId = r.raceId WHERE res.fastestLapSpeed = ( SELECT MAX(fastestLapSpeed) FROM results );
SELECT c.name AS circuit_name, c.location || ', ' || c.country AS full_location FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.date = (SELECT MAX(date) FROM races);
SELECT circuitId FROM circuits WHERE name = 'Marina Bay Street Circuit';
SELECT d.forename || ' ' || d.surname AS full_name, d.nationality, r.name AS first_race_name FROM drivers d JOIN results res ON d.driverId = res.driverId JOIN races r ON res.raceId = r.raceId WHERE d.dob = ( SELECT MIN(dob) FROM drivers ) ORDER BY r.date ASC LIMIT 1;
SELECT raceId FROM races WHERE name LIKE '%Canadian Grand Prix%' ) -- Step 2: Count the accidents for each driver in that race , Driver_Accidents AS ( SELECT r.driverId, COUNT(r.driverId) AS accident_count FROM results r JOIN Canadian_GP cg ON r.raceId = cg.raceId WHERE r.statusId = 3 -- Assuming statusId = 3 indicates an accident GROUP BY r.driverId ) -- Step 3: Select the driver with the highest number of accidents SELECT MAX(accident_count) AS max_accidents FROM Driver_Accidents
SELECT d.forename || ' ' || d.surname AS full_name, COUNT(r.resultId) AS wins FROM drivers d LEFT JOIN results r ON d.driverId = r.driverId WHERE d.dob = (SELECT MIN(dob) FROM drivers) AND r.position = 1 GROUP BY d.driverId;
SELECT driverId, MAX(duration) AS longestPitStopDuration FROM pitStops GROUP BY driverId ORDER BY longestPitStopDuration DESC LIMIT 1;
SELECT MIN(milliseconds) AS fastestLapTime FROM lapTimes;
SELECT MAX(duration) AS longestPitStopDuration FROM pitStops WHERE driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton');
SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'
SELECT p.driverId, p.lap, p.duration FROM races r JOIN pitStops p ON r.raceId = p.raceId WHERE r.year = 2011 AND r.round = 1; -- Assuming the first round corresponds to the Australian GP
SELECT l.raceId, l.lap, l.milliseconds, r.year, r.name AS race_name, r.date FROM lapTimes l JOIN drivers d ON l.driverId = d.driverId JOIN races r ON l.raceId = r.raceId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY l.milliseconds ASC LIMIT 1;
SELECT d.forename || ' ' || d.surname AS full_name FROM lapTimes lt JOIN drivers d ON lt.driverId = d.driverId WHERE lt.milliseconds = ( SELECT MIN(milliseconds) FROM lapTimes ) LIMIT 1;
SELECT c.circuitId, c.name AS circuit_name, r.round, rs.position AS circuit_position FROM results re JOIN races r ON re.raceId = r.raceId JOIN circuits c ON r.circuitId = c.circuitId JOIN lapTimes lt ON re.raceId = lt.raceId AND re.driverId = lt.driverId JOIN ( SELECT raceId, driverId, MIN(milliseconds) AS fastestLapTime FROM lapTimes WHERE driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton') GROUP BY raceId, driverId ) AS fastestLap ON lt.raceId = fastestLap.raceId AND lt.driverId = fastestLap.driverId AND lt.milliseconds = fastestLap.fastestLapTime JOIN results rs ON re.raceId = rs.raceId AND re.driverId = rs.driverId WHERE re.driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton');
SELECT r.name AS race_name, lt.lap, lt.time AS lap_time, lt.milliseconds AS milliseconds FROM circuits c JOIN races r ON c.circuitId = r.circuitId JOIN lapTimes lt ON r.raceId = lt.raceId WHERE c.name LIKE '%Austria%' ORDER BY lt.milliseconds ASC LIMIT 1;
SELECT c.circuitId, c.name AS circuit_name, c.location, r.raceId, r.name AS race_name, lt.lap, lt.time AS lap_time, lt.milliseconds FROM circuits c JOIN races r ON c.circuitId = r.circuitId JOIN lapTimes lt ON r.raceId = lt.raceId WHERE c.country = 'Italy' AND lt.time IS NOT NULL -- Filter out any NULL times if applicable AND lt.position = 1 -- Getting lap record, assuming position 1 is the best ORDER BY lt.milliseconds ASC; -- Order by fastest time (smallest milliseconds)
SELECT r.name AS RaceName, r.date AS RaceDate, r.year AS RaceYear, l.time AS FastestLapTime FROM lapTimes l JOIN races r ON l.raceId = r.raceId JOIN circuits c ON r.circuitId = c.circuitId WHERE c.name = 'Red Bull Ring' -- Assuming 'Red Bull Ring' is the name of the Austrian Grand Prix Circuit AND l.milliseconds = ( SELECT MIN(milliseconds) FROM lapTimes l2 JOIN races r2 ON l2.raceId = r2.raceId WHERE r2.circuitId = c.circuitId )
SELECT circuitId FROM circuits WHERE name = 'Austrian Grand Prix'
SELECT c.lat, c.lng FROM results r JOIN races ra ON r.raceId = ra.raceId JOIN circuits c ON ra.circuitId = c.circuitId WHERE r.time = '1:29.488';
SELECT AVG(ps.milliseconds) AS average_pit_stop_time FROM pitStops ps JOIN drivers d ON ps.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton';
SELECT AVG(lapTimes.milliseconds) AS averageLapTimeMilliseconds FROM lapTimes JOIN races ON lapTimes.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Italy';
SELECT pa.player_api_id FROM Player_Attributes pa WHERE pa.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes) LIMIT 1;
SELECT player_name, height FROM Player WHERE height = (SELECT MAX(height) FROM Player);
SELECT pa.preferred_foot FROM Player_Attributes pa WHERE pa.potential = (SELECT MIN(potential) FROM Player_Attributes);
SELECT COUNT(*) FROM Player_Attributes WHERE overall_rating >= 60 AND overall_rating < 65 AND defensive_work_rate = 'low';
SELECT p.player_api_id, p.player_name, pa.crossing FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id ORDER BY pa.crossing DESC LIMIT 5;
SELECT l.name AS league_name, SUM(m.home_team_goal + m.away_team_goal) AS total_goals FROM Match m JOIN League l ON m.league_id = l.id WHERE m.season = '2015/2016' GROUP BY l.id ORDER BY total_goals DESC LIMIT 1;
SELECT home_team_api_id, COUNT(*) AS losses FROM Match WHERE season = '2015/2016' AND home_team_goal < away_team_goal GROUP BY home_team_api_id ORDER BY losses ASC LIMIT 1;
SELECT p.player_name, pa.penalties FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id ORDER BY pa.penalties DESC LIMIT 10;
SELECT away_team_api_id, COUNT(*) AS away_wins FROM Match WHERE league_id = (SELECT id FROM League WHERE name = 'Scotland Premier League') AND season = '2009/2010' AND away_team_goal > home_team_goal GROUP BY away_team_api_id ORDER BY away_wins DESC LIMIT 1;
SELECT t.team_long_name, ta.buildUpPlaySpeed FROM Team_Attributes ta JOIN Team t ON t.team_fifa_api_id = ta.team_fifa_api_id ORDER BY ta.buildUpPlaySpeed DESC LIMIT 4;
SELECT l.name AS league_name, COUNT(m.id) AS draw_count FROM Match m JOIN League l ON m.league_id = l.id WHERE m.season = '2015/2016' AND m.home_team_goal = m.away_team_goal GROUP BY l.name ORDER BY draw_count DESC LIMIT 1;
SELECT p.player_name, (strftime('%Y', 'now') - strftime('%Y', p.birthday)) - (strftime('%m', 'now') < strftime('%m', p.birthday) OR (strftime('%m', 'now') = strftime('%m', p.birthday) AND strftime('%d', 'now') < strftime('%d', p.birthday))) AS age FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE pa.sprint_speed >= 97 AND pa.date >= '2013-01-01 00:00:00' AND pa.date <= '2015-12-31 00:00:00';
SELECT l.name AS league_name, COUNT(m.id) AS matches_played FROM Match m JOIN League l ON m.league_id = l.id GROUP BY l.id ORDER BY matches_played DESC LIMIT 1;
SELECT AVG(height) AS average_height FROM Player WHERE birthday >= '1990-01-01' AND birthday < '1996-01-01';
SELECT AVG(overall_rating) AS avg_rating FROM Player_Attributes WHERE substr(date, 1, 4) = '2010';
SELECT team_fifa_api_id FROM Team_Attributes WHERE buildUpPlaySpeed > 50 AND buildUpPlaySpeed < 60;
SELECT AVG(buildUpPlayPassing) AS avg_build_up_play_passing FROM Team_Attributes WHERE strftime('%Y', date) = '2012' ) SELECT T.team_long_name FROM Team T JOIN Team_Attributes TA ON T.team_fifa_api_id = TA.team_fifa_api_id JOIN Average_Passing AP ON TA.buildUpPlayPassing > AP.avg_build_up_play_passing WHERE strftime('%Y', TA.date) = '2012'
SELECT COUNT(*) AS left_footed_count FROM Player WHERE preferred_foot = 'left' AND birthday BETWEEN '1987-01-01' AND '1992-12-31';
SELECT L.name AS league_name, SUM(M.home_team_goal + M.away_team_goal) AS total_goals FROM Match M JOIN League L ON M.league_id = L.id GROUP BY L.id, L.name ORDER BY total_goals ASC LIMIT 5;
SELECT player_api_id FROM Player WHERE player_name = 'Ahmed Samir Farag';
SELECT p.player_name, AVG(pa.heading_accuracy) AS average_heading_accuracy FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.height > 180 GROUP BY p.player_api_id ORDER BY average_heading_accuracy DESC LIMIT 10;
SELECT AVG(chanceCreationPassing) AS avg_chance_creation FROM Team_Attributes ), TeamsWithNormalDribbling AS ( SELECT t.team_long_name, ta.chanceCreationPassing FROM Team_Attributes ta JOIN Team t ON ta.team_api_id = t.team_api_id WHERE ta.buildUpPlayDribblingClass = 'Normal' AND ta.date >= '2014-01-01' AND ta.date <= '2014-01-31' ) SELECT team_long_name, chanceCreationPassing FROM TeamsWithNormalDribbling WHERE chanceCreationPassing < (SELECT avg_chance_creation FROM AverageChanceCreation) ORDER BY chanceCreationPassing DESC
SELECT l.name FROM League l JOIN Match m ON l.id = m.league_id WHERE m.season = '2009/2010' GROUP BY l.id HAVING AVG(m.home_team_goal) > AVG(m.away_team_goal;
SELECT team_short_name FROM Team WHERE team_long_name = 'Queens Park Rangers';
SELECT player_name, birthday FROM Player WHERE substr(birthday, 1, 4) = '1970' AND substr(birthday, 6, 2) = '10';
SELECT player_api_id FROM Player WHERE player_name = 'Franco Zennaro';
SELECT team_api_id FROM Team WHERE team_long_name = 'ADO Den Haag';
SELECT player_api_id FROM Player WHERE player_name = 'Francois Affolter';
SELECT pa.overall_rating FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE p.player_name = 'Gabriel Tamas' AND strftime('%Y', pa.date) = '2011';
SELECT COUNT(*) FROM Match m JOIN League l ON m.league_id = l.id WHERE l.name = 'Scotland Premier League' AND m.season = '2015/2016';
SELECT pa.preferred_foot FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.birthday = (SELECT MAX(birthday) FROM Player);
SELECT p.player_api_id, p.player_name, pa.potential FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE pa.potential = ( SELECT MAX(potential) FROM Player_Attributes );
SELECT COUNT(*) FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.weight < 130 AND pa.preferred_foot = 'left' AND pa.attacking_work_rate = 'left';
SELECT t.team_short_name FROM Team t JOIN Team_Attributes ta ON t.team_api_id = ta.team_api_id WHERE ta.chanceCreationPassingClass = 'Risky';
SELECT pa.defensive_work_rate FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'David Wilson';
SELECT p.birthday FROM Player p JOIN ( SELECT player_fifa_api_id, MAX(overall_rating) AS max_rating FROM Player_Attributes ) AS max_rating_table ON p.player_fifa_api_id = max_rating_table.player_fifa_api_id WHERE max_rating_table.max_rating = (SELECT MAX(overall_rating) FROM Player_Attributes);
SELECT l.name FROM League l JOIN Country c ON l.country_id = c.id WHERE c.name = 'Netherlands';
SELECT AVG(home_team_goal) AS average_home_goals FROM Match M JOIN League L ON M.league_id = L.id JOIN Country C ON L.country_id = C.id WHERE C.name = 'Poland' AND M.season = '2010/2011';
SELECT player_api_id FROM Player WHERE height = (SELECT MAX(height) FROM Player);
SELECT player_name FROM Player WHERE height > 180;
SELECT COUNT(*) FROM Player WHERE strftime('%Y', birthday) > '1990';
SELECT COUNT(*) FROM Player WHERE player_name LIKE 'Adam%' AND weight > 170;
SELECT p.player_name FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE pa.overall_rating > 80 AND strftime('%Y', pa.date) BETWEEN '2008' AND '2010';
SELECT pa.potential FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Aaron Doran';
SELECT P.player_name, P.player_api_id FROM Player P JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id WHERE PA.preferred_foot = 'left';
SELECT T.team_long_name FROM Team AS T JOIN Team_Attributes AS TA ON T.team_fifa_api_id = TA.team_fifa_api_id WHERE TA.buildUpPlaySpeedClass = 'Fast';
SELECT ta.buildUpPlayPassingClass FROM Team t JOIN Team_Attributes ta ON t.team_api_id = ta.team_api_id WHERE t.team_short_name = 'CLB';
SELECT T.team_short_name FROM Team T JOIN Team_Attributes TA ON T.team_api_id = TA.team_api_id WHERE TA.buildUpPlayPassing > 70;
SELECT AVG(pa.overall_rating) AS average_overall_rating FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE strftime('%Y', pa.date) BETWEEN '2010' AND '2015' AND p.height > 170;
SELECT player_name, height FROM Player WHERE height = (SELECT MIN(height) FROM Player);
SELECT Country.name FROM League JOIN Country ON League.country_id = Country.id WHERE League.name = 'Italy Serie A';
SELECT T.team_short_name FROM Team_Attributes TA JOIN Team T ON TA.team_api_id = T.team_api_id WHERE TA.buildUpPlaySpeed = 31 AND TA.buildUpPlayDribbling = 53 AND TA.buildUpPlayPassing = 32;
SELECT AVG(overall_rating) AS average_overall_rating FROM Player_Attributes WHERE player_api_id = ( SELECT player_api_id FROM Player WHERE player_name = 'Aaron Doran' );
SELECT id FROM League WHERE name = 'Germany 1. Bundesliga';
SELECT Team.team_short_name FROM Match JOIN Team ON Match.home_team_api_id = Team.team_api_id WHERE Match.home_team_goal = 10;
SELECT pa.player_api_id, p.player_name, pa.balance FROM Player_Attributes AS pa JOIN Player AS p ON pa.player_api_id = p.player_api_id WHERE pa.potential = 61 AND pa.balance = ( SELECT MAX(balance) FROM Player_Attributes WHERE potential = 61 );
SELECT AVG(CASE WHEN P.player_name = 'Abdou Diallo' THEN PA.ball_control END) - AVG(CASE WHEN P.player_name = 'Aaron Appindangoye' THEN PA.ball_control END) AS difference_average_ball_control FROM Player_Attributes PA JOIN Player P ON PA.player_api_id = P.player_api_id WHERE P.player_name IN ('Abdou Diallo', 'Aaron Appindangoye');
SELECT team_long_name FROM Team WHERE team_short_name = 'GEN';
SELECT player_name, birthday FROM Player WHERE player_name IN ('Aaron Lennon', 'Abdelaziz Barrada');
SELECT MAX(height) FROM Player;
SELECT COUNT(*) FROM Player_Attributes WHERE preferred_foot = 'left' AND attacking_work_rate = 'low';
SELECT Country.name FROM League JOIN Country ON League.country_id = Country.id WHERE League.name = 'Belgium Jupiler League';
SELECT l.name FROM League l JOIN Country c ON l.country_id = c.id WHERE c.name = 'Germany';
SELECT P.player_name, PA.overall_rating FROM Player_Attributes PA JOIN Player P ON PA.player_api_id = P.player_api_id WHERE PA.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes);
SELECT COUNT(*) AS num_players FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE strftime('%Y', p.birthday) < '1986' AND pa.defensive_work_rate = 'high';
SELECT player_api_id, player_name FROM Player WHERE player_name IN ('Alexis', 'Ariel Borysiuk', 'Arouna Kone');
SELECT player_api_id FROM Player WHERE player_name = 'Ariel Borysiuk';
SELECT COUNT(*) FROM Player P JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id WHERE P.height > 180 AND PA.volleys > 70;
SELECT P.player_name FROM Player P JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id WHERE PA.volleys > 70 AND PA.dribbling > 70;
SELECT COUNT(*) AS total_matches FROM Match WHERE season = '2008/2009' AND league_id IN ( SELECT id FROM League WHERE country_id = ( SELECT id FROM Country WHERE name = 'Belgium' ) );
SELECT PA.long_passing FROM Player_Attributes PA JOIN Player P ON PA.player_api_id = P.player_api_id WHERE P.birthday = (SELECT MIN(birthday) FROM Player)
SELECT id FROM League WHERE name = 'Belgium Jupiler League';
SELECT l.name, COUNT(m.id) AS match_count FROM Match m JOIN League l ON m.league_id = l.id WHERE m.season = '2008/2009' GROUP BY l.id ORDER BY match_count DESC LIMIT 1;
SELECT AVG(pa.overall_rating) AS average_overall_rating FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE strftime('%Y', p.birthday) < '1986';
SELECT overall_rating FROM Player_Attributes WHERE player_fifa_api_id IN ( SELECT player_fifa_api_id FROM Player WHERE player_name = 'Ariel Borysiuk' UNION SELECT player_fifa_api_id FROM Player WHERE player_name = 'Paulin Puel' );
SELECT AVG(ta.buildUpPlaySpeed) AS average_build_up_play_speed FROM Team_Attributes ta JOIN Team t ON ta.team_api_id = t.team_api_id WHERE t.team_long_name = 'Heart of Midlothian';
SELECT AVG(pa.overall_rating) AS average_overall_rating FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE p.player_name = 'Pietro Marino';
SELECT SUM(pa.crossing) AS total_crossing_score FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Aaron Lennox';
SELECT MAX(ta.chanceCreationPassing) AS highest_chance_creation_passing_score, ta.chanceCreationPassingClass FROM Team AS t INNER JOIN Team_Attributes AS ta ON t.team_fifa_id = ta.team_fifa_id WHERE t.team_long_name = 'Ajax' GROUP BY ta.chanceCreationPassingClass ORDER BY highest_chance_creation_passing_score DESC LIMIT 1;
SELECT preferred_foot FROM Player WHERE player_name = 'Abdou Diallo';
SELECT MAX(pa.overall_rating) AS highest_overall_rating FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE p.player_name = 'Dorlan Pabon';
SELECT AVG(away_team_goal) AS average_goals FROM Match WHERE away_team_api_id = ( SELECT team_api_id FROM Team WHERE team_long_name = 'Parma' ) AND country_id = ( SELECT id FROM Country WHERE name = 'Italy' );
SELECT player_api_id FROM Player_Attributes WHERE overall_rating = 77 AND date = '2016-06-23'
SELECT pa.overall_rating FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Aaron Mooy' AND pa.date = '2016-02-04 00:00:00';
SELECT pa.potential FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Francesco Parravicini' AND pa.date = '2010-08-30 00:00:00';
SELECT player_api_id FROM Player WHERE player_name = 'Francesco Migliore';
SELECT pa.defensive_work_rate FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Kevin Berigaud' AND pa.date = '2013-02-22 00:00:00';
SELECT player_api_id FROM Player WHERE player_name = 'Kevin Constant' ), -- Step 2: Find maximum crossing score for Kevin Constant MaxCrossing AS ( SELECT date, crossing, ROW_NUMBER() OVER (ORDER BY crossing DESC) AS ranking FROM Player_Attributes WHERE player_api_id IN (SELECT player_api_id FROM PlayerID) ) -- Step 3: Select the date when the highest crossing score was first recorded SELECT date FROM MaxCrossing WHERE ranking = 1
SELECT ta.buildUpPlaySpeedClass FROM Team t JOIN Team_Attributes ta ON t.team_fifa_api_id = ta.team_fifa_api_id WHERE t.team_long_name = 'Willem II' AND ta.date = '2012-02-22 00:00:00';
SELECT team_api_id FROM Team WHERE team_short_name = 'LEI';
SELECT ta.buildUpPlayPassingClass FROM Team t JOIN Team_Attributes ta ON t.team_api_id = ta.team_api_id WHERE t.team_long_name = 'FC Lorient' AND ta.date = '2010-02-22';
SELECT ta.chanceCreationPassingClass FROM Team t JOIN Team_Attributes ta ON t.team_fifa_api_id = ta.team_fifa_api_id WHERE t.team_long_name = 'PEC Zwolle' AND ta.date = '2013-09-20 00:00:00';
SELECT ta.chanceCreationCrossingClass FROM Team t JOIN Team_Attributes ta ON t.team_fifa_api_id = ta.team_fifa_api_id WHERE t.team_long_name = 'Hull City' AND ta.date = '2010-02-22 00:00:00';
SELECT ta.defenceAggressionClass FROM Team_Attributes ta JOIN Team t ON ta.team_fifa_id = t.team_fifa_id WHERE t.team_long_name = 'Hannover 96' AND ta.date = '2015-09-10';
SELECT player_api_id FROM Player WHERE player_name = 'Marko Arnautovic';
SELECT p.player_name, pa.overall_rating FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name IN ('Landon Donovan', 'Jordan Bowery') AND pa.date = '2013/7/12' ) SELECT (SELECT overall_rating FROM PlayerRatings WHERE player_name = 'Landon Donovan') AS landon_rating, (SELECT overall_rating FROM PlayerRatings WHERE player_name = 'Jordan Bowery') AS bowery_rating, (100.0 * (SELECT overall_rating FROM PlayerRatings WHERE player_name = 'Landon Donovan') - (SELECT overall_rating FROM PlayerRatings WHERE player_name = 'Jordan Bowery')) / (SELECT overall_rating FROM PlayerRatings WHERE player_name = 'Landon Donovan') AS percentage_difference FROM PlayerRatings LIMIT 1
SELECT player_name FROM Player ORDER BY height DESC LIMIT 5;
SELECT player_api_id FROM Player ORDER BY weight DESC LIMIT 10;
SELECT player_name FROM Player WHERE (strftime('%Y', 'now') - strftime('%Y', birthday)) >= 35;
SELECT SUM(home_team_goal) AS total_home_goals FROM "Match" WHERE home_player_1 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_2 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_3 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_4 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_5 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_6 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_7 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_8 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_9 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_10 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon') OR home_player_11 = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Lennon');
SELECT SUM(m.away_team_goal) AS total_away_goals FROM Match m JOIN Player p ON ( m.away_player_1 = p.player_api_id OR m.away_player_2 = p.player_api_id OR m.away_player_3 = p.player_api_id OR m.away_player_4 = p.player_api_id OR m.away_player_5 = p.player_api_id OR m.away_player_6 = p.player_api_id OR m.away_player_7 = p.player_api_id OR m.away_player_8 = p.player_api_id OR m.away_player_9 = p.player_api_id OR m.away_player_10 = p.player_api_id OR m.away_player_11 = p.player_api_id ) WHERE p.player_name IN ('Daan Smith', 'Filipe Ferreira');
SELECT SUM(m.home_team_goal) AS total_home_goals FROM Player p JOIN Match m ON p.player_api_id IN (m.home_player_1, m.home_player_2, m.home_player_3, m.home_player_4, m.home_player_5, m.home_player_6, m.home_player_7, m.home_player_8, m.home_player_9, m.home_player_10, m.home_player_11) WHERE (strftime('%Y', 'now') - strftime('%Y', p.birthday) - (strftime('%m', 'now') < strftime('%m', p.birthday) OR (strftime('%m', 'now') = strftime('%m', p.birthday) AND strftime('%d', 'now') < strftime('%d', p.birthday)))) <= 30;
SELECT p.player_name FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id ORDER BY pa.overall_rating DESC LIMIT 10;
SELECT P.player_name FROM Player P JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id WHERE PA.potential = (SELECT MAX(potential) FROM Player_Attributes);
SELECT P.player_name FROM Player P INNER JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id WHERE PA.attacking_work_rate = 'high';
SELECT p.player_name FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE pa.finishing = 1 ORDER BY p.birthday ASC LIMIT 1;
SELECT p.player_name FROM Player p JOIN National_Team nt ON p.player_api_id = nt.player_api_id JOIN Country c ON nt.country_id = c.id WHERE c.name = 'Belgium';
SELECT DISTINCT p.player_name, c.name AS country_name FROM Player_Attributes AS pa JOIN Player AS p ON pa.player_api_id = p.player_api_id JOIN Match AS m ON m.home_player_1 = p.player_api_id OR m.away_player_1 = p.player_api_id JOIN League AS l ON m.league_id = l.id JOIN Country AS c ON l.country_id = c.id WHERE pa.vision >= 90;
SELECT C.name AS country_name, AVG(P.weight) AS average_weight FROM Player P JOIN Player_Attributes PA ON P.player_api_id = PA.player_api_id JOIN Team T ON P.player_api_id = T.team_api_id -- Assuming this is the correct relation, trim if not used as players belong to teams JOIN League L ON T.team_fifa_api_id = L.id JOIN Country C ON L.country_id = C.id GROUP BY C.id ORDER BY average_weight DESC LIMIT 1;
SELECT T.team_long_name FROM Team T JOIN Team_Attributes TA ON T.team_fifa_api_id = TA.team_fifa_api_id WHERE TA.buildUpPlaySpeedClass = 'Slow';
SELECT Team.team_short_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.chanceCreationPassingClass = 'Safe';
SELECT AVG(p.height) AS average_height FROM Player p JOIN Match m ON p.player_api_id IN ( m.home_player_1, m.home_player_2, m.home_player_3, m.home_player_4, m.home_player_5, m.home_player_6, m.home_player_7, m.home_player_8, m.home_player_9, m.home_player_10, m.home_player_11, m.away_player_1, m.away_player_2, m.away_player_3, m.away_player_4, m.away_player_5, m.away_player_6, m.away_player_7, m.away_player_8, m.away_player_9, m.away_player_10, m.away_player_11 ) JOIN League l ON m.league_id = l.id JOIN Country c ON l.country_id = c.id WHERE c.name = 'Italy';
SELECT player_name FROM Player WHERE height > 180 ORDER BY player_name LIMIT 3;
SELECT COUNT(*) FROM Player WHERE player_name LIKE 'Aaron%' AND birthday > '1990-12-31';
SELECT (SELECT jumping FROM Player_Attributes WHERE player_api_id = 6) - (SELECT jumping FROM Player_Attributes WHERE player_api_id = 23) AS jumping_difference;
SELECT pa.player_api_id FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE pa.potential = (SELECT MIN(potential) FROM Player_Attributes) AND p.preferred_foot = 'right' ORDER BY pa.potential ASC LIMIT 3;
SELECT COUNT(*) AS left_foot_players_with_highest_crossing FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id WHERE pa.crossing = (SELECT MAX(crossing) FROM Player_Attributes) AND p.preferred_foot = 'left';
SELECT (COUNT(CASE WHEN strength > 80 AND stamina > 80 THEN 1 END) * 100.0) / COUNT(*) AS percentage FROM Player_Attributes;
SELECT Country.name FROM League JOIN Country ON League.country_id = Country.id WHERE League.name = 'Ekstraklasa';
SELECT id FROM League WHERE name = 'Belgian Jupiler League';
SELECT pa.sprint_speed, pa.agility, pa.acceleration FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.player_name = 'Alexis Blin';
SELECT team_api_id FROM Team WHERE team_long_name = 'KSV Cercle Brugge';
SELECT id FROM League WHERE name = 'Serie A';
SELECT MAX(home_team_goal) AS highest_home_score FROM Match WHERE league_id = (SELECT id FROM League WHERE name = 'Eredivisie');
SELECT pa.finishing AS finishing_rate, pa.curve AS curve_score FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE p.weight = (SELECT MAX(weight) FROM Player);
SELECT L.name, COUNT(M.id) AS match_count FROM Match M JOIN League L ON M.league_id = L.id WHERE M.season = '2015/2016' GROUP BY L.id ORDER BY match_count DESC LIMIT 1;
SELECT T.team_long_name FROM Match M JOIN Team T ON M.away_team_api_id = T.team_api_id WHERE M.away_team_goal = (SELECT MAX(away_team_goal) FROM Match);
SELECT p.player_name, pa.overall_rating FROM Player_Attributes pa JOIN Player p ON pa.player_api_id = p.player_api_id ORDER BY pa.overall_rating DESC LIMIT 1;
SELECT (COUNT(CASE WHEN height < 180 AND overall_rating > 70 THEN 1 END) * 100.0 / COUNT(id)) AS percentage FROM Player
SELECT SUM(CASE WHEN Admission = '+' THEN 1 ELSE 0 END) AS Male_In_Patient, SUM(CASE WHEN Admission = '-' THEN 1 ELSE 0 END) AS Male_Out_Patient FROM Patient WHERE SEX = 'M' ) SELECT Male_In_Patient, Male_Out_Patient, (Male_In_Patient - Male_Out_Patient) AS Difference, ((Male_In_Patient - Male_Out_Patient) * 100.0 / NULLIF(Male_Out_Patient, 0)) AS Deviation_Percentage FROM MaleCounts
SELECT (COUNT(CASE WHEN year(Birthday) > 1930 THEN 1 END) * 100.0 / COUNT(*)) AS Percentage FROM Patient WHERE SEX = 'F';
SELECT (COUNT(CASE WHEN Admission = '+' THEN 1 END) * 100.0 / COUNT(*)) AS inpatient_percentage FROM Patient WHERE Birthday BETWEEN '1930-01-01' AND '1940-12-31';
SELECT CASE WHEN COUNT(CASE WHEN Admission = '-' THEN 1 END) = 0 THEN 0 ELSE (COUNT(CASE WHEN Admission = '-' THEN 1 END) * 1.0 / COUNT(CASE WHEN Admission = '+' THEN 1 END)) END AS outpatient_to_inpatient_ratio FROM Patient WHERE Diagnosis = 'SLE';
SELECT p.Diagnosis AS Disease, l.Date AS Laboratory_Test_Date FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.ID = 30609;
SELECT Patient.SEX, Patient.Birthday, Examination.`Examination Date`, Examination.Symptoms FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Patient.ID = '163109';
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.LDH > 500;
SELECT P.ID, (strftime('%Y', 'now') - strftime('%Y', P.Birthday) - CASE WHEN strftime('%m-%d', 'now') < strftime('%m-%d', P.Birthday) THEN 1 ELSE 0 END) AS age FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE E.RVVT = '+';
SELECT p.ID, p.SEX, p.Diagnosis FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE e.Thrombosis = 2;
SELECT DISTINCT P.ID, P.SEX, P.Birthday, P.Description, P.`First Date`, P.Admission, P.Diagnosis FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE strftime('%Y', P.Birthday) = '1937' AND L.`T-CHO` >= 250;
SELECT Patient.ID, Patient.SEX, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.ALB < 3.5;
SELECT (COUNT(L.ID) * 100.0 / NULLIF(COUNT(P.ID), 0)) AS Percentage_Abnormal_TP FROM Patient P LEFT JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'F' AND (L.TP < 6.0 OR L.TP > 8.5)
SELECT AVG(E.`aCL IgG`) AS Average_aCL_IgG_Concentration FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE P.Admission = '+' AND (strftime('%Y', 'now') - strftime('%Y', P.Birthday)) >= 50;
SELECT COUNT(*) AS FemalePatientsCount FROM Patient WHERE SEX = 'F' AND strftime('%Y', Description) = '1997' AND Admission = '-';
SELECT strftime('%Y', `First Date`) - strftime('%Y', Birthday) - (strftime('%m', `First Date`) < strftime('%m', Birthday) OR (strftime('%m', `First Date`) = strftime('%m', Birthday) AND strftime('%d', `First Date`) < strftime('%d', Birthday))) AS Age FROM Patient ORDER BY Birthday ASC LIMIT 1;
SELECT COUNT(DISTINCT p.ID) AS WomenPatientsWithSevereThrombosis FROM Examination e JOIN Patient p ON e.ID = p.ID WHERE e.Thrombosis = 1 AND strftime('%Y', e.`Examination Date`) = '1997' AND p.SEX = 'F';
SELECT (MAX(strftime('%Y', 'now')) - MIN(strftime('%Y', Birthday))) AS age_gap FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.TG >= 200;
SELECT E.Symptoms, E.Diagnosis FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE P.Birthday = (SELECT MIN(Birthday) FROM Patient);
SELECT AVG(monthly_count) AS average_male_patients_tested_per_month FROM ( SELECT strftime('%Y-%m', L.Date) AS month, COUNT(DISTINCT P.ID) AS monthly_count FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.Date BETWEEN '1998-01-01' AND '1998-12-31' GROUP BY month );
SELECT MAX(l.Date) AS Lab_Work_Date, (JULIANDAY(p.`First Date`) - JULIANDAY(p.Birthday)) / 365 AS Age_At_Admission FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Diagnosis = 'SJS' AND p.Birthday = (SELECT MIN(Birthday) FROM Patient WHERE Diagnosis = 'SJS') GROUP BY p.ID;
SELECT SUM(CASE WHEN p.SEX = 'M' AND l.UA <= 8.0 THEN 1 ELSE 0 END) AS Male_Count, SUM(CASE WHEN p.SEX = 'F' AND l.UA <= 6.5 THEN 1 ELSE 0 END) AS Female_Count, CASE WHEN SUM(CASE WHEN p.SEX = 'F' AND l.UA <= 6.5 THEN 1 ELSE 0 END) > 0 THEN SUM(CASE WHEN p.SEX = 'M' AND l.UA <= 8.0 THEN 1 ELSE 0 END) * 1.0 / SUM(CASE WHEN p.SEX = 'F' AND l.UA <= 6.5 THEN 1 ELSE 0 END) ELSE NULL END AS Male_to_Female_Ratio FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE (p.SEX = 'M' AND l.UA <= 8.0) OR (p.SEX = 'F' AND l.UA <= 6.5);
SELECT COUNT(DISTINCT P.ID) AS PatientCount FROM Patient P INNER JOIN Examination E ON P.ID = E.ID WHERE (strftime('%Y', E.`Examination Date`) - strftime('%Y', P.`First Date`)) >= 1;
SELECT COUNT(DISTINCT p.ID) AS UnderagePatientCount FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE e.`Examination Date` BETWEEN '1990-01-01' AND '1993-12-31' AND p.Birthday < '1975-01-01';
SELECT COUNT(DISTINCT p.ID) AS MalePatientsWithElevatedTBil FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'M' AND l.`T-BIL` > 2.0;
SELECT p.Diagnosis, COUNT(p.Diagnosis) AS DiagnosisCount FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE e.`Examination Date` BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY p.Diagnosis ORDER BY DiagnosisCount DESC LIMIT 1;
SELECT AVG(strftime('%Y', Date) - strftime('%Y', Birthday)) AS Average_Age FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Date BETWEEN '1991-10-01' AND '1991-10-31';
SELECT (SUBTRACT(YEAR(e.`Examination Date`), YEAR(p.Birthday))) AS Age, e.Diagnosis FROM Examination e JOIN Patient p ON e.ID = p.ID JOIN Laboratory l ON p.ID = l.ID AND e.`Examination Date` = l.Date WHERE l.HGB = (SELECT MAX(HGB) FROM Laboratory) LIMIT 1; -- Ensuring we get only one result in case of ties
SELECT E.ANA FROM Examination E JOIN Patient P ON E.ID = P.ID WHERE E.ID = 3605340 AND E.`Examination Date` = '1996-12-02';
SELECT ID, Date, `T-CHO` FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04' AND `T-CHO` < 250;
SELECT SEX FROM Patient WHERE Diagnosis = 'AORTITIS' ORDER BY `First Date` ASC LIMIT 1;
SELECT e.`aCL IgM` FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE p.Diagnosis = 'SLE' AND p.Description = '1994-02-19' AND e.`Examination Date` = '1993-11-12';
SELECT P.SEX FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.GPT = 9 AND L.Date = '1992-06-12';
SELECT (strftime('%Y', '1991-10-21') - strftime('%Y', Birthday)) AS Age FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.UA = 8.4 AND Laboratory.Date = '1991-10-21';
SELECT ID FROM Patient WHERE `First Date` = '1991-06-13' AND Diagnosis = 'SJS';
SELECT P.Diagnosis FROM Patient P WHERE P.ID = ( SELECT E.ID FROM Examination E WHERE E.Diagnosis = 'SLE' AND E.`Examination Date` = '1997-01-27' )
SELECT E.Symptoms FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE P.Birthday = '1959-03-01' AND E.`Examination Date` = '1993-09-27';
SELECT ID FROM Patient WHERE Birthday = '1959-02-18' ), CholesterolCTE AS ( SELECT SUM(CASE WHEN Date LIKE '1981-11-%' THEN `T-CHO` ELSE 0 END) AS November_Total, SUM(CASE WHEN Date LIKE '1981-12-%' THEN `T-CHO` ELSE 0 END) AS December_Total FROM Laboratory WHERE ID IN (SELECT ID FROM PatientCTE) ) SELECT (November_Total - December_Total) AS Decrease, (CAST((November_Total - December_Total) AS REAL) / November_Total) * 100 AS Decrease_Rate_Percentage FROM CholesterolCTE
SELECT Patient.ID FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Patient.Diagnosis = 'Behcet' AND Examination.`Examination Date` >= '1997-01-01' AND Examination.`Examination Date` < '1998-01-01';
SELECT DISTINCT p.ID FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE e.`Examination Date` BETWEEN '1987-07-06' AND '1996-01-31' AND l.GPT > 30 AND l.ALB < 4;
SELECT ID FROM Patient WHERE SEX = 'F' AND YEAR(Birthday) = 1964 AND Admission = '+';
SELECT COUNT(DISTINCT e.ID) AS Number_Of_Patients FROM Examination e WHERE e.Thrombosis = 2 AND e.ANA = 'S' AND e.`aCL IgM` > (SELECT AVG(`aCL IgM`) * 1.2 FROM Examination WHERE Thrombosis = 2 AND ANA = 'S');
SELECT ID FROM Laboratory WHERE `U-PRO` > 0 AND `U-PRO` < 30 ), UricAcidBelowNormal AS ( SELECT ID FROM Laboratory WHERE UA <= 6.5 ) SELECT (COUNT(DISTINCT U.ID) * 100.0 / NULLIF(COUNT(DISTINCT N.ID), 0)) AS Percentage FROM NormalProteinuria N LEFT JOIN UricAcidBelowNormal U ON N.ID = U.ID
SELECT ID, Diagnosis FROM Patient WHERE SEX = 'M' AND strftime('%Y', `First Date`) = '1981' ) SELECT (COUNT(CASE WHEN Diagnosis = 'BEHCET' THEN 1 END) * 100.0 / COUNT(*)) AS PercentageOfBehcet FROM MalePatients1981
SELECT DISTINCT P.ID, P.SEX, P.Birthday, P.Description, P.`First Date`, P.Admission, P.Diagnosis FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Admission = '-' AND L.Date BETWEEN '1991-10-01' AND '1991-10-31' AND L.`T-BIL` < 2.0;
SELECT COUNT(*) AS NumberOfWomen FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE E.`ANA Pattern` != 'P' AND P.SEX = 'F' AND P.Birthday BETWEEN '1980-01-01' AND '1989-12-31';
SELECT P.SEX FROM Patient P JOIN Examination E ON P.ID = E.ID JOIN Laboratory L ON P.ID = L.ID WHERE E.Diagnosis = 'PSS' AND L.CRP > 2 AND L.CRE = 1 AND L.LDH = 123;
SELECT AVG(L.ALB) AS Average_Albumin_Level FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'F' AND P.Diagnosis = 'SLE' AND L.PLT > 400;
SELECT Symptoms, COUNT(*) as SymptomCount FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Patient.Diagnosis = 'SLE' GROUP BY Symptoms ORDER BY SymptomCount DESC LIMIT 1;
SELECT Description, Diagnosis FROM Patient WHERE ID = 48473;
SELECT COUNT(*) FROM Patient WHERE SEX = 'F' AND Diagnosis = 'APS';
SELECT COUNT(DISTINCT P.ID) AS NumPatients FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE YEAR(L.Date) = 1997 AND (L.TP < 6 OR L.TP > 8.5);
SELECT (SELECT COUNT(*) FROM Patient WHERE Diagnosis LIKE '%ITP%') AS Total_ITP, (SELECT COUNT(*) FROM Patient WHERE Diagnosis LIKE '%ITP%' AND Diagnosis LIKE '%SLE%') AS Total_SLE_in_ITP, (SELECT (100.0 * COUNT(CASE WHEN Diagnosis LIKE '%SLE%' THEN 1 END) / NULLIF(COUNT(*), 0)) FROM Patient WHERE Diagnosis LIKE '%ITP%' ) AS Proportion_SLE_in_ITP FROM Patient;
SELECT (COUNT(CASE WHEN SEX = 'F' THEN 1 END) * 100.0 / COUNT(*)) AS percentage_women FROM Patient WHERE YEAR(Birthday) = 1980 AND Diagnosis = 'RA';
SELECT COUNT(*) AS MalePatientsCount FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE p.SEX = 'M' AND e.`Examination Date` BETWEEN '1995-01-01' AND '1997-12-31' AND e.Diagnosis = 'BEHCET' AND p.Admission = '-';
SELECT COUNT(DISTINCT p.ID) AS FemalePatientsWithLowWBC FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'F' AND l.WBC < 3.5;
SELECT JULIANDAY(E.Examination_Date) - JULIANDAY(P.First_Date) AS Days_Between FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE P.ID = 821298 ORDER BY E.Examination_Date LIMIT 1; -- This ensures we only consider the first examination date
SELECT P.ID, P.SEX, L.UA, CASE WHEN P.SEX = 'M' AND L.UA > 8.0 THEN 'Normal' WHEN P.SEX = 'F' AND L.UA > 6.5 THEN 'Normal' ELSE 'Not Normal' END AS Uric_Acid_Status FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.ID = 57266;
SELECT L.Date FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE P.ID = 48473 AND L.GOT >= 60;
SELECT P.SEX, P.Birthday FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.GOT < 60 AND strftime('%Y', L.Date) = '1994';
SELECT DISTINCT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.GPT >= 60;
SELECT p.Diagnosis, p.Birthday FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.GPT > 60 ORDER BY p.Birthday ASC;
SELECT AVG(LDH) as Average_LDH FROM Laboratory WHERE LDH < 500;
SELECT P.ID, (strftime('%Y', 'now') - strftime('%Y', P.Birthday)) AS age FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.LDH BETWEEN 600 AND 800;
SELECT P.ID, P.Admission FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.ALP < 300;
SELECT p.ID AS PatientID, l.ALP, CASE WHEN l.ALP < 300 THEN 'Within normal range' ELSE 'Not within normal range' END AS ALPStatus FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Birthday = '1982-04-01';
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.TP < 6.0;
SELECT p.ID, (l.TP - 8.5) AS TP_Deviation FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'F' AND l.TP > 8.5;
SELECT P.ID, P.SEX, P.Birthday, L.ALB AS Albumin FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND (L.ALB <= 3.5 OR L.ALB >= 5.5) ORDER BY P.Birthday DESC;
SELECT p.ID, p.Birthday, l.ALB, CASE WHEN l.ALB BETWEEN 3.5 AND 5.5 THEN 'Within Normal Range' ELSE 'Outside Normal Range' END AS Albumin_Status FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE strftime('%Y', p.Birthday) = '1982';
SELECT (COUNT(CASE WHEN L.UA > 6.5 THEN 1 END) * 100.0 / COUNT(P.ID)) AS female_percentage_abnormal_UA FROM Patient P LEFT JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'F';
SELECT AVG(LA.UA) AS Average_UA FROM ( SELECT L.* FROM Laboratory L INNER JOIN ( SELECT ID, MAX(Date) AS LatestDate FROM Laboratory GROUP BY ID ) AS LatestResults ON L.ID = LatestResults.ID AND L.Date = LatestResults.LatestDate ) AS LA INNER JOIN Patient P ON LA.ID = P.ID WHERE (P.SEX = 'M' AND LA.UA < 8.0) OR (P.SEX = 'F' AND LA.UA < 6.5);
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.UN = 29;
SELECT p.ID, p.SEX, p.Birthday FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Diagnosis = 'RA' AND l.UN < 30;
SELECT COUNT(DISTINCT P.ID) AS MalePatientsWithHighCRE FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.CRE >= 1.5;
SELECT SUM(CASE WHEN p.SEX = 'M' THEN 1 ELSE 0 END) AS MaleCount, SUM(CASE WHEN p.SEX = 'F' THEN 1 ELSE 0 END) AS FemaleCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.CRE >= 1.5;
SELECT MAX(`T-BIL`) AS Max_T_BIL FROM Laboratory;
SELECT P.SEX, COUNT(*) AS PatientCount FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.`T-BIL` >= 2.0 GROUP BY P.SEX;
SELECT ID, MIN(Birthday) AS OldestBirthday FROM Patient GROUP BY ID ), MaxTCHO AS ( SELECT ID, MAX(`T-CHO`) AS HighestTCHO FROM Laboratory GROUP BY ID ) SELECT P.ID as PatientID, L.`T-CHO` FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Birthday = (SELECT MIN(Birthday) FROM Patient) AND L.`T-CHO` = (SELECT MAX(`T-CHO`) FROM Laboratory)
SELECT AVG(strftime('%Y', 'now') - strftime('%Y', Birthday)) AS Average_Age FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.`T-CHO` >= 250;
SELECT p.ID, p.Diagnosis, l.TG FROM Patient p INNER JOIN Laboratory l ON p.ID = l.ID WHERE l.TG > 300;
SELECT COUNT(DISTINCT p.ID) AS NumPatientsOver50WithHighTG FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.TG >= 200 AND (strftime('%Y', 'now') - strftime('%Y', p.Birthday)) > 50;
SELECT DISTINCT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Admission = '-' AND L.CPK < 250;
SELECT COUNT(DISTINCT p.ID) AS MalePatientCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Birthday BETWEEN '1936-01-01' AND '1956-12-31' AND p.SEX = 'M' AND l.CPK >= 250;
SELECT p.ID, p.SEX, strftime('%Y', 'now') - strftime('%Y', p.Birthday) AS age FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.GLU >= 180 AND l.`T-CHO` < 250;
SELECT Patient.ID, Laboratory.GLU FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GLU < 180 AND YEAR(Patient.Description) >= 1991;
SELECT P.ID, P.SEX, P.Birthday FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.WBC <= 3.5 OR L.WBC >= 9.0 GROUP BY P.SEX, P.ID ORDER BY P.Birthday ASC;
SELECT P.ID, P.Diagnosis, (STRFTIME('%Y', 'now') - STRFTIME('%Y', P.Birthday)) AS Age FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.RBC < 3.5;
SELECT P.ID, P.SEX, P.Birthday, P.Admission, L.RBC FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'F' AND (julianday('now') - julianday(P.Birthday)) / 365.25 >= 50 AND (L.RBC <= 3.5 OR L.RBC >= 6.0);
SELECT P.ID, P.SEX FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Admission = '-' AND L.HGB < 10;
SELECT P.ID, P.SEX FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE P.Diagnosis = 'SLE' AND E.HGB > 10 AND E.HGB < 17 ORDER BY P.Birthday ASC LIMIT 1;
SELECT p.ID, (strftime('%Y', 'now') - strftime('%Y', p.Birthday)) AS age FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.HCT >= 52 GROUP BY p.ID HAVING COUNT(l.ID) > 2;
SELECT AVG(HCT) AS Average_Lower_HCT FROM Laboratory WHERE Date LIKE '1991%' AND HCT < 29;
SELECT ID, COUNT(CASE WHEN PLT < 100 THEN 1 END) AS LowCount, COUNT(CASE WHEN PLT > 400 THEN 1 END) AS HighCount FROM Laboratory WHERE PLT < 100 OR PLT > 400 GROUP BY ID ) SELECT SUM(LowCount) AS NumberOfPatientsLowerThanNormalRange, SUM(HighCount) AS NumberOfPatientsHigherThanNormalRange, CASE WHEN SUM(LowCount) > SUM(HighCount) THEN 'Lower is more' WHEN SUM(LowCount) < SUM(HighCount) THEN 'Higher is more' ELSE 'Equal' END AS Comparison FROM AbnormalPlatelets
SELECT p.ID, p.SEX, p.Birthday, l.PLT FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.Date LIKE '1984%' AND (STRFTIME('%Y', 'now') - STRFTIME('%Y', p.Birthday)) < 50 AND l.PLT BETWEEN 100 AND 400;
SELECT (SUM(CASE WHEN p.SEX = 'F' AND lab.PT >= 14 THEN 1 ELSE 0 END) * 1.0 / NULLIF(COUNT(DISTINCT p.ID), 0)) * 100 AS Percentage_Female_Abnormal_PT FROM Patient p JOIN Laboratory lab ON p.ID = lab.ID WHERE (strftime('%Y', 'now') - strftime('%Y', p.Birthday)) > 55;
SELECT p.ID, p.SEX, p.Birthday, p.Description, p.`First Date`, p.Admission, p.Diagnosis FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.`First Date` > '1992-12-31' AND l.PT < 14;
SELECT COUNT(*) AS Inactivated_APTT_Count FROM Examination WHERE `Examination Date` > '1997-01-01' AND APTT >= 45;
SELECT COUNT(DISTINCT p.ID) AS MildThrombosisPatients FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE l.APTT > 45 AND e.Thrombosis = 3;
SELECT COUNT(DISTINCT p.ID) AS AbnormalFibrinogenCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'M' AND l.WBC BETWEEN 3.5 AND 9.0 AND (l.FG <= 150 OR l.FG >= 450);
SELECT COUNT(DISTINCT p.ID) AS DistinctPatients FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Birthday > '1980-01-01' AND (l.FG < 150 OR l.FG > 450);
SELECT DISTINCT p.Diagnosis FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.`U-PRO` >= 30;
SELECT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.`U-PRO` > 0 AND L.`U-PRO` < 30 AND P.Diagnosis = 'SLE';
SELECT COUNT(DISTINCT P.ID) AS patient_count FROM Patient P JOIN Laboratory L ON P.ID = L.ID JOIN Examination E ON P.ID = E.ID WHERE L.IGG < 900 AND E.Symptoms = 'abortion';
SELECT COUNT(DISTINCT p.ID) AS PatientsWithSymptoms FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.IGG BETWEEN 900 AND 2000 AND p.Symptoms IS NOT NULL;
SELECT P.Diagnosis FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.IGA BETWEEN 80 AND 500 AND L.IGA = ( SELECT MAX(IGA) FROM Laboratory WHERE IGA BETWEEN 80 AND 500 ) LIMIT 1;
SELECT COUNT(DISTINCT P.ID) AS Normal_IgA_Patients FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.IGA BETWEEN 80 AND 500 AND P.`First Date` >= '1990-01-01';
SELECT p.Diagnosis, COUNT(*) AS Count FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.IGM NOT BETWEEN 40 AND 400 GROUP BY p.Diagnosis ORDER BY Count DESC LIMIT 1;
SELECT COUNT(DISTINCT Patient.ID) AS NormalCRPWithoutData FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE (Laboratory.CRP LIKE '+' OR Laboratory.CRP LIKE '-' OR Laboratory.CRP < 1.0) AND Patient.Description IS NULL;
SELECT COUNT(DISTINCT p.ID) AS NumPatientsUnder18 FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.CRP NOT IN ('+-', '-') AND l.CRP >= 1.0 AND (strftime('%Y', 'now') - strftime('%Y', p.Birthday)) < 18;
SELECT COUNT(DISTINCT P.ID) AS Normal_RF_Positive_KCT_Patient_Count FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.RF IN ('-', '+-') AND L.KCT = '+';
SELECT p.Diagnosis FROM Patient p WHERE p.Birthday >= '1995-01-01' AND p.RF IN ('-', '+-');
SELECT p.ID FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.RF < 20 AND (strftime('%Y', 'now') - strftime('%Y', p.Birthday)) > 60;
SELECT COUNT(DISTINCT Patient.ID) AS NormalRF_NoThrombosis_Count FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID JOIN Examination ON Patient.ID = Examination.ID WHERE Laboratory.RF < 20 AND Examination.Thrombosis = 0;
SELECT COUNT(DISTINCT p.ID) AS NumberOfPatients FROM Patient p JOIN Laboratory l ON p.ID = l.ID JOIN Examination e ON p.ID = e.ID WHERE l.C3 > 35 AND e.`ANA Pattern` = 'P';
SELECT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.HCT < 29 OR L.HCT > 52 ORDER BY L.`aCL IgA` DESC LIMIT 1;
SELECT COUNT(DISTINCT p.ID) AS Normal_C4_Patients_With_Thrombosis FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE e.Thrombosis = 1 -- Assuming 1 indicates presence of thrombosis AND l.C4 > 10; -- Condition for normal level of C4
SELECT COUNT(DISTINCT p.ID) AS Normal_RNP_Admitted_Patients FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE (l.RNP = '-' OR l.RNP = '+-') AND p.Admission = '+';
SELECT P.Birthday FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.RNP NOT IN ('-', '+') -- Filter for abnormal RNP levels ORDER BY P.Birthday DESC -- Order by birthday, with youngest first LIMIT 1; -- Limit to the youngest patient
SELECT COUNT(DISTINCT Patient.ID) AS Normal_Anti_SM_Thrombosis_Count FROM Patient JOIN Examination ON Patient.ID = Examination.ID JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.SM IN ('negative', '0') -- assuming 'negative' relates to 'normal' AND Examination.Thrombosis = 1;
SELECT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.SM NOT IN ('-', '+') ORDER BY P.Birthday DESC LIMIT 3;
SELECT DISTINCT p.ID FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE e.`Examination Date` >= '1997-01-01' AND e.SC170 IN ('-', '+-');
SELECT COUNT(DISTINCT P.ID) AS Male_Vertigo_Patients FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.SC170 IN ('-', '+') AND P.SEX = 'M' AND P.Symptoms LIKE '%vertigo%';
SELECT COUNT(DISTINCT p.ID) AS num_patients FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE (l.SSA = '-' OR l.SSA = '+-') AND YEAR(p.`First Date`) < 1990;
SELECT P.ID FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.SSA NOT IN ('-', '+-') ORDER BY P.`First Date` ASC LIMIT 1;
SELECT COUNT(DISTINCT P.ID) AS Normal_anti_SSB_patients FROM Patient P JOIN Examination E ON P.ID = E.ID WHERE (E.`SSB` = '-' OR E.`SSB` = '+-') AND P.Diagnosis = 'SLE';
SELECT COUNT(DISTINCT p.ID) AS PatientCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID JOIN Examination e ON p.ID = e.ID WHERE l.SSB = '-' AND e.Symptoms IS NOT NULL;
SELECT COUNT(DISTINCT p.ID) AS MaleCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.CENTROMEA = '-' AND l.SSB = '-' AND p.SEX = 'M';
SELECT DISTINCT P.Diagnosis FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.DNA >= 8;
SELECT COUNT(DISTINCT P.ID) AS Normal_Anti_DNA_Patient_Count FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.DNA < 8 AND P.Description IS NULL;
SELECT COUNT(DISTINCT p.ID) AS AdmittedPatientsWithAbnormalDNAII FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.`DNA-II` >= 8 AND p.Admission = '+';
SELECT CASE WHEN total_abnormal_got > 0 THEN (100.0 * sle_abnormal_got / total_abnormal_got) -- Calculate the percentage ELSE 0 -- If no patients have abnormal GOT, return 0 END AS percentage_of_sle_abnormal_got FROM (SELECT COUNT(ID) AS total_abnormal_got FROM Laboratory WHERE GOT >= 60 ) AS total_abnormal, (SELECT COUNT(ID) AS sle_abnormal_got FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.GOT >= 60 AND P.Diagnosis = 'SLE' ) AS sle_abnormal;
SELECT COUNT(DISTINCT P.ID) AS MalePatientsWithNormalGOT FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.GOT < 60;
SELECT MAX(P.Birthday) AS Youngest_Birthday FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.GOT >= 60;
SELECT P.Birthday FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.GPT < 60 ORDER BY L.GPT DESC LIMIT 3;
SELECT COUNT(DISTINCT P.ID) AS MalePatientsWithNormalGPT FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.GPT < 60 AND P.SEX = 'M';
SELECT p.ID, max_lab.LDH, p.`First Date` FROM ( SELECT ID, LDH, MIN(Date) AS First_Data_Date FROM Laboratory WHERE LDH < 500 GROUP BY ID ) AS max_lab JOIN Patient p ON p.ID = max_lab.ID WHERE max_lab.LDH = ( SELECT MAX(LDH) FROM Laboratory WHERE LDH < 500 )
SELECT L.Date FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.First_Date = (SELECT MAX(First_Date) FROM Patient) AND L.LDH >= 500;
SELECT COUNT(DISTINCT P.ID) AS NumberOfAdmittedPatients FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.ALP >= 300 AND P.Admission = '+';
SELECT COUNT(DISTINCT P.ID) AS NormalALPPatients FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Admission = '-' AND L.ALP < 300;
SELECT DISTINCT P.Diagnosis FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.TP < 6.0;
SELECT COUNT(DISTINCT P.ID) AS NormalTP_SJS_Patients FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Diagnosis = 'SJS' AND L.TP > 6.0 AND L.TP < 8.5;
SELECT E.`Examination Date` FROM Examination E JOIN Laboratory L ON E.ID = L.ID WHERE L.ALB = ( SELECT MAX(ALB) FROM Laboratory WHERE ALB > 3.5 AND ALB < 5.5 );
SELECT COUNT(DISTINCT P.ID) AS MalePatientsWithNormalAlbuminAndTP FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.SEX = 'M' AND L.ALB > 3.5 AND L.ALB < 5.5 AND L.TP >= 6.0 AND L.TP <= 8.5;
SELECT * FROM table
SELECT MAX(E.ANA) AS Highest_ANA FROM Examination E JOIN Laboratory L ON E.ID = L.ID JOIN Patient P ON E.ID = P.ID WHERE L.CRE < 1.5;
SELECT ID FROM Laboratory WHERE CRE < 1.5 ), -- Step 2: Get the maximum aCL IgA level and associated patient IDs MaxACLIgA AS ( SELECT ID, MAX(`aCL IgA`) AS MaxACLIgA FROM Examination GROUP BY ID ) -- Step 3: Combine results to get patient IDs that meet both criteria SELECT nc.ID FROM NormalCreatinine nc JOIN MaxACLIgA ma ON nc.ID = ma.ID WHERE ma.MaxACLIgA IS NOT NULL
SELECT COUNT(DISTINCT P.ID) AS PatientCount FROM Patient P JOIN Laboratory L ON P.ID = L.ID JOIN Examination E ON P.ID = E.ID WHERE L.`T-BIL` >= 2.0 AND E.`ANA Pattern` LIKE '%P%';
SELECT e.ANA FROM Examination e JOIN Patient p ON e.ID = p.ID WHERE p.ID = ( SELECT l.ID FROM Laboratory l WHERE l.`T-BIL` < 2.0 ORDER BY l.`T-BIL` DESC LIMIT 1 );
SELECT COUNT(DISTINCT p.ID) AS TotalPatients FROM Patient p JOIN Laboratory l ON p.ID = l.ID JOIN Examination e ON p.ID = e.ID WHERE l.`T-CHO` >= 250 AND e.KCT = '-';
SELECT COUNT(DISTINCT p.ID) AS PatientCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID JOIN Examination e ON p.ID = e.ID WHERE l.`T-CHO` < 250 AND e.`ANA Pattern` = 'P';
SELECT COUNT(DISTINCT p.ID) AS PatientCount FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.TG < 200 AND p.Symptoms IS NOT NULL;
SELECT P.Diagnosis FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.TG = ( SELECT MAX(L2.TG) FROM Laboratory L2 WHERE L2.TG < 200 )
SELECT DISTINCT p.ID FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE e.Thrombosis = 0 AND l.CPK < 250;
SELECT COUNT(DISTINCT p.ID) AS Positive_Coagulation_Count FROM Laboratory l JOIN Patient p ON l.ID = p.ID WHERE l.CPK < 250 AND (l.KCT = '+' OR l.RVVT = '+' OR l.LAC = '+');
SELECT MIN(P.Birthday) AS Oldest_Birthday FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.GLU > 180;
SELECT COUNT(DISTINCT P.ID) AS Normal_Glucose_No_Thrombosis FROM Laboratory L JOIN Patient P ON L.ID = P.ID WHERE L.GLU < 180 AND P.Thrombosis = 0;
SELECT COUNT(DISTINCT P.ID) AS NormalWBCPatients FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Admission = '+' AND L.WBC BETWEEN 3.5 AND 9.0;
SELECT COUNT(DISTINCT p.ID) AS SLE_Normal_WBC_Count FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Diagnosis = 'SLE' AND l.WBC BETWEEN 3.5 AND 9.0;
SELECT DISTINCT p.ID FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE (l.RBC <= 3.5 OR l.RBC >= 6.0) AND p.Admission = '-';
SELECT COUNT(DISTINCT P.ID) AS CountOfPatientsWithSymptoms FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.PLT > 100 AND L.PLT < 400 AND P.Diagnosis IS NOT NULL;
SELECT p.ID, l.PLT FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Diagnosis = 'MCTD' AND l.PLT > 100 AND l.PLT < 400;
SELECT AVG(Lab.PT) AS Average_PT FROM Patient AS Pat JOIN Laboratory AS Lab ON Pat.ID = Lab.ID WHERE Pat.SEX = 'M' AND Lab.PT < 14;
SELECT COUNT(DISTINCT p.ID) AS patient_count FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE e.Thrombosis IN (1, 2) -- Severe thrombosis AND l.PT < 14; -- Normal prothrombin time
SELECT m.first_name, m.last_name, ma.major_name FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE m.first_name = 'Angela' AND m.last_name = 'Sanders';
SELECT COUNT(*) AS student_count FROM member AS m JOIN major AS maj ON m.link_to_major = maj.major_id WHERE maj.college = 'College of Engineering';
SELECT m.first_name || ' ' || m.last_name AS full_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE maj.department = 'Art and Design';
SELECT COUNT(DISTINCT a.link_to_member) AS number_of_attendees FROM event e JOIN attendance a ON e.event_id = a.link_to_event WHERE e.event_name = 'Women''s Soccer';
SELECT m.phone FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = 'Women\'s Soccer' AND m.position = 'Student Club'; -- Adjust the position filter as necessary
SELECT COUNT(*) AS medium_tshirt_attendees FROM member m JOIN attendance a ON m.member_id = a.link_to_member WHERE a.link_to_event = (SELECT event_id FROM event WHERE event_name = 'Women''s Soccer') AND m.t_shirt_size = 'Medium';
SELECT e.event_id, e.event_name, e.event_date, COUNT(a.link_to_member) AS attendance_count FROM attendance a JOIN member m ON a.link_to_member = m.member_id JOIN event e ON a.link_to_event = e.event_id WHERE m.position = 'Student Club' -- Assuming 'position' indicates the club affiliation GROUP BY e.event_id ORDER BY attendance_count DESC LIMIT 1;
SELECT major.college FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Vice President';
SELECT member_id FROM member WHERE first_name = 'Maya' AND last_name = 'Mclean'
SELECT member_id FROM member WHERE first_name = 'Sacha' AND last_name = 'Harrison';
SELECT COUNT(*) AS meeting_count FROM event e JOIN attendance a ON e.event_id = a.link_to_event WHERE e.type = 'Meeting' GROUP BY e.event_id HAVING COUNT(a.link_to_member) > 10;
SELECT e.event_name FROM event e JOIN attendance a ON e.event_id = a.link_to_event WHERE e.event_name LIKE '%Student_Club%' GROUP BY e.event_id, e.event_name HAVING COUNT(a.link_to_member) > 20;
SELECT event_id FROM event WHERE type = 'Meeting' AND strftime('%Y', event_date) = '2020'
SELECT expense_description, cost FROM expense WHERE cost = ( SELECT MAX(cost) FROM expense )
SELECT COUNT(m.member_id) AS member_count FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Environmental Engineering';
SELECT m.first_name || ' ' || m.last_name AS full_name FROM attendance a JOIN event e ON a.link_to_event = e.event_id JOIN member m ON a.link_to_member = m.member_id WHERE e.event_name = 'Laugh Out Loud';
SELECT m.last_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Law and Constitutional Studies';
SELECT z.county FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Sherri' AND m.last_name = 'Ramsey';
SELECT m.first_name, m.last_name, maj.college FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.first_name = 'Tyler' AND m.last_name = 'Hewitt';
SELECT i.amount FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE m.position = 'Vice President';
SELECT SUM(b.spent) AS total_spent_on_food FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE e.event_name = 'September Meeting' AND b.category = 'Food';
SELECT z.city, z.state FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.position = 'President';
SELECT m.first_name || ' ' || m.last_name AS full_name FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE z.state = 'Illinois';
SELECT event_id FROM event WHERE event_name = 'September Meeting';
SELECT DISTINCT m.first_name, m.last_name, maj.department FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.first_name IN ('Pierce', 'Guidi');
SELECT SUM(amount) AS total_budgeted_amount FROM budget WHERE link_to_event IN ( SELECT event_id FROM event WHERE event_name = 'October Speaker' );
SELECT e.event_id, e.event_name, ex.expense_id, ex.expense_description, ex.approved FROM event e JOIN budget b ON e.event_id = b.link_to_event JOIN expense ex ON b.budget_id = ex.link_to_budget WHERE e.event_name = 'October Meeting' AND e.event_date = '2019-10-08';
SELECT AVG(e.cost) AS average_cost FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN expense e ON a.link_to_event = e.link_to_budget -- Assuming expenses are linked to events through budgets JOIN event ev ON a.link_to_event = ev.event_id WHERE m.first_name = 'Elijah' AND m.last_name = 'Allen' AND (strftime('%m', e.expense_date) = '09' OR strftime('%m', e.expense_date) = '10');
SELECT SUM(CASE WHEN strftime('%Y', event_date) = '2019' THEN budget.spent ELSE 0 END) AS spent_2019, SUM(CASE WHEN strftime('%Y', event_date) = '2020' THEN budget.spent ELSE 0 END) AS spent_2020, SUM(CASE WHEN strftime('%Y', event_date) = '2020' THEN budget.spent ELSE 0 END) - SUM(CASE WHEN strftime('%Y', event_date) = '2019' THEN budget.spent ELSE 0 END) AS difference FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE event.type LIKE '%Student Club%' -- Adjust this condition as needed based on how Student Club events are identified AND (strftime('%Y', event_date) = '2019' OR strftime('%Y', event_date) = '2020');
SELECT location FROM event WHERE event_name = 'Spring Budget Review';
SELECT e.event_name, b.budget_id, ex.cost FROM event e JOIN budget b ON e.event_id = b.link_to_event JOIN expense ex ON b.budget_id = ex.link_to_budget WHERE e.event_name = 'Posters' AND e.event_date = '2019-09-04';
SELECT b.remaining FROM budget b WHERE b.amount = ( SELECT MAX(b2.amount) FROM budget b2 WHERE b2.category = 'Food' );
SELECT notes FROM income WHERE date_received = '2019-09-14' AND source = 'Fundraising';
SELECT COUNT(*) AS number_of_majors FROM major WHERE college = 'College of Humanities and Social Sciences';
SELECT phone FROM member WHERE first_name = 'Carlo' AND last_name = 'Jacobs';
SELECT z.county FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Adela' AND m.last_name = 'O\'Gallagher';
SELECT COUNT(*) FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'November Meeting') AND remaining < 0;
SELECT SUM(b.amount) AS total_budget_amount FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE e.event_name = 'September Speaker';
SELECT e.status FROM expense ex JOIN budget b ON ex.link_to_budget = b.budget_id JOIN event e ON b.link_to_event = e.event_id WHERE ex.expense_description = 'Post Cards, Posters' AND ex.expense_date = '2019-8-20';
SELECT m.first_name, m.last_name, maj.major_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.first_name = 'Brent' AND m.last_name = 'Thomason';
SELECT COUNT(*) FROM member WHERE link_to_major = ( SELECT major_id FROM major WHERE major_name = 'Human Development and Family Studies' ) AND t_shirt_size = 'Large';
SELECT z.type FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Christof' AND m.last_name = 'Nielson';
SELECT m.link_to_major, maj.major_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.position = 'Vice President';
SELECT z.state FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Sacha' AND m.last_name = 'Harrison';
SELECT m.first_name, m.last_name, maj.department FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.position = 'President';
SELECT member_id FROM member WHERE first_name = 'Connor' AND last_name = 'Hilton'
SELECT m.first_name || ' ' || m.last_name AS full_name FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE i.source = 'Dues' ORDER BY i.date_received LIMIT 1;
SELECT link_to_event, category, amount FROM budget WHERE category = 'Advertisement' AND (link_to_event = 'yearly_kickoff_id' OR link_to_event = 'october_meeting_id') ) SELECT COUNT(*) AS times_budget_greater FROM budget_amounts AS yk JOIN budget_amounts AS om ON yk.link_to_event = 'yearly_kickoff_id' AND om.link_to_event = 'october_meeting_id' WHERE yk.amount > om.amount
SELECT (SUM(CASE WHEN b.category = 'Parking' THEN b.amount ELSE 0 END) / (SELECT SUM(b2.amount) FROM budget b2 JOIN event e ON b2.link_to_event = e.event_id WHERE e.event_name = 'November Speaker') ) * 100 AS parking_budget_percentage FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE e.event_name = 'November Speaker';
SELECT SUM(cost) AS total_cost_of_pizzas FROM expense WHERE expense_description = 'Pizza';
SELECT COUNT(DISTINCT city) AS number_of_cities FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia';
SELECT department FROM major WHERE college = 'College of Humanities and Social Sciences';
SELECT z.city, z.county, z.state FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Amy' AND m.last_name = 'Firth';
SELECT e.expense_id, e.expense_description, e.expense_date, e.cost FROM expense e WHERE e.link_to_budget = ( SELECT b.budget_id FROM budget b ORDER BY b.remaining ASC LIMIT 1 );
SELECT m.first_name, m.last_name, m.email, m.position, m.phone FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = 'October Meeting';
SELECT m.college, COUNT(m.member_id) AS member_count FROM member m JOIN major j ON m.link_to_major = j.major_id GROUP BY j.college ORDER BY member_count DESC LIMIT 1;
SELECT m.first_name, m.last_name, ma.major_name FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE m.phone = '809-555-3360';
SELECT e.event_id, e.event_name, b.amount FROM budget b JOIN event e ON b.link_to_event = e.event_id ORDER BY b.amount DESC LIMIT 1;
SELECT e.* FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE m.position = 'Vice President';
SELECT COUNT(DISTINCT link_to_member) AS number_of_attendees FROM attendance WHERE link_to_event = ( SELECT event_id FROM event WHERE event_name = 'Women''s Soccer' );
SELECT i.date_received FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE m.first_name = 'Casey' AND m.last_name = 'Mason';
SELECT COUNT(*) AS number_of_members_from_maryland FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE z.state = 'MD';
SELECT member_id FROM member WHERE phone = "954-555-6240";
SELECT major_id FROM major WHERE department = 'School of Applied Sciences, Technology and Education';
SELECT e.event_id, e.event_name, b.spent, b.amount, (b.spent / b.amount) AS spend_to_budget_ratio FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE e.status = 'Closed' ORDER BY spend_to_budget_ratio DESC LIMIT 1;
SELECT COUNT(*) AS president_count FROM member WHERE position = 'President';
SELECT MAX(spent) AS highest_budget_spent FROM budget;
SELECT COUNT(*) AS meeting_events_count FROM event WHERE type = 'Meeting' AND event_date >= '2020-01-01' AND event_date <= '2020-12-31';
SELECT SUM(spent) AS total_spent_on_food FROM budget WHERE category = 'Food';
SELECT m.first_name, m.last_name FROM member m JOIN attendance a ON m.member_id = a.link_to_member GROUP BY m.member_id HAVING COUNT(DISTINCT a.link_to_event) > 7;
SELECT m.first_name, m.last_name FROM member m JOIN major j ON m.link_to_major = j.major_id JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE j.major_name = 'Interior Design' AND e.event_name = 'Community Theater';
SELECT first_name, last_name FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE zip_code.city = 'Georgetown' AND zip_code.state = 'South Carolina';
SELECT SUM(i.amount) AS total_income FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE m.first_name = 'Grant' AND m.last_name = 'Gilmour';
SELECT m.first_name, m.last_name FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE i.amount > 40;
SELECT SUM(e.cost) AS total_expense FROM event ev JOIN budget b ON ev.event_id = b.link_to_event JOIN expense e ON b.budget_id = e.link_to_budget WHERE ev.event_name = 'Yearly Kickoff';
SELECT m.first_name, m.last_name FROM member m JOIN budget b ON b.link_to_event = (SELECT e.event_id FROM event e WHERE e.event_name = 'Yearly Kickoff') WHERE b.budget_id IN ( SELECT budget_id FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff') );
SELECT m.first_name || ' ' || m.last_name AS full_name, i.source FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE i.amount = (SELECT MAX(amount) FROM income);
SELECT e.event_id, e.event_name, MIN(exp.cost) AS lowest_cost FROM event e JOIN budget b ON e.event_id = b.link_to_event JOIN expense exp ON b.budget_id = exp.link_to_budget GROUP BY e.event_id, e.event_name ORDER BY lowest_cost ASC LIMIT 1;
SELECT (SUM(CASE WHEN e.event_id = 'Yearly Kickoff' THEN e.cost ELSE 0 END) / NULLIF(SUM(e.cost), 0)) * 100 AS percentage_yearly_kickoff FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id JOIN event ev ON b.link_to_event = ev.event_id;
SELECT SUM(CASE WHEN m.link_to_major = (SELECT major_id FROM major WHERE major_name = 'Finance') THEN 1 ELSE 0 END) AS finance_count, SUM(CASE WHEN m.link_to_major = (SELECT major_id FROM major WHERE major_name = 'Physics') THEN 1 ELSE 0 END) AS physics_count, CASE WHEN SUM(CASE WHEN m.link_to_major = (SELECT major_id FROM major WHERE major_name = 'Physics') THEN 1 ELSE 0 END) = 0 THEN NULL ELSE SUM(CASE WHEN m.link_to_major = (SELECT major_id FROM major WHERE major_name = 'Finance') THEN 1 ELSE 0 END) * 1.0 / SUM(CASE WHEN m.link_to_major = (SELECT major_id FROM major WHERE major_name = 'Physics') THEN 1 ELSE 0 END) END AS ratio FROM member m;
SELECT source, SUM(amount) AS total_amount FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' GROUP BY source ORDER BY total_amount DESC LIMIT 1;
SELECT first_name || ' ' || last_name AS full_name, email FROM member WHERE position = 'Secretary';
SELECT COUNT(*) AS member_count FROM member AS m JOIN major AS mg ON m.link_to_major = mg.major_id WHERE mg.major_name = 'Physics Teaching';
SELECT COUNT(a.link_to_member) AS number_of_attendees FROM event e JOIN attendance a ON e.event_id = a.link_to_event WHERE e.event_name = 'Community Theater' AND strftime('%Y', e.event_date) = '2019';
SELECT member_id, link_to_major FROM member WHERE first_name = 'Luisa' AND last_name = 'Guidi';
SELECT AVG(spent) AS average_spent_on_food FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE b.category = 'Food' AND e.status = 'Closed';
SELECT e.event_id, e.event_name, b.spent FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE b.category = 'Advertisement' AND b.spent = (SELECT MAX(spent) FROM budget WHERE category = 'Advertisement');
SELECT EXISTS ( SELECT 1 FROM attendance a JOIN event e ON a.link_to_event = e.event_id JOIN member m ON a.link_to_member = m.member_id WHERE e.event_name = 'Women''s Soccer' AND m.first_name = 'Maya' AND m.last_name = 'Mclean' );
SELECT (COUNT(CASE WHEN type = 'Community Service' THEN 1 END) * 100.0) / COUNT(event_id) AS percentage_share FROM event WHERE event_date BETWEEN '2019-01-01' AND '2019-12-31';
SELECT e.cost FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id JOIN event ev ON b.link_to_event = ev.event_id WHERE ev.event_name = 'September Speaker' AND e.expense_description = 'Posters';
SELECT t_shirt_size, COUNT(t_shirt_size) AS size_count FROM member GROUP BY t_shirt_size ORDER BY size_count DESC LIMIT 1;
SELECT e.event_name FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE e.status = 'Closed' AND b.remaining < 0 ORDER BY b.remaining ASC LIMIT 1;
SELECT e.expense_description AS Expense_Type, SUM(e.cost) AS Total_Value FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id JOIN event ev ON b.link_to_event = ev.event_id WHERE ev.event_name = 'October Meeting' AND e.approved = 'Yes' -- Assuming 'approved' field holds 'Yes' for approved expenses GROUP BY e.expense_description;
SELECT b.category, b.amount FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE e.event_name = 'April Speaker' ORDER BY b.amount ASC;
SELECT MAX(amount) AS highest_budgeted_amount FROM budget WHERE category = 'Food';
SELECT * FROM budget WHERE category = 'Advertisement' ORDER BY amount DESC LIMIT 3;
SELECT SUM(cost) AS total_cost_parking FROM expense WHERE expense_description = 'Parking';
SELECT SUM(cost) AS total_expense FROM expense WHERE expense_date = '2019-08-20';
SELECT m.first_name || ' ' || m.last_name AS full_name, SUM(e.cost) AS total_cost
SELECT member_id FROM member WHERE first_name = 'Sacha' AND last_name = 'Harrison'
SELECT expense.expense_description FROM expense JOIN member ON expense.link_to_member = member.member_id WHERE member.t_shirt_size = 'X-Large';
SELECT DISTINCT m.zip FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE e.cost < 50;
SELECT m.first_name, m.last_name, maj.major_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.first_name = 'Phillip' AND m.last_name = 'Cullen';
SELECT major_id FROM major WHERE major_name = 'Business';
SELECT major_id FROM major WHERE major_name = 'Business';
SELECT DISTINCT e.type FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE b.remaining > 30;
SELECT type FROM event WHERE location = 'MU 215';
SELECT b.category FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE e.event_date = '2020-03-24T12:00:00';
SELECT m.first_name, m.last_name, maj.major_name FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.position = 'Vice President';
SELECT (COUNT(m.member_id) * 100.0 / (SELECT COUNT(*) FROM member)) AS percentage_major_mathematics FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Mathematics';
SELECT type FROM event WHERE location = 'MU 215';
SELECT COUNT(*) AS income_count FROM income WHERE amount = 50;
SELECT COUNT(*) AS number_of_members_with_x_large_tshirt_size FROM member WHERE t_shirt_size = 'X-Large';
SELECT COUNT(*) AS number_of_majors FROM major WHERE department = 'School of Applied Sciences, Technology and Education' AND college = 'College of Agriculture and Applied Sciences';
SELECT member.last_name, major.department, major.college FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering';
SELECT b.category FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE e.location = 'MU 215' AND e.type = 'Guest Speaker' AND b.spent = 0;
SELECT z.city, z.state FROM member AS m JOIN major AS ma ON m.link_to_major = ma.major_id JOIN zip_code AS z ON m.zip = z.zip_code WHERE ma.department = 'Electrical and Computer Engineering Department' AND m.position = 'Member';
SELECT e.event_name FROM event e JOIN attendance a ON e.event_id = a.link_to_event JOIN member m ON a.link_to_member = m.member_id WHERE m.position = 'Vice President' AND e.type = 'Social' AND e.location = '900 E. Washington St.';
SELECT m.last_name, m.position FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE e.expense_description = 'Pizza' AND e.expense_date = '2019-09-10';
SELECT m.last_name FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = 'Women\'s Soccer';
SELECT member_id FROM member WHERE t_shirt_size = 'Medium' ), TotalMediumCount AS ( SELECT COUNT(*) AS total_members FROM MediumMembers ), MembersWithAmount AS ( SELECT COUNT(DISTINCT im.link_to_member) AS count_of_member_with_amount_50 FROM MediumMembers mm JOIN income im ON mm.member_id = im.link_to_member WHERE im.amount = 50 ) SELECT (CAST(m.count_of_member_with_amount_50 AS REAL) / t.total_members) * 100 AS percentage FROM TotalMediumCount t, MembersWithAmount m
SELECT DISTINCT state FROM zip_code WHERE type = 'PO Box';
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND city = 'San Juan' AND state = 'Puerto Rico';
SELECT event_name FROM event WHERE type = 'Game' AND status = 'Closed' AND event_date BETWEEN '2019-03-15' AND '2020-03-20';
SELECT attendance.link_to_event FROM income JOIN member ON income.link_to_member = member.member_id JOIN attendance ON member.member_id = attendance.link_to_member WHERE income.amount > 50;
SELECT m.member_id, m.first_name, m.last_name, e.event_id, e.event_name FROM member m JOIN expense ex ON m.member_id = ex.link_to_member JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE ex.approved = 'true' AND ex.expense_date BETWEEN '2019-01-10' AND '2019-11-19';
SELECT m.first_name, maj.college FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE m.first_name = 'Katy' AND m.link_to_major = 'rec1N0upiVLy5esTO';
SELECT m.phone FROM member m JOIN major j ON m.link_to_major = j.major_id WHERE j.major_name = 'Business' AND j.college = 'College of Agriculture and Applied Sciences';
SELECT m.email FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE e.cost > 20 AND e.expense_date BETWEEN '2019-09-10' AND '2019-11-19';
SELECT COUNT(m.member_id) AS number_of_members FROM member m JOIN major j ON m.link_to_major = j.major_id WHERE j.major_name = 'Education' AND j.college = 'College of Education & Human Services';
SELECT (COUNT(CASE WHEN remaining < 0 THEN 1 END) * 100.0) / COUNT(budget_id) AS percentage_over_budget FROM budget;
SELECT event_id, location, status FROM event WHERE event_date BETWEEN '2019-11-01' AND '2020-03-31';
SELECT expense_id, expense_description, cost FROM expense WHERE cost > ( SELECT AVG(cost) FROM expense ) AND (SELECT AVG(cost) FROM expense) > 50;
SELECT first_name || ' ' || last_name AS full_name FROM member WHERE t_shirt_size = 'X-Large';
SELECT (COUNT(CASE WHEN type = 'PO Box' THEN 1 END) * 100.0 / COUNT(zip_code)) AS percentage_po_boxes FROM zip_code;
SELECT event.event_name, event.location FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE budget.remaining > 0;
SELECT e.event_name, e.event_date FROM event e JOIN budget b ON e.event_id = b.link_to_event JOIN expense exp ON b.budget_id = exp.link_to_budget WHERE exp.expense_description = 'Pizza' AND exp.cost > 50 AND exp.cost < 100;
SELECT m.first_name || ' ' || m.last_name AS full_name, maj.major_name FROM member m JOIN expense e ON m.member_id = e.link_to_member JOIN major maj ON m.link_to_major = maj.major_id WHERE e.cost > 100;
SELECT z.city, z.county FROM income i JOIN member m ON i.link_to_member = m.member_id JOIN zip_code z ON m.zip = z.zip_code JOIN event e ON e.event_id = i.link_to_event GROUP BY e.event_id HAVING COUNT(i.income_id) > 40;
SELECT m.member_id, m.first_name, m.last_name, SUM(e.cost) AS total_expense FROM expense e JOIN attendance a ON e.link_to_member = a.link_to_member JOIN member m ON a.link_to_member = m.member_id GROUP BY m.member_id, m.first_name, m.last_name HAVING COUNT(DISTINCT a.link_to_event) > 1 ORDER BY total_expense DESC LIMIT 1;
SELECT AVG(e.cost) AS average_amount_paid FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE m.position != 'Member';
SELECT AVG(cost) AS average_parking_cost FROM expense WHERE expense_description = 'Parking';
SELECT e.event_id FROM event e WHERE e.type = 'Game' ), ExpensesForGameEvents AS ( SELECT SUM(ex.cost) AS total_cost, COUNT(DISTINCT ge.event_id) AS game_event_count FROM Expense ex JOIN Budget b ON ex.link_to_budget = b.budget_id JOIN GameEvents ge ON b.link_to_event = ge.event_id ) SELECT CASE WHEN game_event_count > 0 THEN (total_cost * 100.0 / game_event_count) ELSE 0 END AS game_event_cost_percentage FROM ExpensesForGameEvents
SELECT b.budget_id, SUM(e.cost) AS total_cost FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id WHERE e.expense_description IN ('Water', 'chips', 'cookies') GROUP BY b.budget_id ORDER BY total_cost DESC LIMIT 1;
SELECT m.first_name || ' ' || m.last_name AS full_name, SUM(e.cost) AS total_spending FROM member m JOIN expense e ON m.member_id = e.link_to_member GROUP BY m.member_id ORDER BY total_spending DESC LIMIT 5;
SELECT m.first_name || ' ' || m.last_name AS full_name, m.phone AS contact_number FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE e.cost > (SELECT AVG(cost) FROM expense);
SELECT zip_code.state, COUNT(member.member_id) AS total_members, COUNT(CASE WHEN member.position = 'Member' THEN 1 END) AS member_count FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE zip_code.state IN ('Maine', 'Vermont') GROUP BY zip_code.state ), percentages AS ( SELECT state, (member_count * 100.0 / NULLIF(total_members, 0)) AS member_percentage FROM member_counts ) SELECT (SELECT member_percentage FROM percentages WHERE state = 'Maine') - (SELECT member_percentage FROM percentages WHERE state = 'Vermont') AS percentage_difference
SELECT m.first_name, m.last_name, ma.major_name, ma.department FROM member AS m JOIN major AS ma ON m.link_to_major = ma.major_id WHERE m.first_name = 'Garrett' AND m.last_name = 'Gerke';
SELECT m.first_name || ' ' || m.last_name AS full_name, e.cost FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE e.expense_description IN ('Water', 'Veggie tray', 'Supplies');
SELECT m.last_name, m.phone FROM member m JOIN major maj ON m.link_to_major = maj.major_id WHERE maj.major_name = 'Elementary Education';
SELECT b.category, b.amount FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE e.event_name = 'January Speaker';
SELECT e.event_name FROM event e JOIN budget b ON e.event_id = b.link_to_event WHERE b.category = 'Food';
SELECT m.first_name || ' ' || m.last_name AS full_name, i.amount FROM income i JOIN member m ON i.link_to_member = m.member_id WHERE i.date_received = '9/9/2019';
SELECT b.category FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id WHERE e.expense_description = 'Posters';
SELECT member.first_name || ' ' || member.last_name AS full_name, major.college FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Secretary';
SELECT e.event_name, SUM(b.spent) AS total_spent FROM budget b JOIN event e ON b.link_to_event = e.event_id WHERE b.category = 'Speaker Gifts' GROUP BY e.event_name;
SELECT z.city AS hometown FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE m.first_name = 'Garrett' AND m.last_name = 'Girke';
SELECT m.first_name || ' ' || m.last_name AS full_name, m.position FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE z.city = 'Lincolnton' AND z.state = 'North Carolina' AND m.zip = 28092;
SELECT COUNT(DISTINCT gs.GasStationID) AS PremiumGasStationCount FROM gasstations gs JOIN transactions_1k t ON gs.GasStationID = t.GasStationID JOIN products p ON t.ProductID = p.ProductID WHERE gs.Country = 'CZE' AND p.Description LIKE '%Premium%';
SELECT (SELECT COUNT(*) FROM customers WHERE Currency = 'EUR') * 1.0 / NULLIF((SELECT COUNT(*) FROM customers WHERE Currency = 'CZK'), 0) AS EUR_to_CZK_Ratio
SELECT c.CustomerID, SUM(ym.Consumption) AS TotalConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Segment = 'LAM' AND ym.Date BETWEEN '201201' AND '201212' GROUP BY c.CustomerID ORDER BY TotalConsumption ASC LIMIT 1;
SELECT AVG(MonthlyConsumption) AS AverageMonthlyConsumption FROM ( SELECT AVG(Consumption) AS MonthlyConsumption FROM yearmonth WHERE CustomerID IN ( SELECT CustomerID FROM customers WHERE Segment = 'SME' ) AND Date BETWEEN '201301' AND '201312' GROUP BY Date );
SELECT c.CustomerID, SUM(ym.Consumption) AS TotalConsumption FROM customers c JOIN yearmonth ym ON c.CustomerID = ym.CustomerID WHERE c.Currency = 'CZK' AND ym.Date BETWEEN '201101' AND '201112' GROUP BY c.CustomerID ORDER BY TotalConsumption DESC;
SELECT COUNT(DISTINCT ym.CustomerID) AS CustomerCount FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Segment = 'KAM' AND ym.Date BETWEEN '201201' AND '201212' GROUP BY ym.CustomerID HAVING SUM(ym.Consumption) < 30000;
SELECT COALESCE(SUM(CASE WHEN c.Currency = 'CZK' THEN ym.Consumption END), 0) AS CZK_Consumption, COALESCE(SUM(CASE WHEN c.Currency = 'EUR' THEN ym.Consumption END), 0) AS EUR_Consumption, COALESCE(SUM(CASE WHEN c.Currency = 'CZK' THEN ym.Consumption END), 0) - COALESCE(SUM(CASE WHEN c.Currency = 'EUR' THEN ym.Consumption END), 0) AS Consumption_Difference FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE ym.Date BETWEEN '201201' AND '201212';
SELECT strftime('%Y', ym.Date) AS Year, SUM(ym.Consumption) AS TotalConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID JOIN transactions_1k t ON ym.CustomerID = t.CustomerID WHERE c.Currency = 'EUR' GROUP BY Year ORDER BY TotalConsumption DESC LIMIT 1;
SELECT c.Segment, SUM(ym.Consumption) AS TotalConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID GROUP BY c.Segment ORDER BY TotalConsumption ASC LIMIT 1;
SELECT substr(ym.Date, 1, 4) AS Year, SUM(ym.Consumption) AS TotalConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Currency = 'CZK' GROUP BY Year ORDER BY TotalConsumption DESC LIMIT 1;
SELECT substr(ym.Date, 1, 7) AS YearMonth, -- Extract the year and month from the Date field SUM(ym.Consumption) AS TotalConsumption -- Sum of consumption for the month FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Segment = 'SME' -- Filter for SME customers AND substr(ym.Date, 1, 4) = '2013' -- Only consider the year 2013 GROUP BY YearMonth -- Group by Year and Month ORDER BY TotalConsumption DESC -- Order by total consumption in descending order LIMIT 1; -- Limit to get the peak month
SELECT * FROM table
SELECT * FROM table
SELECT SUM(Consumption) AS TotalConsumption FROM yearmonth WHERE CustomerID = 6 AND Date BETWEEN '201308' AND '201311';
SELECT (SELECT COUNT(*) FROM gasstations WHERE Country = 'Czech Republic' AND Segment = 'discount') - (SELECT COUNT(*) FROM gasstations WHERE Country = 'Slovakia' AND Segment = 'discount') AS More_Discount_GasStations;
SELECT Consumption FROM yearmonth WHERE CustomerID = 7 AND Date = '201304'
SELECT Currency, COUNT(*) AS Count FROM customers WHERE Segment = 'SME' AND Currency IN ('Czech Koruna', 'Euro') -- Filter for relevant currencies GROUP BY Currency;
SELECT c.CustomerID, SUM(ym.Consumption) AS TotalConsumption FROM customers c JOIN yearmonth ym ON c.CustomerID = ym.CustomerID WHERE c.Segment = 'LAM' AND c.Currency = 'Euro' AND ym.Date = '201310' -- Referring to October 2013 as per the external knowledge GROUP BY c.CustomerID ORDER BY TotalConsumption DESC LIMIT 1;
SELECT c.CustomerID, SUM(y.Consumption) AS TotalConsumption FROM customers c JOIN yearmonth y ON c.CustomerID = y.CustomerID WHERE c.Segment = 'KAM' GROUP BY c.CustomerID ORDER BY TotalConsumption DESC LIMIT 1;
SELECT SUM(y.Consumption) AS TotalConsumption FROM yearmonth y JOIN customers c ON y.CustomerID = c.CustomerID WHERE c.Segment = 'KAM' AND y.Date = '201305';
SELECT CustomerID FROM customers WHERE Segment = 'LAM' ), Consumption_Above_Threshold AS ( SELECT COUNT(DISTINCT ym.CustomerID) AS CountAboveThreshold FROM yearmonth ym JOIN LAM_Customers lc ON ym.CustomerID = lc.CustomerID WHERE ym.Consumption > 46.73 ), Total_LAM_Customers AS ( SELECT COUNT(CustomerID) AS TotalCount FROM LAM_Customers ) SELECT (CAST(CA.CountAboveThreshold AS REAL) / CAST(TC.TotalCount AS REAL)) * 100 AS PercentageGreaterThan46_73 FROM Consumption_Above_Threshold CA, Total_LAM_Customers TC
SELECT Country, COUNT(DISTINCT GasStationID) AS TotalValueForMoneyGasStations FROM gasstations GROUP BY Country;
SELECT CustomerID FROM customers WHERE Segment = 'KAM' ), KAM_Euro_Customers AS ( SELECT CustomerID FROM KAM_Customers JOIN customers ON KAM_Customers.CustomerID = customers.CustomerID WHERE Currency = 'EUR' ) SELECT (COUNT(KAM_Euro_Customers.CustomerID) * 100.0 / COUNT(KAM_Customers.CustomerID)) AS PercentageKAMEuros FROM KAM_Customers LEFT JOIN KAM_Euro_Customers ON KAM_Customers.CustomerID = KAM_Euro_Customers.CustomerID
SELECT (COUNT(CASE WHEN Consumption > 528.3 THEN 1 END) * 100.0 / COUNT(*)) AS Percentage FROM yearmonth WHERE Date = '201202';
SELECT (COUNT(CASE WHEN Segment = 'premium' THEN 1 END) * 100.0 / COUNT(*)) AS PercentageOfPremiumGasStations FROM gasstations WHERE Country = 'Slovakia';
SELECT CustomerID, SUM(Consumption) AS TotalConsumption FROM yearmonth WHERE Date = '201309' GROUP BY CustomerID ORDER BY TotalConsumption DESC LIMIT 1;
SELECT c.Segment, SUM(ym.Consumption) AS TotalConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE ym.Date = '201309' GROUP BY c.Segment ORDER BY TotalConsumption ASC LIMIT 1;
SELECT c.CustomerID, c.Segment, ym.Consumption FROM customers c JOIN yearmonth ym ON c.CustomerID = ym.CustomerID WHERE ym.Date = '201206' AND c.Segment = 'SME' ORDER BY ym.Consumption ASC LIMIT 1;
SELECT MAX(MonthlyConsumption) AS HighestMonthlyConsumption FROM ( SELECT SUM(Consumption) AS MonthlyConsumption FROM yearmonth WHERE Date LIKE '2012%' GROUP BY substr(Date, 1, 7) -- Group by year and month (YYYY-MM) );
SELECT MAX(Consumption) AS LargestMonthlyConsumption FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Currency = 'euro';
SELECT p.Description FROM transactions_1k t JOIN products p ON t.ProductID = p.ProductID WHERE t.Date BETWEEN '2013-09-01' AND '2013-09-30';
SELECT DISTINCT g.Country FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE t.Date BETWEEN '2013-06-01' AND '2013-06-30';
SELECT DISTINCT g.ChainID FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID JOIN customers c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR';
SELECT p.Description FROM transactions_1k t JOIN products p ON t.ProductID = p.ProductID JOIN customers c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'euro';
SELECT AVG(total_price) AS average_total_price FROM ( SELECT SUM(Price) AS total_price FROM transactions_1k WHERE Date BETWEEN '2012-01-01' AND '2012-01-31' GROUP BY TransactionID );
SELECT COUNT(DISTINCT ym.CustomerID) AS EuroCustomersOver1000 FROM yearmonth ym JOIN customers c ON ym.CustomerID = c.CustomerID WHERE c.Currency = 'euro' AND ym.Consumption > 1000;
SELECT p.Description FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID JOIN products p ON t.ProductID = p.ProductID WHERE g.Country = 'CZE';
SELECT DISTINCT t.Time FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.ChainID = 11;
SELECT COUNT(*) AS NumberOfTransactions FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE' AND t.Price > 1000;
SELECT COUNT(*) AS NumberOfTransactions FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE' AND t.Date > '2012-01-01';
SELECT AVG(t.Price) AS AverageTotalPrice FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE';
SELECT AVG(TotalPrice) AS AverageTotalPrice FROM ( SELECT c.CustomerID, SUM(t.Price) AS TotalPrice FROM customers c JOIN transactions_1k t ON c.CustomerID = t.CustomerID WHERE c.Currency = 'euro' GROUP BY c.CustomerID );
SELECT c.CustomerID, SUM(t.Amount * t.Price) AS TotalPaid FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-25' GROUP BY c.CustomerID ORDER BY TotalPaid DESC LIMIT 1;
SELECT g.Country FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-25' ORDER BY t.Time LIMIT 1;
SELECT c.Currency FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-24' AND t.Time = '16:25:00';
SELECT c.Segment FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-23' AND t.Time = '21:20:00';
SELECT COUNT(*) AS TransactionCount FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE c.Currency = 'EUR' AND t.Date = '2012-08-26' AND t.Time >= '00:00:00' AND t.Time <= '12:59:59';
SELECT Segment FROM customers WHERE CustomerID = (SELECT MIN(CustomerID) FROM customers);
SELECT g.Country FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-24' AND t.Time = '12:42:00';
SELECT ProductID FROM transactions_1k WHERE Date = '2012-08-23' AND Time = '21:20:00';
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-24' AND Price = 124.05 ) -- Step 2 & 3: Sum expenses for January 2012 for the identified customer SELECT strftime('%Y-%m-%d', Date) as TransactionDate, SUM(Price) as TotalSpent FROM transactions_1k WHERE CustomerID IN (SELECT CustomerID FROM CustomerInfo) AND Date BETWEEN '2012-01-01' AND '2012-01-31' GROUP BY TransactionDate ORDER BY TransactionDate
SELECT COUNT(*) AS TransactionCount FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE' AND t.Date = '2012-08-26' AND t.Time BETWEEN '08:00:00' AND '09:00:00';
SELECT c.Currency FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Amount = 214582.17 AND strftime('%Y%m', t.Date) = '201306';
SELECT g.Country FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE t.CardID = 667467;
SELECT c.Segment -- Assuming Segment relates to nationality FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-24' AND t.Price = 548.4;
SELECT COUNT(DISTINCT c.CustomerID) AS TotalCustomers, COUNT(DISTINCT CASE WHEN c.Currency = 'EUR' THEN c.CustomerID END) AS EurCustomers FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID WHERE t.Date = '2012-08-25' ) -- Step 2: Calculate the percentage of EUR customers SELECT (EurCustomers * 100.0 / TotalCustomers) AS EurCustomerPercentage FROM CustomerCounts
SELECT CustomerID FROM transactions_1k WHERE Date = '2012-08-25' AND Price = 634.8;
SELECT g.GasStationID, SUM(t.Amount * t.Price) AS TotalRevenue FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID GROUP BY g.GasStationID ORDER BY TotalRevenue DESC LIMIT 1;
SELECT c.CustomerID, c.Segment FROM customers c JOIN transactions_1k t ON c.CustomerID = t.CustomerID JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'SVK' ) SELECT (COUNT(CASE WHEN Segment = 'premium' THEN 1 END) * 100.0) / COUNT(*) AS premium_percentage FROM CustomerCount
SELECT SUM(Price * Amount) AS TotalSpent FROM transactions_1k WHERE CustomerID = 38508
SELECT p.Description AS ProductName, SUM(t.Amount) AS TotalSales FROM transactions_1k t JOIN products p ON t.ProductID = p.ProductID GROUP BY p.ProductID ORDER BY TotalSales DESC LIMIT 5;
SELECT c.CustomerID, SUM(t.Price) AS TotalSpend, SUM(t.Amount) AS TotalAmount, c.Currency FROM transactions_1k t JOIN customers c ON t.CustomerID = c.CustomerID GROUP BY c.CustomerID ), TopCustomer AS ( SELECT CustomerID, TotalSpend, TotalAmount, Currency FROM CustomerSpending ORDER BY TotalSpend DESC LIMIT 1 ) SELECT tc.CustomerID, tc.TotalSpend, CASE WHEN tc.TotalAmount > 0 THEN (tc.TotalSpend / tc.TotalAmount) ELSE NULL END AS AveragePricePerItem, tc.Currency FROM TopCustomer tc
SELECT gs.Country FROM transactions_1k t JOIN gasstations gs ON t.GasStationID = gs.GasStationID WHERE t.ProductID = 2 ORDER BY t.Price DESC LIMIT 1;
SELECT DISTINCT CustomerID FROM transactions_1k WHERE ProductID = 5 AND (Price / Amount) > 29.00 ) -- Step 2: Get the consumption status for these Customers in August 2012 SELECT ym.CustomerID, ym.Consumption FROM yearmonth ym JOIN HighPriceCustomers hpc ON ym.CustomerID = hpc.CustomerID WHERE ym.Date = '201208'
