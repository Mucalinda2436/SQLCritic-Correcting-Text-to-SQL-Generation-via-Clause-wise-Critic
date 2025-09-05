SELECT schools.`County`, frpm.`Percent (%) Eligible Free (K-12)` FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE schools.`County` = 'Alameda' ORDER BY frpm.`Percent (%) Eligible Free (K-12)` DESC LIMIT 1
SELECT schools.`CDSCode`, schools.`School`, frpm.`Percent (%) Eligible Free (Ages 5-17)` FROM schools JOIN frpm ON schools.`CDSCode` = frpm.`CDSCode` WHERE schools.`StatusType` = 'Continuation' ORDER BY frpm.`Percent (%) Eligible Free (Ages 5-17)` LIMIT 3
SELECT schools.Zip FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE frpm.`Charter School (Y/N)` = 1 AND schools.County = 'Fresno County Office of Education'
SELECT Schools.City, Schools.Street, Schools.Zip FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode ORDER BY frpm.`FRPM Count (K-12)` DESC LIMIT 1
SELECT schools.Phone FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE schools.OpenDate > '2000-01-01' AND frpm.`Charter Funding Type` = 'Charter School' AND frpm.`Charter School (Y/N)` = 1
SELECT COUNT(*) FROM satscores INNER JOIN schools ON satscores.cds = schools.CDSCode WHERE AvgScrMath < 400 AND Virtual = 'F'
SELECT s.School FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE ss.NumTstTakr > 500 AND s.Magnet = 1
SELECT schools.Phone FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.NumGE1500 = (SELECT MAX(NumGE1500) FROM satscores) AND satscores.NumTstTakr = (SELECT MAX(NumTstTakr) FROM satscores WHERE NumGE1500 = (SELECT MAX(NumGE1500) FROM satscores))
SELECT satscores.NumTstTakr FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode JOIN satscores ON schools.CDSCode = satscores.cds ORDER BY frpm.`FRPM Count (K-12)` DESC LIMIT 1
SELECT COUNT(schools.CDSCode) FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE satscores.AvgScrMath > 560 AND schools.FundingType = 'Charter'
SELECT frpm.`FRPM Count (Ages 5-17)` FROM frpm JOIN satscores ON frpm.CDSCode = satscores.cds WHERE satscores.AvgScrRead = (SELECT MAX(AvgScrRead) FROM satscores) LIMIT 1
SELECT schools.CDSCode FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE frpm.`Enrollment (K-12)` + frpm.`Enrollment (Ages 5-17)` > 500
SELECT MAX(`Percent (%) Eligible Free (Ages 5-17)`) FROM frpm WHERE CDSCode IN (SELECT cds FROM satscores WHERE NumTstTakr > 0 AND (CAST(NumGE1500 AS REAL) / NumTstTakr) > 0.3)
SELECT schools.Phone FROM satscores JOIN schools ON satscores.cds = schools.CDSCode ORDER BY CAST(satscores.NumGE1500 AS FLOAT) / satscores.NumTstTakr DESC LIMIT 3
SELECT s.School, s.NCESSchool, fr.Enrollment(Ages 5-17) FROM schools s JOIN frpm fr ON s.CDSCode = fr.CDSCode ORDER BY fr.Enrollment(Ages 5-17) DESC LIMIT 5
SELECT DISTINCT frpm.`District Name`, satscores.AvgScrRead FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode JOIN satscores ON schools.CDSCode = satscores.cds WHERE schools.StatusType = 'Active' ORDER BY satscores.AvgScrRead DESC LIMIT 1
SELECT COUNT(*) FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.County = 'Alameda' AND ss.NumTstTakr < 100
SELECT schools.CharterNum FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.AvgScrWrite = 499
SELECT COUNT(*) FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode JOIN satscores ON frpm.CDSCode = satscores.cds WHERE frpm.`County Name` = 'Contra Costa' AND frpm.`Charter Funding Type` = 'Directly funded' AND satscores.NumTstTakr <= 250
SELECT schools.Phone FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.AvgScrMath = (SELECT MAX(AvgScrMath) FROM satscores)
SELECT COUNT(*) FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE `County Name` = 'Amador' AND `Low Grade` = '9' AND `High Grade` = '12'
SELECT schools.`School` FROM schools JOIN frpm ON schools.`CDSCode` = frpm.`CDSCode` WHERE schools.`County` = 'Los Angeles' AND frpm.`Free Meal Count (K-12)` > 500 AND frpm.`Free Meal Count (K-12)` < 700
SELECT satscores.sname, satscores.NumTstTakr FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE schools.County = 'Contra Costa' ORDER BY satscores.NumTstTakr DESC LIMIT 1
SELECT frpm.`School Name`, schools.Street FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE ABS(frpm.`Enrollment (K-12)` - frpm.`Enrollment (Ages 5-17)`) > 30
SELECT satscores.sname FROM satscores JOIN schools ON satscores.cds = schools.CDSCode JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE frpm.`Percent (%) Eligible Free (K-12)` > 0.1 AND satscores.NumGE1500 >= 1
SELECT s.School, s.FundingType FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE s.County = 'Riverside' AND ss.AvgScrMath > 400
SELECT satscores.sname, schools.Street || ', ' || schools.City || ', ' || schools.State || ' ' || schools.Zip AS Full_Address FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.enroll12 = 12 AND satscores.NumGE1500 > 800 AND schools.County = 'Monterey' AND schools.GSoffered = '12'
SELECT satscores.sname, satscores.AvgScrWrite, schools.Phone FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE (schools.OpenDate > '1991-01-01' OR schools.ClosedDate < '2000-12-31') AND satscores.AvgScrWrite IS NOT NULL
SELECT s.School, s.DOCType, (fr.Enrollment - fr.`Enrollment (Ages 5-17)`) AS EnrollmentDifference FROM frpm fr JOIN schools s ON fr.CDSCode = s.CDSCode WHERE fr.`Charter Funding Type` = 'Locally Funded' AND (fr.Enrollment - fr.`Enrollment (Ages 5-17)`) > (SELECT AVG(fr.Enrollment - fr.`Enrollment (Ages 5-17)`) FROM frpm fr WHERE fr.`Charter Funding Type` = 'Locally Funded')
SELECT schools.OpenDate FROM schools WHERE schools.StatusType = "active" ORDER BY schools.Enroll12 DESC LIMIT 1
SELECT schools.City FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE frpm.`Enrollment (K-12)` IS NOT NULL ORDER BY frpm.`Enrollment (K-12)` ASC LIMIT 5
SELECT (FRPM.`Free Meal Count (K-12)` / FRPM.`Enrollment (K-12)`) as 'Eligible Free Rate', s.School FROM frpm FRPM JOIN schools S ON FRPM.CDSCode = S.CDSCode WHERE S.`Charter School (Y/N)` = 0 ORDER BY FRPM.`Enrollment (K-12)` DESC LIMIT 11, 2
SELECT s.School, (f.FRPM Count (K-12) / f.Enrollment (K-12)) as Eligible_Free_Reduced_Price_Meal_Rate FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.CharterNum = '66' AND s.StatusType = '1-12' ORDER BY f.FRPM Count (K-12) DESC LIMIT 5
SELECT schools."School", schools."Website" FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE frpm."Free Meal Count (Ages 5-17)" >= 1900 AND frpm."Free Meal Count (Ages 5-17)" <= 2000
SELECT `Free Meal Count (Ages 5-17)` / `Enrollment (Ages 5-17)` FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.School = 'Kacey Gibson'
SELECT schools.AdmEmail1 FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE frpm.`Charter School (Y/N)` = 1 ORDER BY frpm.`Enrollment (K-12)` ASC LIMIT 1
SELECT s.AdmFName1 || ' ' || s.AdmLName1 AS AdminName FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE ss.NumGE1500 = (SELECT MAX(NumGE1500) FROM satscores) LIMIT 1
SELECT schools.Street, schools.City, schools.Zip, schools.State FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE satscores.NumTstTakr > 0 ORDER BY CAST(satscores.NumGE1500 AS REAL) / CAST(satscores.NumTstTakr AS REAL) LIMIT 1
SELECT schools.Website FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE schools.County = 'Los Angeles' AND satscores.NumTstTakr BETWEEN 2000 AND 3000
SELECT AVG(NumTstTakr) FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE schools.County = "Fresno" AND schools.OpenDate BETWEEN '1980-01-01' AND '1980-12-31'
SELECT schools.Phone FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE schools.District = 'Fresno Unified' ORDER BY satscores.AvgScrRead LIMIT 1
SELECT s.sname, s.AvgScrRead FROM satscores s JOIN schools sc ON s.cds = sc.CDSCode WHERE sc.Virtual = 'F' ORDER BY s.AvgScrRead DESC LIMIT 5
SELECT frpm.`School Type` FROM frpm JOIN satscores ON frpm.CDSCode = satscores.cds WHERE satscores.AvgScrMath = (SELECT MAX(AvgScrMath) FROM satscores)
SELECT satscores.cds, schools.County, satscores.AvgScrMath FROM satscores JOIN schools ON satscores.cds = schools.CDSCode ORDER BY (satscores.AvgScrMath + satscores.AvgScrRead + satscores.AvgScrWrite) ASC LIMIT 1
SELECT AVG(AvgScrWrite) AS AverageWritingScore, City FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE satscores.NumTstTakr = (SELECT MAX(NumTstTakr) FROM satscores WHERE NumGE1500 > 0) AND satscores.NumGE1500 >= 1500
SELECT schools.School, satscores.AvgScrWrite FROM schools JOIN satscores ON schools.CDSCode = satscores.cds WHERE AdmFName1 = 'Ricci' AND AdmLName1 = 'Ulrich'
SELECT s.School, sum(fr.Enrollment) FROM schools s JOIN frpm fr ON s.CDSCode = fr.CDSCode WHERE s.DOC = '31' AND s.GSoffered LIKE '%1-12%' GROUP BY s.School ORDER BY sum(fr.Enrollment) DESC LIMIT 1
SELECT COUNT(*) / 12 FROM schools WHERE County = 'Alameda' AND DOC = 52 AND OpenDate LIKE '1980%'
SELECT COUNT(s.District) FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE f.`County Name` = 'Orange County' AND s.DOC = 54 UNION SELECT COUNT(s.District) FROM schools s JOIN frpm f ON s.CDSCode = f.CDSCode WHERE f.`County Name` = 'Orange County' AND s.DOC = 52
SELECT schools.County, schools.School, schools.ClosedDate FROM schools WHERE schools.StatusType = 'Closed' GROUP BY schools.County ORDER BY COUNT(schools.School) DESC LIMIT 1
SELECT s.Street, s.School FROM schools s JOIN satscores ss ON s.CDSCode = ss.cds WHERE ss.AvgScrMath IS NOT NULL ORDER BY ss.AvgScrMath DESC LIMIT 5, 1
SELECT schools.MailStreet, schools.School FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.AvgScrRead = (SELECT MIN(AvgScrRead) FROM satscores)
SELECT COUNT(*) FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE (satscores.AvgScrRead + satscores.AvgScrMath + satscores.AvgScrWrite) >= 1500 AND schools.MailCity = 'Lakeport'
SELECT SUM(NumTstTakr) FROM satscores WHERE cds IN (SELECT CDSCode FROM schools WHERE MailCity = 'Fresno')
SELECT schools.School, schools.MailZip FROM schools WHERE schools.AdmFName1 = 'Avetik' AND schools.AdmLName1 = 'Atoian' OR schools.AdmFName2 = 'Avetik' AND schools.AdmLName2 = 'Atoian' OR schools.AdmFName3 = 'Avetik' AND schools.AdmLName3 = 'Atoian'
SELECT COUNT(*) AS Colusa_schools, (SELECT COUNT(*) FROM schools WHERE County = 'Humboldt' AND MailState = 'CA') AS Humboldt_schools, (SELECT CAST(Colusa_schools AS FLOAT) / CAST(Humboldt_schools AS FLOAT)) AS Ratio FROM schools WHERE County = 'Colusa' AND MailState = 'CA'
SELECT COUNT(*) FROM schools WHERE MailState = 'CA' AND County = 'San Joaquin' AND StatusType = 'Active'
SELECT phone, ext FROM schools WHERE CDSCode = (SELECT cds FROM satscores ORDER BY AvgScrWrite DESC LIMIT 1 OFFSET 332)
SELECT schools.School, schools.Phone, schools.Ext FROM schools WHERE schools.Zip = '95203-3704'
SELECT Website FROM schools WHERE AdmFName1 = 'Mike' AND AdmLName1 = 'Larson'
SELECT s.Website FROM schools s WHERE s.Virtual = 'P' AND s.Charter = 1 AND s.County = 'San Joaquin'
SELECT count(*) FROM schools WHERE Charter = 1 AND City = 'Hickman' AND DOC = 52
SELECT COUNT(s.CDSCode) FROM frpm f JOIN schools s ON f.CDSCode = s.CDSCode WHERE s.County = 'Los Angeles' AND f.`School Type` = 'NON-CHARTER' AND (f.`Free Meal Count (K-12)` * 100 / f.`Enrollment (K-12)`) < 0.18
SELECT schools.School, schools.City, schools.AdmFName1 || ' ' || schools.AdmLName1 AS Administrator1, schools.AdmFName2 || ' ' || schools.AdmLName2 AS Administrator2, schools.AdmFName3 || ' ' || schools.AdmLName3 AS Administrator3 FROM schools INNER JOIN satscores ON schools.CDSCode = satscores.cds WHERE schools.Charter = 1 AND schools.CharterNum = '00D2'
SELECT COUNT(*) FROM schools WHERE MailCity = 'Hickman' AND CharterNum = '00D4'
SELECT COUNT(CDSCode) * 100.0 / (SELECT COUNT(CDSCode) FROM schools WHERE County = 'Santa Clara' AND FundingType = 'Locally Funded') AS LocalFundedRatio FROM schools WHERE County = 'Santa Clara' AND FundingType != 'Locally Funded'
SELECT COUNT(*) FROM schools WHERE OpenDate BETWEEN '2000-01-01' AND '2005-12-31' AND County = 'Stanislaus' AND FundingType = 'Directly Funded'
SELECT SUM(CASE WHEN schools.City = 'San Francisco' AND schools.ClosedDate LIKE '%1989%' THEN 1 ELSE 0 END) as Total_Closure FROM schools WHERE schools.StatusType = 'Closed - No Longer Operational'
SELECT schools.County, COUNT(schools.ClosedDate) AS NumSchoolClosures FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE schools.ClosedDate BETWEEN '1980-01-01' AND '1989-12-31' AND frpm.SOC = '11' GROUP BY schools.County ORDER BY NumSchoolClosures DESC LIMIT 1
SELECT schools.NCESDist FROM schools WHERE schools.SOC = '31'
SELECT COUNT(*) FROM schools WHERE County = 'Alpine' AND StatusType IN ('Active', 'Closed') AND School = 'District Community Day'
SELECT frpm.`District Code` FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.City = 'Fresno' AND schools.Magnet = 0
SELECT SUM(`Enrollment (Ages 5-17)`) FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.EdOpsCode = 'SSS' AND frpm.`Academic Year` = '2014-2015' AND frpm.`School Name` = 'State Special School' AND schools.City = 'Fremont'
SELECT frpm.`Free Meal Count (Ages 5-17)` FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.MailStreet = 'PO Box 1040' AND schools.School = 'Youth Authority School'
SELECT frpm.`Low Grade` FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.NCESDist = '613360' AND schools.EdOpsCode = 'SPECON'
SELECT s.School Name, s.`District Name`, s.`County Name`, s.`Charter School (Y/N)`, frpm.`Educational Option Type` FROM schools s INNER JOIN frpm ON s.CDSCode = frpm.CDSCode WHERE frpm.`NSLP Provision Status` = 'Breakfast Provision 2' AND frpm.`County Code` = '37'
SELECT schools.City FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE frpm.`Educational Option Type` = 'HS' AND frpm.`NSLP Provision Status` = '2' AND frpm.`Low Grade` = '9' AND frpm.`High Grade` = '12' AND schools.County = 'Merced'
SELECT s.School, s.District, s.County, frpm.`Percent (%) Eligible FRPM (Ages 5-17)` FROM schools s JOIN frpm ON s.CDSCode = frpm.CDSCode WHERE s.GSserved LIKE "%K-9%" AND s.County = "Los Angeles"
SELECT schools.`City`, schools.`GSserved`, COUNT(schools.`GSserved`) as Frequency FROM schools WHERE schools.`City` = 'Adelanto' GROUP BY schools.`GSserved` ORDER BY Frequency DESC LIMIT 1
SELECT County, COUNT(*) as num_virtual_schools FROM schools WHERE Virtual = 'F' AND County IN ('San Diego', 'Santa Barbara') GROUP BY County ORDER BY num_virtual_schools DESC LIMIT 1
SELECT s.School, s.Latitude, s.SchoolType FROM schools s WHERE s.Latitude = (SELECT MAX(Latitude) FROM schools)
SELECT schools.City, schools.School, schools.`Low Grade`, schools.Latitude FROM schools WHERE schools.State = 'CA' ORDER BY schools.Latitude LIMIT 1
SELECT schools.`High Grade` FROM schools WHERE schools.Longitude = (SELECT MAX(schools.Longitude) FROM schools)
SELECT schools.School, frpm.`Educational Option Type` FROM schools JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE schools.GSserved = 'K-8' AND schools.Magnet = 1 AND frpm.`Educational Option Type` = 'Multiple Provision Types'
SELECT AdmFName1, District FROM schools WHERE AdmFName1 != '' UNION ALL SELECT AdmFName2, District FROM schools WHERE AdmFName2 != '' UNION ALL SELECT AdmFName3, District FROM schools WHERE AdmFName3 != '' GROUP BY AdmFName1 ORDER BY COUNT(*) DESC LIMIT 2
SELECT schools.`District Code`, (frpm.`Free Meal Count (K-12)` / frpm.`Enrollment (K-12)`) * 100 as `Percent (%) Eligible Free (K-12)` FROM frpm JOIN schools ON frpm.CDSCode = schools.CDSCode WHERE schools.AdmFName1 = 'Alusine'
SELECT schools.`AdmLName1`, schools.District, schools.County, schools.School FROM schools WHERE schools.CharterNum = '40'
SELECT schools.AdmEmail1 FROM schools INNER JOIN frpm ON schools.CDSCode = frpm.CDSCode WHERE schools.County = 'San Bernardino' AND schools.District = 'San Bernardino City Unified' AND schools.OpenDate BETWEEN '1/1/2009' AND '12/31/2010' AND (schools.DOCType = 'Intermediate/Middle Schools' OR schools.DOC = 54)
SELECT satscores.sname, schools.AdmEmail1 FROM satscores JOIN schools ON satscores.cds = schools.CDSCode WHERE satscores.NumGE1500 = (SELECT MAX(NumGE1500) FROM satscores)
SELECT COUNT(account.account_id) FROM account JOIN district ON account.district_id = district.district_id WHERE district.A3 = 'East Bohemia' AND account.frequency = 'POPLATEK PO OBRATU'
SELECT COUNT(*) FROM account JOIN district ON account.district_id = district.district_id WHERE district.A3 = 'Prague'
SELECT AVG(A12) AS avg_unemployment_1995, AVG(A13) AS avg_unemployment_1996 FROM district
SELECT COUNT(*) FROM district WHERE A11 > 6000 AND A11 < 10000 AND district_id IN (SELECT district_id FROM client WHERE gender = 'F')
SELECT COUNT(*) FROM client c JOIN district d ON c.district_id = d.district_id WHERE c.gender = 'M' AND d.A3 = 'North Bohemia' AND d.A11 > 8000
SELECT account.account_id FROM account JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' ORDER BY client.birth_date ASC, district.A11 ASC LIMIT 1
SELECT account.account_id FROM account JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON client.district_id = district.district_id WHERE client.birth_date = (SELECT MIN(birth_date) FROM client) AND district.A11 = (SELECT MAX(A11) FROM district)
SELECT COUNT(*) FROM disp JOIN card ON disp.disp_id = card.disp_id JOIN account ON disp.account_id = account.account_id WHERE account.frequency = 'POPLATEK TYDNE' AND disp.type = 'OWNER'
SELECT client.client_id, client.gender, client.birth_date FROM client JOIN disp ON client.client_id = disp.client_id JOIN card ON disp.disp_id = card.disp_id WHERE card.type = 'DISPONENT' AND account.frequency = 'POPLATEK PO OBRATU'
SELECT account_id, frequency FROM account WHERE account_id IN ( SELECT account_id FROM loan WHERE date LIKE '1997%' AND status = 'A' ORDER BY amount ASC LIMIT 1 ) AND frequency = 'POPLATEK TYDNE'
SELECT account_id, MAX(amount) as max_approved_amount FROM loan JOIN account ON loan.account_id = account.account_id WHERE duration > 12 AND date LIKE '1993%' GROUP BY account_id ORDER BY max_approved_amount DESC LIMIT 1
SELECT COUNT(*) FROM account JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON account.district_id = district.district_id WHERE client.gender = 'F' AND client.birth_date < '1950-01-01' AND district.A2 = 'Slokolov'
SELECT account_id, date FROM account WHERE date = (SELECT MIN(date) FROM account WHERE strftime('%Y', date) = '1995')
SELECT account_id FROM account WHERE date < '1997-01-01' AND account_id IN (SELECT account_id FROM trans WHERE amount > 3000) ORDER BY account_id
SELECT client_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN card ON disp.disp_id = card.disp_id WHERE card.issued = '1994-03-03'
SELECT date FROM trans WHERE amount = 840 AND date = '1998-10-14'
SELECT district_id FROM account WHERE account_id = ( SELECT account_id FROM loan WHERE date = '1994-08-25' )
SELECT MAX(amount) as max_amount FROM trans JOIN account ON trans.account_id = account.account_id JOIN disp ON account.account_id = disp.account_id JOIN card ON disp.disp_id = card.disp_id WHERE card.issued = '1996-10-21'
SELECT client.gender FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE client.birth_date = (SELECT MIN(birth_date) FROM client) AND district.A11 = (SELECT MAX(A11) FROM district)
SELECT trans.amount FROM (SELECT MAX(loan.amount) as max_loan FROM loan) as max_loan_amount JOIN loan ON loan.amount = max_loan_amount.max_loan JOIN account ON account.account_id = loan.account_id JOIN disp ON disp.account_id = account.account_id JOIN trans ON trans.account_id = account.account_id LIMIT 1
SELECT COUNT(*) FROM client JOIN district ON client.district_id = district.district_id WHERE district.A2 = 'Jesenik' AND client.gender = 'Woman'
SELECT disp_id FROM trans WHERE amount = 5100 AND date = '1998-09-02'
SELECT COUNT(account_id) FROM account JOIN district ON account.district_id = district.district_id WHERE district.A2 = 'Litomerice' AND strftime('%Y', account.date) = '1996'
SELECT A2 FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id WHERE client.gender = 'F' AND client.birth_date = '1976-01-29'
SELECT client.birth_date FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN loan ON account.account_id = loan.account_id WHERE loan.amount = 98832 AND loan.date = '1996-01-03'
SELECT disp.account_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN district ON client.district_id = district.district_id WHERE district.A3 = 'Prague' LIMIT 1
SELECT ROUND((COUNT(CASE WHEN c.gender = 'M' THEN c.client_id END) * 1.0 / COUNT(c.client_id)) * 100, 2) AS percentage_male_clients FROM client c JOIN district d ON c.district_id = d.district_id WHERE d.A3 = 'south Bohemia' AND d.A4 = (SELECT MAX(A4) FROM district WHERE A3 = 'south Bohemia')
SELECT ((b.balance - a.balance) / a.balance) * 100 AS increase_rate FROM ( SELECT trans.account_id, trans.balance FROM trans JOIN loan ON loan.account_id = trans.account_id WHERE loan.date = '1993-07-05' ) a JOIN ( SELECT trans.account_id, trans.balance FROM trans JOIN loan ON loan.account_id = trans.account_id WHERE loan.date = '1998-12-27' ) b ON a.account_id = b.account_id WHERE trans.date = '1993-03-22'
SELECT (CAST(SUM(amount) AS REAL) / (SELECT SUM(amount) FROM loan WHERE status = 'A')) * 100 FROM loan WHERE status = 'A'
SELECT (account_id, status) FROM loan WHERE amount < 100000 AND status = 'C'
SELECT account.account_id, district.A2, district.A3 FROM account INNER JOIN district ON account.district_id = district.district_id WHERE account.date >= '1993-01-01' AND account.frequency = 'POPLATEK PO OBRATU'
SELECT disp.client_id, disp.account_id, account.frequency FROM disp JOIN account ON disp.account_id = account.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON client.district_id = district.district_id WHERE district.A2 = 'east Bohemia' AND account.date BETWEEN '1995-01-01' AND '2000-12-31'
SELECT account_id, date FROM account JOIN district ON account.district_id = district.district_id WHERE district.A2 = 'Prachatice'
SELECT d.A2 as district, d.A3 as region FROM loan l JOIN account a ON l.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE l.loan_id = 4990
SELECT a.account_id, d.A2 as district, d.A3 as region FROM account a JOIN loan l ON a.account_id = l.account_id JOIN district d ON a.district_id = d.district_id WHERE l.amount > 300000
SELECT loan.loan_id, district.A3, district.A11 FROM loan JOIN account ON loan.account_id = account.account_id JOIN client ON account.district_id = client.district_id JOIN district ON client.district_id = district.district_id WHERE loan.duration = 60
SELECT d.A2 AS district, ((d.A13 - d.A12) / d.A12) * 100 AS unemployment_rate_increment FROM district d JOIN account a ON d.district_id = a.district_id JOIN loan l ON a.account_id = l.account_id WHERE l.status = 'D'
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM account WHERE strftime('%Y', date) = '1993') FROM account INNER JOIN district ON account.district_id = district.district_id WHERE district.A2 = 'Decin' AND strftime('%Y', account.date) = '1993'
SELECT account_id FROM account WHERE frequency = 'POPLATEK MESICNE'
SELECT d.A2 AS district_name, COUNT(c.client_id) AS female_account_holders FROM client c JOIN disp d ON c.client_id = d.client_id WHERE c.gender = 'F' GROUP BY d.district_id ORDER BY female_account_holders DESC LIMIT 10
SELECT d.A2 AS district_name, SUM(t.amount) AS total_withdrawal FROM trans t JOIN account a ON t.account_id = a.account_id JOIN district d ON a.district_id = d.district_id WHERE t.type = 'VYDAJ' AND t.date LIKE '1996-01%' GROUP BY d.A2 ORDER BY total_withdrawal DESC LIMIT 10
SELECT COUNT(account.account_id) FROM account JOIN disp ON disp.account_id = account.account_id JOIN client ON disp.client_id = client.client_id JOIN district ON client.district_id = district.district_id WHERE district.A3 = 'South Bohemia' AND disp_id NOT IN (SELECT disp_id FROM card)
SELECT A3 AS district_name, COUNT(*) AS active_loans FROM district JOIN account ON district.district_id = account.district_id JOIN loan ON account.account_id = loan.account_id WHERE loan.status = 'C' GROUP BY district.district_id ORDER BY active_loans DESC LIMIT 1
SELECT AVG(loan.amount) FROM loan JOIN account ON loan.account_id = account.account_id JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id WHERE client.gender = 'M'
SELECT DISTINCT A2 as district_name, A5 as branch_location FROM district WHERE A13 = (SELECT MAX(A13) FROM district) ORDER BY A2
SELECT district_id, count(account_id) as num_accounts FROM account WHERE district_id = (SELECT district_id FROM district WHERE A16 = (SELECT max(A16) FROM district)) GROUP BY district_id
SELECT COUNT(DISTINCT a.account_id) FROM account a JOIN disp d ON a.account_id = d.account_id JOIN card c ON d.disp_id = c.disp_id JOIN trans t ON a.account_id = t.account_id WHERE t.type = 'VYBER KARTOU' AND a.frequency = 'POPLATEK MESICNE' AND t.balance < 0
SELECT COUNT(loan_id) AS approved_loans FROM loan JOIN account ON loan.account_id = account.account_id WHERE date BETWEEN '1995-01-01' AND '1997-12-31' AND amount >= 250000 AND frequency = 'POPLATEK MESICNE' AND status = 'approved'
SELECT COUNT(account_id) FROM account WHERE district_id = 1
SELECT COUNT(client.client_id) FROM client JOIN district ON client.district_id = district.district_id WHERE district.A16 = (SELECT MAX(A16) FROM district WHERE district.A16 NOT IN (SELECT MAX(A16) FROM district)) AND client.gender = 'M'
SELECT COUNT(*) FROM card INNER JOIN disp ON card.card_id = disp.disp_id WHERE type = 'gold' AND disp.type = 'disponent'
SELECT COUNT(*) FROM account WHERE district_id IN (SELECT district_id FROM district WHERE A2 = 'Pisek')
SELECT district.A2 FROM district JOIN account ON account.district_id = district.district_id JOIN trans ON trans.account_id = account.account_id WHERE trans.amount > 10000 AND trans.date >= '1997-01-01' AND trans.date <= '1997-12-31'
SELECT account.account_id FROM account JOIN trans ON account.account_id = trans.account_id JOIN "order" ON account.account_id = "order".account_id WHERE trans.k_symbol = 'SIPO' AND "order".bank_to = 'Pisek'
SELECT account.account_id FROM account JOIN disp ON disp.account_id = account.account_id JOIN client ON client.client_id = disp.client_id JOIN card ON card.disp_id = disp.disp_id WHERE card.type = 'gold' AND client.client_id IN (SELECT client_id FROM disp JOIN card ON card.disp_id = disp.disp_id WHERE card.type = 'junior')
SELECT AVG(amount) FROM trans WHERE account_id IN (SELECT account_id FROM card WHERE type = 'credit' AND issued >= '2021-01-01' AND issued < '2022-01-01') AND type = 'credit card withdrawn'
SELECT disp.client_id FROM disp JOIN account ON disp.account_id = account.account_id JOIN trans ON account.account_id = trans.account_id JOIN card ON disp.disp_id = card.disp_id WHERE trans.date >= '1998-01-01' AND trans.date < '1999-01-01' AND trans.type = 'VYBER KARTOU' GROUP BY disp.client_id HAVING SUM(trans.amount) / 12 < (SELECT AVG(trans.amount) FROM trans WHERE trans.type = 'VYBER KARTOU' AND trans.date >= '1998-01-01' AND trans.date < '1999-01-01')
SELECT client.client_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN card ON disp.disp_id = card.disp_id JOIN loan ON account.account_id = loan.account_id WHERE client.gender = 'F'
SELECT COUNT(*) FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN district ON client.district_id = district.district_id WHERE client.gender = 'F' AND district.A3 = 'south Bohemia'
SELECT account_id FROM account JOIN district ON account.district_id = district.district_id JOIN disp ON account.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id WHERE district.A2 = 'Tabor' AND disp.type = 'OWNER'
SELECT DISTINCT disp.type FROM disp JOIN client ON disp.client_id = client.client_id JOIN account ON disp.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE account.frequency = 'OWNER' AND district.A11 > 8000 AND district.A11 <= 9000
SELECT COUNT(DISTINCT account_id) FROM account JOIN district ON account.district_id = district.district_id JOIN trans ON account.account_id = trans.account_id WHERE district.A3 = 'North Bohemia' AND trans.bank = 'AB'
SELECT DISTINCT A2 FROM trans JOIN account ON trans.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE type = 'VYDAJ'
SELECT AVG(district.A15) FROM district JOIN account ON district.district_id = account.district_id WHERE district.A15 > 4000 AND strftime('%Y', account.date) >= '1997'
SELECT COUNT(*) FROM card INNER JOIN disp ON card.disp_id = disp.disp_id WHERE disp.type = 'OWNER' AND card.type = 'Classic'
SELECT COUNT(client_id) FROM client WHERE district_id = (SELECT district_id FROM district WHERE A2 = 'Hl.m. Praha') AND gender = 'M'
SELECT (COUNT(*) * 100.0) / (SELECT COUNT(*) FROM card) FROM card WHERE type = 'gold' AND issued < '1998-01-01'
SELECT c.client_id, c.gender, c.birth_date FROM client c JOIN disp d ON c.client_id = d.client_id JOIN loan l ON d.account_id = l.account_id WHERE l.amount = (SELECT MAX(amount) FROM loan)
SELECT d.A15 FROM account a JOIN district d ON a.district_id = d.district_id WHERE a.account_id = 532
SELECT district_id FROM account JOIN `order` ON account.account_id = `order`.account_id WHERE `order`.order_id = 33333
SELECT trans_id, date, amount FROM trans WHERE account_id = (SELECT account_id FROM disp WHERE client_id = 3356) AND type = 'VYBER'
SELECT count(*) FROM account JOIN loan ON account.account_id = loan.account_id WHERE account.frequency = 'POPLATEK TYDNE' AND loan.amount < 200000
SELECT card.type FROM card JOIN disp ON disp.disp_id = card.disp_id WHERE disp.client_id = 13539
SELECT district.A3 FROM client JOIN district ON client.district_id = district.district_id WHERE client.client_id = 3541
SELECT d.A2 AS district_name, COUNT(l.account_id) AS total_accounts FROM district d JOIN client c ON d.district_id = c.district_id JOIN disp dp ON c.client_id = dp.client_id JOIN account a ON dp.account_id = a.account_id JOIN loan l ON a.account_id = l.account_id WHERE l.status = 'A' GROUP BY d.A2 ORDER BY total_accounts DESC LIMIT 1
SELECT client.client_id, client.gender, client.birth_date FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN `order` ON account.account_id = `order`.account_id WHERE `order`.order_id = 32423
SELECT trans.* FROM trans JOIN account ON trans.account_id = account.account_id JOIN district ON account.district_id = district.district_id WHERE district.A5 = '5'
SELECT COUNT(*) FROM account JOIN district ON account.district_id = district.district_id WHERE A2 = 'Jesenik'
SELECT client_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN card ON disp.disp_id = card.disp_id WHERE card.type = 'junior' AND card.issued >= '1997-01-01'
SELECT ROUND((COUNT(c.client_id) * 100.0) / (SELECT COUNT(*) FROM client c JOIN district d ON c.district_id = d.district_id WHERE d.A11 > 10000 AND c.gender = 'F'), 2) as percentage_female FROM client c JOIN district d ON c.district_id = d.district_id WHERE d.A11 > 10000
SELECT ((SELECT SUM(l1.amount) FROM loan l1 JOIN account a ON l1.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.gender = 'M' AND strftime('%Y', l1.date) = '1997') - (SELECT SUM(l2.amount) FROM loan l2 JOIN account a ON l2.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.gender = 'M' AND strftime('%Y', l2.date) = '1996')) / (SELECT SUM(l3.amount) FROM loan l3 JOIN account a ON l3.account_id = a.account_id JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.gender = 'M' AND strftime('%Y', l3.date) = '1996') * 100 as Growth_Rate
SELECT COUNT(*) FROM trans WHERE operation = 'VYBER KARTOU' AND date > '1995-01-01'
SELECT (A16) AS North_Bohemia_Crimes, (SELECT A16 FROM district WHERE A3 = 'East Bohemia') AS East_Bohemia_Crimes, (SELECT A16 FROM district WHERE A3 = 'North Bohemia') - (SELECT A16 FROM district WHERE A3 = 'East Bohemia') AS Difference_in_Crimes FROM district
SELECT COUNT(DISTINCT(dis.owner_id, dis.disp_id)) FROM disp dis JOIN account acc ON acc.account_id = dis.account_id WHERE acc.account_id BETWEEN 1 AND 10
SELECT frequency FROM account WHERE account_id = 3
SELECT client.birth_date FROM account INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE client.client_id = 130
SELECT COUNT(*) FROM disp JOIN account ON disp.account_id = account.account_id WHERE disp.type = 'OWNER' AND account.frequency = 'POPLATEK PO OBRATU'
SELECT SUM(amount) as total_debt, SUM(payments) as total_payments FROM loan INNER JOIN account ON loan.account_id = account.account_id INNER JOIN disp ON account.account_id = disp.account_id INNER JOIN client ON disp.client_id = client.client_id WHERE client.client_id = 992
SELECT SUM(balance) AS account_balance, client.gender FROM trans JOIN disp ON trans.account_id = disp.account_id JOIN client ON disp.client_id = client.client_id WHERE disp.client_id = 4 AND trans.trans_id <= 851
SELECT card.type FROM card JOIN disp ON card.disp_id = disp.disp_id WHERE disp.client_id = 9
SELECT SUM(trans.amount) FROM client JOIN disp ON disp.client_id = client.client_id JOIN account ON account.account_id = disp.account_id JOIN trans ON trans.account_id = account.account_id WHERE client.client_id = 617 AND trans.date >= '1998-01-01' AND trans.date < '1999-01-01'
SELECT client.client_id FROM client JOIN district ON client.district_id = district.district_id WHERE client.birth_date BETWEEN '1983-01-01' AND '1987-12-31' AND district.A6 = 'East Bohemia'
SELECT client.client_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN loan ON account.account_id = loan.account_id WHERE client.gender = 'F' ORDER BY loan.amount DESC LIMIT 3
SELECT COUNT(client.client_id) FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id JOIN trans ON account.account_id = trans.account_id WHERE client.gender = 'M' AND client.birth_date BETWEEN '1974-01-01' AND '1976-12-31' AND trans.amount > 4000 AND trans.k_symbol = 'SIPO'
SELECT COUNT(*) FROM account JOIN district ON account.district_id = district.district_id WHERE district.A2 = 'Beroun' AND account.date > '1996-01-01'
SELECT COUNT(DISTINCT c.client_id) FROM client c JOIN disp d ON c.client_id = d.client_id JOIN card cd ON d.disp_id = cd.disp_id WHERE c.gender = 'F' AND cd.type = 'junior'
SELECT ROUND((COUNT(DISTINCT cl.client_id) * 100.0 / (SELECT COUNT(DISTINCT cl.client_id) FROM client cl JOIN disp d ON cl.client_id = d.client_id JOIN account ac ON d.account_id = ac.account_id JOIN district dt ON cl.district_id = dt.district_id WHERE dt.A3 LIKE '%Prague%' )) FROM client cl JOIN disp d ON cl.client_id = d.client_id JOIN account ac ON d.account_id = ac.account_id JOIN district dt ON cl.district_id = dt.district_id WHERE cl.gender = 'F' AND dt.A3 LIKE '%Prague%'
SELECT ((SELECT COUNT(client_id) FROM client WHERE gender = 'M' AND client_id IN (SELECT client_id FROM disp WHERE disp_id IN (SELECT disp_id FROM account WHERE frequency = 'POPLATEK TYDNE'))) / (SELECT COUNT(client_id) FROM client WHERE client_id IN (SELECT client_id FROM disp WHERE disp_id IN (SELECT disp_id FROM account WHERE frequency = 'POPLATEK TYDNE'))))*100 as percentage_male_requesting_weekly_statements
SELECT COUNT(*) FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id WHERE account.frequency = 'POPLATEK TYDNE' and disp.type = 'OWNER'
SELECT a.account_id, a.amount FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.duration > 24 AND l.amount = ( SELECT MIN(amount) FROM loan WHERE duration > 24 ) AND a.date < '1997-01-01'
SELECT a.account_id FROM account a JOIN disp d ON a.account_id = d.account_id JOIN client c ON d.client_id = c.client_id WHERE c.gender = 'F' ORDER BY c.birth_date ASC, district_id DESC LIMIT 1
SELECT COUNT(*) FROM client JOIN district ON client.district_id = district.district_id WHERE strftime('%Y', client.birth_date) = '1920' AND district.A3 = 'East Bohemia'
SELECT COUNT(*) FROM loan l JOIN account a ON l.account_id = a.account_id WHERE l.duration = 24 AND a.frequency = 'POPLATEK TYDNE' AND l.status = 'A'
SELECT AVG(amount) FROM loan WHERE status = 'C'
SELECT client.client_id, client.district_id FROM client JOIN disp ON client.client_id = disp.client_id JOIN account ON disp.account_id = account.account_id WHERE disp.type = 'OWNER'
SELECT client.client_id, strftime('%Y', 'now') - strftime('%Y', client.birth_date) AS age FROM client INNER JOIN disp ON client.client_id = disp.client_id INNER JOIN card ON disp.disp_id = card.disp_id WHERE card.type = 'gold'
SELECT bond_type, COUNT(bond_type) AS count FROM bond GROUP BY bond_type ORDER BY count DESC LIMIT 1
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element = 'cl' AND m.label = '-'
SELECT AVG(CASE WHEN atom.element = 'o' AND bond.bond_type = '-' THEN 1 ELSE 0 END) FROM atom JOIN connected ON atom.atom_id = connected.atom_id JOIN bond ON bond.bond_id = connected.bond_id WHERE molecule_id IN (SELECT molecule_id FROM bond WHERE bond_type = '-')
SELECT AVG(CASE WHEN m.label='+' THEN 1 ELSE 0 END) AS avg_carcinogenic_single_bonded FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '-'
SELECT COUNT(*) FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '-' AND atom.element = 'na'
SELECT molecule_id FROM atom JOIN bond ON atom.molecule_id = bond.molecule_id JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE bond.bond_type = '
SELECT DIVIDE(SUM(CASE WHEN a.element = 'c' THEN 1 ELSE 0 END), COUNT(a.atom_id)) AS percentage FROM atom a JOIN bond b ON a.molecule_id = b.molecule_id WHERE b.bond_type = ' = '
SELECT COUNT(*) AS num_triple_bonds FROM bond WHERE bond_type = '
SELECT COUNT(atom_id) FROM atom WHERE element != 'br'
SELECT COUNT(*) FROM molecule WHERE molecule_id BETWEEN 'TR000' AND 'TR099' AND label = '+'
SELECT DISTINCT molecule.molecule_id FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE atom.element = 'si'
SELECT element FROM atom INNER JOIN connected ON atom.atom_id = connected.atom_id OR atom.atom_id = connected.atom_id2 INNER JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_id = 'TR004_8_9'
SELECT DISTINCT element FROM atom WHERE atom_id IN ( SELECT atom_id FROM bond WHERE bond_type = ' = ' )
SELECT label, COUNT(label) AS label_count FROM atom WHERE element = 'h' GROUP BY label ORDER BY label_count DESC LIMIT 1
SELECT bond.bond_type FROM atom JOIN connected ON atom.atom_id = connected.atom_id JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 'te'
SELECT atom_id, atom_id2 FROM connected JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = '-'
SELECT connected.atom_id, connected.atom_id2 FROM connected JOIN bond ON connected.bond_id = bond.bond_id JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = '-'
SELECT element, COUNT(*) AS num_elements FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE label = '-' GROUP BY element ORDER BY num_elements ASC LIMIT 1
SELECT bond.bond_type FROM connected JOIN bond ON connected.bond_id = bond.bond_id WHERE connected.atom_id = 'TR004_8' AND connected.atom_id2 = 'TR004_20'
SELECT DISTINCT m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element != 'sn'
SELECT COUNT(DISTINCT a.atom_id) FROM atom a INNER JOIN molecule m ON a.molecule_id = m.molecule_id INNER JOIN bond b ON m.molecule_id = b.molecule_id INNER JOIN connected c ON a.atom_id = c.atom_id WHERE (a.element = 'i' OR a.element = 's') AND b.bond_type = '-'
SELECT a.atom_id, c.atom_id2 FROM connected c JOIN bond b ON c.bond_id = b.bond_id JOIN atom a ON c.atom_id = a.atom_id WHERE b.bond_type = '
SELECT DISTINCT a2.* FROM atom a JOIN connected c ON a.atom_id = c.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.label = 'TR181'
SELECT 100 * DIVIDE(COUNT(DISTINCT m.molecule_id) - COUNT(DISTINCT m2.molecule_id), COUNT(DISTINCT m.molecule_id)) AS percent FROM molecule m LEFT JOIN molecule m2 ON m.molecule_id = m2.molecule_id AND m2.element = 'f' WHERE m.label = '+'
SELECT DIVIDE(SUM(b.`bond_type` = '
SELECT element, COUNT(*) AS count FROM atom WHERE molecule_id = 'TR000' GROUP BY element ORDER BY element LIMIT 3
SELECT a.atom_id, a2.atom_id FROM connected c JOIN atom a ON c.atom_id = a.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN bond b ON c.bond_id = b.bond_id JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.molecule_id = 'TR001' AND b.bond_id = 'TR001_2_6'
SELECT SUM(CASE WHEN label = '+' THEN 1 ELSE 0 END) - SUM(CASE WHEN label = '-' THEN 1 ELSE 0 END) AS difference FROM molecule
SELECT `atom_id` FROM `connected` WHERE `bond_id` = 'TR_000_2_5'
SELECT bond_id FROM connected WHERE atom_id2 = 'TR000_2'
SELECT m.`label` FROM `molecule` m INNER JOIN `bond` b ON m.`molecule_id` = b.`molecule_id` WHERE b.`bond_type` = ' = ' ORDER BY m.`label` ASC LIMIT 5
SELECT DIVIDE(SUM(bond_type = ' = '), COUNT(bond_id)) FROM bond WHERE molecule_id = 'TR008'
SELECT DIVIDE(SUM(m.label = '+'), COUNT(m.molecule_id)) as percent FROM molecule m
SELECT DIVIDE(SUM(element = 'h'), COUNT(atom_id)) as percent FROM atom WHERE molecule_id = 'TR206'
SELECT bond.bond_type FROM bond WHERE bond.molecule_id = 'TR000'
SELECT atom.element, molecule.label FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.molecule_id = 'TR060'
SELECT bond_type, COUNT(bond_type) AS bond_count FROM bond WHERE molecule_id = 'TR018' GROUP BY bond_type ORDER BY bond_count DESC LIMIT 1
SELECT m.label FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id JOIN connected c ON b.bond_id = c.bond_id WHERE b.bond_type = '-' AND m.label = '-' GROUP BY m.molecule_id ORDER BY m.label ASC LIMIT 3
SELECT `bond`.`bond_id`, `bond`.`bond_type` FROM `bond` WHERE `bond`.`molecule_id` = 'TR006' ORDER BY `bond`.`bond_type` ASC LIMIT 2
SELECT COUNT(*) FROM connected WHERE (atom_id = 'TR009_12' OR atom_id2 = 'TR009_12') AND bond_id LIKE 'TR009_%'
SELECT COUNT(*) FROM molecule WHERE label = '+' AND molecule_id IN ( SELECT molecule_id FROM atom WHERE element = 'br' )
SELECT `bond_type`, `atom_id`, `atom_id2` FROM `bond` b JOIN `connected` c ON b.`bond_id` = c.`bond_id` WHERE b.`bond_id` = 'TR001_6_9'
SELECT m.`label` FROM `atom` a JOIN `molecule` m ON a.`molecule_id` = m.`molecule_id` WHERE a.`atom_id` = 'TR001_10'
SELECT COUNT(DISTINCT molecule_id) FROM bond WHERE bond_type = '
SELECT COUNT(*) FROM connected WHERE atom_id='TR%_19' OR atom_id2='TR%_19'
SELECT DISTINCT element FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = 'TR004'
SELECT COUNT(*) FROM molecule WHERE label = '-'
SELECT m.* FROM molecule m WHERE m.label = '+' AND EXISTS ( SELECT a.atom_id FROM atom a WHERE CAST(SUBSTR(a.atom_id, 7, 2) AS INTEGER) BETWEEN 21 AND 25 AND a.molecule_id = m.molecule_id )
SELECT bond.bond_id FROM bond JOIN connected ON bond.molecule_id = connected.bond_id JOIN atom AS a1 ON a1.atom_id = connected.atom_id JOIN atom AS a2 ON a2.atom_id = connected.atom_id2 WHERE (a1.element = 'p' OR a1.element = 'n') AND (a2.element = 'p' OR a2.element = 'n')
SELECT m.molecule_id FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '= ' GROUP BY m.molecule_id ORDER BY COUNT(b.bond_id) DESC LIMIT 1
SELECT AVG(COUNT(bond_id) * 1.0 / COUNT(atom_id)) FROM atom WHERE element = 'i'
SELECT bond_type, bond_id FROM bond WHERE molecule_id = (SELECT molecule_id FROM atom WHERE atom_id = 'atom45')
SELECT element FROM atom WHERE atom_id NOT IN (SELECT atom_id FROM connected)
SELECT a.atom_id, a.element FROM atom a JOIN connected c ON a.atom_id = c.atom_id JOIN bond b ON c.bond_id = b.bond_id JOIN molecule m ON b.molecule_id = m.molecule_id WHERE m.label = "TR447" AND b.bond_type = '
SELECT element FROM atom WHERE molecule_id = 'TR144_8_19'
SELECT m.molecule_id, m.label, COUNT(b.bond_id) AS double_bonds FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE m.label = '+' AND b.bond_type = '=' GROUP BY m.molecule_id ORDER BY double_bonds DESC LIMIT 1
SELECT element FROM atom WHERE molecule_id IN (SELECT molecule_id FROM molecule WHERE label = '+') GROUP BY element ORDER BY COUNT(*) ASC LIMIT 1
SELECT DISTINCT a2.atom_id FROM connected c JOIN atom a ON a.atom_id = c.atom_id JOIN atom a2 ON a2.atom_id = c.atom_id2 WHERE a.element = 'pb'
SELECT element FROM atom JOIN bond ON atom.molecule_id = bond.molecule_id WHERE bond.bond_type = '
SELECT (CAST(COUNT(b.bond_id) AS REAL) / (SELECT COUNT(*) FROM atom WHERE element = (SELECT element FROM ( SELECT a.element, COUNT(a.element) as element_count FROM atom a JOIN connected c ON a.atom_id = c.atom_id GROUP BY a.element ORDER BY element_count DESC LIMIT 1 ) )) * 100) FROM bond b JOIN connected c ON b.bond_id = c.bond_id JOIN atom a ON c.atom_id = a.atom_id
SELECT DIVIDE( SUM( CASE WHEN bond.bond_type = '-' AND molecule.label = '+' THEN 1 ELSE 0 END ), COUNT(bond.bond_id) ) AS proportion_carcinogenic_single_bonds FROM bond JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '-'
SELECT COUNT(*) AS total_atoms FROM atom WHERE element IN ('c', 'h')
SELECT connected.atom_id2 FROM atom JOIN connected ON atom.atom_id = connected.atom_id WHERE atom.element = 's'
SELECT bond.bond_type FROM atom JOIN bond ON atom.molecule_id = bond.molecule_id WHERE atom.element = 'sn'
SELECT COUNT(DISTINCT a.element) FROM atom a JOIN bond b ON a.molecule_id = b.molecule_id WHERE b.bond_type = '-'
SELECT COUNT(DISTINCT atom_id) FROM atom WHERE molecule_id IN ( SELECT molecule_id FROM bond WHERE bond_type = '
SELECT bond.bond_id FROM bond JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = '+'
SELECT DISTINCT M.molecule_id FROM bond B JOIN molecule M ON B.molecule_id = M.molecule_id WHERE B.bond_type = '-' AND M.label = '-'
SELECT DIVIDE(SUM(element = 'cl'), COUNT(atom_id)) as percent FROM atom WHERE molecule_id IN (SELECT molecule_id FROM bond WHERE bond_type = '-')
SELECT m.molecule_id, m.label FROM molecule m WHERE m.molecule_id IN ('TR000', 'TR001', 'TR002')
SELECT molecule_id FROM molecule WHERE label = '-'
SELECT COUNT(*) AS carcinogenic_molecules FROM molecule WHERE label = '+' AND molecule_id BETWEEN 'TR000' AND 'TR030'
SELECT b.bond_type FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE m.molecule_id BETWEEN 'TR000' AND 'TR050'
SELECT a.element FROM atom a JOIN connected c ON a.atom_id = c.atom_id OR a.atom_id = c.atom_id2 JOIN bond b ON b.bond_id = c.bond_id WHERE b.bond_id = 'TR001_10_11'
SELECT COUNT(bond.bond_id) FROM bond JOIN atom ON bond.molecule_id = atom.molecule_id WHERE atom.element = 'i'
SELECT molecule_id, label FROM molecule WHERE molecule_id IN (SELECT molecule_id FROM atom WHERE element = 'ca') AND label IN ('+','-')
SELECT DISTINCT bond.bond_id FROM bond JOIN connected ON bond.bond_id = connected.bond_id JOIN atom ON atom.atom_id = connected.atom_id OR atom.atom_id = connected.atom_id2 WHERE (atom.element = 'cl' OR atom.element = 'c') AND bond.bond_id = 'TR001_1_8'
SELECT m1.molecule_id, m2.molecule_id FROM molecule m1, molecule m2, bond b WHERE m1.molecule_id = b.molecule_id AND m2.molecule_id = b.molecule_id AND b.bond_type = '
SELECT DIVIDE( SUM(CASE WHEN element = 'cl' THEN 1 ELSE 0 END), COUNT(DISTINCT molecule.molecule_id) ) AS percentage FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+'
SELECT element FROM atom WHERE molecule_id = 'TR001'
SELECT `molecule_id` FROM `bond` WHERE `bond_type` = ' = '
SELECT connected.atom_id, connected.atom_id2 FROM connected JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_type = '
SELECT atom.element FROM atom JOIN connected ON atom.atom_id = connected.atom_id JOIN bond ON bond.bond_id = connected.bond_id WHERE bond.bond_id = 'TR005_16_26'
SELECT COUNT(*) FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '-' AND m.label = '-'
SELECT m.label FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_id = 'TR001_10_11'
SELECT `bond_id` FROM `bond` WHERE `bond_type` = '
SELECT element, COUNT(*) AS tally FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE molecule.label = '+' AND substr(atom.atom_id, 7, 1) = 4 GROUP BY element
SELECT DIVIDE(SUM(CASE WHEN element = 'h' THEN 1 ELSE 0 END), COUNT(element)), (SELECT label FROM molecule WHERE molecule_id = 'TR006') FROM atom WHERE molecule_id = 'TR006'
SELECT m.label FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element = 'ca'
SELECT b.bond_type FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id JOIN connected c ON a.atom_id = c.atom_id JOIN bond b ON c.bond_id = b.bond_id WHERE a.element = 'te'
SELECT a.element FROM atom a JOIN connected c ON a.atom_id = c.atom_id JOIN bond b ON c.bond_id = b.bond_id WHERE b.bond_id = 'TR001_10_11'
SELECT ROUND((SELECT COUNT(*) FROM bond WHERE bond_type = '
SELECT (DIVIDE(SUM(bond_type = ' = '), COUNT(*)) * 100) AS percent FROM bond WHERE molecule_id = 'TR047'
SELECT m.label FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.atom_id = 'TR001_1'
SELECT label FROM molecule WHERE molecule_id = 'TR151' AND label = '+'
SELECT a.element FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE m.label = 'TR151' AND a.element IN ('pb', 'te', 'sn')
SELECT COUNT(*) FROM molecule WHERE label = '+'
SELECT DISTINCT a.atom_id FROM atom a INNER JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'c' AND substr(m.molecule_id, 3, 3) > 010 AND substr(m.molecule_id, 3, 3) < 050
SELECT COUNT(*) FROM atom WHERE molecule_id IN (SELECT molecule_id FROM molecule WHERE label = '+')
SELECT bond.bond_id FROM bond JOIN molecule ON bond.molecule_id = molecule.molecule_id WHERE bond.bond_type = '=' AND molecule.label = '+'
SELECT COUNT(*) FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'hydrogen' AND m.label = '+'
SELECT molecule_id FROM connected WHERE atom_id = 'TR00_1' AND bond_id = 'TR00_1_2'
SELECT a.atom_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'c' AND m.label = '-'
SELECT DIVIDE(SUM(label = '+' AND element = 'h'), COUNT(molecule_id)) * 100.0 AS percentage FROM molecule JOIN atom ON atom.molecule_id = molecule.molecule_id WHERE label = '+' AND element = 'h'
SELECT label FROM molecule WHERE molecule_id = 'TR124'
SELECT A.atom_id, A.element FROM atom A JOIN molecule M ON A.molecule_id = M.molecule_id WHERE M.molecule_id = 'TR186'
SELECT `bond_type` FROM `bond` WHERE `bond_id` = 'TR007_4_19'
SELECT DISTINCT element FROM atom WHERE atom_id IN ( SELECT atom_id FROM connected WHERE bond_id = 'TR001_2_4' )
SELECT COUNT(*) AS double_bonds, m.label AS carcinogenic FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = '=' AND m.molecule_id = 'TR006'
SELECT `molecule`.`label`, `atom`.`element` FROM `molecule` JOIN `atom` ON `molecule`.`molecule_id` = `atom`.`molecule_id` WHERE `molecule`.`label` = '+' GROUP BY `molecule`.`molecule_id`, `atom`.`element` ORDER BY `molecule`.`molecule_id`ASC
SELECT `bond_id`, `atom_id`, `atom_id2`, `molecule_id` FROM `connected` JOIN `bond` ON `connected`.`bond_id` = `bond`.`bond_id` WHERE `bond`.`bond_type` = '-'
SELECT m.molecule_id, GROUP_CONCAT(a.element) AS elements FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '
SELECT atom.element FROM atom JOIN connected ON atom.atom_id = connected.atom_id JOIN bond ON bonded.bond_id = connected.bond_id WHERE bond.bond_id = 'TR000_2_3'
SELECT COUNT(*) FROM atom a JOIN connected c ON a.atom_id = c.atom_id JOIN bond b ON c.bond_id = b.bond_id WHERE a.element = 'cl'
SELECT atom.atom_id, COUNT(bond.bond_id) FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id JOIN bond ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = 'TR346' GROUP BY atom.atom_id
SELECT COUNT(DISTINCT b.molecule_id) AS molecules_with_double_bond, COUNT(DISTINCT m.molecule_id) AS carcinogenic_molecules_with_double_bond FROM bond b JOIN molecule m ON b.molecule_id = m.molecule_id WHERE b.bond_type = ' = ' AND m.label = '+'
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule m LEFT JOIN atom a ON m.molecule_id = a.molecule_id LEFT JOIN bond b ON m.molecule_id = b.molecule_id LEFT JOIN connected c ON a.atom_id = c.atom_id WHERE a.element != 's' OR b.bond_type != '='
SELECT label FROM molecule WHERE molecule_id = (SELECT molecule_id FROM bond WHERE bond_id = 'TR001_2_4') AND label = '+'
SELECT COUNT(atom_id) AS num_atoms FROM atom WHERE molecule_id = 'TR005'
SELECT COUNT(`bond_id`) FROM `bond` WHERE `bond_type` = '-'
SELECT molecule.molecule_id, molecule.label FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE atom.element LIKE '%cl%' AND molecule.label = '+'
SELECT DISTINCT m.molecule_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'c' AND m.label = '-'
SELECT DIVIDE(SUM(label = '+' and element = 'cl'), COUNT(molecule_id)) as percentage FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id WHERE label = '+' GROUP BY element
SELECT `molecule_id` FROM `bond` WHERE `bond_id` = 'TR001_1_7'
SELECT COUNT(DISTINCT element) FROM atom JOIN connected ON atom.atom_id = connected.atom_id JOIN bond ON connected.bond_id = bond.bond_id WHERE bond.bond_id = 'TR001_3_4'
SELECT b.bond_type FROM connected c JOIN bond b ON c.bond_id = b.bond_id WHERE c.atom_id = 'TR000_1' AND c.atom_id2 = 'TR000_2'
SELECT molecule.label FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE atom.atom_id = 'TR000_2'
SELECT element FROM atom WHERE atom_id = 'TR000_1'
SELECT m.label FROM molecule m WHERE m.molecule_id = 'TR000'
SELECT DIVIDE( SUM(CASE WHEN b.bond_type = '-' THEN 1 ELSE 0 END), COUNT(a.atom_id) ) AS percentage FROM atom a LEFT JOIN connected c ON a.atom_id = c.atom_id LEFT JOIN bond b ON c.bond_id = b.bond_id
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id WHERE a.element = 'n' AND m.label = '+'
SELECT m.molecule_id FROM atom a JOIN molecule m ON a.molecule_id = m.molecule_id JOIN bond b ON a.molecule_id = b.molecule_id WHERE a.element = 'S' AND b.bond_type = '='
SELECT `molecule_id` FROM `molecule` WHERE `label` = '-' AND `molecule_id` IN ( SELECT `molecule_id` FROM `atom` GROUP BY `molecule_id` HAVING COUNT(`atom_id`) > 5 )
SELECT DISTINCT element FROM atom JOIN bond ON atom.molecule_id = bond.molecule_id JOIN connected ON atom.atom_id = connected.atom_id WHERE bond.bond_type = '=' AND bond.molecule_id = 'TR024'
SELECT molecule_id, COUNT(atom_id) as num_atoms FROM atom WHERE molecule_id IN (SELECT molecule_id from molecule WHERE label = '+') GROUP BY molecule_id ORDER BY num_atoms DESC LIMIT 1
SELECT DIVIDE(SUM(m.label = '+'), COUNT(DISTINCT m.molecule_id)) * 100.0 FROM molecule m JOIN atom a ON m.molecule_id = a.molecule_id JOIN bond b ON m.molecule_id = b.molecule_id WHERE a.element = 'h' AND b.bond_type = '
SELECT COUNT(*) FROM molecule WHERE label = '+'
SELECT COUNT(DISTINCT molecule_id) FROM bond WHERE bond_type = '-' AND molecule_id BETWEEN 'TR004' AND 'TR010'
SELECT COUNT(*) FROM atom WHERE molecule_id = 'TR008' AND element = 'c'
SELECT element FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id WHERE atom.atom_id = 'TR004_7' AND molecule.label = '-'
SELECT COUNT(DISTINCT m.molecule_id) FROM connected c JOIN bond b ON c.bond_id = b.bond_id JOIN atom a ON c.atom_id = a.atom_id JOIN atom a2 ON c.atom_id2 = a2.atom_id JOIN molecule m ON a.molecule_id = m.molecule_id WHERE a.element = 'o' AND a2.element = 'o' AND b.bond_type = ' = '
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule m JOIN bond b ON m.molecule_id = b.molecule_id WHERE b.bond_type = '
SELECT a.element, b.bond_type FROM atom a JOIN bond b ON a.molecule_id = b.molecule_id WHERE a.molecule_id = 'TR016'
SELECT atom.atom_id FROM atom JOIN molecule ON atom.molecule_id = molecule.molecule_id JOIN bond ON bond.molecule_id = molecule.molecule_id WHERE molecule.label = 'TR012' AND atom.element = 'c' AND bond.bond_type = ' = '
SELECT atom_id FROM atom WHERE molecule_id IN ( SELECT molecule_id FROM molecule WHERE label = '+' ) AND element = 'o'
SELECT * FROM cards WHERE cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL
SELECT * FROM cards WHERE borderColor = 'borderless' AND cardKingdomFoilId IS NULL AND cardKingdomId IS NOT NULL
SELECT name FROM cards WHERE faceConvertedManaCost = (SELECT MAX(faceConvertedManaCost) FROM cards)
SELECT cards.name FROM cards WHERE cards.frameVersion = '2015' AND cards.edhrecRank < 100
SELECT c.name FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.rarity = 'mythic' AND l.format = 'gladiator' AND l.status = 'Banned'
SELECT c.name, l.status FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE c.types LIKE '%Artifact%' AND c.side IS NULL AND l.format = 'vintage'
SELECT cards.id, cards.artist FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE power = '*' OR power IS NULL AND format = 'commander' AND status = 'Legal'
SELECT c.name, r.text, c.hasContentWarning FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.artist = 'Stephen Daniele'
SELECT rulings.date, rulings.text FROM rulings JOIN cards ON rulings.uuid = cards.uuid WHERE cards.name = 'Sublime Epiphany' AND cards.number = '74s'
SELECT cards.name, cards.artist, cards.isPromo FROM cards JOIN rulings ON cards.uuid = rulings.uuid GROUP BY cards.uuid ORDER BY COUNT(rulings.uuid) DESC LIMIT 1
SELECT foreign_data.language FROM foreign_data JOIN cards ON foreign_data.uuid = cards.uuid WHERE cards.name = 'annul' AND cards.number = '29'
SELECT * FROM cards WHERE uuid IN (SELECT DISTINCT uuid FROM foreign_data WHERE language = 'Japanese')
SELECT (card_count.chinese_count * 100) / card_count.total_count AS percentage FROM (SELECT COUNT(cards.id) AS total_count, COUNT(foreign_data.id) AS chinese_count FROM cards LEFT JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE foreign_data.language = 'Chinese Simplified') AS card_count
SELECT sets.name, sets.totalSetSize FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language = 'Italian'
SELECT COUNT(DISTINCT c.type) FROM cards c WHERE c.artist = 'Aaron Boyd'
SELECT keywords FROM cards WHERE name = 'Angel of Mercy'
SELECT COUNT(*) FROM cards WHERE power = '*'
SELECT promoTypes FROM cards WHERE name = 'Duress'
SELECT borderColor FROM cards WHERE name = "Ancestor's Chosen"
SELECT originalType FROM cards WHERE name = "Ancestor's Chosen"
SELECT language FROM cards JOIN sets ON cards.setCode = sets.code JOIN set_translations ON sets.code = set_translations.setCode WHERE cards.name = 'Angel of Mercy'
SELECT count(*) FROM legalities l JOIN cards c ON l.uuid = c.uuid WHERE l.status = 'restricted' AND c.isTextless = 0
SELECT text FROM rulings WHERE uuid = (SELECT uuid FROM cards WHERE name = "Condemn")
SELECT count(legalities.uuid) FROM legalities JOIN cards ON legalities.uuid = cards.uuid WHERE legalities.status = 'restricted' AND cards.isStarter = 1
SELECT legalities.status FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.name = "Cloudchaser Eagle"
SELECT type FROM cards WHERE name = 'Benalish Knight'
SELECT legalities.format FROM cards JOIN rulings ON cards.uuid = rulings.uuid JOIN legalities ON legalities.uuid = rulings.uuid WHERE cards.name = "Benalish Knight" LIMIT 1
SELECT artist FROM cards WHERE uuid IN (SELECT uuid FROM foreign_data WHERE language = 'Phyrexian')
SELECT ROUND((COUNT(id) * 100.0 / (SELECT COUNT(id) FROM cards)), 2) AS percentage FROM cards WHERE borderColor = 'borderless'
SELECT COUNT(*) FROM cards WHERE scryfallIllustrationId IN (SELECT scryfallIllustrationId FROM foreign_data WHERE language = 'German') AND isReprint = 1
SELECT COUNT(*) FROM cards WHERE borderColor = 'borderless' AND uuid IN (SELECT uuid FROM foreign_data WHERE language = 'Russian')
SELECT (SELECT CAST(COUNT(id) AS REAL) / (SELECT COUNT(id) FROM cards WHERE isStorySpotlight = 1) * 100 FROM cards WHERE language = 'French' AND isStorySpotlight = 1) AS percentage_of_french_story_spotlight_cards
SELECT COUNT(id) FROM cards WHERE toughness = '99'
SELECT name FROM cards WHERE artist = 'Aaron Boyd'
SELECT count(*) FROM cards WHERE borderColor = 'black' AND availability = 'mtgo'
SELECT id FROM cards WHERE convertedManaCost = 0
SELECT layout FROM cards WHERE keywords LIKE '%flying%'
SELECT COUNT(*) FROM cards WHERE originalType = "Summon - Angel" AND subtypes <> "Angel"
SELECT cards.id FROM cards WHERE cards.cardKingdomFoilId IS NOT NULL AND cards.cardKingdomId IS NOT NULL
SELECT id FROM cards WHERE duelDeck = 'a'
SELECT edhrecRank FROM cards WHERE frameVersion = '2015'
SELECT cards.artist FROM cards JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE foreign_data.language = 'Chinese Simplified'
SELECT c.name FROM cards c WHERE c.availability = 'paper' AND c.uuid IN (SELECT f.uuid FROM foreign_data f WHERE f.language = 'Japanese')
SELECT COUNT(*) FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE legalities.status = 'Banned' AND cards.borderColor = 'white'
SELECT cards.uuid, foreign_data.language FROM cards JOIN legalities ON cards.uuid = legalities.uuid JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE legalities.format = 'legacy'
SELECT text FROM rulings WHERE uuid IN (SELECT uuid FROM cards WHERE name = 'Beacon of Immortality')
SELECT COUNT(*) as future_frame_cards, status as legality_status FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE frameVersion = 'future' GROUP BY status
SELECT cards.name, cards.colors FROM cards INNER JOIN sets ON cards.setCode = sets.code WHERE sets.code = 'OGW'
SELECT cards.name, set_translations.language FROM cards JOIN sets ON cards.setCode = sets.code JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.code = '10E' AND cards.convertedManaCost = 5
SELECT cards.name, rulings.date FROM cards JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.originalType = 'Creature - Elf'
SELECT colors, format FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.id BETWEEN 1 AND 20
SELECT c.name FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.originalType = 'Artifact' AND c.colors = 'B' AND fd.language <> 'en'
SELECT c.name FROM cards c JOIN rulings r ON c.uuid = r.uuid WHERE c.rarity = 'uncommon' ORDER BY r.date ASC LIMIT 3
SELECT COUNT(*) FROM cards WHERE artist = 'John Avon' AND hasFoil = 1 AND cardKingdomFoilId IS NOT NULL
SELECT COUNT(*) FROM cards WHERE borderColor = 'white' AND cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL
SELECT COUNT(*) FROM cards WHERE artist = 'UDON' AND availability = 'mtgo' AND hand = '-1'
SELECT COUNT(*) FROM cards WHERE frameVersion = '1993' AND availability = 'paper' AND hasContentWarning = 1
SELECT manaCost FROM cards WHERE layout = 'normal' AND frameVersion = '2003' AND borderColor = 'black' AND (availability = 'paper' OR availability = 'mtgo')
SELECT SUM(convertedManaCost) AS total_unconverted_mana FROM cards WHERE artist = 'Rob Alexander'
SELECT DISTINCT type FROM cards WHERE availability = 'arena'
SELECT set_translations.setCode FROM set_translations WHERE set_translations.language = "Spanish"
SELECT DIVIDE(COUNT(hand = '+3'), COUNT(id)) FROM cards WHERE frameEffects = 'legendary'
SELECT cards.id FROM cards WHERE cards.isStorySpotlight = 1 AND cards.isTextless = 0
SELECT name as card_name, 100*(SELECT COUNT(id) FROM cards WHERE uuid IN (SELECT uuid FROM foreign_data WHERE language = 'Spanish')) / (SELECT COUNT(id) FROM cards) as percentage FROM cards WHERE uuid IN (SELECT uuid FROM foreign_data WHERE language = 'Spanish') ORDER BY card_name
SELECT language FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE baseSetSize = 309)
SELECT COUNT(*) FROM set_translations JOIN sets ON set_translations.setCode = sets.code WHERE sets.block = 'Commander' AND set_translations.language = 'Portuguese (Brasil)'
SELECT cards.id, cards.name FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE legalities.format = 'legal' AND cards.types LIKE '%Creature%'
SELECT DISTINCT foreign_data.language AS "German" FROM foreign_data WHERE foreign_data.language = "German"
SELECT COUNT(*) FROM cards WHERE power IS NULL AND text LIKE '%triggered ability%'
SELECT COUNT(*) FROM cards JOIN legalities ON cards.uuid = legalities.uuid JOIN rulings ON cards.uuid = rulings.uuid WHERE legalities.format NOT LIKE '%modern%' AND rulings.text = 'This is a triggered mana ability' AND cards.side IS NULL
SELECT cards.id FROM cards WHERE cards.artist = 'Erica Yang' AND cards.rarity = 'pauper' AND cards.availability = 'paper'
SELECT cards.artist FROM cards WHERE cards.flavorText = "Das perfekte Gegenmittel zu einer dichten Formation"
SELECT c.name FROM cards c JOIN foreign_data fd ON c.uuid = fd.uuid WHERE c.type LIKE '%Creature%' AND c.layout = 'normal' AND c.borderColor = 'black' AND c.artist = 'Matthew D. Wilson' AND fd.language = 'French'
SELECT COUNT(*) FROM cards JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.rarity = 'rare' AND rulings.date = '2009-01-10'
SELECT set_translations.language FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.block = 'Ravnica' AND sets.baseSetSize = 180
SELECT DIVIDE(COUNT(*), (SELECT COUNT(*) FROM cards WHERE format = 'commander' AND UUID IN (SELECT UUID FROM legalities WHERE status = 'legal'))) * 100 FROM cards WHERE format = 'commander' AND UUID IN (SELECT UUID FROM legalities WHERE status = 'legal') AND hasContentWarning = 0
SELECT language, power, COUNT(*) as total_cards, SUM(CASE WHEN language = 'French' AND (power IS NULL OR power = '*') THEN 1 ELSE 0 END) as french_no_power_cards FROM cards GROUP BY language, power
SELECT (DIVIDE((SELECT COUNT(*) FROM set_translations WHERE language = 'Japanese'), (SELECT COUNT(*) FROM set_translations)) * 100) as percentage
SELECT cards.availability FROM cards WHERE cards.artist = 'Daren Bader'
SELECT COUNT(*) FROM cards WHERE borderColor = 'borderless' AND edhrecRank > 12000
SELECT SUM(isOversized) AS num_oversized, SUM(isReprint) AS num_reprinted, SUM(isPromo) AS num_promotions FROM cards
SELECT c.name FROM cards c WHERE c.power IS NULL OR c.power = '*' AND c.promoTypes = 'arenaleague' ORDER BY c.name LIMIT 3
SELECT language FROM foreign_data WHERE multiverseid = 149934
SELECT cards.cardKingdomFoilId, cards.cardKingdomId FROM cards WHERE cards.cardKingdomFoilId IS NOT NULL AND cards.cardKingdomId IS NOT NULL ORDER BY cards.cardKingdomFoilId ASC, cards.cardKingdomId ASC LIMIT 3
SELECT ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cards WHERE isTextless = 1 AND layout = 'normal')), 2) AS proportion FROM cards WHERE isTextless = 1
SELECT c.number FROM cards c WHERE c.uuid IN (SELECT uuid FROM subtypes WHERE subtype = 'Angel' OR subtype = 'Wizard') AND c.side IS NULL
SELECT sets.name FROM sets WHERE sets.mtgoCode IS NULL OR sets.mtgoCode = '' ORDER BY sets.name LIMIT 3
SELECT language FROM set_translations JOIN sets ON set_translations.setCode = sets.code WHERE sets.mcmName = 'Archenemy' AND sets.code = 'ARC'
SELECT sets.name, set_translations.translation FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.id = 5
SELECT sets.name, sets.type FROM sets WHERE sets.id = 206
SELECT sets.name, sets.code FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language = 'Italian' AND sets.block = 'Shadowmoor' ORDER BY sets.name ASC LIMIT 2
SELECT s.name, s.id FROM sets s WHERE s.isForeignOnly = 0 AND s.isFoilOnly = 1 AND s.id IN ( SELECT st.id FROM set_translations st WHERE st.language = 'Japanese' ) AND s.id NOT IN ( SELECT s2.id FROM sets s2 WHERE s2.isForeignOnly = 1 ) LIMIT 1
SELECT sets.name FROM sets LEFT JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language = 'Russian' ORDER BY sets.baseSetSize DESC LIMIT 1
SELECT ROUND((COUNT(DISTINCT c.uuid) * 100.0) / (SELECT COUNT(DISTINCT c.uuid) FROM foreign_data f JOIN cards c ON f.uuid = c.uuid WHERE f.language = 'Chinese Simplified' AND c.isOnlineOnly = 1), 2) AS percentage FROM foreign_data f JOIN cards c ON f.uuid = c.uuid WHERE f.language = 'Chinese Simplified' AND c.isOnlineOnly = 1
SELECT COUNT(*) FROM sets WHERE language = 'Japanese' AND (mtgoCode IS NULL OR mtgoCode = '')
SELECT COUNT(id) as blackBorderCount, id FROM cards WHERE borderColor = 'black'
SELECT COUNT(*) AS num_cards, GROUP_CONCAT(id) AS card_ids FROM cards WHERE frameEffects = 'extendedart'
SELECT name FROM cards WHERE borderColor = 'black' AND isFullArt = 1
SELECT sets.id, set_translations.language FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.id = 174
SELECT name FROM sets WHERE code = "ALL"
SELECT f.language FROM foreign_data f JOIN cards c ON f.uuid = c.uuid WHERE c.name = 'A Pedra Fellwar'
SELECT code FROM sets WHERE releaseDate = '2007-07-13'
SELECT sets.baseSetSize, sets.code FROM sets WHERE sets.block = "Masques" OR sets.block = "Mirage"
SELECT code FROM sets WHERE type = 'expansion'
SELECT cards.name AS card_name, cards.watermark AS card_watermark, cards.types AS card_types FROM cards WHERE cards.watermark = 'Boros'
SELECT cards.name, cards.watermark, foreign_data.language, foreign_data.flavorText, cards.type FROM cards JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.watermark = "colorpie"
SELECT DIVIDE(COUNT(convertedManaCost = 10), COUNT(convertedManaCost))*100 FROM cards WHERE name = 'Abyssal Horror'
SELECT sets.code FROM sets WHERE sets.type = "expansion commander"
SELECT cards.name, cards.type FROM cards WHERE cards.watermark = 'Abzan'
SELECT language, type FROM cards WHERE watermark = 'Azorius'
SELECT COUNT(*) FROM cards WHERE artist = 'Aaron Miller' AND cardKingdomFoilId = cardKingdomId AND cardKingdomId IS NOT NULL
SELECT COUNT(*) FROM cards WHERE availability LIKE '%paper%' AND hand LIKE '+%'
SELECT name FROM cards WHERE isTextless = 0
SELECT convertedManaCost FROM cards WHERE name = 'Ancestor`s Chosen'
SELECT COUNT(*) FROM cards WHERE borderColor = 'white' AND (power = '*' OR power IS NULL)
SELECT c.name FROM cards c WHERE c.isPromo = 1 AND c.side IS NOT NULL
SELECT types FROM cards WHERE name = 'Molimo, Maro-Sorcerer'
SELECT purchaseUrls FROM cards WHERE promoTypes = 'bundle'
SELECT COUNT(DISTINCT artist) FROM cards WHERE borderColor = 'black' AND availability LIKE '%arena%' AND availability LIKE '%mtgo%'
SELECT name, convertedManaCost FROM cards WHERE name = 'Serra Angel' OR name = 'Shrine Keeper'
SELECT artist FROM cards WHERE flavorName = 'Battra, Dark Destroyer'
SELECT name FROM cards WHERE frameVersion = '2003' ORDER BY convertedManaCost DESC LIMIT 3
SELECT t.translation FROM sets s JOIN set_translations t ON s.code = t.setCode JOIN cards c ON s.code = c.setCode WHERE c.name = 'Ancestor's Chosen' AND t.language = 'Italian'
SELECT COUNT(*) FROM set_translations WHERE setCode = (SELECT code FROM cards WHERE name = 'Angel of Mercy')
SELECT cards.name FROM cards JOIN sets ON cards.setCode = sets.code WHERE sets.name = 'Hauptset Zehnte Edition'
SELECT EXISTS (SELECT * FROM "cards" WHERE name = 'Ancestor\'s Chosen' AND uuid IN (SELECT uuid FROM "foreign_data" WHERE language = 'Korean'))
SELECT COUNT(*) FROM cards WHERE setCode = (SELECT code FROM sets WHERE name = 'Hauptset Zehnte Edition') AND artist = 'Adam Rex'
SELECT baseSetSize FROM sets WHERE name = "Hauptset Zehnte Edition"
SELECT translation FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Eighth Edition' )
SELECT sets.name, sets.mtgoCode FROM sets JOIN cards ON sets.code = cards.setCode WHERE cards.name = 'Angel of Mercy'
SELECT releaseDate FROM sets WHERE name = 'Ancestor''s Chosen'
SELECT sets.type FROM sets, set_translations WHERE sets.code = set_translations.setCode AND set_translations.translation = 'Hauptset Zehnte Edition'
SELECT COUNT(*) FROM sets WHERE block = 'Ice Age' AND code IN (SELECT setCode FROM set_translations WHERE language = 'Italian')
SELECT s.isForeignOnly FROM sets s JOIN cards c ON s.code = c.setCode WHERE c.name = 'Adarkar Valkyrie'
SELECT COUNT(*) FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Italian' AND translation IS NOT NULL) AND baseSetSize < 10
SELECT COUNT(*) FROM cards WHERE setCode = 'CSP' and borderColor = 'black'
SELECT c.name FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Coldsnap' ORDER BY c.convertedManaCost DESC LIMIT 1
SELECT DISTINCT artist FROM cards WHERE name = 'Coldsnap' AND artist IN ('Jeremy Jarvis', 'Aaron Miller', 'Chippy')
SELECT * FROM cards WHERE setCode = 'CSP' AND number = '4'
SELECT COUNT(*) FROM cards WHERE setCode = 'Coldsnap' AND convertedManaCost > 5 AND (power = '*' OR power IS NULL)
SELECT foreign_data.flavorText FROM foreign_data JOIN cards ON foreign_data.uuid = cards.uuid WHERE cards.name = 'Ancestor''s Chosen' AND foreign_data.language = 'Italian'
SELECT DISTINCT language FROM foreign_data WHERE flavorText IS NOT NULL AND uuid = (SELECT uuid FROM cards WHERE name = 'Ancestor''s Chosen')
SELECT c.type FROM cards c JOIN foreign_data f ON c.uuid = f.uuid WHERE c.name = 'Ancestor''s Chosen' AND f.language = 'German'
SELECT rulings.text FROM cards JOIN rulings ON cards.uuid = rulings.uuid JOIN sets ON cards.setCode = sets.code WHERE sets.name = 'Coldsnap' AND rulings.language = 'Italian'
SELECT cards.name FROM cards JOIN sets ON cards.setCode = sets.code JOIN set_translations ON sets.code = set_translations.setCode WHERE sets.name = 'Coldsnap' AND set_translations.language = 'Italian' ORDER BY cards.convertedManaCost DESC LIMIT 1
SELECT rulings.date FROM rulings JOIN cards ON rulings.uuid = cards.uuid WHERE cards.name = 'Reminisce'
SELECT (COUNT(*) * 100) / (SELECT COUNT(*) FROM cards WHERE setCode = 'Coldsnap') FROM cards WHERE convertedManaCost = 7 AND setCode = 'Coldsnap'
SELECT ROUND((SUM(cards.cardKingdomFoilId = cards.cardKingdomId AND cards.cardKingdomId IS NOT NULL) * 100.0 / SUM(cards.name = 'Coldsnap')), 2) AS percentage_of_incredibly_powerful FROM cards WHERE cards.set_code = 'Coldsnap'
SELECT code FROM sets WHERE releaseDate = '2017-07-14'
SELECT keyruneCode FROM sets WHERE code = 'PKHC'
SELECT mcmId FROM sets WHERE code = 'SS2'
SELECT sets.mcmName FROM sets WHERE sets.releaseDate = '2017-06-09'
SELECT s.type FROM sets s WHERE s.name = 'From the Vault: Lore'
SELECT parentCode FROM sets WHERE name = 'Commander 2014 Oversized'
SELECT cards.* FROM cards INNER JOIN rulings ON cards.uuid = rulings.uuid WHERE cards.artist = 'Jim Pavelec'
SELECT releaseDate FROM sets WHERE code = (SELECT setCode FROM cards WHERE name = 'Evacuation')
SELECT sets.name, sets.baseSetSize FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.translation = 'Rinascita di Alara'
SELECT sets.type FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.translation = 'Huitième édition'
SELECT s.translation FROM set_translations s JOIN cards c ON c.setCode = s.setCode WHERE c.name = "Tendo Ice Bridge" AND s.language = 'French'
SELECT COUNT(translation) FROM set_translations WHERE setCode = (SELECT code FROM sets WHERE name = 'Salvat 2011')
SELECT set_translations.translation AS japanese_name FROM sets JOIN set_translations ON sets.code = set_translations.setCode JOIN cards ON sets.code = cards.setCode WHERE cards.name = 'Fellwar Stone' AND set_translations.language = 'Japanese'
SELECT c.name FROM cards c JOIN sets s ON c.setCode = s.code WHERE s.name = 'Journey into Nyx Hero''s Path' ORDER BY c.convertedManaCost DESC LIMIT 1
SELECT releaseDate FROM sets WHERE name = 'Ola de frío'
SELECT sets.type FROM cards JOIN sets ON cards.setCode = sets.code WHERE cards.name = 'Samite Pilgrim'
SELECT COUNT(*) FROM cards WHERE name = 'World Championship Decks 2004' AND convertedManaCost = 3
SELECT set_translations.translation FROM set_translations JOIN sets ON set_translations.setCode = sets.code WHERE sets.name = 'Mirrodin' AND set_translations.language = 'Chinese Simplified'
SELECT (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE st.language = 'Japanese')) AS percentage FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.isNonFoilOnly = 1 AND st.language = 'Japanese'
SELECT DIVIDE(SUM(CASE WHEN isOnlineOnly = 1 THEN 1 ELSE 0 END), SUM(CASE WHEN language = 'Portuguese (Brazil)' THEN 1 ELSE 0 END))*100 FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Portuguese (Brazil)')
SELECT cards.availability FROM cards WHERE cards.artist = 'Aleksi Briclot' AND cards.isTextless = 1
SELECT id FROM sets WHERE baseSetSize = (SELECT MAX(baseSetSize) FROM sets)
SELECT cards.artist FROM cards WHERE cards.faceName IS NULL ORDER BY cards.convertedManaCost DESC LIMIT 1
SELECT frameEffects, COUNT(*) AS freq FROM cards WHERE cardKingdomFoilId IS NOT NULL AND cardKingdomId IS NOT NULL GROUP BY frameEffects ORDER BY freq DESC LIMIT 1
SELECT COUNT(*) FROM cards WHERE power IS NULL AND hasFoil = 0 AND duelDeck = 'a'
SELECT s.id FROM sets s WHERE s.type = 'commander' ORDER BY s.totalSetSize DESC LIMIT 1
SELECT c.name FROM cards c JOIN legalities l ON c.uuid = l.uuid WHERE l.format = 'duel' ORDER BY c.convertedManaCost DESC LIMIT 10
SELECT MIN(originalReleaseDate) as oldest_release_date, GROUP_CONCAT(format) as legal_play_formats FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE rarity = 'mythic' GROUP BY rarity
SELECT COUNT(*) FROM cards JOIN foreign_data ON cards.uuid = foreign_data.uuid WHERE cards.artist = 'Volkan Baga' AND foreign_data.language = 'French'
SELECT COUNT(*) FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE rarity = 'rare' AND types = 'Enchantment' AND name = 'Abundance' AND status = 'Legal'
SELECT format, name FROM legalities JOIN cards ON legalities.uuid = cards.uuid WHERE status = 'banned' GROUP BY format ORDER BY COUNT(*) DESC LIMIT 1
SELECT s.language FROM sets s JOIN set_translations st ON s.code = st.setCode WHERE s.name = 'Battlebond'
SELECT artist AS illustrator, COUNT(*) AS card_count, format AS play_format FROM ( SELECT c.artist, c.uuid, l.format FROM cards c JOIN legalities l ON c.uuid = l.uuid ) GROUP BY illustrator ORDER BY card_count LIMIT 1
SELECT legalities.status FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE cards.frameVersion = '1997' AND cards.artist = 'D. Alexander Gregory' AND legalities.format = 'legacy' AND (cards.hasContentWarning = 1 OR cards.setCode = 'WOC')
SELECT cards.name, legalities.format FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE edhrecRank = 1 AND legalities.status = 'banned'
SELECT AVG(totalSetSize) AS annual_avg_sets, MAX(COUNT(language)) AS common_language FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE releaseDate BETWEEN '2012-01-01' AND '2015-12-31'
SELECT DISTINCT artist FROM cards WHERE borderColor = 'black' AND availability = 'arena'
SELECT cards.uuid FROM cards JOIN legalities ON cards.uuid = legalities.uuid WHERE legalities.format = 'oldschool' AND (legalities.status = 'restricted' OR legalities.status = 'banned')
SELECT COUNT(*) FROM cards WHERE artist = 'Matthew D. Wilson' AND availability = 'paper'
SELECT rulings.text FROM rulings JOIN cards ON rulings.uuid = cards.uuid WHERE cards.artist = 'Kev Walker' ORDER BY rulings.date DESC
SELECT cards.name, legalities.format FROM cards JOIN sets ON cards.setCode = sets.code JOIN legalities ON cards.uuid = legalities.uuid WHERE sets.name = 'Hour of Devastation' AND legalities.status = 'legal'
SELECT sets.name FROM sets JOIN set_translations ON sets.code = set_translations.setCode WHERE set_translations.language NOT LIKE '%Japanese%' AND set_translations.language = 'Korean'
SELECT frameVersion FROM cards GROUP BY frameVersion
SELECT MAX(Reputation) as Highest_Reputation FROM users WHERE DisplayName = 'Harlan' OR DisplayName = 'Jarrod Dixon'
SELECT DisplayName FROM users WHERE strftime('%Y', CreationDate) = '2014'
SELECT COUNT(*) FROM users WHERE LastAccessDate > '2014-09-01 00:00:00'
SELECT DisplayName FROM users ORDER BY Views DESC LIMIT 1
SELECT COUNT(DISTINCT users.Id) FROM users JOIN votes ON users.Id = votes.UserId WHERE UpVotes > 100 AND DownVotes > 1
SELECT COUNT(*) FROM users WHERE Views > 10 AND strftime('%Y', CreationDate) > '2013'
SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie')
SELECT posts.Title FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = "csgillespie"
SELECT users.DisplayName FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE posts.Title = "Eliciting priors from experts"
SELECT Title FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = "csgillespie" ORDER BY ViewCount DESC LIMIT 1
SELECT users.DisplayName FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE FavoriteCount = (SELECT MAX(FavoriteCount) FROM posts)
SELECT SUM(posts.CommentCount) FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'csgillespie'
SELECT MAX(posts.AnswerCount) as Max_AnswerCount FROM posts INNER JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = "csgillespie"
SELECT u.DisplayName FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Title = "Examples for teaching: Correlation does not mean causation"
SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = "csgillespie") AND ParentId IS NULL
SELECT users.DisplayName FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE posts.ClosedDate IS NOT NULL
SELECT COUNT(*) FROM posts WHERE OwnerUserId IN (SELECT Id FROM users WHERE Age > 65) AND Score >= 20
SELECT users.Location FROM users JOIN posts ON users.Id = posts.OwnerUserId WHERE posts.Title = 'Eliciting priors from experts'
SELECT p.Body FROM posts p JOIN tags t ON p.Id = t.ExcerptPostId WHERE t.TagName = "bayesian"
SELECT posts.Body FROM posts JOIN tags ON tags.ExcerptPostId = posts.Id WHERE tags.Count = (SELECT MAX(Count) FROM tags)
SELECT COUNT(*) FROM badges WHERE UserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie')
SELECT Name FROM badges WHERE UserId = (SELECT Id FROM users WHERE DisplayName = "csgillespie")
SELECT COUNT(*) FROM badges JOIN users ON badges.UserId = users.Id WHERE users.DisplayName = "csgillespie" AND strftime('%Y', badges.Date) = '2011'
SELECT u.DisplayName FROM users u JOIN badges b ON u.Id = b.UserId GROUP BY u.Id ORDER BY COUNT(b.Id) DESC LIMIT 1
SELECT AVG(posts.Score) FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'csgillespie'
SELECT UserId, AVG(Id) FROM badges JOIN users ON badges.UserId = users.Id WHERE users.Views > 200 GROUP BY UserId
SELECT (CAST((SELECT COUNT(DISTINCT p.Id) FROM posts p INNER JOIN users u ON p.OwnerUserId = u.Id WHERE p.Score > 20 AND u.Age > 65) AS FLOAT) / (SELECT COUNT(DISTINCT p.Id) FROM posts p INNER JOIN users u ON p.OwnerUserId = u.Id WHERE p.Score > 20) * 100) AS PercentageElderOwnedPosts
SELECT COUNT(*) FROM votes WHERE UserId = 58 AND DATE(CreationDate) = '2010-07-19'
SELECT MAX(CreationDate) AS Max_Votes_CreationDate FROM votes
SELECT COUNT(*) FROM badges WHERE Name = 'Revival'
SELECT posts.Title FROM posts JOIN comments ON posts.Id = comments.PostId WHERE comments.Score = (SELECT MAX(Score) FROM comments)
SELECT COUNT(*) FROM posts WHERE ViewCount = 1910
SELECT posts.FavoriteCount FROM posts JOIN comments ON posts.Id = comments.PostId JOIN users ON comments.UserId = users.Id WHERE users.Id = 3025 AND comments.CreationDate = '2014-04-23 20:29:39'
SELECT comments.Text FROM comments JOIN posts ON comments.PostId = posts.Id WHERE posts.ParentId = 107829
SELECT CASE WHEN (SELECT EXISTS(SELECT 1 FROM comments JOIN posts ON comments.PostId = posts.Id WHERE comments.UserId = 23853 AND comments.CreationDate = '2013-07-12 09:08:18.0' AND posts.ClosedDate IS NULL) ) = 1 THEN 'Not well-finished' ELSE 'Well-finished' END AS PostStatus
SELECT u.Reputation FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE p.Id = 65041
SELECT COUNT(Id) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = "Tiago Pasqualini")
SELECT users.DisplayName FROM votes JOIN users ON votes.UserId = users.Id WHERE votes.Id = 6347
SELECT COUNT(*) FROM votes v JOIN posts p ON v.PostId = p.Id WHERE p.Title LIKE '%data visualization%'
SELECT badges.Name FROM badges JOIN users ON badges.UserId = users.Id WHERE users.DisplayName = "DatEpicCoderGuyWhoPrograms"
SELECT CAST(COUNT(DISTINCT posts.Id) as FLOAT) / COUNT(DISTINCT votes.Id) as PostToVoteRatio FROM posts JOIN users ON posts.OwnerUserId = users.Id JOIN votes ON posts.Id = votes.PostId WHERE users.Id = 24
SELECT ViewCount FROM posts WHERE Title = 'Integration of Weka and/or RapidMiner into Informatica PowerCenter/Developer'
SELECT Text FROM comments WHERE Score = 17
SELECT DisplayName FROM users WHERE WebsiteUrl = 'http://stackoverflow.com'
SELECT badges.Name FROM badges JOIN users ON badges.UserId = users.Id WHERE users.DisplayName = 'SilentGhost'
SELECT users.DisplayName FROM comments JOIN users ON users.Id = comments.UserId WHERE comments.Text = 'thank you user93'
SELECT comments.Text FROM comments JOIN users ON comments.UserId = users.Id WHERE users.DisplayName = 'A Lion'
SELECT users.DisplayName, users.Reputation FROM users JOIN posts ON users.Id = posts.OwnerUserId WHERE Title = 'Understanding what Dassault iSight is doing?'
SELECT comments.Text FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.Title = 'How does gentle boosting differ from AdaBoost?'
SELECT DisplayName FROM badges JOIN users ON badges.UserId = users.Id WHERE badges.Name = 'Necromancer' LIMIT 10
SELECT users.DisplayName AS Editor FROM posts JOIN users ON posts.LastEditorUserId = users.Id WHERE posts.Title = 'Open source tools for visualizing multi-dimensional data'
SELECT Title FROM posts WHERE LastEditorUserId = (SELECT Id FROM users WHERE DisplayName = 'Vebjorn Ljosa')
SELECT SUM(p.Score) AS TotalScore, u.WebsiteUrl FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE u.DisplayName = "Yevgeny"
SELECT users.DisplayName, comments.Text FROM users INNER JOIN postHistory ON users.Id = postHistory.UserId INNER JOIN comments ON comments.PostId = postHistory.PostId INNER JOIN posts ON postHistory.PostId = posts.Id WHERE posts.Title = 'Why square the difference instead of taking the absolute value in standard deviation?'
SELECT SUM(BountyAmount) AS TotalBountyAmount FROM votes JOIN posts ON votes.PostId = posts.Id WHERE posts.Title LIKE '%data%'
SELECT users.DisplayName FROM votes JOIN posts ON votes.PostId = posts.Id JOIN users ON votes.UserId = users.Id WHERE posts.Title = 'variance' AND votes.BountyAmount = 50
SELECT posts.Title, comments.Text, posts.Score FROM posts JOIN tags ON posts.Id = tags.Id JOIN comments ON posts.Id = comments.PostId WHERE tags.TagName = 'humor'
SELECT COUNT(*) FROM comments WHERE UserId = 13
SELECT users.Id FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users)
SELECT Id FROM users ORDER BY Views LIMIT 1
SELECT COUNT(DISTINCT UserId) FROM badges WHERE Name = 'Supporter' AND strftime('%Y', Date) = '2011'
SELECT COUNT(UserId) FROM badges GROUP BY UserId HAVING COUNT(Name) > 5
SELECT COUNT(users.Id) FROM users JOIN badges ON users.Id = badges.UserId WHERE users.Location = 'New York' AND (badges.Name = 'Supporter' OR badges.Name = 'Teacher')
SELECT users.DisplayName, users.Reputation FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE posts.Id = 1
SELECT u.DisplayName FROM users u JOIN posts p ON u.Id = p.OwnerUserId JOIN postHistory ph ON p.Id = ph.PostId WHERE p.ViewCount >= 1000 GROUP BY u.Id HAVING COUNT(DISTINCT ph.Id) = 1
SELECT u.Id, u.DisplayName, b.Name FROM users u JOIN comments c ON u.Id = c.UserId JOIN ( SELECT UserId, COUNT(Id) as comment_count FROM comments GROUP BY UserId ORDER BY comment_count DESC LIMIT 1 ) AS max_comments ON u.Id = max_comments.UserId LEFT JOIN badges b ON u.Id = b.UserId
SELECT COUNT(users.Id) FROM users JOIN badges ON badges.UserId = users.Id WHERE users.Location = 'India' AND badges.Name = 'Teacher'
SELECT ( (SELECT COUNT(Name) * 100.0 / (SELECT COUNT(Name) FROM badges WHERE strftime('%Y', Date) = '2010') FROM badges WHERE strftime('%Y', Date) = '2010') - (SELECT COUNT(Name) * 100.0 / (SELECT COUNT(Name) FROM badges WHERE strftime('%Y', Date) = '2011') FROM badges WHERE strftime('%Y', Date) = '2011') ) AS PercentageDifference
SELECT PostHistoryTypeId FROM postHistory WHERE PostId = 3720
SELECT posts.* FROM posts JOIN postLinks ON posts.Id = postLinks.RelatedPostId WHERE postLinks.PostId = 61217
SELECT Score, LinkTypeId FROM postLinks WHERE PostId = 395
SELECT posts.Id FROM posts WHERE posts.Score > 60
SELECT SUM(FavoriteCount) FROM posts WHERE OwnerUserId = 686 AND strftime('%Y', ClosedDate) = '2011'
SELECT AVG(u.UpVotes) AS AvgUpVotes, AVG(u.Age) AS AvgAge FROM users u JOIN posts p ON u.Id = p.OwnerUserId GROUP BY u.Id HAVING COUNT(u.Id) > 10
SELECT COUNT(UserId) FROM badges WHERE Name = "Announcer"
SELECT Name FROM badges WHERE Date = '2010-07-19 19:39:08'
SELECT COUNT(*) FROM comments WHERE Score > 60
SELECT comments.Text FROM comments WHERE comments.CreationDate = '2010-07-19 19:25:47.0'
SELECT COUNT(*) FROM posts WHERE Score = 10
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Reputation = (SELECT MAX(Reputation) FROM users)
SELECT u.Reputation FROM badges b JOIN users u ON b.UserId = u.Id WHERE b.Date = '2010-07-19 19:39:08.0'
SELECT badges.Name FROM badges JOIN users ON badges.UserId = users.Id WHERE users.DisplayName = 'Pierre'
SELECT badges.Date FROM users JOIN badges ON users.Id = badges.UserId WHERE users.Location = 'Rochester, NY'
SELECT (COUNT(DISTINCT UserId) * 100) / (SELECT COUNT(DISTINCT Id) FROM users) AS Percentage FROM badges WHERE Name = "Teacher"
SELECT (COUNT(DISTINCT UserId) * 100.0) / (SELECT COUNT(DISTINCT UserId) FROM badges WHERE Name = "Organizer") AS Percentage FROM badges WHERE UserId IN (SELECT DISTINCT UserId FROM users WHERE Age BETWEEN 13 AND 18) AND Name = "Organizer"
SELECT comments.Score FROM comments JOIN posts ON comments.PostId = posts.Id WHERE posts.CreaionDate = '2010-07-19 19:19:56.0'
SELECT comments.Text FROM comments JOIN posts ON posts.Id = comments.PostId WHERE posts.CreaionDate = '2010-07-19 19:37:33.0'
SELECT users.Age FROM users JOIN badges ON users.Id = badges.UserId WHERE users.Location = 'Vienna, Austria'
SELECT COUNT(*) FROM badges INNER JOIN users ON badges.UserId = users.Id WHERE badges.Name = 'Supporter' AND users.Age BETWEEN 19 AND 65
SELECT SUM(views) as numberOfViews FROM users WHERE CreationDate = '2010-07-19 19:39:08.0'
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Reputation = (SELECT MIN(Reputation) FROM users)
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = "Sharpie"
SELECT COUNT(*) FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.Age > 65 AND b.Name = "Supporter"
SELECT DisplayName FROM users WHERE ID = 30
SELECT COUNT(*) FROM users WHERE Location = 'New York'
SELECT COUNT(*) FROM votes WHERE CreationDate BETWEEN '2010-01-01' AND '2010-12-31'
SELECT COUNT(*) FROM users WHERE Age BETWEEN 19 AND 65
SELECT DisplayName FROM users WHERE Views = (SELECT MAX(Views) FROM users)
SELECT (SELECT COUNT(Id) FROM votes WHERE strftime('%Y', CreationDate) = '2010') / (SELECT COUNT(Id) FROM votes WHERE strftime('%Y', CreationDate) = '2011') as Ratio
SELECT TagName FROM tags WHERE Id IN (SELECT ExcerptPostId FROM tags WHERE Id IN (SELECT PostId FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'John Stauffer')))
SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Daniel Vassallo')
SELECT COUNT(*) FROM votes JOIN users ON votes.UserId = users.Id WHERE users.DisplayName = 'Harlan'
SELECT posts.Id FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'slashnick' ORDER BY posts.AnswerCount DESC LIMIT 1
SELECT MAX(SUM(ViewCount)) AS TotalViews FROM posts WHERE OwnerDisplayName = 'Harvey Motulsky' OR OwnerDisplayName = 'Noah Snyder'
SELECT COUNT(*) FROM posts WHERE posts.Id IN ( SELECT PostId FROM votes WHERE VoteTypeId > 4 AND UserId = ( SELECT Id FROM users WHERE DisplayName = 'Matt Parker' ) )
SELECT COUNT(*) FROM comments WHERE Score < 60 AND UserId = (SELECT Id FROM users WHERE DisplayName = 'Neil McGuigan')
SELECT tags.TagName FROM posts JOIN tags ON tags.Id = posts.Tags LEFT JOIN comments ON comments.PostId = posts.Id JOIN users ON users.Id = posts.OwnerUserId WHERE users.DisplayName = 'Mark Meckes' AND comments.Id IS NULL
SELECT u.DisplayName FROM users u JOIN badges b ON u.Id = b.UserId WHERE b.Name = 'Organizer'
SELECT ROUND( CAST( (SELECT COUNT(posts.Id) FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'Community') * 100.0 / (SELECT COUNT(posts.Id) FROM posts JOIN tags ON posts.Tags like '%' || tags.TagName || '%' WHERE tags.TagName = 'r') AS REAL ), 2) as percentage
SELECT (SELECT SUM(ViewCount) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Mornington')) - (SELECT SUM(ViewCount) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Amos')) as ViewCountDifference
SELECT COUNT(DISTINCT UserId) FROM badges WHERE Name = "commentator" AND strftime('%Y', Date) = '2014'
SELECT COUNT(*) FROM posts WHERE CreationDate BETWEEN '2010-07-21 00:00:00' AND '2010-07-21 23:59:59'
SELECT users.DisplayName, users.Age FROM users WHERE users.Views = (SELECT MAX(Views) FROM users)
SELECT posts.LastEditDate, posts.LastEditorUserId FROM posts WHERE posts.Title = 'Detecting a given face in a database of facial images'
SELECT COUNT(*) FROM comments WHERE Score < 60 AND UserId = 13
SELECT posts.Title, comments.UserDisplayName FROM posts JOIN comments ON posts.Id = comments.PostId WHERE comments.Score > 60
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE strftime('%Y', b.Date) = '2011' AND u.Location = 'North Pole'
SELECT users.DisplayName, users.WebsiteUrl FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE posts.FavoriteCount > 150
SELECT COUNT(*) AS PostHistoryCounts, MAX(LastEditDate) AS LastEditDate FROM posts WHERE Title = "What is the best introductory Bayesian statistics textbook"
SELECT users.LastAccessDate, users.Location FROM badges JOIN users ON badges.UserId = users.Id WHERE badges.Name = 'Outliers'
SELECT posts.Title FROM posts WHERE Title = 'How to tell if something happened in a data set which monitors a value over time'
SELECT posts.Id, badges.Name FROM posts JOIN users ON posts.OwnerUserId = users.Id JOIN badges ON users.Id = badges.UserId WHERE users.DisplayName = 'Samuel' AND STRFTIME('%Y', posts.CreaionDate) = '2013' AND STRFTIME('%Y', badges.Date) = '2013'
SELECT posts.OwnerDisplayName FROM posts WHERE ViewCount = (SELECT MAX(ViewCount) FROM posts)
SELECT users.DisplayName, users.Location FROM tags JOIN posts ON tags.ExcerptPostId = posts.Id JOIN users ON posts.OwnerUserId = users.Id WHERE tags.TagName = 'hypothesis-testing'
SELECT posts.Title, postLinks.LinkTypeId FROM posts JOIN postLinks ON posts.Id = postLinks.PostId WHERE posts.Title = 'What are principal component scores?'
SELECT pt1.OwnerDisplayName as ParentDisplayName FROM posts pt1 JOIN posts pt2 ON pt1.Id = pt2.ParentId WHERE pt2.Score = (SELECT MAX(Score) FROM posts WHERE ParentId IS NOT NULL)
SELECT users.DisplayName, users.WebsiteUrl FROM votes JOIN users ON votes.UserId = users.Id WHERE votes.VoteTypeId = 8 and votes.BountyAmount = (SELECT MAX(BountyAmount) FROM votes WHERE VoteTypeId = 8)
SELECT p.Title FROM posts p WHERE p.ViewCount = (SELECT MAX(ViewCount) FROM posts) ORDER BY p.ViewCount DESC LIMIT 5
SELECT COUNT(*) FROM tags WHERE Count BETWEEN 5000 AND 7000
SELECT OwnerUserId FROM posts WHERE FavoriteCount = ( SELECT MAX(FavoriteCount) FROM posts )
SELECT MAX(Age) FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users)
SELECT COUNT(*) FROM posts p JOIN votes v ON p.Id = v.PostId WHERE STRFTIME('%Y', p.CreaionDate) = '2011' AND v.BountyAmount = 50
SELECT MIN(Age) FROM users
SELECT p.Score FROM posts p JOIN postTags pt ON p.Id = pt.PostId JOIN tags t ON pt.TagId = t.Id WHERE t.Count = (SELECT MAX(Count) FROM tags)
SELECT AVG(num_links) AS average_monthly_links FROM ( SELECT COUNT(pl.Id) AS num_links FROM postLinks pl JOIN posts p ON pl.PostId = p.Id WHERE strftime('%Y', pl.CreationDate) = '2010' AND p.AnswerCount <= 2 GROUP BY strftime('%m', pl.CreationDate) ) subquery
SELECT p.Id FROM votes v JOIN posts p ON v.PostId = p.Id WHERE v.UserId = 1465 ORDER BY p.FavoriteCount DESC LIMIT 1
SELECT Title FROM posts WHERE Id = ( SELECT PostId FROM postLinks WHERE CreationDate = ( SELECT MIN(CreationDate) FROM postLinks ) )
SELECT u.DisplayName FROM users u JOIN badges b ON u.Id = b.UserId GROUP BY u.Id ORDER BY COUNT(b.Name) DESC LIMIT 1
SELECT MIN(CreationDate) FROM votes INNER JOIN users ON votes.UserId = users.Id WHERE DisplayName = 'chl'
SELECT MIN(posts.CreaionDate) FROM users JOIN posts ON posts.OwnerUserId = users.Id WHERE users.Age = (SELECT MIN(Age) FROM users)
SELECT u.DisplayName FROM users u JOIN badges b ON u.Id = b.UserId WHERE b.Name = 'Autobiographer' AND b.Date = (SELECT MIN(Date) FROM badges WHERE Name = 'Autobiographer')
SELECT COUNT(DISTINCT u.Id) FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE u.Location = 'United Kingdom' AND p.FavoriteCount >= 4
SELECT AVG(PostId) FROM votes WHERE UserId IN (SELECT Id FROM users WHERE Age = (SELECT MAX(Age) FROM users))
SELECT DisplayName FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users)
SELECT COUNT(*) FROM users WHERE Reputation > 2000 AND Views > 1000
SELECT DisplayName FROM users WHERE Age BETWEEN 19 AND 65
SELECT COUNT(*) FROM posts WHERE OwnerUserId = (SELECT Id FROM users WHERE DisplayName = 'Jay Stevens') AND strftime('%Y', CreationDate) = '2010'
SELECT p.Id, p.Title FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE u.DisplayName = 'Harvey Motulsky' ORDER BY p.ViewCount DESC LIMIT 1
SELECT Id, Title FROM posts WHERE Score = (SELECT MAX(Score) FROM posts)
SELECT AVG(posts.Score) FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.DisplayName = 'Stephen Turner'
SELECT u.DisplayName FROM users u JOIN posts p ON u.Id = p.OwnerUserId WHERE p.ViewCount > 20000 AND strftime('%Y', p.CreaionDate) = '2011'
SELECT Id, OwnerDisplayName FROM posts WHERE FavoriteCount = (SELECT MAX(FavoriteCount) FROM posts WHERE strftime('%Y', CreationDate) = '2010')
SELECT DIVIDE(COUNT(posts.Id), COUNT(users.Id)) * 100 AS percentage FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.Reputation > 1000 AND STRFTIME('%Y', posts.CreationDate) = '2011'
SELECT COUNT(Id) AS total_users, COUNT(Id) FILTER (WHERE Age BETWEEN 13 AND 18) AS teenage_users, CAST(COUNT(Id) FILTER (WHERE Age BETWEEN 13 AND 18) AS FLOAT) / CAST(COUNT(Id) AS FLOAT) * 100 AS percentage_of_teenage_users FROM users
SELECT SUM(ViewCount) AS TotalViews, u.DisplayName AS LastPoster FROM posts p JOIN users u ON p.OwnerUserId = u.Id WHERE Title = 'Computer Game Datasets'
SELECT COUNT(*) FROM posts WHERE ViewCount > (SELECT AVG(ViewCount) FROM posts)
SELECT COUNT(*) FROM comments WHERE PostId = (SELECT Id FROM posts WHERE Score = (SELECT MAX(Score) FROM posts))
SELECT COUNT(*) FROM posts WHERE ViewCount > 35000 AND CommentCount = 0
SELECT u.DisplayName, u.Location FROM posts p JOIN users u ON p.LastEditorUserId = u.Id WHERE p.Id = 183
SELECT b.Name FROM badges b JOIN users u ON b.UserId = u.Id WHERE u.DisplayName = 'Emmett' ORDER By b.Date DESC LIMIT 1
SELECT COUNT(*) FROM users WHERE Age BETWEEN 19 AND 65 AND UpVotes > 5000
SELECT (stats_badges.CreationDate - u.CreationDate) AS TimeToGetBadge FROM stats_badges JOIN users u ON stats_badges.UserId = u.Id WHERE u.DisplayName = 'Zolomon'
SELECT COUNT(posts.Id) AS NumOfPosts, COUNT(comments.Id) AS NumOfComments FROM posts JOIN users ON posts.OwnerUserId = users.Id JOIN comments ON comments.UserId = users.Id WHERE users.CreationDate = (SELECT MAX(CreationDate) FROM users)
SELECT comments.Text, users.DisplayName FROM posts JOIN comments ON posts.Id = comments.PostId JOIN users ON comments.UserId = users.Id WHERE posts.Title = 'Analysing wind data with R' ORDER BY comments.CreationDate DESC LIMIT 1
SELECT COUNT(*) FROM badges WHERE Name = 'Citizen Patrol'
SELECT COUNT(*) FROM posts JOIN tags ON posts.Id = tags.ExcerptPostId WHERE tags.TagName = 'careers'
SELECT users.Reputation, users.Views FROM users WHERE users.DisplayName = 'Jarrod Dixon'
SELECT COUNT(*) as Comment_count, posts.AnswerCount as Answer_count FROM comments JOIN posts ON comments.PostId = posts.Id WHERE posts.Title = 'Clustering 1D data'
SELECT CreationDate FROM users WHERE DisplayName = 'IrishStat'
SELECT COUNT(*) FROM votes WHERE BountyAmount >= 30
SELECT DIVIDE(COUNT(posts.Id) WHERE Score >= 50, COUNT(posts.Id)) AS percentage FROM posts JOIN users ON posts.OwnerUserId = users.Id WHERE users.Reputation = (SELECT MAX(Reputation) FROM users)
SELECT COUNT(*) FROM posts WHERE Score < 20
SELECT COUNT(*) FROM tags WHERE Id < 15 AND Count <= 20
SELECT ExcerptPostId, WikiPostId FROM tags WHERE TagName = 'sample'
SELECT users.Reputation, users.UpVotes FROM users JOIN comments ON users.Id = comments.UserId WHERE comments.Text = 'fine, you win :)'
SELECT posts.Body FROM posts WHERE posts.Title = 'How can I adapt ANOVA for binary data?'
SELECT c.Text FROM posts p JOIN comments c ON p.Id = c.PostId WHERE p.ViewCount BETWEEN 100 AND 150 ORDER BY c.Score DESC LIMIT 1
SELECT users.CreationDate, users.Age FROM comments JOIN users ON comments.UserId = users.Id WHERE comments.Text LIKE '%http%'
SELECT COUNT(*) FROM comments JOIN posts ON comments.PostId = posts.Id WHERE comments.Score = 0 AND posts.ViewCount < 5
SELECT COUNT(*) FROM comments WHERE Id IN (SELECT PostId FROM posts WHERE CommentCount = 1) AND Score = 0
SELECT COUNT(DISTINCT users.Id) as TotalUsersAge40 FROM comments INNER JOIN users ON comments.UserId = users.Id WHERE comments.Score = 0 AND users.Age = 40
SELECT posts.Id AS PostID, comments.Text AS Comment FROM posts JOIN comments ON posts.Id = comments.PostId WHERE posts.Title = 'Group differences on a five point Likert item'
SELECT users.UpVotes FROM comments JOIN users ON users.Id = comments.UserId WHERE comments.Text = 'R is also lazy evaluated.'
SELECT comments.* FROM comments JOIN users ON comments.UserId = users.Id WHERE users.DisplayName = 'Harvey Motulsky'
SELECT users.DisplayName FROM comments JOIN users ON comments.UserId = users.Id WHERE comments.Score BETWEEN 1 AND 5 AND users.DownVotes = 0
SELECT (COUNT(DISTINCT c.UserId) WHERE c.Score BETWEEN 5 AND 10 AND u.UpVotes = 0) * 100.0 / (COUNT(DISTINCT c.UserId) WHERE c.Score BETWEEN 5 AND 10) AS percentage FROM comments c JOIN users u ON c.UserId = u.Id
SELECT superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.superhero_name = '3-D Man'
SELECT COUNT(DISTINCT hero_id) FROM hero_power JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Super Strength'
SELECT COUNT(*) FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Super Strength' AND superhero.height_cm > 200
SELECT s.superhero_name, COUNT(hp.power_id) as power_count FROM superhero s JOIN hero_power hp ON s.id = hp.hero_id GROUP BY s.id HAVING power_count > 15
SELECT COUNT(*) FROM superhero WHERE eye_colour_id = (SELECT id FROM colour WHERE colour = 'Blue')
SELECT colour.colour FROM superhero JOIN colour ON superhero.skin_colour_id = colour.id WHERE superhero.superhero_name = 'Apocalypse'
SELECT COUNT(DISTINCT s.id) FROM superhero s JOIN colour c ON s.eye_colour_id = c.id JOIN hero_power hp ON s.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE c.colour = 'Blue' AND sp.power_name = 'Agility'
SELECT superhero.superhero_name FROM superhero JOIN colour eye_col ON superhero.eye_colour_id = eye_col.id JOIN colour hair_col ON superhero.hair_colour_id = hair_col.id WHERE eye_col.colour = 'Blue' AND hair_col.colour = 'Blond'
SELECT COUNT(*) FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'Marvel Comics'
SELECT superhero.superhero_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics') ORDER BY superhero.height_cm DESC LIMIT 1
SELECT publisher.publisher_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.superhero_name = 'Sauron'
SELECT COUNT(*) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics') AND eye_colour_id = (SELECT id FROM colour WHERE colour = 'Blue')
SELECT AVG(height_cm) FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'Marvel Comics'
SELECT COUNT(DISTINCT superhero.id) * 100.0 / (SELECT COUNT(DISTINCT superhero.id) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics')) FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics') AND superpower.power_name = 'Super Strength'
SELECT COUNT(*) FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'DC Comics'
SELECT publisher.publisher_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' ORDER BY hero_attribute.attribute_value LIMIT 1
SELECT COUNT(*) FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id JOIN publisher ON superhero.publisher_id = publisher.id WHERE colour.colour = 'Gold' AND publisher.publisher_name = 'Marvel Comics'
SELECT publisher.publisher_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.superhero_name = 'Blue Beetle II'
SELECT COUNT(*) FROM superhero WHERE hair_colour_id = (SELECT id FROM colour WHERE colour = 'Blond')
SELECT superhero.superhero_name FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Intelligence' ORDER BY hero_attribute.attribute_value ASC LIMIT 1
SELECT race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.superhero_name = 'Copycat'
SELECT COUNT(DISTINCT hero_id) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Durability') AND attribute_value < 50
SELECT superhero.superhero_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Death Touch'
SELECT COUNT(DISTINCT superhero.id) FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE gender.gender = 'Female' AND attribute.attribute_name = 'Strength' AND attribute_value = 100
SELECT superhero.superhero_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id GROUP BY superhero.superhero_name ORDER BY COUNT(hero_power.power_id) DESC LIMIT 1
SELECT COUNT(*) FROM superhero WHERE race_id = (SELECT id FROM race WHERE race = 'Vampire')
SELECT ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Bad')), 2) AS percentage, (SELECT COUNT(*) FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Bad') AND publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics')) AS marvel_comics_count FROM superhero
SELECT publisher_name, COUNT(*) AS total_superheroes FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher_name = 'DC Comics' OR publisher_name = 'Marvel Comics' GROUP BY publisher_name
SELECT id FROM publisher WHERE publisher_name = 'Star Trek'
SELECT AVG(a.attribute_value) as average_attribute_value FROM hero_attribute a
SELECT COUNT(*) FROM superhero WHERE full_name IS NULL
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.id = 75
SELECT sp.power_name FROM superhero s INNER JOIN hero_power hp ON s.id = hp.hero_id INNER JOIN superpower sp ON hp.power_id = sp.id WHERE s.superhero_name = 'Deathlok'
SELECT AVG(weight_kg) FROM superhero WHERE gender_id = 2
SELECT hero.superhero_name, power.power_name FROM superhero hero JOIN hero_power hp ON hero.id = hp.hero_id JOIN superpower power ON hp.power_id = power.id JOIN gender g ON hero.gender_id = g.id WHERE g.gender = 'Male' LIMIT 5
SELECT superhero.superhero_name FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Alien'
SELECT superhero.superhero_name FROM superhero WHERE superhero.height_cm BETWEEN 170 AND 190 AND superhero.eye_colour_id = 1
SELECT power_name FROM superpower WHERE id IN ( SELECT power_id FROM hero_power WHERE hero_id = 56 )
SELECT superhero.superhero_name FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Demi-God'
SELECT COUNT(*) FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Bad')
SELECT race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.weight_kg = 169
SELECT colour.colour FROM superhero JOIN race ON superhero.race_id = race.id JOIN colour ON superhero.hair_colour_id = colour.id WHERE race.race = 'human' AND superhero.height_cm = 185
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.weight_kg = (SELECT MAX(weight_kg) FROM superhero)
SELECT COUNT(superhero.id) * 100.0 / (SELECT COUNT(superhero.id) FROM superhero WHERE height_cm >= 150 AND height_cm <= 180) FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE height_cm >= 150 AND height_cm <= 180 AND publisher.publisher_name = 'Marvel Comics'
SELECT s.full_name FROM superhero s JOIN gender g ON s.gender_id = g.id WHERE g.gender = 'male' AND s.weight_kg > (SELECT 0.79 * AVG(s2.weight_kg) FROM superhero s2)
SELECT power_name FROM superpower JOIN hero_power ON superpower.id = hero_power.power_id GROUP BY power_name ORDER BY COUNT(hero_power.hero_id) DESC LIMIT 1
SELECT hero_attribute.attribute_value FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE superhero.superhero_name = 'Abomination'
SELECT superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.id = 1
SELECT COUNT(DISTINCT superhero.id) FROM superhero JOIN hero_power ON hero_power.hero_id = superhero.id JOIN superpower ON superpower.id = hero_power.power_id WHERE superpower.power_name = 'stealth'
SELECT superhero.full_name FROM superhero JOIN hero_attribute ON hero_attribute.hero_id = superhero.id JOIN attribute ON attribute.id = hero_attribute.attribute_id WHERE attribute.attribute_name = 'strength' ORDER BY hero_attribute.attribute_value DESC LIMIT 1
SELECT COUNT(superhero.id) / SUM(CASE WHEN skin_colour_id IS NULL THEN 1 ELSE 0 END) FROM superhero
SELECT COUNT(*) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Dark Horse Comics')
SELECT superhero.superhero_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'durability' AND publisher.publisher_name = 'Dark Horse Comics' ORDER BY hero_attribute.attribute_value DESC LIMIT 1
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.superhero_name = 'Abraham Sapien'
SELECT superhero.superhero_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Flight'
SELECT colour.colour AS eye_colour, as_c.colour AS hair_colour, as_s.colour AS skin_colour FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN colour ON superhero.eye_colour_id = colour.id JOIN colour as as_c ON superhero.hair_colour_id = as_c.id JOIN colour as as_s ON superhero.skin_colour_id = as_s.id JOIN publisher ON superhero.publisher_id = publisher.id WHERE gender.gender = 'Female' AND publisher.publisher_name = 'Dark Horse Comics'
SELECT superhero.superhero_name, publisher.publisher_name FROM superhero INNER JOIN colour ON superhero.eye_colour_id = colour.id AND superhero.hair_colour_id = colour.id AND superhero.skin_colour_id = colour.id INNER JOIN publisher ON superhero.publisher_id = publisher.id
SELECT race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.superhero_name = 'A-Bomb'
SELECT ( (COUNT(hero.id) * 100) / (SELECT COUNT(hero.id) FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE gender.gender = 'Female' AND colour.colour = 'Blue') ) as percentage_blue_female_superheroes FROM superhero INNER JOIN gender ON superhero.gender_id = gender.id INNER JOIN colour ON superhero.eye_colour_id = colour.id WHERE gender.gender = 'Female' AND colour.colour = 'Blue'
SELECT superhero.superhero_name, race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.full_name = 'Charles Chandler'
SELECT gender.gender FROM superhero JOIN gender ON superhero.gender_id = gender.id WHERE superhero.superhero_name = 'Agent 13'
SELECT hero.superhero_name FROM superhero hero JOIN hero_power hp ON hero.id = hp.hero_id JOIN superpower sp ON hp.power_id = sp.id WHERE sp.power_name = 'Adaptation'
SELECT COUNT(power_id) FROM hero_power WHERE hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Amazo')
SELECT superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.full_name = 'Hunter Zolomon'
SELECT superhero.superhero_name, superhero.height_cm FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Amber'
SELECT superhero.superhero_name FROM superhero JOIN colour eye_colour ON superhero.eye_colour_id = eye_colour.id JOIN colour hair_colour ON superhero.hair_colour_id = hair_colour.id WHERE eye_colour.colour = 'Black' AND hair_colour.colour = 'Black'
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.skin_colour_id = (SELECT id FROM colour WHERE colour = 'Gold')
SELECT superhero.full_name FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Vampire'
SELECT hero.superhero_name FROM superhero hero JOIN alignment a ON hero.alignment_id = a.id WHERE a.alignment = 'Neutral'
SELECT COUNT(hero_id) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength') AND attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength'))
SELECT race.race, alignment.alignment FROM superhero JOIN race ON superhero.race_id = race.id JOIN alignment ON superhero.alignment_id = alignment.id WHERE superhero.superhero_name = 'Cameron Hicks'
SELECT COUNT(DISTINCT superhero.id) * 100.0 / (SELECT COUNT(*) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics') AND gender_id = (SELECT id FROM gender WHERE gender = 'Female') ) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics') AND gender_id = (SELECT id FROM gender WHERE gender = 'Female')
SELECT AVG(weight_kg) FROM superhero WHERE race_id = (SELECT id FROM race WHERE race = 'Alien')
SELECT SUM(weight_kg)
SELECT superhero.superhero_name, AVG(superhero.height_cm) AS average_height FROM superhero GROUP BY superhero.superhero_name
SELECT superhero.superhero_name, superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.superhero_name = 'Abomination'
SELECT COUNT(*) FROM superhero WHERE race_id = 21 AND gender_id = 1
SELECT superhero.superhero_name FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON attribute.id = hero_attribute.attribute_id WHERE attribute.attribute_name = 'Speed' ORDER BY hero_attribute.attribute_value DESC LIMIT 1
SELECT COUNT(*) FROM superhero WHERE alignment_id = 3
SELECT attribute.attribute_name, hero_attribute.attribute_value FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE superhero.superhero_name = '3-D Man'
SELECT superhero.superhero_name FROM superhero JOIN colour AS eye_colour ON superhero.eye_colour_id = eye_colour.id JOIN colour AS hair_colour ON superhero.hair_colour_id = hair_colour.id WHERE eye_colour.colour = 'blue' AND hair_colour.colour = 'brown'
SELECT publisher.publisher_name FROM superhero INNER JOIN publisher on superhero.publisher_id = publisher.id WHERE superhero.superhero_name = 'Hawkman' OR superhero.superhero_name = 'Karate Kid' OR superhero.superhero_name = 'Speedy'
SELECT COUNT(*) FROM superhero WHERE publisher_id IS NULL
SELECT (COUNT(superhero.id) * 100.0) / (SELECT COUNT(*) FROM superhero) AS percentage FROM superhero WHERE superhero.eye_colour_id = (SELECT id FROM colour WHERE colour = 'blue')
SELECT (DIVIDE( (SELECT COUNT(*) FROM superhero WHERE gender_id = 1), (SELECT COUNT(*) FROM superhero WHERE gender_id = 2) )) as ratio_male_to_female
SELECT superhero.superhero_name FROM superhero WHERE superhero.height_cm = (SELECT MAX(height_cm) FROM superhero)
SELECT id FROM superpower WHERE power_name = 'cryokinesis'
SELECT superhero_name FROM superhero WHERE id = 294
SELECT superhero.full_name FROM superhero WHERE superhero.weight_kg = 0 OR superhero.weight_kg IS NULL
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.full_name = "Karen Beecher-Duncan"
SELECT superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.full_name = 'Helen Parr'
SELECT race.race FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.weight_kg = 108 AND superhero.height_cm = 188
SELECT publisher.publisher_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE superhero.id = 38
SELECT race.race FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id JOIN race ON superhero.race_id = race.id WHERE hero_attribute.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute)
SELECT alignment.alignment, superpower.power_name FROM superhero JOIN alignment ON superhero.alignment_id = alignment.id JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.superhero_name = 'Atom IV'
SELECT superhero.full_name FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE colour.colour = 'Blue' LIMIT 5
SELECT AVG(attribute_value) FROM hero_attribute WHERE hero_id IN (SELECT id FROM superhero WHERE alignment_id = 3)
SELECT colour.colour FROM superhero JOIN colour ON superhero.skin_colour_id = colour.id JOIN hero_attribute ON superhero.id = hero_attribute.hero_id WHERE hero_attribute.attribute_value = 100
SELECT COUNT(*) FROM superhero WHERE alignment_id = 1 AND gender_id = 2
SELECT superhero.superhero_name FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_value BETWEEN 75 AND 80
SELECT race.race FROM superhero JOIN colour ON superhero.hair_colour_id = colour.id JOIN gender ON superhero.gender_id = gender.id JOIN race ON superhero.race_id = race.id WHERE colour.colour = 'blue' AND gender.gender = 'male'
SELECT ROUND((COUNT(DISTINCT s.id)*100.0) / (SELECT COUNT(DISTINCT s.id) FROM superhero s JOIN alignment a ON s.alignment_id = a.id JOIN gender g ON s.gender_id = g.id WHERE a.alignment = 'bad' AND g.gender = 'female'), 2) AS percentage_female FROM superhero s JOIN alignment a ON s.alignment_id = a.id JOIN gender g ON s.gender_id = g.id WHERE a.alignment = 'bad' AND g.gender = 'female'
SELECT COUNT(*) - (SELECT COUNT(*) FROM superhero WHERE eye_colour_id = 1) AS difference FROM superhero WHERE weight_kg = 0 OR weight_kg IS NULL AND eye_colour_id = 7
SELECT hero_attribute.attribute_value FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE superhero.superhero_name = 'Hulk' AND attribute.attribute_name = 'Strength'
SELECT superpower.power_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.superhero_name = 'Ajax'
SELECT COUNT(*) FROM superhero JOIN alignment ON superhero.alignment_id = alignment.id JOIN colour ON superhero.skin_colour_id = colour.id WHERE alignment.alignment = 'Bad' AND colour.colour = 'Green'
SELECT COUNT(*) FROM superhero WHERE gender_id = (SELECT id FROM gender WHERE gender = 'Female') AND publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics')
SELECT superhero.superhero_name FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Wind Control' ORDER BY superhero.superhero_name ASC
SELECT gender.gender FROM superhero JOIN gender ON superhero.gender_id = gender.id JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Phoenix Force'
SELECT superhero.superhero_name FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'DC Comics' ORDER BY superhero.weight_kg DESC LIMIT 1
SELECT AVG(height_cm) FROM superhero JOIN race ON superhero.race_id = race.id JOIN publisher ON superhero.publisher_id = publisher.id WHERE race.race <> 'Human' AND publisher.publisher_name = 'Dark Horse Comics'
SELECT COUNT(*) FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE attribute.attribute_name = 'Speed' AND hero_attribute.attribute_value = 100
SELECT publisher_name, COUNT(*) as total_superheroes FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id GROUP BY publisher_name
SELECT hero_id, attribute_id, MIN(attribute_value) FROM hero_attribute INNER JOIN superhero ON superhero.id = hero_attribute.hero_id INNER JOIN attribute ON attribute.id = hero_attribute.attribute_id WHERE superhero.superhero_name = 'Black Panther'
SELECT colour.colour FROM superhero LEFT JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.superhero_name = 'Abomination'
SELECT superhero_name FROM superhero WHERE height_cm = (SELECT MAX(height_cm) FROM superhero)
SELECT superhero_name FROM superhero WHERE full_name = 'Charles Chandler'
SELECT (MULTIPLY((COUNT(DISTINCT superhero.id) * 1.0), DIVIDE((COUNT(DISTINCT CASE WHEN superhero.gender_id = (SELECT id FROM gender WHERE gender = 'Female') THEN superhero.id END) * 1.0), COUNT(DISTINCT superhero.id))) * 100) AS percentage_female_superheroes FROM superhero INNER JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher.publisher_name = 'George Lucas'
SELECT ROUND((COUNT(s.id) * 100.0 / (SELECT COUNT(*) FROM superhero WHERE publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics'))) * (SELECT COUNT(*) FROM superhero WHERE alignment_id = (SELECT id FROM alignment WHERE alignment = 'Good' AND publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics'))), 2) AS percentage_good_superheroes FROM superhero s WHERE s.alignment_id = (SELECT id FROM alignment WHERE alignment = 'Good' AND s.publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics')) AND s.publisher_id = (SELECT id FROM publisher WHERE publisher_name = 'Marvel Comics')
SELECT COUNT(*) FROM superhero WHERE full_name LIKE 'John%'
SELECT min(attribute_value) as lowest_attribute_value FROM hero_attribute
SELECT superhero.full_name FROM superhero WHERE superhero.superhero_name = 'Alien'
SELECT superhero.full_name FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.weight_kg < 100 AND colour.colour = 'brown'
SELECT attribute.attribute_name, hero_attribute.attribute_value FROM superhero JOIN hero_attribute ON superhero.id = hero_attribute.hero_id JOIN attribute ON hero_attribute.attribute_id = attribute.id WHERE superhero.superhero_name = 'Aquababy'
SELECT race.race, superhero.weight_kg FROM superhero JOIN race ON superhero.race_id = race.id WHERE superhero.id = 40
SELECT AVG(superhero.height_cm) FROM superhero JOIN alignment ON superhero.alignment_id = alignment.id WHERE alignment.alignment = 'Neutral'
SELECT superhero.id FROM superhero JOIN hero_power ON superhero.id = hero_power.hero_id JOIN superpower ON hero_power.power_id = superpower.id WHERE superpower.power_name = 'Intelligence'
SELECT colour.colour FROM superhero JOIN colour ON superhero.eye_colour_id = colour.id WHERE superhero.superhero_name = 'Blackwulf'
SELECT HP.power_name FROM superhero AS HS JOIN hero_power AS HP ON HS.id = HP.hero_id WHERE HS.height_cm > (SELECT 0.8 * AVG(height_cm) FROM superhero)
SELECT drivers.driverRef FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId WHERE qualifying.raceId = 18 AND qualifying.q1 = ( SELECT MAX(q1) FROM qualifying WHERE raceId = 18 ) ORDER BY drivers.driverId
SELECT drivers.surname FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId WHERE qualifying.raceId = 19 AND qualifying.q2 = (SELECT MIN(q2) FROM qualifying WHERE raceId = 19)
SELECT races.year FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.location = 'Shanghai'
SELECT url FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Circuit de Barcelona-Catalunya'
SELECT races.name FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Germany'
SELECT circuits.circuitRef, circuits.name, circuits.location, circuits.country FROM circuits INNER JOIN constructors ON circuits.circuitId = constructors.constructorId WHERE constructors.name = 'Renault'
SELECT COUNT(r.raceId) FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE r.year = 2010 AND c.country NOT IN ('Asia', 'Europe')
SELECT races.name FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Spain'
SELECT circuits.lat, circuits.lng FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN seasons ON races.year = seasons.year WHERE races.name = 'Australian Grand Prix'
SELECT races.name, races.date, races.time FROM races INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Sepang International Circuit'
SELECT races.date, races.time FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Sepang International Circuit'
SELECT lat, lng FROM circuits WHERE name = 'Abu Dhabi Grand Prix'
SELECT c.country FROM constructors c JOIN constructorResults cr ON c.constructorId = cr.constructorId JOIN races r ON cr.raceId = r.raceId WHERE cr.points = 1 AND r.raceId = 24
SELECT q1 FROM qualifying JOIN drivers on qualifying.driverId = drivers.driverId WHERE drivers.forename = 'Bruno' AND drivers.surname = 'Senna' AND qualifying.raceId = 354
SELECT drivers.nationality FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId WHERE qualifying.q2 = '0:01:40' AND qualifying.raceId = 355
SELECT number FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId WHERE raceId = 903 AND q3 = '0:01:54'
SELECT count(*) FROM results WHERE raceId = (SELECT raceId FROM races WHERE year = 2007 AND name = 'Bahrain Grand Prix') AND statusId != 1
SELECT url FROM seasons WHERE year = (SELECT year FROM races WHERE raceId = 901)
SELECT COUNT(*) FROM results WHERE raceId = ( SELECT raceId FROM races WHERE date = '2015-11-29' )
SELECT drivers.forename, drivers.surname, drivers.dob FROM drivers JOIN results ON drivers.driverId = results.driverId WHERE results.raceId = 592 AND results.time IS NOT NULL ORDER BY drivers.dob ASC LIMIT 1
SELECT drivers.forename, drivers.surname, drivers.url FROM lapTimes JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE lapTimes.raceId = 161 AND lapTimes.time = '0:01:27'
SELECT drivers.forename, drivers.surname, drivers.nationality FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE races.raceId = 933 ORDER BY results.fastestLapSpeed DESC LIMIT 1
SELECT lat, lng FROM circuits WHERE name = 'Malaysian Grand Prix'
SELECT c.url FROM constructors c JOIN constructorResults cr ON c.constructorId = cr.constructorId JOIN races r ON cr.raceId = r.raceId WHERE r.round = 9 ORDER BY cr.points DESC LIMIT 1
SELECT q1 FROM qualifying INNER JOIN drivers ON qualifying.driverId = drivers.driverId WHERE drivers.forename = 'Lucas' AND drivers.surname = 'di Grassi' AND qualifying.raceId = 345
SELECT drivers.nationality FROM qualifying JOIN drivers ON qualifying.driverId = drivers.driverId WHERE qualifying.q2 = '0:01:15' AND qualifying.raceId = 347
SELECT drivers.code FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId JOIN races ON qualifying.raceId = races.raceId WHERE races.raceId = 45 AND qualifying.q3 = '0:01:33'
SELECT results.time FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE races.raceId = 743 AND drivers.forename = 'Bruce' AND drivers.surname = 'McLaren'
SELECT drivers.forename, drivers.surname FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE races.name = 'San Marino Grand Prix' AND races.year = 2006 AND results.position = 2
SELECT url FROM seasons WHERE year = ( SELECT year FROM races WHERE raceId = 901 )
SELECT COUNT(*) FROM results WHERE raceId = (SELECT raceId FROM races WHERE date = '2015-11-29' ) AND position IS NOT NULL
SELECT forename, surname FROM drivers WHERE driverId IN (SELECT driverId FROM results WHERE raceId = 872 AND time IS NOT NULL) ORDER BY dob DESC LIMIT 1
SELECT drivers.forename || ' ' || drivers.surname AS driver_full_name FROM lapTimes JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE lapTimes.raceId = 348 ORDER BY lapTimes.time LIMIT 1
SELECT drivers.nationality FROM results JOIN drivers ON results.driverId = drivers.driverId WHERE results.fastestLapSpeed = (SELECT MAX(fastestLapSpeed) FROM results)
SELECT DIVIDE(SUBTRACT( (SELECT fastestLapSpeed FROM results WHERE raceId = 853 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Paul' AND surname = 'di Resta')), (SELECT fastestLapSpeed FROM results WHERE raceId = 854 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Paul' AND surname = 'di Resta')) ), (SELECT fastestLapSpeed FROM results WHERE raceId = 853 AND driverId = (SELECT driverId FROM drivers WHERE forename = 'Paul' AND surname = 'di Resta')) ) as percentage
SELECT drivers.forename, drivers.surname, (Count(distinct results.driverId) WHERE results.time IS NOT NULL AND races.date = '1983-07-16') / (Count(distinct drivers.driverId) WHERE races.date = '1983-07-16') AS race_completion_rate FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races on results.raceId = races.raceId WHERE races.date = '1983-07-16' GROUP BY drivers.forename, drivers.surname
SELECT races.year FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Singapore Circuit' ORDER BY races.year ASC LIMIT 1
SELECT COUNT(*) FROM races WHERE year = 2005
SELECT races.name FROM races WHERE races.year = (SELECT MIN(year) FROM seasons)
SELECT races.name, races.date FROM races WHERE races.year = 1999 AND races.round = (SELECT MAX(round) FROM races WHERE year = 1999)
SELECT year FROM races GROUP BY year ORDER BY max(round) DESC LIMIT 1
SELECT races.name FROM races WHERE races.year = 2017 AND races.name NOT IN (SELECT races.name FROM races WHERE races.year = 2000)
SELECT circuits.country, circuits.name, circuits.location FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN seasons ON races.year = seasons.year WHERE races.round = 1 AND seasons.year = (SELECT MIN(year) FROM seasons) AND circuits.country = 'Europe'
SELECT r.year FROM seasons r JOIN races ra ON r.year = ra.year JOIN circuits c ON ra.circuitId = c.circuitId WHERE c.name = 'Brands Hatch' AND ra.name = 'British Grand Prix' AND ra.year = (SELECT MAX(year) FROM seasons)
SELECT COUNT(year) FROM races INNER JOIN circuits ON races.circuitId = circuits.circuitId INNER JOIN seasons ON races.year = seasons.year WHERE circuits.name = 'Silverstone Circuit' AND circuits.country = 'United Kingdom' AND races.name = 'British Grand Prix'
SELECT drivers.forename, drivers.surname FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE races.name = 'Singapore Grand Prix' AND races.year = 2010 ORDER BY results.position
SELECT drivers.forename || ' ' || drivers.surname as full_name, MAX(results.points) as max_points FROM drivers JOIN results ON drivers.driverId = results.driverId
SELECT drivers.forename, drivers.surname, results.points FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE races.year = 2017 AND races.name = 'Chinese Grand Prix' ORDER BY results.points DESC LIMIT 3
SELECT MIN(time) as best_lap_time, drivers.forename, drivers.surname, races.name FROM lapTimes JOIN races ON lapTimes.raceId = races.raceId JOIN drivers ON lapTimes.driverId = drivers.driverId GROUP BY best_lap_time ORDER BY best_lap_time
SELECT AVG(milliseconds) FROM lapTimes JOIN races ON lapTimes.raceId = races.raceId JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE drivers.forename = 'Sebastian' AND drivers.surname = 'Vettel' AND races.year = 2009 AND races.name = 'Chinese Grand Prix'
SELECT ROUND((CAST((SELECT COUNT(raceId) FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.surname = 'Hamilton' AND races.year >= 2010 AND results.position > 1) AS REAL) / CAST((SELECT COUNT(raceId) FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.surname = 'Hamilton' AND races.year >= 2010) AS REAL) * 100), 2) as percentage
SELECT drivers.forename, drivers.surname, drivers.nationality, AVG(driverStandings.points) as average_points FROM drivers JOIN driverStandings ON drivers.driverId = driverStandings.driverId GROUP BY drivers.driverId ORDER BY COUNT(driverStandings.wins) DESC, AVG(driverStandings.points) DESC LIMIT 1
SELECT 2022 - year(dob) + 1 as age, forename || " " || surname as name FROM drivers WHERE nationality = 'Japanese' ORDER BY dob ASC LIMIT 1
SELECT c.name FROM circuits c INNER JOIN races r ON c.circuitId = r.circuitId INNER JOIN seasons s ON r.year = s.year WHERE s.year BETWEEN 1990 AND 2000 GROUP BY c.name HAVING COUNT(r.raceId) = 4
SELECT circuits.name, circuits.location, races.name FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN seasons ON seasons.year = races.year WHERE circuits.country = 'USA' AND seasons.year = 2006
SELECT races.name, circuits.name, circuits.location FROM races JOIN circuits ON races.circuitId = circuits.circuitId JOIN seasons ON races.year = seasons.year WHERE strftime('%m', races.date) = '09' AND seasons.year = 2005
SELECT races.name FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE drivers.forename = 'Alex' AND drivers.surname = 'Yoong' AND results.positionOrder < 10
SELECT COUNT(*) FROM results JOIN races ON results.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId JOIN drivers ON results.driverId = drivers.driverId WHERE drivers.forename = 'Michael' AND drivers.surname = 'Schumacher' AND circuits.name = 'Sepang International Circuit' AND results.position = 1
SELECT races.name, races.year FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE drivers.surname = 'Schumacher' AND drivers.forename = 'Michael' ORDER BY results.milliseconds LIMIT 1
SELECT AVG(points) FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Eddie' AND drivers.surname = 'Irvine' AND races.year = 2000
SELECT races.name, results.points FROM races JOIN results ON races.raceId = results.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' ORDER BY races.year LIMIT 1
SELECT races.name, circuits.country FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.year = 2017 ORDER BY races.date
SELECT races.name, races.year, circuits.location FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.laps = (SELECT MAX(laps) FROM results)
SELECT ((SELECT COUNT(*) FROM races WHERE name = 'European Grand Prix' AND country = 'Germany') * 100) / (SELECT COUNT(*) FROM races WHERE name = 'European Grand Prix') as percentage
SELECT lat, lng FROM circuits WHERE name = 'Silverstone Circuit'
SELECT circuitRef, name, lat FROM circuits WHERE name IN ('Silverstone Circuit', 'Hockenheimring', 'Hungaroring') ORDER BY lat DESC LIMIT 1
SELECT circuitRef FROM circuits WHERE name = 'Marina Bay Street Circuit'
SELECT c.country FROM circuits c WHERE c.alt = (SELECT MAX(alt) FROM circuits)
SELECT COUNT(*) FROM drivers WHERE code IS NULL
SELECT nationality FROM drivers WHERE dob = (SELECT MIN(dob) FROM drivers)
SELECT surname FROM drivers WHERE nationality = 'Italian'
SELECT url FROM drivers WHERE forename = 'Anthony' AND surname = 'Davidson'
SELECT driverRef FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton'
SELECT circuits.name FROM races JOIN circuits ON races.circuitId = circuits.circuitId JOIN seasons ON races.year = seasons.year WHERE races.name = 'Spanish Grand Prix' AND seasons.year = 2009
SELECT races.year FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Silverstone Circuit'
SELECT races.name, races.date FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Silverstone Circuit'
SELECT races.time FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE races.year >= 2010 AND races.year < 2020 AND circuits.name = 'Abu Dhabi Circuit'
SELECT COUNT(*) FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Italy'
SELECT races.name, races.date FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Circuit de Barcelona-Catalunya'
SELECT circuits.url FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN seasons ON races.year = seasons.year WHERE races.name = 'Spanish Grand Prix' AND seasons.year = 2009
SELECT MIN(fastestLapTime) FROM results JOIN drivers ON results.driverId = drivers.driverId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton'
SELECT drivers.forename, drivers.surname FROM drivers JOIN results ON drivers.driverId = results.driverId WHERE results.fastestLapSpeed = (SELECT MAX(fastestLapSpeed) FROM results) GROUP BY drivers.driverId
SELECT drivers.driverRef FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE races.name = 'Australian Grand Prix' AND races.year = 2008 ORDER BY results.position LIMIT 1
SELECT r.name FROM results as res JOIN races as r on res.raceId = r.raceId JOIN drivers as d on res.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton'
SELECT r.name, r.date FROM races r JOIN results res ON r.raceId = res.raceId JOIN drivers d ON res.driverId = d.driverId WHERE d.forename = 'Lewis' AND d.surname = 'Hamilton' ORDER BY res.rank LIMIT 1
SELECT max(fastestLapSpeed) FROM results WHERE raceId = (SELECT raceId FROM races WHERE year = 2009 AND name = 'Spanish Grand Prix')
SELECT races.year FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton'
SELECT results.positionOrder FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' AND races.name = 'Australian Grand Prix' AND races.year = 2008
SELECT drivers.forename, drivers.surname FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE races.year = 2008 AND races.name = 'Australian Grand Prix' AND results.grid = 4
SELECT COUNT(*) FROM results JOIN races ON results.raceId = races.raceId WHERE races.year = 2008 AND races.name = 'Australian Grand Prix' AND results.time IS NOT NULL
SELECT results.fastestLapTime FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' AND races.year = 2008 AND races.name = 'Australian Grand Prix'
SELECT results.time FROM results JOIN races ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId WHERE races.year = 2008 AND races.name = 'Australian Grand Prix' AND results.position = 2
SELECT results.position, drivers.forename, drivers.surname, drivers.url FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId WHERE races.year = 2008 AND races.name = 'Australian Grand Prix' AND results.position = 1
SELECT COUNT(*) FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE nationality = 'American' AND year = 2008 AND name = 'Australian Grand Prix'
SELECT COUNT(driverId) FROM results WHERE raceId = (SELECT raceId FROM races WHERE date = '2008-03-16') AND time IS NOT NULL
SELECT SUM(points) FROM results WHERE driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton')
SELECT AVG(STRFTIME('%s', fastestLapTime)) FROM results JOIN drivers ON drivers.driverId = results.driverId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton'
SELECT (SELECT COUNT(DISTINCT driverId) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix')) / (SELECT COUNT(DISTINCT driverId) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix') AND time IS NOT NULL) AS rate_completed_laps_2008_Australian_Grand_Prix
SELECT (results.fastestLapTime - (SELECT results.fastestLapTime FROM results WHERE results.raceId = (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix') AND results.time IS NOT NULL ORDER BY results.position DESC LIMIT 1)) / (SELECT results.fastestLapTime FROM results WHERE results.raceId = (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix') AND position = 1) * 100 AS PercentageFaster FROM results WHERE results.raceId = (SELECT raceId FROM races WHERE year = 2008 AND name = 'Australian Grand Prix') AND results.position = 1
SELECT COUNT(*) FROM circuits WHERE location = 'Melbourne' AND country = 'Australia'
SELECT c.lat, c.lng FROM circuits c WHERE c.country = 'USA'
SELECT COUNT(*) FROM drivers WHERE nationality = 'British' AND dob > '1980-01-01'
SELECT AVG(points) FROM constructorStandings JOIN constructors ON constructorStandings.constructorId = constructors.constructorId WHERE nationality = 'British'
SELECT constructors.name, sum(constructorStandings.points) as total_points FROM constructors JOIN constructorStandings ON constructors.constructorId = constructorStandings.constructorId GROUP BY constructors.name ORDER BY total_points DESC LIMIT 1
SELECT constructors.name FROM constructorStandings INNER JOIN constructors ON constructorStandings.constructorId = constructors.constructorId WHERE constructorStandings.points = 0 AND constructorStandings.raceId = 291
SELECT count(*) FROM constructorStandings INNER JOIN constructors ON constructorStandings.constructorId = constructors.constructorId INNER JOIN constructorResults ON constructorStandings.constructorId = constructorResults.constructorId INNER JOIN races ON races.raceId = constructorResults.raceId WHERE constructors.nationality = 'Japanese' AND constructorStandings.points = 0 GROUP BY constructorStandings.constructorId HAVING COUNT(races.raceId) = 2
SELECT constructors.name FROM constructors JOIN constructorStandings ON constructors.constructorId = constructorStandings.constructorId WHERE constructorStandings.position = 1
SELECT COUNT(DISTINCT constructors.constructorId) FROM constructors JOIN results ON constructors.constructorId = results.constructorId JOIN races ON results.raceId = races.raceId JOIN lapTimes ON races.raceId = lapTimes.raceId WHERE constructors.nationality = 'French' AND lapTimes.lap > 50
SELECT COUNT(driverId) FROM results WHERE driverId IN ( SELECT driverId FROM drivers WHERE nationality = 'Japanese' ) AND raceId IN ( SELECT raceId FROM races WHERE year BETWEEN 2007 AND 2009 AND time IS NOT NULL ) AND year BETWEEN 2007 AND 2009
SELECT races.year, AVG(strftime('%s', results.time)) as average_time_seconds FROM races JOIN results ON races.raceId = results.raceId WHERE results.position = 1 AND results.time NOT NULL GROUP BY races.year
SELECT drivers.forename, drivers.surname FROM drivers JOIN driverStandings ON drivers.driverId = driverStandings.driverId WHERE drivers.dob > '1975-01-01' AND driverStandings.position = 2
SELECT COUNT(*) FROM drivers d JOIN results r ON d.driverId = r.driverId JOIN races ra ON r.raceId = ra.raceId WHERE d.nationality = 'Italian' AND r.time IS NULL
SELECT drivers.forename, drivers.surname FROM results JOIN drivers ON results.driverId = drivers.driverId WHERE results.fastestLapTime = ( SELECT MIN(fastestLapTime) FROM results WHERE fastestLapTime IS NOT NULL )
SELECT results.fastestLap FROM results JOIN races ON results.raceId = races.raceId WHERE races.year = 2009 AND results.position = 1
SELECT AVG(fastestLapSpeed) FROM results JOIN races ON results.raceId = races.raceId WHERE races.name = 'Spanish Grand Prix' AND races.year = 2009
SELECT r.name, s.year FROM races r JOIN results rs ON r.raceId = rs.raceId WHERE rs.milliseconds = (SELECT MIN(milliseconds) FROM results WHERE milliseconds IS NOT NULL)
SELECT (DIVIDE( COUNT(driverId WHERE year(dob) < 1985 AND laps > 50), COUNT(driverId WHERE year BETWEEN 2000 AND 2005) ) * 100 AS percentage FROM drivers
SELECT COUNT(DISTINCT drivers.driverId) FROM drivers JOIN lapTimes ON drivers.driverId = lapTimes.driverId WHERE drivers.nationality = 'French' AND lapTimes.time < '02:00.00'
SELECT code FROM drivers WHERE nationality = 'America'
SELECT raceId FROM races WHERE year = 2009
SELECT COUNT(driverId) FROM results WHERE raceId=18
SELECT driverId FROM drivers ORDER BY strftime('%Y', dob) DESC LIMIT 3
SELECT driverRef FROM drivers WHERE forename = 'Robert' AND surname = 'Kubica'
SELECT COUNT(*) FROM drivers WHERE nationality = 'Australian' AND strftime('%Y', dob) = '1980'
SELECT drivers.forename, drivers.surname, lapTimes.time FROM drivers JOIN lapTimes ON drivers.driverId = lapTimes.driverId WHERE drivers.nationality = 'German' AND drivers.dob BETWEEN '1980-01-01' AND '1990-12-31' ORDER BY lapTimes.time LIMIT 3
SELECT driverRef FROM drivers WHERE dob = (SELECT MIN(dob) FROM drivers WHERE nationality = 'German')
SELECT drivers.driverId, drivers.code FROM drivers JOIN results ON drivers.driverId = results.driverId WHERE drivers.dob = '1971' AND results.fastestLapTime IS NOT NULL
SELECT drivers.forename, drivers.surname FROM drivers JOIN lapTimes ON drivers.driverId = lapTimes.driverId WHERE drivers.nationality = 'Spanish' AND drivers.dob < 1982 ORDER BY lapTimes.time DESC LIMIT 10
SELECT races.year FROM results JOIN races ON results.raceId = races.raceId WHERE results.fastestLapTime IS NOT NULL ORDER BY results.fastestLapTime LIMIT 1
SELECT races.year FROM results INNER JOIN races ON results.raceId = races.raceId WHERE results.fastestLapTime = (SELECT MAX(results.time) FROM results)
SELECT driverId FROM lapTimes WHERE lap = 1 ORDER BY time ASC LIMIT 5
SELECT COUNT(*) FROM results WHERE raceId > 50 AND raceId < 100 AND statusId = 2
SELECT races.name, circuits.location, circuits.lat, circuits.lng FROM races JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.country = 'Austria'
SELECT raceId, COUNT(*) as finishers FROM results WHERE time is not null GROUP BY raceId ORDER BY finishers DESC LIMIT 1
SELECT d.forename || ' ' || d.surname as driver_name, d.nationality, d.dob FROM drivers d JOIN qualifying q ON d.driverId = q.driverId JOIN races r ON q.raceId = r.raceId WHERE q.q2 IS NOT NULL AND r.raceId = 23
SELECT races.name, races.date, races.time FROM races JOIN qualifying ON races.raceId = qualifying.raceId JOIN drivers ON qualifying.driverId = drivers.driverId WHERE drivers.dob = (SELECT MIN(dob) FROM drivers) ORDER BY races.date LIMIT 1
SELECT COUNT(DISTINCT driverId) FROM results WHERE driverId IN ( SELECT driverId FROM drivers WHERE nationality = 'American' ) AND statusId = 2
SELECT c.name as constructor_name, c.url as introduction_website FROM constructors c JOIN constructorStandings cs ON c.constructorId = cs.constructorId WHERE c.nationality = 'Italian' ORDER BY cs.points DESC LIMIT 1
SELECT constructors.url FROM constructors WHERE constructors.constructorId = (SELECT constructorId FROM constructorStandings GROUP BY constructorId ORDER BY SUM(wins) DESC LIMIT 1)
SELECT drivers.forename, drivers.surname FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId WHERE races.name = 'French Grand Prix' AND results.laps >= 3 ORDER BY results.time DESC LIMIT 1
SELECT races.name, lapTimes.time, lapTimes.milliseconds FROM races JOIN lapTimes ON races.raceId = lapTimes.raceId WHERE lapTimes.lap = 1 ORDER BY lapTimes.milliseconds LIMIT 1
SELECT AVG(fastestLapTime) FROM results INNER JOIN races ON results.raceId = races.raceId INNER JOIN drivers ON results.driverId = drivers.driverId WHERE races.year = 2006 AND races.name = 'United States Grand Prix' AND results.rank < 11
SELECT drivers.forename, drivers.surname, AVG(pitStops.milliseconds) AS avg_duration FROM drivers JOIN pitStops ON drivers.driverId = pitStops.driverId WHERE drivers.nationality = 'German' AND drivers.dob BETWEEN '1980-01-01' AND '1985-12-31' GROUP BY drivers.driverId ORDER BY avg_duration LIMIT 5
SELECT drivers.forename, drivers.surname, results.position, results.time FROM races JOIN results ON races.raceId = results.raceId JOIN drivers ON results.driverId = drivers.driverId JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Canadian Grand Prix' AND races.year = 2008 AND results.position = 1
SELECT constructors.constructorRef, constructors.url FROM constructors JOIN results ON constructors.constructorId = results.constructorId JOIN races ON results.raceId = races.raceId WHERE races.name = 'Singapore Grand Prix' AND races.year = 2009 ORDER BY results.position LIMIT 1
SELECT drivers.forename || ' ' || drivers.surname AS full_name, drivers.dob AS date_of_birth FROM drivers WHERE drivers.nationality = 'Austrian' AND (strftime('%Y', drivers.dob) BETWEEN '1981' AND '1991')
SELECT drivers.forename || ' ' || drivers.surname AS full_name, drivers.url AS wiki_page, drivers.dob AS date_of_birth FROM drivers WHERE drivers.nationality = 'German' AND strftime('%Y', drivers.dob) BETWEEN '1971' AND '1985' ORDER BY drivers.dob DESC
SELECT location, country, lat, lng FROM circuits WHERE circuitRef = 'hungaroring'
SELECT constructors.name, constructors.nationality, SUM(results.points) as total_points FROM results JOIN constructors ON results.constructorId = constructors.constructorId JOIN races ON results.raceId = races.raceId WHERE races.name = 'Monaco Grand Prix' AND races.year BETWEEN 1980 AND 2010 GROUP BY constructors.name, constructors.nationality ORDER BY total_points DESC LIMIT 1
SELECT AVG(points) FROM results WHERE raceId IN (SELECT raceId FROM races WHERE name = 'Turkish Grand Prix') AND driverId = (SELECT driverId FROM drivers WHERE surname = 'Hamilton' AND forename = 'Lewis')
SELECT COUNT(raceId) as total_races, COUNT(DISTINCT year) as total_years, COUNT(raceId) / COUNT(DISTINCT year) as avg_races_per_year FROM races WHERE date BETWEEN '2000-01-01' AND '2010-12-31'
SELECT nationality FROM drivers GROUP BY nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT SUM(points) as total_points FROM driverStandings WHERE position = 91
SELECT races.name FROM results JOIN races ON results.raceId = races.raceId WHERE results.fastestLapTime = (SELECT MIN(fastestLapTime) FROM results)
SELECT c.name || ' in ' || c.location || ', ' || c.country AS full_location FROM races r JOIN circuits c ON r.circuitId = c.circuitId WHERE date = (SELECT MAX(date) FROM races) LIMIT 1
SELECT drivers.forename, drivers.surname FROM drivers JOIN qualifying ON drivers.driverId = qualifying.driverId JOIN races ON qualifying.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Marina Bay Street Circuit' AND races.year = 2008 AND qualifying.q3 = (SELECT MIN(q3) FROM qualifying WHERE q3 > 0) AND qualifying.position = 1
SELECT drivers.forename || ' ' || drivers.surname AS full_name, drivers.nationality, races.name AS first_race_name FROM drivers JOIN results ON drivers.driverId = results.driverId JOIN races ON results.raceId = races.raceId WHERE drivers.dob = (SELECT MAX(dob) FROM drivers)
SELECT COUNT(*) FROM results JOIN races ON races.raceId = results.raceId JOIN status ON results.statusId = status.statusId JOIN drivers ON results.driverId = drivers.driverId WHERE races.name = 'Canadian Grand Prix' AND status.status = 'Accident' AND results.driverId = ( SELECT driverId FROM ( SELECT results.driverId, COUNT(*) AS num_accidents FROM results JOIN status ON results.statusId = status.statusId WHERE status.status = 'Accident' GROUP BY results.driverId ORDER BY num_accidents DESC LIMIT 1 ) ) GROUP BY results.driverId
SELECT drivers.forename || ' ' || drivers.surname as full_name, driverStandings.wins FROM drivers JOIN driverStandings ON drivers.driverId = driverStandings.driverId WHERE drivers.dob = (SELECT MIN(dob) FROM drivers)
SELECT MAX(milliseconds) AS longest_time_spent_at_pitstop FROM pitStops
SELECT MIN(milliseconds) AS fastest_lap_time FROM lapTimes
SELECT MAX(duration) FROM pitStops WHERE driverId = (SELECT driverId FROM drivers WHERE driverRef = 'hamilton')
SELECT lap FROM pitStops JOIN races ON pitStops.raceId = races.raceId JOIN drivers ON pitStops.driverId = drivers.driverId WHERE races.year = 2011 AND races.name = 'Australian Grand Prix' AND drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton'
SELECT drivers.forename, drivers.surname, pitStops.duration FROM drivers JOIN pitStops ON drivers.driverId = pitStops.driverId JOIN races ON pitStops.raceId = races.raceId WHERE races.year = 2011 AND races.name = 'Australian Grand Prix'
SELECT driverId, time FROM lapTimes JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE forename = 'Lewis' AND surname = 'Hamilton' ORDER BY milliseconds ASC LIMIT 1
SELECT drivers.forename || ' ' || drivers.surname AS "Driver Name" FROM lapTimes JOIN drivers ON lapTimes.driverId = drivers.driverId WHERE lapTimes.time = (SELECT MIN(time) FROM lapTimes)
SELECT results.position FROM results JOIN drivers ON results.driverId = drivers.driverId JOIN races ON results.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId WHERE drivers.forename = 'Lewis' AND drivers.surname = 'Hamilton' AND results.fastestLap = 1
SELECT results.fastestLapTime FROM results JOIN races ON results.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Austrian Grand Prix Circuit' ORDER BY results.fastestLapTime ASC LIMIT 1
SELECT circuits.name, results.fastestLapTime FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN results ON results.raceId = races.raceId JOIN drivers ON results.driverId = drivers.driverId JOIN status ON results.statusId = status.statusId WHERE circuits.country = 'Italy'
SELECT races.name FROM races INNER JOIN circuits ON races.circuitId = circuits.circuitId WHERE circuits.name = 'Red Bull Ring' AND races.time = (SELECT MIN(time) FROM results WHERE fastestLap = 1)
SELECT pitStops.duration FROM pitStops JOIN races ON pitStops.raceId = races.raceId JOIN circuits ON races.circuitId = circuits.circuitId JOIN drivers ON pitStops.driverId = drivers.driverId WHERE circuits.location = 'Spielberg' AND races.name = 'Austrian Grand Prix' AND drivers.fastestLap = 1 LIMIT 1
SELECT circuits.location, circuits.lat, circuits.lng FROM circuits JOIN races ON circuits.circuitId = races.circuitId JOIN results ON races.raceId = results.raceId WHERE results.fastestLapTime = '1:29.488'
SELECT AVG(milliseconds) FROM pitStops WHERE driverId = (SELECT driverId FROM drivers WHERE forename = 'Lewis' AND surname = 'Hamilton')
SELECT AVG(milliseconds) FROM lapTimes WHERE raceId IN (SELECT raceId FROM races WHERE circuitId IN (SELECT circuitId FROM circuits WHERE country = 'Italy'))
SELECT Player.player_api_id FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes)
SELECT MAX(height) as tallest_player_height, player_name FROM Player
SELECT Player_Attributes.preferred_foot FROM Player_Attributes WHERE Player_Attributes.potential = (SELECT MIN(potential) FROM Player_Attributes)
SELECT COUNT(*) FROM Player_Attributes WHERE overall_rating >= 60 AND overall_rating < 65 AND attacking_work_rate <> 'low' AND defensive_work_rate = 'low'
SELECT p.player_api_id FROM Player_Attributes p ORDER BY p.crossing DESC LIMIT 5
SELECT c.name AS league_name, SUM(m.home_team_goal + m.away_team_goal) AS total_goals FROM League c JOIN Match m ON c.id = m.league_id WHERE m.season = '2015/2016' GROUP BY c.name ORDER BY total_goals DESC LIMIT 1
SELECT Team.team_long_name FROM Match JOIN Team ON Match.home_team_api_id = Team.team_api_id WHERE Match.season = '2015/2016' AND (Match.home_team_goal - Match.away_team_goal) < 0 GROUP BY Team.team_api_id ORDER BY COUNT(*) ASC LIMIT 1
SELECT Player.player_name, Player_Attributes.penalties FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id ORDER BY Player_Attributes.penalties DESC LIMIT 10
SELECT Team.team_long_name AS away_team, COUNT(Match.id) AS away_wins FROM Match JOIN Team ON Match.away_team_api_id = Team.team_api_id JOIN League ON Match.league_id = League.id WHERE League.name = 'Scotland Premier League' AND Match.season = '2009/2010' AND Match.away_team_goal > Match.home_team_goal GROUP BY away_team ORDER BY away_wins DESC LIMIT 1
SELECT Team.team_long_name, Team_Attributes.buildUpPlaySpeed FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id ORDER BY Team_Attributes.buildUpPlaySpeed DESC LIMIT 4
SELECT League.name FROM Match JOIN League ON Match.league_id = League.id WHERE Match.season = '2015/2016' GROUP BY League.name ORDER BY COUNT(*) DESC LIMIT 1
SELECT strftime('%Y', 'now') - strftime('%Y', p.birthday) AS player_age FROM Player p JOIN Player_Attributes pa ON p.player_api_id = pa.player_api_id WHERE pa.sprint_speed >= 97 AND pa.date >= '2013-01-01 00:00:00' AND pa.date <= '2015-12-31 00:00:00'
SELECT League.name, COUNT(Match.id) AS total_matches FROM League JOIN Match ON League.id = Match.league_id GROUP BY League.name ORDER BY total_matches DESC LIMIT 1
SELECT ROUND(AVG(height),2) AS average_height FROM Player WHERE birthday >= '1990-01-01 00:00:00' AND birthday < '1996-01-01 00:00:00'
SELECT Player_Attributes.player_api_id FROM Player_Attributes WHERE overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes WHERE substr(date,1,4) = '2010')
SELECT Team.team_fifa_api_id FROM Team_Attributes JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE buildUpPlaySpeed BETWEEN 51 AND 59
SELECT Team.team_long_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.buildUpPlayPassing > (SELECT AVG(buildUpPlayPassing) FROM Team_Attributes WHERE buildUpPlayPassing IS NOT NULL) AND strftime('%Y', Team_Attributes.date) = '2012'
SELECT SUM(preferred_foot = 'left') * 100.0 / COUNT(player_fifa_api_id) FROM Player_Attributes JOIN Player ON Player_Attributes.player_fifa_api_id = Player.player_fifa_api_id WHERE birthday BETWEEN '1987-01-01 00:00:00' AND '1992-12-31 00:00:00'
SELECT l.name AS league_name, SUM(m.home_team_goal + m.away_team_goal) AS total_goals FROM League l JOIN Match m ON l.id = m.league_id GROUP BY l.name ORDER BY total_goals ASC LIMIT 5
SELECT player_name as "Player Name", AVG(long_shots) as "Average Long Shots" FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE player_name = "Ahmed Samir Farag"
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.height > 180 GROUP BY Player.player_name ORDER BY AVG(Player_Attributes.heading_accuracy) DESC LIMIT 10
SELECT Team.team_long_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.buildUpPlayDribblingClass = 'Normal' AND Team_Attributes.date BETWEEN '2014-01-01 00:00:00' AND '2014-01-31 00:00:00' AND Team_Attributes.chanceCreationPassing < (SELECT AVG(chanceCreationPassing) FROM Team_Attributes) ORDER BY Team_Attributes.chanceCreationPassing DESC
SELECT l.name FROM League l JOIN Match m ON l.id = m.league_id WHERE m.season = '2009/2010' GROUP BY l.name HAVING AVG(m.home_team_goal) > AVG(m.away_team_goal)
SELECT `team_short_name` FROM `Team` WHERE `team_long_name` = 'Queens Park Rangers'
SELECT `player_name` FROM `Player` WHERE substr(`birthday`,1,4) = '1970' AND substr(`birthday`,6,2) = '10'
SELECT attacking_work_rate FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = "Franco Zennaro"
SELECT BuildUpPlayPositioningClass FROM Team_Attributes WHERE team_api_id = (SELECT team_api_id FROM Team WHERE team_long_name = 'ADO Den Haag')
SELECT pa.heading_accuracy AS header_finishing_rate FROM Player_Attributes AS pa JOIN Player AS p ON pa.player_api_id = p.player_api_id AND p.player_name = 'Francois Affolter' WHERE pa.date = '2014-09-18 00:00:00'
SELECT overall_rating FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player.player_name = 'Gabriel Tamas' AND strftime('%Y', Player_Attributes.date) = '2011'
SELECT COUNT(*) FROM Match JOIN League ON Match.league_id = League.id WHERE League.name = 'Scotland Premier League' AND Match.season = '2015/2016'
SELECT Player_Attributes.preferred_foot FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player.birthday = (SELECT MAX(birthday) FROM Player)
SELECT player_name FROM Player WHERE player_api_id IN (SELECT player_api_id FROM Player_Attributes WHERE potential = (SELECT MAX(potential) FROM Player_Attributes))
SELECT COUNT(*) FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.weight < 130 AND Player_Attributes.preferred_foot = 'left'
SELECT Team.team_short_name FROM Team_Attributes JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE Team_Attributes.chanceCreationPassingClass = 'Risky'
SELECT defensive_work_rate FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = "David Wilson"
SELECT Player.birthday FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes)
SELECT `League`.`name` FROM `League` JOIN `Country` ON `Country`.`id` = `League`.`country_id` WHERE `Country`.`name` = 'Netherlands'
SELECT AVG(home_team_goal) FROM Match WHERE country_id = (SELECT id FROM Country WHERE name = 'Poland') AND season = '2010/2011'
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player_Attributes.finishing = (SELECT MAX(Player_Attributes.finishing) FROM Player_Attributes) OR Player_Attributes.finishing = (SELECT MIN(Player_Attributes.finishing) FROM Player_Attributes) GROUP BY Player.player_name ORDER BY AVG(Player_Attributes.finishing) DESC LIMIT 1
SELECT Player.player_name FROM Player WHERE Player.height > 180
SELECT COUNT(*) FROM Player WHERE strftime('%Y', birthday) > '1990'
SELECT COUNT(*) FROM Player WHERE player_name LIKE 'Adam%' AND weight > 170
SELECT Player.player_name FROM Player INNER JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.overall_rating > 80 AND strftime('%Y', Player_Attributes.date) BETWEEN '2008' AND '2010'
SELECT potential FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Doran')
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.preferred_foot = 'left'
SELECT Team.team_long_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.buildUpPlaySpeedClass = 'Fast'
SELECT `buildUpPlayPassingClass` FROM `Team_Attributes` WHERE `team_api_id` = (SELECT `team_api_id` FROM `Team` WHERE `team_short_name` = 'CLB')
SELECT Team.team_short_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.buildUpPlayPassing > 70
SELECT AVG(overall_rating) FROM Player_Attributes JOIN Player ON Player.player_api_id = Player_Attributes.player_api_id WHERE strftime('%Y', Player_Attributes.date) BETWEEN '2010' AND '2015' AND Player.height > 170
SELECT player_name FROM Player WHERE height = (SELECT MIN(height) FROM Player)
SELECT c.name FROM League l JOIN Country c ON l.country_id = c.id WHERE l.name = 'Italy Serie A'
SELECT Team.team_short_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.buildUpPlaySpeed = 31 AND Team_Attributes.buildUpPlayDribbling = 53 AND Team_Attributes.buildUpPlayPassing = 32
SELECT AVG(overall_rating) FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Aaron Doran')
SELECT COUNT(*) FROM Match JOIN League ON Match.league_id = League.id WHERE League.name = 'Germany 1. Bundesliga' AND strftime('%Y-%m', Match.date) BETWEEN '2008-08' AND '2008-10'
SELECT Team.team_short_name FROM Match JOIN Team ON Match.home_team_api_id = Team.team_api_id WHERE Match.home_team_goal = 10
SELECT * FROM Player_Attributes WHERE balance = (SELECT MAX(balance) FROM Player_Attributes) AND potential = 61
SELECT ABS(AVG(ball_control, 'Abdou Diallo') - AVG(ball_control, 'Aaron Appindangoye')) AS difference_of_average_ball_control FROM Player_Attributes
SELECT team_long_name FROM Team WHERE team_short_name = 'GEN'
SELECT Player.player_name, Player.birthday FROM Player WHERE Player.player_name = 'Aaron Lennon' OR Player.player_name = 'Abdelaziz Barrada'
SELECT Player.player_name FROM Player WHERE height = (SELECT MAX(height) FROM Player)
SELECT COUNT(*) FROM Player_Attributes WHERE preferred_foot = 'left' AND attacking_work_rate = 'low'
SELECT Country.name FROM League JOIN Country ON League.country_id = Country.id WHERE League.name = 'Belgium Jupiler League'
SELECT League.name FROM League JOIN Country ON League.country_id = Country.id WHERE Country.name = 'Germany'
SELECT Player.player_name FROM Player INNER JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes)
SELECT COUNT(*) FROM Player_Attributes WHERE (strftime('%Y', date) < '1986') AND (defensive_work_rate = 'high')
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name IN ('Alexis', 'Ariel Borysiuk', 'Arouna Kone') ORDER BY Player_Attributes.crossing DESC LIMIT 1
SELECT `heading_accuracy` FROM `Player_Attributes` WHERE `player_api_id` = (SELECT `player_api_id` FROM `Player` WHERE `player_name` = 'Ariel Borysiuk')
SELECT COUNT(*) FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.height > 180 AND Player_Attributes.volleys > 70
SELECT Player.player_name FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.volleys > 70 AND Player_Attributes.dribbling > 70
SELECT COUNT(*) FROM Match WHERE season = '2008/2009' AND (home_team_api_id IN (SELECT team_api_id FROM Team WHERE team_long_name = 'Belgium') OR away_team_api_id IN (SELECT team_api_id FROM Team WHERE team_long_name = 'Belgium'))
SELECT `long_passing` FROM `Player_Attributes` WHERE `birthday` = (SELECT MIN(birthday) FROM `Player`)
SELECT COUNT(*) FROM Match JOIN League ON Match.league_id = League.id WHERE League.name = 'Belgium Jupiler League' AND strftime('%Y', Match.date) = '2009' AND strftime('%m', Match.date) = '04'
SELECT l.name FROM League l JOIN ( SELECT league_id, COUNT(*) as num_matches FROM Match WHERE season = '2008/2009' GROUP BY league_id ORDER BY num_matches DESC LIMIT 1 ) m ON l.id = m.league_id
SELECT AVG(overall_rating) AS avg_overall_rating FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE strftime('%Y', birthday) < '1986'
SELECT ((overall_rating - (SELECT overall_rating FROM Player_Attributes WHERE player_name = 'Paulin Puel')) / (SELECT overall_rating FROM Player_Attributes WHERE player_name = 'Paulin Puel')) * 100 AS higher_percentage FROM Player_Attributes WHERE player_name = 'Ariel Borysiuk'
SELECT AVG(buildUpPlaySpeed) FROM Team_Attributes WHERE team_api_id = (SELECT team_api_id FROM Team WHERE team_long_name = 'Heart of Midlothian')
SELECT Player_Attributes.player_name, AVG(Player_Attributes.overall_rating) AS average_rating FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Pietro Marino'
SELECT T2.player_name, SUM(T1.crossing) as total_crossing_score FROM Player_Attributes T1 JOIN Player T2 ON T1.player_api_id = T2.player_api_id WHERE T2.player_name = 'Aaron Lennox' GROUP BY T2.player_name
SELECT MAX(chanceCreationPassing) AS highest_chance_creation_passing_score, chanceCreationPassingClass AS classification FROM Team_Attributes INNER JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE Team.team_long_name = 'Ajax'
SELECT preferred_foot FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Abdou Diallo')
SELECT MAX(overall_rating) FROM Player_Attributes INNER JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Dorlan Pabon'
SELECT AVG(away_team_goal) FROM Match WHERE away_team_api_id IN (SELECT team_api_id FROM Team WHERE team_long_name = 'Parma') AND country_id IN (SELECT id FROM Country WHERE name = 'Italy')
SELECT Player.player_name FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.overall_rating = 77 AND Player_Attributes.date = '2016/6/23' ORDER BY Player.birthday ASC LIMIT 1
SELECT overall_rating FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Aaron Mooy' AND date = '2016-02-04 00:00:00'
SELECT potential FROM Player_Attributes WHERE player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Francesco Parravicini') AND date = '2010-08-30 00:00:00'
SELECT attacking_work_rate FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Francesco Migliore' AND Player_Attributes.date = '2015-05-01'
SELECT `defensive_work_rate` FROM `Player_Attributes` JOIN `Player` ON `Player_Attributes`.`player_api_id` = `Player`.`player_api_id` WHERE `Player`.`player_name` = 'Kevin Berigaud' AND `Player_Attributes`.`date` = '2013-02-22'
SELECT Player_Attributes.date FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Kevin Constant' AND Player_Attributes.crossing = (SELECT MAX(crossing) FROM Player_Attributes WHERE player_api_id IN (SELECT player_api_id FROM Player WHERE player_name = 'Kevin Constant')) ORDER BY Player_Attributes.date LIMIT 1
SELECT `buildUpPlaySpeedClass` FROM `Team_Attributes` JOIN `Team` ON `Team_Attributes`.`team_api_id` = `Team`.`team_api_id` WHERE `Team`.`team_long_name` = 'Willem II' AND `Team_Attributes`.`date` = '2012-02-22 00:00:00'
SELECT Team_Attributes.buildUpPlayDribblingClass FROM Team_Attributes JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE Team.team_short_name = 'LEI' AND Team_Attributes.date = '2015-09-10'
SELECT Team_Attributes.buildUpPlayPassingClass FROM Team_Attributes JOIN Team ON Team_Attributes.team_fifa_api_id = Team.team_fifa_api_id WHERE Team.team_long_name = 'FC Lorient' AND Team_Attributes.date = '2010-02-22'
SELECT Team_Attributes.chanceCreationPassingClass FROM Team_Attributes JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE Team.team_long_name = 'PEC Zwolle' AND Team_Attributes.date = '2013-09-20 00:00:00'
SELECT ta.chanceCreationCrossingClass FROM Team_Attributes ta JOIN Team t ON ta.team_api_id = t.team_api_id WHERE t.team_long_name = 'Hull City' AND ta.date = '2010-02-22 00:00:00'
SELECT `Team_Attributes`.`defenceAggressionClass` FROM `Team_Attributes` JOIN `Team` ON `Team_Attributes`.`team_api_id` = `Team`.`team_api_id` WHERE `Team`.`team_long_name` = 'Hannover 96' AND `Team_Attributes`.`date` = '2015-09-10 00:00:00'
SELECT AVG(overall_rating) FROM Player_Attributes INNER JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.player_name = 'Marko Arnautovic' AND date BETWEEN '2007-02-22 00:00:00' AND '2016-04-21 00:00:00'
SELECT ((pd.overall_rating - pb.overall_rating) / pb.overall_rating) * 100 AS percentage FROM Player_Attributes pd JOIN Player pdon ON pd.player_api_id = pdon.player_api_id JOIN Player_Attributes pb ON pb.player_api_id = (SELECT player_api_id FROM Player WHERE player_name = 'Jordan Bowery') WHERE pdon.player_name = 'Landon Donovan' AND pd.date = '2013-07-12'
SELECT Player.player_name FROM Player ORDER BY Player.height DESC LIMIT 5
SELECT Player.player_api_id FROM Player ORDER BY weight DESC LIMIT 10
SELECT Player.player_name FROM Player WHERE strftime('%Y', 'now') - strftime('%Y', Player.birthday) > 34
SELECT SUM(home_team_goal) AS home_team_goals_by_Aaron_Lennon FROM "Match" JOIN "Player" ON "Match"."home_player_1" = "Player"."player_api_id" WHERE "Player"."player_name" = 'Aaron Lennon'
SELECT SUM(M.away_team_goal) AS total_away_goals FROM Match M JOIN Team T ON M.away_team_api_id = T.team_api_id JOIN Player P ON M.away_player_1 = P.player_api_id OR M.away_player_2 = P.player_api_id OR M.away_player_3 = P.player_api_id OR M.away_player_4 = P.player_api_id OR M.away_player_5 = P.player_api_id OR M.away_player_6 = P.player_api_id OR M.away_player_7 = P.player_api_id OR M.away_player_8 = P.player_api_id OR M.away_player_9 = P.player_api_id OR M.away_player_10 = P.player_api_id OR M.away_player_11 = P.player_api_id WHERE P.player_name = 'Daan Smith' OR P.player_name = 'Filipe Ferreira'
SELECT SUM(Match.home_team_goal) FROM Match JOIN Player ON Match.home_player_1 = Player.player_api_id OR Match.home_player_2 = Player.player_api_id OR Match.home_player_3 = Player.player_api_id OR Match.home_player_4 = Player.player_api_id OR Match.home_player_5 = Player.player_api_id OR Match.home_player_6 = Player.player_api_id OR Match.home_player_7 = Player.player_api_id OR Match.home_player_8 = Player.player_api_id OR Match.home_player_9 = Player.player_api_id OR Match.home_player_10 = Player.player_api_id OR Match.home_player_11 = Player.player_api_id WHERE strftime('%Y', 'now') - strftime('%Y', Player.birthday) < 31
SELECT Player.player_name FROM Player INNER JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes) LIMIT 10
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player_Attributes.potential = (SELECT MAX(potential) FROM Player_Attributes)
SELECT Player.player_name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player_Attributes.attacking_work_rate = 'high'
SELECT Player.player_name FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.finishing = 1 ORDER BY datetime('now') - datetime(Player.birthday) DESC LIMIT 1
SELECT Player.player_name FROM Player JOIN Country ON Country.name = "Belgium" WHERE Player.player_country_id = Country.id
SELECT Player.player_name, Country.name FROM Player_Attributes JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id JOIN Country ON Player_Attributes.player_fifa_api_id = Country.id WHERE Player_Attributes.vision >= 90
SELECT Country.name FROM Player INNER JOIN Country ON Player.country_id = Country.id GROUP BY Country.name ORDER BY AVG(Player.weight) DESC LIMIT 1
SELECT Team.team_long_name FROM Team_Attributes INNER JOIN Team ON Team_Attributes.team_api_id = Team.team_api_id WHERE Team_Attributes.buildUpPlaySpeedClass = 'Slow'
SELECT Team.team_short_name FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team_Attributes.chanceCreationPassingClass = 'Safe'
SELECT AVG(height) FROM Player WHERE id IN (SELECT id FROM Player WHERE player_api_id IN (SELECT player_api_id FROM Player WHERE player_fifa_api_id IN (SELECT player_fifa_api_id FROM Player WHERE player_name IN (SELECT player_name FROM Player WHERE player_fifa_api_id IN (SELECT player_fifa_api_id FROM Player_Attributes WHERE id IN (SELECT id FROM Player_Attributes WHERE player_api_id IN (SELECT player_api_id FROM Player_Attributes WHERE player_fifa_api_id IN (SELECT player_fifa_api_id FROM Player_Attributes WHERE player_api_id IN (SELECT player_api_id FROM Player WHERE player_name IN (SELECT player_name FROM Player WHERE player_fifa_api_id IN (SELECT player_fifa_api_id FROM Player WHERE player_name IN (SELECT player_name FROM Player WHERE id IN (SELECT id FROM Player WHERE player_api_id IN (SELECT player_api_id FROM Country WHERE name = 'Italy'))))))))))))))
SELECT player_name FROM Player WHERE height > 180 ORDER BY player_name LIMIT 3
SELECT COUNT(*) FROM Player WHERE player_name LIKE 'Aaron%' AND birthday > '1990'
SELECT abs((SELECT jumping FROM Player_Attributes WHERE id = 6) - (SELECT jumping FROM Player_Attributes WHERE id = 23)) AS difference_of_jumping_scores
SELECT p.player_api_id FROM Player_Attributes p WHERE p.potential = (SELECT MIN(potential) FROM Player_Attributes) AND p.preferred_foot = 'right' ORDER BY p.overall_rating DESC LIMIT 3
SELECT COUNT(*) FROM Player_Attributes WHERE crossing = (SELECT MAX(crossing) FROM Player_Attributes) AND preferred_foot = 'left'
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Player_Attributes WHERE strength > 80 AND stamina > 80) as percentage FROM Player_Attributes WHERE strength > 80 AND stamina > 80
SELECT `Country`.`name` FROM `Country` JOIN `League` ON `Country`.`id` = `League`.`country_id` WHERE `League`.`name` = 'Poland Ekstraklasa'
SELECT home_team_goal, away_team_goal FROM Match JOIN League ON Match.league_id = League.id JOIN Country ON League.country_id = Country.id JOIN Team AS HomeTeam ON Match.home_team_api_id = HomeTeam.team_api_id JOIN Team AS AwayTeam ON Match.away_team_api_id = AwayTeam.team_api_id WHERE Country.name = 'Belgium' AND League.name = 'Jupiler League' AND Match.date LIKE '2008-09-24%'
SELECT `Player_Attributes`.`sprint_speed`, `Player_Attributes`.`agility`, `Player_Attributes`.`acceleration` FROM `Player_Attributes` JOIN `Player` ON `Player_Attributes`.`player_api_id` = `Player`.`player_api_id` WHERE `Player`.`player_name` = 'Alexis Blin'
SELECT Team.team_long_name, Team_Attributes.buildUpPlaySpeedClass FROM Team JOIN Team_Attributes ON Team.team_api_id = Team_Attributes.team_api_id WHERE Team.team_long_name = 'KSV Cercle Brugge'
SELECT COUNT(*) FROM Match WHERE season = '2015/2016' AND league_id = ( SELECT id FROM League WHERE name = 'Italian Serie A' )
SELECT MAX(home_team_goal) FROM Match WHERE league_id = ( SELECT id FROM League WHERE name = 'Eredivisie' AND country_id = ( SELECT id FROM Country WHERE name = 'Netherlands' ) )
SELECT Player.player_name, Player.weight, Player_Attributes.finishing, Player_Attributes.curve FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player.weight = (SELECT MAX(weight) FROM Player)
SELECT League.name FROM Match JOIN Team ON Match.home_team_api_id = Team.team_api_id JOIN League ON Team.team_long_name = League.name WHERE Match.season = '2015/2016' GROUP BY League.name ORDER BY COUNT(Match.id) DESC LIMIT 1
SELECT Team.team_long_name FROM Match JOIN Team ON Match.away_team_api_id = Team.team_api_id GROUP BY Team.team_long_name ORDER BY MAX(Match.away_team_goal) DESC LIMIT 1
SELECT Player.player_name FROM Player JOIN Player_Attributes ON Player.player_api_id = Player_Attributes.player_api_id WHERE Player_Attributes.overall_rating = (SELECT MAX(overall_rating) FROM Player_Attributes)
SELECT ROUND((COUNT(*) * 1.0) / (SELECT COUNT(*) FROM Player WHERE height < 180) * 100, 2) AS percentage FROM Player_Attributes INNER JOIN Player ON Player_Attributes.player_api_id = Player.player_api_id WHERE Player.height < 180 AND Player_Attributes.strength > 70
SELECT SUBTRACT(COUNT(ID) where SEX = 'M' and Admission = '+', COUNT(ID) where SEX = 'M' and Admission = '-') as Deviation FROM Patient WHERE SEX = 'M' and Admission in ('+', '-')
SELECT DIVIDE( SELECT COUNT(ID) FROM Patient WHERE STRFTIME('%Y', Birthday) > '1930' AND SEX = 'F', SELECT COUNT(ID) FROM Patient WHERE SEX = 'F' ) * 100 AS Percentage_female_born_after_1930
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Patient WHERE Year(Birthday) BETWEEN '1930-01-01' AND '1940-12-31') AS Percentage FROM Patient WHERE Year(Birthday) BETWEEN '1930-01-01' AND '1940-12-31' AND Admission = '+'
SELECT DIVIDE( (SELECT COUNT(ID) FROM Patient WHERE Diagnosis = 'SLE' AND Admission = '-') , (SELECT COUNT(ID) FROM Patient WHERE Diagnosis = 'SLE' AND Admission = '+') ) as Ratio_Outpatient_Inpatient FROM Patient
SELECT Diagnosis, Date FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.ID = 30609
SELECT Patient.SEX, Patient.Birthday, Examination.`Examination Date`, Examination.Symptoms FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Patient.ID = 163109
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE LDH > 500
SELECT Patient.ID, (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) AS age FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE RVVT = '+'
SELECT Patient.ID, Patient.SEX, Patient.Diagnosis FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Examination.Thrombosis = 2
SELECT Patient.ID, Patient.SEX, Patient.Birthday, Patient.`First Date`, Patient.Admission, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE strftime('%Y', Patient.Birthday) = '1937' AND `T-CHO` >= 250
SELECT Patient.ID, Patient.SEX, Patient.Diagnosis FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.ALB < 3.5
SELECT DIVIDE(COUNT(DISTINCT ID where SEX = 'F' and (TP < 6.0 or TP > 8.5)), COUNT(DISTINCT ID)) * 100 FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID
SELECT AVG(aCL IgG) FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Patient.Admission = '+' AND (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) >= 50
SELECT COUNT(*) FROM Patient WHERE SEX = 'F' AND YEAR(Description) = '1997' AND Admission = '-'
SELECT ID, MIN(SUBTRACT(YEAR(Birthday), YEAR(`First Date`))) as "Age at Arrival" FROM Patient GROUP BY ID ORDER BY "Age at Arrival" ASC LIMIT 1
SELECT COUNT(*) FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Thrombosis = 1 AND `Examination Date` LIKE '1997%' AND Patient.SEX = 'F'
SELECT
SELECT Symptoms, Diagnosis FROM Examination WHERE ID = (SELECT ID FROM Patient WHERE Birthday = (SELECT MIN(Birthday) FROM Patient))
SELECT ROUND(DIVIDE(COUNT(DISTINCT Patient.ID), 12), 2) as Avg_Male_Patients_Tested_Per_Month FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE SEX = 'M' AND Date BETWEEN '1998-01-01' AND '1998-12-31'
SELECT MAX(l.Date) as `Laboratory Completion Date`, (strftime('%Y', l.Date) - strftime('%Y', p.Birthday)) as `Age at Hospital Arrival` FROM Laboratory l JOIN Patient p ON l.ID = p.ID WHERE p.Diagnosis = 'SJS'
SELECT SUM(CASE WHEN SEX = 'M' AND UA <= 8.0 THEN 1 ELSE 0 END) as male_abnormal_uric_acid_count, SUM(CASE WHEN SEX = 'F' AND UA <= 6.5 THEN 1 ELSE 0 END) as female_abnormal_uric_acid_count, SUM(CASE WHEN UA <= 8.0 THEN 1 ELSE 0 END) as total_male_count, SUM(CASE WHEN UA <= 6.5 THEN 1 ELSE 0 END) as total_female_count FROM Laboratory WHERE UA IS NOT NULL
SELECT COUNT(*) FROM Patient WHERE NOT EXISTS ( SELECT * FROM Examination WHERE Examination.ID = Patient.ID AND (julianday(`Examination Date`) - julianday(`First Date`)) < 365 )
SELECT COUNT(DISTINCT Patient.ID) FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE strftime('%Y', Patient.Birthday) >= '1990' AND strftime('%Y', Patient.Birthday) <= '1993'
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'M' AND l.`T-BIL` > 2.0
SELECT Diagnosis, COUNT(*) as DiagnosisCount FROM Examination WHERE `Examination Date` BETWEEN '1985-01-01' AND '1995-12-31' GROUP BY Diagnosis ORDER BY DiagnosisCount DESC LIMIT 1
SELECT AVG(SUBTRACT('1991', year(Birthday))) FROM Patient WHERE ID IN (SELECT DISTINCT ID FROM Laboratory WHERE Date BETWEEN '1991-10-01' AND '1991-10-30')
SELECT YEAR(Ex."Examination Date") - YEAR(Pat.Birthday) AS Age, Ex.Diagnosis FROM Examination Ex JOIN Patient Pat ON Ex.ID = Pat.ID WHERE Ex."HGB" = (SELECT MAX(HGB) FROM Examination)
SELECT `aCL IgG`, `aCL IgM`, ANA FROM Examination WHERE ID = 3605340 AND `Examination Date` = '1996-12-02'
SELECT `T-CHO` FROM Laboratory WHERE ID = 2927464 AND Date = '1995-09-04'
SELECT SEX FROM Patient WHERE Diagnosis = 'AORTITIS' ORDER BY `First Date` LIMIT 1
SELECT `aCL IgM` FROM Examination e JOIN Patient p ON e.ID = p.ID WHERE e.`Examination Date` = '1993-11-12' AND p.Diagnosis = 'SLE' AND p.Description = '1994-02-19'
SELECT Patient.SEX FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GPT = '9' AND Laboratory.Date = '1992-06-12'
SELECT ID, (CAST(strftime('%Y', '1991-10-21') AS INTEGER) - CAST(strftime('%Y', Birthday) AS INTEGER)) AS Age FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE Date = '1991-10-21' AND UA = '8.4')
SELECT COUNT(l.ID) FROM Patient p INNER JOIN Laboratory l ON p.ID = l.ID WHERE p.`First Date` = '1991-06-13' AND p.Diagnosis = 'SJS' AND strftime('%Y', l.Date) = '1995'
SELECT Patient.Diagnosis FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Patient.`First Date` = '1997-01-27' AND Examination.`Examination Date` = '1997-01-27' AND Examination.Diagnosis = 'SLE'
SELECT Examination.Symptoms FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Patient.Birthday = '1959-03-01' AND Examination.`Examination Date` = '1993-09-27'
SELECT ((SELECT `T-CHO` FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE Birthday = '1959-02-18') AND Date LIKE '1981-12-%') - (SELECT `T-CHO` FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE Birthday = '1959-02-18') AND Date LIKE '1981-11-%')) / (SELECT `T-CHO` FROM Laboratory WHERE ID = (SELECT ID FROM Patient WHERE Birthday = '1959-02-18') AND Date LIKE '1981-11-%') * 100 AS Decrease_Rate
SELECT Patient.ID FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE Diagnosis LIKE '%Behcet%' AND `Examination Date` >= '1997-01-01' AND `Examination Date` < '1998-01-01'
SELECT Patient.ID FROM Examination JOIN Patient ON Patient.ID = Examination.ID JOIN Laboratory ON Laboratory.ID = Examination.ID AND Laboratory.Date = Examination.`Examination Date` WHERE Examination.`Examination Date` BETWEEN '1987-07-06' AND '1996-01-31' AND Laboratory.GPT > 30 AND Laboratory.ALB < 4
SELECT p.ID FROM Patient p WHERE p.SEX = 'F' AND strftime('%Y', p.Birthday) = '1964' AND p.Admission = '+'
SELECT COUNT(ID) FROM Examination WHERE Thrombosis = 2 AND `ANA Pattern` = 'S' AND `aCL IgM` > (SELECT AVG(`aCL IgM`) * 1.2 FROM Examination)
SELECT SUM(CASE WHEN Laboratory.`U-PRO` > 0 AND Laboratory.`U-PRO` < 30 THEN CASE WHEN Laboratory.UA <= 6.5 THEN 1 ELSE 0 END ELSE 0 END) * 100 / COUNT(DISTINCT Patient.ID) FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Patient WHERE SEX = 'M' AND strftime('%Y', `First Date`) = '1981') FROM Patient WHERE SEX = 'M' AND strftime('%Y', `First Date`) = '1981' AND Diagnosis = 'BEHCET'
SELECT Patient.ID, Patient.SEX, Patient.Birthday, Patient.`First Date`, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.Admission = '-' AND Laboratory.Date LIKE '1991-10%' AND Laboratory.`T-BIL` < 2.0 ORDER BY Patient.ID
SELECT COUNT(*) FROM Patient WHERE ID NOT IN ( SELECT ID FROM Examination WHERE `ANA Pattern` = 'P' ) AND SEX = 'F' AND Birthday BETWEEN '1980-01-01' AND '1989-12-31'
SELECT Patient.SEX FROM Patient JOIN Examination ON Patient.ID = Examination.ID JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Examination.Diagnosis = 'PSS' AND Laboratory.CRP > 2 AND Laboratory.CRE = 1 AND Laboratory.LDH = 123
SELECT AVG(ALB) FROM Laboratory JOIN Patient ON Laboratory.ID = Patient.ID WHERE Patient.SEX = 'F' AND PLT > 400 AND Patient.Diagnosis = 'SLE'
SELECT MAX(Symptoms) FROM Examination WHERE Diagnosis = 'SLE'
SELECT Patient.`First Date`, Patient.Diagnosis FROM Patient WHERE Patient.ID = 48473
SELECT COUNT(*) FROM Patient WHERE SEX = 'F' AND Diagnosis = 'APS'
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE strftime('%Y', l.Date) = '1997' AND (TP < 6 OR TP > 8.5)
SELECT DIVIDE(SUM(Diagnosis LIKE '%ITP%'), SUM(Diagnosis LIKE '%SLE%')) * 100 FROM Examination WHERE Thrombosis = 1
SELECT (SUM(CASE WHEN SEX = 'F' THEN 1 ELSE 0 END) * 100) / COUNT(*) AS percentage FROM Patient WHERE YEAR(Birthday) = '1980' AND Diagnosis = 'RA'
SELECT COUNT(*) FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Patient.SEX = 'M' AND Examination.`Examination Date` BETWEEN '1995' AND '1997' AND Examination.Diagnosis = 'BEHCET' AND Patient.Admission = '-'
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'F' AND l.WBC < 3.5
SELECT DATEDIFF(Examination.`Examination Date`, Patient.`First Date`) AS DaysSinceFirstVisit FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Examination.ID = 821298
SELECT Laboratory.UA, Patient.SEX FROM Laboratory INNER JOIN Patient ON Laboratory.ID = Patient.ID WHERE Laboratory.ID = 57266 AND ((Patient.SEX = 'M' AND Laboratory.UA > 8.0) OR (Patient.SEX = 'F' AND Laboratory.UA > 6.5))
SELECT Date FROM Laboratory WHERE ID = 48473 AND GOT >= 60
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GOT < 60 AND strftime('%Y', Laboratory.Date) = '1994'
SELECT Patient.ID FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.GPT >= 60
SELECT Patient.ID, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE GPT > 60 ORDER BY Patient.Birthday ASC
SELECT ID, AVG(LDH) FROM Laboratory WHERE LDH < 500 GROUP BY ID
SELECT Patient.ID, AS age FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE LDH >= 600 AND LDH <= 800
SELECT Patient.ID, Patient.Admission FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE ALP < 300
SELECT ID FROM Patient WHERE Birthday = '1982-04-01'
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.TP < 6.0
SELECT Patient.ID, Patient.SEX, Laboratory.TP, ABS(Laboratory.TP - 8.5) as `TP Deviation` FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'F' AND Laboratory.TP > 8.5
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND (Laboratory.ALB <= 3.5 OR Laboratory.ALB >= 5.5) ORDER BY Patient.Birthday DESC
SELECT Patient.ID, Patient.ALB FROM Patient WHERE strftime('%Y', Patient.Birthday) = '1982' AND Patient.ALB >= 3.5 AND Patient.ALB <= 5.5
SELECT 100 * (SELECT COUNT(*) FROM Patient WHERE SEX = 'F' AND ID IN ( SELECT ID FROM Laboratory WHERE (SEX = 'M' AND UA > 8.0) OR (SEX = 'F' AND UA > 6.5) )) / (SELECT COUNT(*) FROM Patient WHERE SEX = 'F') AS PercentageFemaleUricAcidAbnormal
SELECT ID, AVG(UA) as `Average UA Index` FROM Laboratory JOIN Patient ON Laboratory.ID = Patient.ID WHERE UA < 8.0 AND SEX = 'M' OR UA < 6.5 AND SEX = 'F' GROUP BY ID
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.UN = 29
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.UN < 30 AND Patient.Diagnosis = 'RA'
SELECT COUNT(*) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.CRE >= 1.5
SELECT (SELECT SUM(CASE WHEN SEX = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN SEX = 'F' THEN 1 ELSE 0 END) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE CRE >= 1.5) AS More_Male_Patients_Creatinine_Not_Normal_Range
SELECT MAX(`T-BIL`) as Highest_Total_Bilirubin, Patient.ID, Patient.SEX, Patient.Birthday FROM Laboratory JOIN Patient ON Laboratory.ID = Patient.ID WHERE `T-BIL` = (SELECT MAX(`T-BIL`) FROM Laboratory)
SELECT SEX, SUM(CASE WHEN `T-BIL` >= 2.0 THEN 1 ELSE 0 END) AS `Not Within Normal Range T-BIL` FROM Patient JOIN Laboratory on Patient.ID = Laboratory.ID GROUP BY SEX
SELECT Patient.ID, MAX(Laboratory.`T-CHO`) AS "Total Cholesterol" FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.Birthday = (SELECT MIN(Birthday) FROM Patient) GROUP BY Patient.ID
SELECT DIVIDE(SUM(SUBTRACT(YEAR(NOW()), YEAR(Patient.Birthday))), COUNT(Patient.ID)) as AverageAge FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.`T-CHO` >= 250
SELECT Patient.ID, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.TG > 100
SELECT COUNT(*) FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE TG >= 200) AND (SUBSTR(CURRENT_DATE, 1,4) - SUBSTR(Birthday, 1,4)) > 50
SELECT DISTINCT p.ID FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Admission = '-' AND l.CPK < 250
SELECT COUNT(*) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE (strftime('%Y', Birthday) BETWEEN '1936' AND '1956') AND SEX = 'M' AND CPK >= 250
SELECT Patient.ID, Patient.SEX, (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) AS age FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.GLU >= 180 AND Laboratory.`T-CHO` < 250
SELECT Patient.ID, Laboratory.GLU FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.`First Date` >= '1991-01-01' AND Laboratory.GLU < 180
SELECT Patient.ID, Patient.SEX, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.WBC <= 3.5 OR Laboratory.WBC >= 9.0 GROUP BY Patient.SEX, Patient.Birthday ORDER BY (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) ASC
SELECT Patient.ID, Date('now') - Date(Birthday) AS Age FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE RBC < 3.5
SELECT Patient.ID, Patient.SEX, Patient.Birthday, Patient.`First Date`, Patient.Admission FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'F' AND (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) >= 50 AND (Laboratory.RBC <= 3.5 OR Laboratory.RBC >= 6.0) AND Patient.Admission = '+'
SELECT Patient.ID, Patient.SEX FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.Admission = "-" AND Laboratory.HGB < 10
SELECT Patient.ID, Patient.SEX FROM Patient JOIN Examination ON Patient.ID = Examination.ID JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Diagnosis = 'SLE' AND HGB > 10 AND HGB < 17 ORDER BY Birthday desc LIMIT 1
SELECT Patient.ID, (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) as age FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID GROUP BY Patient.ID HAVING COUNT(Laboratory.ID) > 2 AND MAX(Laboratory.HCT) >= 52
SELECT AVG(HCT) FROM Laboratory WHERE Date LIKE '1991%' AND HCT < 29
SELECT count(*) as "Number of Patients with Abnormal Platelet Level", SUM(CASE WHEN PLT < 100 THEN 1 ELSE 0 END) as "Number of Patients with Platelet Level Lower Than Normal Range", SUM(CASE WHEN PLT > 400 THEN 1 ELSE 0 END) as "Number of Patients with Platelet Level Higher Than Normal Range" FROM Laboratory WHERE PLT < 100 OR PLT > 400
SELECT Patient.ID, Patient.SEX, Patient.Birthday, Laboratory.Date, Laboratory.PLT FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.Date LIKE '1984%' AND (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) < 50 AND Laboratory.PLT BETWEEN 100 AND 400
SELECT COUNT(DISTINCT ID) AS Total_Patients, COUNT(DISTINCT CASE WHEN PT >= 14 AND SEX = 'F' THEN ID END) AS Female_Abnormal_PT, CAST(COUNT(DISTINCT CASE WHEN PT >= 14 AND SEX = 'F' THEN ID END) AS REAL) / CAST(COUNT(DISTINCT ID) AS REAL) AS Female_Abnormal_PT_Percentage FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE (strftime('%Y', 'now') - strftime('%Y', Birthday)) > 55
SELECT Patient.ID FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.`First Date` > 1992 AND Laboratory.PT < 14
SELECT COUNT(*) FROM Examination WHERE `Examination Date` > '1997-01-01' AND APTT < 45
SELECT COUNT(DISTINCT Examination.ID) FROM Examination JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Laboratory.APTT > 45 AND Examination.Thrombosis = 3
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.SEX = 'M' AND l.WBC BETWEEN 3.5 AND 9.0 AND (l.FG <= 150 OR l.FG >= 450)
SELECT COUNT(DISTINCT P.ID) FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE P.Birthday > '1980-01-01' AND (L.FG < 150 OR L.FG > 450)
SELECT DISTINCT p.Diagnosis FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.`U-PRO` >= 30
SELECT Patient.ID FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE `U-PRO` > 0 AND `U-PRO` < 30 AND Diagnosis = 'SLE'
SELECT COUNT(*) FROM Examination JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Laboratory.IGG < 900 AND Examination.Symptoms = 'abortion'
SELECT COUNT(*) FROM Patient p JOIN Examination e ON p.ID = e.ID WHERE `aCL IgG` BETWEEN 900 AND 2000 AND Symptoms IS NOT NULL
SELECT Diagnosis FROM Patient WHERE ID = (SELECT ID FROM Laboratory WHERE IGA = (SELECT MAX(IGA) FROM Laboratory WHERE IGA BETWEEN 80 AND 500))
SELECT COUNT(ID) FROM Patient WHERE IGA BETWEEN 80 AND 500 AND `First Date` >= '1990-01-01'
SELECT MAX(COUNT(Diagnosis)) FROM Examination WHERE `aCL IgM` NOT BETWEEN 40 AND 400
SELECT COUNT(*) FROM Patient WHERE (Description IS NULL OR Description = '') AND (CRP LIKE '+' OR CRP LIKE '-' OR CRP < 1.0)
SELECT COUNT(DISTINCT Patient.ID) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE CRP NOT IN ('+-', '-') AND CRP >= 1.0 AND (STRFTIME('%Y', 'now') - STRFTIME('%Y', Patient.Birthday)) < 18
SELECT COUNT(DISTINCT Patient.ID) FROM Patient JOIN Examination ON Patient.ID = Examination.ID JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE RA IN ('-', '+-') AND KCT = '+'
SELECT Diagnosis FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE strftime('%Y', p.Birthday) >= '1995' AND RA IN ('-', '+-')
SELECT Patient.ID FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE RF < 20 AND (strftime('%Y', 'now') - strftime('%Y', Patient.Birthday)) > 60
SELECT COUNT(*) FROM Patient WHERE ID IN ( SELECT ID FROM Laboratory WHERE RF < 20 AND ID NOT IN ( SELECT ID FROM Examination WHERE Thrombosis = 0 ) )
SELECT COUNT(DISTINCT p.ID) FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE l.C3 > 35 AND e.`ANA Pattern` = 'P'
SELECT Patient.ID FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Examination.`HCT` < 29 OR Examination.`HCT` > 52 ORDER BY Examination.`aCL IgA` DESC LIMIT 1
SELECT COUNT(DISTINCT E.ID) FROM Examination E JOIN Patient P ON E.ID = P.ID WHERE E.Thrombosis = 1 AND E.C4 > 10
SELECT count(distinct ID) FROM Laboratory WHERE RNP = '-' or RNP = '+-' AND ID IN ( SELECT ID FROM Patient WHERE Admission = '+' )
SELECT Patient.ID, Patient.Birthday FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.RNP NOT IN ('-', '+-') ORDER BY Patient.Birthday DESC LIMIT 1
SELECT COUNT(*) FROM Examination WHERE ID IN (SELECT ID FROM Laboratory WHERE SM = 'negative' OR SM = '0') AND Thrombosis = 1
SELECT Patient.ID FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.SM NOT IN ('-', '+-') ORDER BY Patient.Birthday DESC LIMIT 3
SELECT DISTINCT e.ID FROM Examination e JOIN Patient p ON e.ID = p.ID WHERE e.`Examination Date` >= '1997-01-01' AND e.SC170 IN ('-', '+-')
SELECT COUNT(DISTINCT P.ID) FROM Patient P JOIN Laboratory L ON P.ID = L.ID WHERE L.SC170 IN ('-', '+-') AND P.SEX = 'M' AND L.Symptoms = 'vertigo'
SELECT COUNT(DISTINCT p.ID) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.SSA IN ('-', '+-') AND YEAR(p.`First Date`) < 1990
SELECT Patient.ID FROM Patient WHERE ID = ( SELECT ID FROM Laboratory WHERE SSA != '-' AND SSA != '+-' ORDER BY Date ASC LIMIT 1 )
SELECT COUNT(DISTINCT E.ID) FROM Examination E JOIN Patient P ON E.ID = P.ID WHERE SSB IN ('-', '+-') AND Diagnosis = 'SLE'
SELECT count(DISTINCT P.ID) FROM Examination E JOIN Patient P ON E.ID = P.ID WHERE E.`SSB` IN ('-','+-') AND E.Symptoms IS NOT NULL
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.CENTROMEA IN ('-', '+-') AND l.SSB IN ('-', '+-') AND p.SEX = 'M'
SELECT DISTINCT p.Diagnosis FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.DNA >= 8
SELECT COUNT(DISTINCT P.ID) FROM Patient P LEFT JOIN Laboratory L ON P.ID = L.ID WHERE L.DNA < 8 OR L.DNA IS NULL
SELECT COUNT(DISTINCT ID) FROM Laboratory WHERE `DNA-II` >= 8 AND ID IN (SELECT ID FROM Patient WHERE Admission = '+')
SELECT (CAST(COUNT(DISTINCT ID) AS REAL) / (SELECT COUNT(DISTINCT ID) FROM Laboratory WHERE GOT >= 60 AND Diagnosis = 'SLE')) * 100 AS Percentage FROM Laboratory WHERE GOT >= 60 AND Diagnosis = 'SLE'
SELECT COUNT(*) FROM Patient WHERE SEX = 'M' AND ID IN (SELECT ID FROM Laboratory WHERE GOT < 60)
SELECT MIN(Birthday) FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE GOT >= 60)
SELECT TOP 3 Birthday FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE GPT < 60 ORDER BY GPT DESC LIMIT 3
SELECT COUNT(*) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE GOT < 60 AND SEX = 'M'
SELECT MIN(`First Date`) FROM Patient WHERE ID = ( SELECT ID FROM Laboratory WHERE LDH < 500 ORDER BY LDH DESC LIMIT 1 )
SELECT MAX(Date) FROM Laboratory WHERE LDH >= 500 AND ID = (SELECT MAX(ID) FROM Patient WHERE Birthday IS NOT NULL)
SELECT COUNT(*) FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE ALP >= 300) AND Admission = '+'
SELECT COUNT(*) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Admission = '-' AND ALP < 300
SELECT Patient.ID, Patient.Diagnosis FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.TP < 6.0
SELECT COUNT(*) FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE Diagnosis = 'SJS' AND TP > 6.0 AND TP < 8.5
SELECT Examination.`Examination Date` FROM Examination JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE ALB > 3.5 AND ALB < 5.5 ORDER BY ALB DESC LIMIT 1
SELECT COUNT(*) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.ALB > 3.5 AND Laboratory.ALB < 5.5 AND Laboratory.TP BETWEEN 6.0 AND 8.5
SELECT `aCL IgG`, `aCL IgM`, `aCL IgA` FROM Examination WHERE ID IN ( SELECT ID FROM Patient WHERE SEX = 'F' AND ID IN ( SELECT ID FROM Laboratory WHERE UA > 6.50 ) )
SELECT MAX(ANA) FROM Examination WHERE CRE < 1.5
SELECT Patient.ID FROM Patient JOIN Examination ON Patient.ID = Examination.ID JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.CRE < 1.5 AND Examination.`aCL IgA` = (SELECT MAX(`aCL IgA`) FROM Examination)
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID JOIN Examination e ON p.ID = e.ID WHERE l.`T-BIL` >= 2.0 AND e.`ANA Pattern` LIKE '%P%'
SELECT `ANA` FROM Examination WHERE `Diagnosis` = 'MAX(`T-BIL` < 2.0)'
SELECT COUNT(*) FROM Patient INNER JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE `T-CHO` >= 250 AND KCT = '-'
SELECT COUNT(*) FROM Patient JOIN Examination ON Patient.ID = Examination.ID WHERE `T-CHO` < 250 AND `ANA Pattern` = 'P'
SELECT COUNT(*) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE TG < 200 AND Symptoms IS NOT NULL
SELECT Diagnosis FROM Examination JOIN Patient ON Examination.ID = Patient.ID WHERE TG = (SELECT MAX(TG) FROM Laboratory WHERE TG < 200)
SELECT Laboratory.ID FROM Laboratory JOIN Examination ON Laboratory.ID = Examination.ID WHERE Examination.Thrombosis = 0 AND Laboratory.CPK < 250
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE l.CPK < 250 AND (l.KCT = '+' OR l.RVVT = '+' OR l.LAC = '+')
SELECT MIN(Birthday) FROM Patient WHERE ID IN (SELECT ID FROM Laboratory WHERE GLU > 180)
SELECT COUNT(*) FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE GLU < 180 AND Thrombosis = 0
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE p.Admission = '+' AND l.WBC BETWEEN 3.5 AND 9.0
SELECT COUNT(*) FROM Patient p JOIN Examination e ON p.ID = e.ID JOIN Laboratory l ON p.ID = l.ID WHERE p.Diagnosis = 'SLE' AND l.WBC >= 3.5 AND l.WBC <= 9.0
SELECT ID FROM Laboratory WHERE RBC <= 3.5 OR RBC >= 6.0 AND ID IN (SELECT ID FROM Patient WHERE Admission = '-')
SELECT COUNT(*) FROM Patient p JOIN Laboratory l ON p.ID = l.ID WHERE PLT > 100 AND PLT < 400 AND Diagnosis IS NOT NULL
SELECT Patient.ID, Laboratory.PLT FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Laboratory.PLT > 100 AND Laboratory.PLT < 400 AND Patient.Diagnosis = 'MCTD'
SELECT Patient.ID, AVG(Laboratory.PT) as `Average Prothrombin Time` FROM Patient JOIN Laboratory ON Patient.ID = Laboratory.ID WHERE Patient.SEX = 'M' AND Laboratory.PT < 14 GROUP BY Patient.ID
SELECT COUNT(*) FROM Examination JOIN Laboratory ON Examination.ID = Laboratory.ID WHERE Examination.Thrombosis IN (1, 2) AND Laboratory.PT < 14
SELECT m.major_name FROM member AS m JOIN major AS maj ON m.link_to_major = maj.major_id WHERE m.first_name = 'Angela' AND m.last_name = 'Sanders'
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.college = 'College of Engineering'
SELECT m.first_name || ' ' || m.last_name AS full_name FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE ma.department = 'Art and Design'
SELECT COUNT(*) FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = "Women's Soccer"
SELECT member.phone FROM member JOIN attendance ON member.member_id = attendance.link_to_member JOIN event ON event.event_id = attendance.link_to_event WHERE event.event_name = 'Women\'s Soccer'
SELECT COUNT(*) FROM member JOIN attendance ON member.member_id = attendance.link_to_member JOIN event ON attendance.link_to_event = event.event_id WHERE event.event_name = 'Women\'s Soccer' AND member.t_shirt_size = 'Medium'
SELECT e.event_name FROM event e JOIN attendance a ON e.event_id = a.link_to_event GROUP BY e.event_id, e.event_name ORDER BY COUNT(a.link_to_member) DESC LIMIT 1
SELECT m.college FROM member m WHERE m.position = 'Vice President'
SELECT event.event_name FROM event JOIN attendance ON event.event_id = attendance.link_to_event JOIN member ON member.member_id = attendance.link_to_member WHERE member.first_name = 'Maya' AND member.last_name = 'Mclean'
SELECT COUNT(*) FROM attendance a JOIN event e ON a.link_to_event = e.event_id JOIN member m ON a.link_to_member = m.member_id WHERE m.first_name = 'Sacha' AND m.last_name = 'Harrison' AND strftime('%Y', e.event_date) = '2019' GROUP BY m.first_name, m.last_name
SELECT COUNT(event_id) FROM event WHERE type = 'Meeting' AND event_id IN (SELECT link_to_event FROM attendance GROUP BY link_to_event HAVING COUNT(link_to_member) > 10)
SELECT event_name FROM event WHERE event_id IN ( SELECT link_to_event FROM attendance GROUP BY link_to_event HAVING COUNT(link_to_member) > 20 )
SELECT AVG(attendance) FROM event JOIN attendance ON event.event_id = attendance.link_to_event WHERE type = 'Meeting' AND event_date LIKE '%2020%'
SELECT MAX(cost) as most_expensive_item FROM expense WHERE expense_description = 'support of club events'
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Environmental Engineering'
SELECT first_name || ' ' || last_name AS full_name FROM member WHERE member_id IN ( SELECT link_to_member FROM attendance WHERE link_to_event = ( SELECT event_id FROM event WHERE event_name = 'Laugh Out Loud' ) )
SELECT m.last_name FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE ma.major_name = 'Law and Constitutional Studies'
SELECT zip_code.county FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE member.first_name = 'Sherri' AND member.last_name = 'Ramsey'
SELECT major.college FROM major JOIN member ON major.major_id = member.link_to_major WHERE member.first_name = 'Tyler' AND member.last_name = 'Hewitt'
SELECT SUM(amount) FROM income WHERE position = 'Vice President'
SELECT SUM(cost) FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id JOIN event ON budget.link_to_event = event.event_id WHERE category = 'Food' AND event_name = 'September Meeting'
SELECT zip_code.city, zip_code.state FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE member.position = 'President'
SELECT m.first_name || ' ' || m.last_name as full_name FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE z.state = 'Illinois'
SELECT SUM(e.amount) FROM expense e JOIN budget b ON e.link_to_budget = b.budget_id JOIN event ev ON b.link_to_event = ev.event_id WHERE e.approved = 'yes' AND b.category = 'Advertisement' AND ev.event_name = 'September Meeting'
SELECT major.department FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Pierce' OR member.first_name = 'Guidi'
SELECT SUM(amount) AS total_budgeted_amount FROM budget WHERE event_status = 'October Speaker'
SELECT expense_id FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'October Meeting' AND event.event_date = '2019-10-08' AND expense.approved = 'True'
SELECT SUM(cost) / COUNT(DISTINCT event_id) AS avg_cost FROM expense WHERE link_to_member = 'Elijah Allen' AND link_to_budget IN (SELECT budget_id FROM budget WHERE event_date LIKE '%-09-%' OR event_date LIKE '%-10-%')
SELECT SUM(CASE WHEN strftime('%Y', event_date) = '2019' THEN spent ELSE 0 END) - SUM(CASE WHEN strftime('%Y', event_date) = '2020' THEN spent ELSE 0 END) AS difference FROM expense INNER JOIN budget ON expense.link_to_budget = budget.budget_id INNER JOIN event ON budget.link_to_event = event.event_id WHERE event.type = 'Student_Club'
SELECT location FROM event WHERE event_name = 'Spring Budget Review'
SELECT cost FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'Poster' AND event.event_date = '2019-09-04'
SELECT remaining FROM budget WHERE category = 'Food' AND amount = (SELECT MAX(amount) FROM budget WHERE category = 'Food')
SELECT notes FROM income WHERE source = 'Fundraising' AND date_received = '2019-09-14'
SELECT COUNT(*) FROM major WHERE college = 'College of Humanities and Social Sciences'
SELECT phone FROM member WHERE first_name = 'Carlo' AND last_name = 'Jacobs'
SELECT zip_code.county FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE member.first_name = 'Adela' AND member.last_name = 'O''Gallagher'
SELECT COUNT(*) FROM budget WHERE event_status = 'November Meeting' AND remaining < 0
SELECT SUM(amount) FROM budget WHERE event_id = 'September Speaker'
SELECT event.status FROM event JOIN expense ON event.event_id = expense.link_to_event WHERE expense.expense_description = 'Post Cards, Posters' AND expense.expense_date = '2019-8-20'
SELECT major_name FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Brent' AND member.last_name = 'Thomason'
SELECT COUNT(*) FROM member WHERE link_to_major = (SELECT major_id FROM major WHERE major_name = 'Human Development and Family Studies') AND t_shirt_size = 'Large'
SELECT zip_code.type FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE member.first_name = 'Christof' AND member.last_name = 'Nielson'
SELECT major_name FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Vice President'
SELECT zip.state FROM member JOIN zip_code zip ON member.zip = zip.zip_code WHERE member.first_name = "Sacha" AND member.last_name = "Harrison"
SELECT major.department FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'President'
SELECT income.date_received FROM income JOIN member ON income.link_to_member = member.member_id WHERE member.first_name = 'Connor' AND member.last_name = 'Hilton' AND income.source = 'Dues'
SELECT first_name || ' ' || last_name AS full_name FROM member JOIN income ON member.member_id = income.link_to_member WHERE source = 'Dues' ORDER BY date_received LIMIT 1
SELECT DIVIDE(SUM(amount) WHERE category = 'Advertisement' AND link_to_event = (SELECT event_id FROM event WHERE event_name = 'Yearly Kickoff'), SUM(amount) WHERE category = 'Advertisement' AND link_to_event = (SELECT event_id FROM event WHERE event_name = 'October Meeting')) AS ratio FROM budget
SELECT (SUM(amount) / COUNT(event_name)) * 100 AS percentage FROM budget JOIN event ON budget.link_to_event = event.event_id WHERE category = 'Parking' AND event_name = 'November Speaker'
SELECT SUM(cost) FROM expense WHERE expense_description = 'Pizza'
SELECT COUNT(DISTINCT(city)) FROM zip_code WHERE county = 'Orange County' AND state = 'Virginia'
SELECT department FROM major WHERE college = 'College of Humanities and Social Sciences'
SELECT city, county, state FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE first_name = 'Amy' AND last_name = 'Firth'
SELECT expense.expense_description FROM budget JOIN expense ON budget.budget_id = expense.link_to_budget WHERE budget.remaining = (SELECT MIN(remaining) FROM budget)
SELECT m.first_name, m.last_name FROM member m JOIN attendance a ON a.link_to_member = m.member_id JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = 'October Meeting'
SELECT major.college FROM member JOIN major ON member.link_to_major = major.major_id GROUP BY major.college ORDER BY COUNT(major.college) DESC LIMIT 1
SELECT major.major_name FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.phone = '809-555-3360'
SELECT event_name FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE amount = (SELECT MAX(amount) FROM budget)
SELECT e.* FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE m.position = 'Vice President'
SELECT COUNT(*) FROM attendance WHERE link_to_event = 'Women\'s Soccer'
SELECT income.date_received FROM income JOIN member ON income.link_to_member = member.member_id WHERE member.first_name = 'Casey' AND member.last_name = 'Mason'
SELECT COUNT(*) FROM member WHERE zip IN (SELECT zip_code FROM zip_code WHERE state = 'Maryland')
SELECT COUNT(*) FROM event WHERE event_id IN (SELECT link_to_event FROM attendance WHERE link_to_member IN (SELECT member_id FROM member WHERE phone = '954-555-6240'))
SELECT m.first_name, m.last_name FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE ma.department = 'School of Applied Sciences, Technology and Education'
SELECT event_id, event_name, MAX(spent / amount) as highest_spend_to_budget_ratio FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE status = 'Closed'
SELECT COUNT(*) FROM member WHERE position = 'President'
SELECT MAX(spent) as highest_budget_spend FROM budget
SELECT COUNT(*) FROM event WHERE type = 'Meeting' AND strftime('%Y', event_date) = '2020'
SELECT SUM(spent) FROM budget WHERE category = 'Food'
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM member INNER JOIN attendance ON member.member_id = attendance.link_to_member GROUP BY full_name HAVING COUNT(attendance.link_to_event) > 7
SELECT member.first_name, member.last_name FROM member JOIN major ON member.link_to_major = major.major_id JOIN attendance ON member.member_id = attendance.link_to_member JOIN event ON attendance.link_to_event = event.event_id WHERE major.major_name = 'Interior Design' AND event.event_name = 'Community Theater'
SELECT first_name, last_name FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE zip_code.city = 'Georgetown' AND zip_code.state = 'South Carolina'
SELECT COUNT(*) FROM income WHERE link_to_member = (SELECT member_id FROM member WHERE first_name = 'Grant' AND last_name = 'Gilmour')
SELECT member.first_name, member.last_name FROM income JOIN member ON income.link_to_member = member.member_id WHERE income.amount > 40
SELECT SUM(cost) FROM expense WHERE link_to_budget = (SELECT budget_id FROM budget WHERE category = 'Yearly Kickoff' AND event_status = 'Approved')
SELECT m.first_name, m.last_name FROM member m JOIN budget b ON m.member_id = b.link_to_event JOIN event e ON b.link_to_event = e.event_id WHERE e.event_name = 'Yearly Kickoff'
SELECT member.first_name || ' ' || member.last_name AS full_name, income.source FROM member JOIN income ON member.member_id = income.link_to_member WHERE amount = (SELECT MAX(amount) FROM income)
SELECT event.event_name FROM event JOIN ( SELECT event_name, MIN(cost) as min_cost FROM event JOIN budget ON event.event_id = budget.link_to_event JOIN expense ON budget.budget_id = expense.link_to_budget ) min_event_cost ON event.event_name = min_event_cost.event_name and expense.cost = min_event_cost.min_cost
SELECT SUM(cost) * 100 / ( SELECT SUM(cost) FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'Yearly Kickoff' ) FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id
SELECT SUM(CASE WHEN m.major_name = 'Finance' THEN 1 ELSE 0 END) * 1.0 / SUM(CASE WHEN m.major_name = 'Physics' THEN 1 ELSE 0 END) AS ratio FROM member m JOIN major mj ON m.link_to_major = mj.major_id
SELECT source, amount FROM income WHERE date_received BETWEEN '2019-09-01' AND '2019-09-30' ORDER BY amount DESC LIMIT 1
SELECT first_name || ' ' || last_name AS full_name, email FROM member WHERE position = 'Secretary'
SELECT COUNT(*) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Physics Teaching'
SELECT COUNT(*) FROM attendance WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'Community Theater' AND strftime('%Y', event_date) = '2019')
SELECT COUNT(*) AS events_attended, major.major_name FROM member JOIN attendance ON member.member_id = attendance.link_to_member JOIN event ON attendance.link_to_event = event.event_id JOIN major ON member.link_to_major = major.major_id WHERE member.first_name = 'Luisa' AND member.last_name = 'Guidi'
SELECT DIVIDE(SUM(spent), COUNT(spent)) as avg_food_spending FROM budget WHERE category = 'Food' AND event_status = 'Closed'
SELECT event_name FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE budget.category = 'Advertisement' ORDER BY budget.spent DESC LIMIT 1
SELECT attendance.link_to_member FROM attendance JOIN event ON attendance.link_to_event = event.event_id JOIN member ON attendance.link_to_member = member.member_id WHERE event.event_name = 'Women\'s Soccer' AND member.first_name = 'Maya' AND member.last_name = 'McLean'
SELECT (DIVIDE(SUM(type = 'Community Service'), COUNT(event_id)) * 100) AS percentage_share FROM event WHERE event_date BETWEEN '2019-01-01' AND '2019-12-31'
SELECT expense.cost FROM event JOIN budget ON event.event_id = budget.link_to_event JOIN expense ON budget.budget_id = expense.link_to_budget WHERE event.event_name = 'September Speaker' AND expense.expense_description = 'Posters'
SELECT t_shirt_size FROM member GROUP BY t_shirt_size ORDER BY COUNT(t_shirt_size) DESC LIMIT 1
SELECT event.event_name FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE event.status = 'Closed' GROUP BY event.event_name HAVING MIN(budget.remaining) < 0
SELECT expense.expense_description, expense.cost FROM expense JOIN budget ON expense.link_to_budget = budget.budget_id JOIN event ON budget.link_to_event = event.event_id WHERE event.event_name = 'October Meeting' AND expense.approved = 'Yes'
SELECT budget_id, category, amount FROM budget WHERE link_to_event = (SELECT event_id FROM event WHERE event_name = 'April Speaker') ORDER BY amount ASC
SELECT * FROM budget WHERE category = 'Food' ORDER BY amount DESC LIMIT 1
SELECT budget_id, category, amount FROM budget WHERE category = 'Advertising' ORDER BY amount DESC LIMIT 3
SELECT SUM(cost) AS total_cost_spent_for_parking FROM expense WHERE expense_description = 'Parking'
SELECT SUM(cost) as total_expense FROM expense WHERE expense_date = '2019-08-20'
SELECT first_name || ' ' || last_name AS full_name, SUM(cost) AS total_cost FROM member JOIN expense ON member.member_id = expense.link_to_member WHERE member.member_id = 'rec4BLdZHS2Blfp4v'
SELECT expense_description FROM expense JOIN member ON member.member_id = expense.link_to_member WHERE member.first_name = 'Sacha' AND member.last_name = 'Harrison'
SELECT expense_description FROM expense WHERE link_to_member IN (SELECT member_id FROM member WHERE t_shirt_size = 'X-Large')
SELECT zip FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE e.cost < 50
SELECT major_name FROM member JOIN major ON member.link_to_major = major.major_id WHERE first_name = 'Phillip' AND last_name = 'Cullen'
SELECT position FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'Business'
SELECT COUNT(*) FROM member WHERE link_to_major = (SELECT major_id FROM major WHERE major_name = 'Business') AND t_shirt_size = 'Medium'
SELECT event_name, category FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE budget.remaining > 30
SELECT event_name, location FROM event WHERE location = 'MU 215'
SELECT budget.category FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE event.event_date = '2020-03-24T12:00:00'
SELECT major_name FROM member JOIN major ON member.link_to_major = major.major_id WHERE member.position = 'Vice President'
SELECT (COUNT(member_id) / ( SELECT COUNT(member_id) FROM member )) * 100 FROM member JOIN major ON member.link_to_major = major.major_id WHERE major_name = 'Mathematics' AND position = 'Member'
SELECT DISTINCT event.event_name FROM event WHERE event.location = 'MU 215'
SELECT COUNT(*) FROM income WHERE amount = 50
SELECT COUNT(member_id) FROM member WHERE t_shirt_size = 'X-Large'
SELECT COUNT(major_id) FROM major WHERE college = 'College of Agriculture and Applied Sciences' AND department = 'School of Applied Sciences, Technology and Education'
SELECT m.last_name, ma.department, ma.college FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE ma.major_name = 'Environmental Engineering'
SELECT budget.category FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE event.location = 'MU 215' AND event.type = 'Guest Speaker' AND budget.spent = 0
SELECT zip_code.city, zip_code.state FROM member JOIN major ON member.link_to_major = major.major_id JOIN zip_code ON member.zip = zip_code.zip_code WHERE major.department = 'Electrical and Computer Engineering Department' AND member.position = 'Member'
SELECT e.event_name FROM event e JOIN attendance a ON e.event_id = a.link_to_event JOIN member m ON a.link_to_member = m.member_id WHERE e.type = 'Social' AND m.position = 'Vice President' AND e.location = '900 E. Washington St.'
SELECT m.last_name, m.position FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE e.expense_description = 'Pizza' AND e.expense_date = '2019-09-10'
SELECT m.last_name FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id WHERE e.event_name = 'Women\'s Soccer' AND m.position = 'Member'
SELECT COUNT(CASE WHEN t_shirt_size = 'Medium' AND position = 'Member' THEN 1 END) AS medium_member_count, COUNT(CASE WHEN t_shirt_size = 'Medium' AND position = 'Member' AND amount = 50 THEN 1 END) AS medium_member_count_amount_50, (medium_member_count_amount_50 * 1.0 / medium_member_count) * 100 AS percentage_amount_50 FROM member
SELECT DISTINCT state FROM zip_code WHERE type = 'PO Box'
SELECT zip_code FROM zip_code WHERE type = 'PO Box' AND county = 'San Juan Municipio' AND state = 'Puerto Rico'
SELECT event_name FROM event WHERE type = 'Game' AND status = 'Closed' AND event_date BETWEEN '2019-03-15' AND '2020-03-20'
SELECT e.event_id, e.event_name, e.event_date, e.type, e.notes, e.location, e.status FROM event e JOIN budget b ON e.event_id = b.link_to_event JOIN expense ex ON b.budget_id = ex.link_to_budget JOIN member m ON ex.link_to_member = m.member_id WHERE ex.cost > 50
SELECT m.member_id, m.first_name, m.last_name, e.event_id FROM member m JOIN attendance a ON m.member_id = a.link_to_member JOIN event e ON a.link_to_event = e.event_id JOIN expense ex ON ex.link_to_member = m.member_id WHERE ex.approved = 'true' AND ex.expense_date BETWEEN '2019-01-10' AND '2019-11-19'
SELECT college FROM member WHERE first_name = 'Katy' AND link_to_major = 'rec1N0upiVLy5esTO'
SELECT phone FROM member JOIN major ON member.link_to_major = major.major_id JOIN zip_code ON member.zip = zip_code.zip_code WHERE major.major_name = 'Business' AND major.college = 'College of Agriculture and Applied Sciences'
SELECT member.email FROM expense JOIN member ON member.member_id = expense.link_to_member WHERE expense_date BETWEEN '2019-09-10' AND '2019-11-19' AND cost > 20
SELECT COUNT(member_id) FROM member JOIN major ON member.link_to_major = major.major_id WHERE major.major_name = 'education' AND major.college = 'College of Education & Human Services'
SELECT (DIVIDE(SUM(CASE WHEN remaining < 0 THEN 1 ELSE 0 END), COUNT(event_id)) * 100) as percentage_over_budget FROM budget
SELECT event_id, location, status FROM event WHERE event_date BETWEEN '2019-11-01' AND '2020-03-31'
SELECT expense_id, expense_description, cost FROM expense GROUP BY expense_id, expense_description, cost HAVING AVG(cost) > 50
SELECT first_name || ' ' || last_name AS full_name FROM member WHERE t_shirt_size = 'X-Large'
SELECT ROUND(CAST((COUNT(CASE WHEN type = 'PO Box' THEN 1 END) * 100.0) / COUNT(zip_code) AS FLOAT), 2) FROM zip_code
SELECT event_name, location FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE budget.remaining > 0
SELECT event_name, event_date FROM event JOIN expense ON event.event_id = expense.link_to_event WHERE expense_description = 'Pizza' AND cost > 50 AND cost < 100
SELECT m.first_name, m.last_name, mj.major_name FROM member m JOIN expense e ON m.member_id = e.link_to_member JOIN budget b ON e.link_to_budget = b.budget_id JOIN major mj ON m.link_to_major = mj.major_id WHERE e.cost > 100
SELECT zip_code.city, zip_code.county FROM event JOIN income ON event.event_id = income.link_to_event JOIN zip_code ON event.location = zip_code.zip_code GROUP BY event.event_id HAVING COUNT(income.income_id) > 40
SELECT member_id, MAX(cost) as max_amount_paid FROM expense WHERE link_to_member IN (SELECT link_to_member FROM expense GROUP BY link_to_member HAVING COUNT(DISTINCT link_to_event) > 1)
SELECT AVG(cost) as average_amount_paid FROM expense e JOIN member m ON e.link_to_member = m.member_id WHERE m.position != 'Member'
SELECT event_name FROM event WHERE event_id IN ( SELECT link_to_event FROM budget WHERE category = 'Parking' GROUP BY link_to_event HAVING cost < (SELECT SUM(cost) / COUNT(event_id) FROM budget WHERE category = 'Parking') )
SELECT DIVIDE(SUM(e.cost), COUNT(e.event_id)) * 100 FROM event e WHERE e.type = 'Game'
SELECT budget_id FROM budget JOIN expense ON budget.budget_id = expense.link_to_budget WHERE expense.expense_description = 'Water, chips, cookies' ORDER BY cost DESC LIMIT 1
SELECT member.first_name || ' ' || member.last_name AS full_name, SUM(expense.cost) AS total_spent FROM member JOIN expense ON member.member_id = expense.link_to_member GROUP BY member.member_id ORDER BY total_spent DESC LIMIT 5
SELECT m.first_name || ' ' || m.last_name AS full_name, m.phone AS contact_number FROM member m JOIN expense e ON m.member_id = e.link_to_member WHERE e.cost > (SELECT AVG(cost) FROM expense)
SELECT ((COUNT(CASE WHEN zip IN (SELECT zip_code FROM zip_code WHERE state = 'Maine') THEN 1 END) / COUNT(CASE WHEN position = 'Member' THEN 1 END)) * 100) - ((COUNT(CASE WHEN zip IN (SELECT zip_code FROM zip_code WHERE state = 'Vermont') THEN 1 END) / COUNT(CASE WHEN position = 'Member' THEN 1 END)) * 100) as percentage_difference FROM member
SELECT major_name, department FROM member JOIN major ON member.link_to_major = major.major_id WHERE first_name = 'Garrett' AND last_name = 'Gerke'
SELECT m.first_name || ' ' || m.last_name AS full_name, e.cost FROM member m JOIN expense ex ON m.member_id = ex.link_to_member JOIN budget b ON ex.link_to_budget = b.budget_id WHERE ex.expense_description = 'Water, Veggie tray, supplies'
SELECT m.last_name, m.phone FROM member m JOIN major mj ON m.link_to_major = mj.major_id WHERE mj.major_name = 'Elementary Education'
SELECT category, amount FROM budget WHERE link_to_event = 'January Speaker'
SELECT event_name FROM event WHERE event_id IN (SELECT link_to_event FROM budget WHERE category = 'Food')
SELECT member.first_name || ' ' || member.last_name AS full_name, income.amount AS funds_received FROM member JOIN income ON member.member_id = income.link_to_member WHERE income.date_received = '9/9/2019'
SELECT budget.category FROM budget JOIN expense ON expense.link_to_budget = budget.budget_id WHERE expense.expense_description = 'Posters'
SELECT m.first_name || ' ' || m.last_name AS full_name, m.position, ma.college FROM member m JOIN major ma ON m.link_to_major = ma.major_id WHERE m.position = 'Secretary'
SELECT event.event_name, SUM(budget.spent) as total_spent FROM event JOIN budget ON event.event_id = budget.link_to_event WHERE budget.category = 'Speaker Gifts' GROUP BY event.event_name
SELECT zip_code.city FROM member JOIN zip_code ON member.zip = zip_code.zip_code WHERE member.first_name = "Garrett" AND member.last_name = "Girke"
SELECT first_name || ' ' || last_name AS full_name, position FROM member m JOIN zip_code z ON m.zip = z.zip_code WHERE z.city = 'Lincolnton' AND z.state = 'North Carolina' AND z.zip_code = 28092
SELECT COUNT(*) FROM gasstations WHERE Country = 'CZE' AND Segment = 'Premium gas'
SELECT COUNT(CASE WHEN Currency = 'EUR' THEN 1 END) AS EUR_customers, COUNT(CASE WHEN Currency = 'CZK' THEN 1 END) AS CZK_customers, (COUNT(CASE WHEN Currency = 'EUR' THEN 1 END) * 1.0) / COUNT(CASE WHEN Currency = 'CZK' THEN 1 END) AS ratio FROM customers
SELECT customers.CustomerID, SUM(yearmonth.Consumption) AS TotalConsumption FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date BETWEEN '201201' AND '201212' AND customers.Segment = 'LAM' GROUP BY customers.CustomerID ORDER BY TotalConsumption LIMIT 1
SELECT AVG(Consumption)/12 as Average_Monthly_Consumption FROM yearmonth WHERE Date BETWEEN '201301' AND '201312' AND CustomerID IN ( SELECT CustomerID FROM customers WHERE Segment = 'SME' )
SELECT customers.CustomerID, customers.Segment, customers.Currency, SUM(transactions_1k.Amount) AS TotalGasConsumed FROM customers INNER JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID INNER JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE customers.Currency = 'CZK' AND transactions_1k.Date BETWEEN '201101' AND '201112' GROUP BY customers.CustomerID ORDER BY TotalGasConsumed DESC LIMIT 1
SELECT COUNT(DISTINCT CustomerID) FROM yearmonth WHERE Date BETWEEN '201201' AND '201212' AND Consumption < 30000
SELECT SUM(CASE WHEN Currency = 'CZK' THEN Consumption ELSE 0 END) - SUM(CASE WHEN Currency = 'EUR' THEN Consumption ELSE 0 END) AS Difference FROM yearmonth WHERE Date BETWEEN '201201' AND '201212'
SELECT strftime('%Y', transactions_1k.Date) AS Year, SUM(transactions_1k.Amount * transactions_1k.Price) AS TotalAmountPaidEUR FROM transactions_1k JOIN products ON transactions_1k.ProductID = products.ProductID WHERE products.Description = 'EUR' GROUP BY Year ORDER BY TotalAmountPaidEUR DESC LIMIT 1
SELECT Segment FROM yearmonth GROUP BY Segment ORDER BY SUM(Consumption) ASC LIMIT 1
SELECT substr(Date, 1, 4) as Year, sum(Consumption) as TotalConsumption FROM yearmonth JOIN customers on yearmonth.CustomerID = customers.CustomerID JOIN transactions_1k on transactions_1k.CustomerID = customers.CustomerID JOIN products on products.ProductID = transactions_1k.ProductID JOIN gasstations on gasstations.GasStationID = transactions_1k.GasStationID WHERE Currency = 'CZK' GROUP BY Year ORDER BY TotalConsumption DESC LIMIT 1
SELECT yearmonth.Date, SUM(yearmonth.Consumption) AS TotalConsumption FROM yearmonth JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE customers.Segment = 'SME' AND yearmonth.Date LIKE '2013%' GROUP BY yearmonth.Date ORDER BY TotalConsumption DESC LIMIT 1
SELECT AVG(y1.Consumption) AS SME_Annual_Avg, AVG(y2.Consumption) AS LAM_Annual_Avg, AVG(y3.Consumption) AS KAM_Annual_Avg, (AVG(y1.Consumption) - AVG(y2.Consumption)) AS SME_LAM_Dif, (AVG(y2.Consumption) - AVG(y3.Consumption)) AS LAM_KAM_Dif, (AVG(y3.Consumption) - AVG(y1.Consumption)) AS KAM_SME_Dif FROM yearmonth y1 JOIN yearmonth y2 ON y1.CustomerID = y2.CustomerID JOIN yearmonth y3 ON y1.CustomerID = y3.CustomerID WHERE y1.Date LIKE '2013%' AND y2.Date LIKE '2013%' AND y3.Date LIKE '2013%' AND y1.Consumption = ( SELECT MIN(Consumption) FROM yearmonth WHERE Date LIKE '2013%' ) AND y2.Consumption = ( SELECT MIN(Consumption) FROM yearmonth WHERE Date LIKE '2013%' ) AND y3.Consum
SELECT Segment, (SUM(CASE WHEN substr(Date, 1, 4) = '2013' THEN Consumption ELSE 0 END) - SUM(CASE WHEN substr(Date, 1, 4) = '2012' THEN Consumption ELSE 0 END)) as Increase_or_Decrease, ((SUM(CASE WHEN substr(Date, 1, 4) = '2013' THEN Consumption ELSE 0 END) - SUM(CASE WHEN substr(Date, 1, 4) = '2012' THEN Consumption ELSE 0 END)) / SUM(CASE WHEN substr(Date, 1, 4) = '2013' THEN Consumption ELSE 0 END)) * 100 as Percentage_of_Increase FROM yearmonth JOIN customers ON yearmonth.CustomerID = customers.CustomerID WHERE Segment IN ('SME', 'LAM', 'KAM') GROUP BY Segment ORDER BY Percentage_of_Increase DESC
SELECT SUM(Consumption) FROM yearmonth WHERE CustomerID = 6 AND Date BETWEEN '201308' AND '201311'
SELECT Country, COUNT(*) AS DiscountGasStations FROM gasstations WHERE Segment = 'discount' GROUP BY Country
SELECT (SELECT Consumption FROM yearmonth WHERE CustomerID = 7 AND Date = '201304') - (SELECT Consumption FROM yearmonth WHERE CustomerID = 5 AND Date = '201304') AS Difference
SELECT COUNT(*) as SMES_Using_Koruna FROM customers WHERE Currency = 'Czech Koruna'
SELECT customers.CustomerID, customers.Segment, customers.Currency, yearmonth.Consumption FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE customers.Currency = "Euro" AND SUBSTR(yearmonth.Date, 1, 6) = "201310" ORDER BY yearmonth.Consumption DESC LIMIT 1
SELECT customers.CustomerID, customers.Segment, SUM(yearmonth.Consumption) AS TotalConsumption FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID GROUP BY customers.CustomerID ORDER BY TotalConsumption DESC LIMIT 1
SELECT SUM(Consumption) FROM yearmonth WHERE Date = '201305' AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'KAM')
SELECT (CustomerID, SUM(Consumption) > 46.73) * 100 / COUNT(CustomerID) FROM yearmonth WHERE CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'LAM')
SELECT Country, COUNT(*) AS TotalValueForMoneyGasStations FROM gasstations WHERE Segment = "value for money" GROUP BY Country
SELECT ((COUNT(CustomerID) / (SELECT COUNT(CustomerID) FROM customers WHERE Segment = 'KAM')) * 100) as Percentage_of_KAM_cust_paying_in_euros FROM transactions_1k JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE customers.Segment = 'KAM' AND customers.Currency = 'Euro'
SELECT 100 * COUNT(DISTINCT ye.CustomerID) FROM yearmonth ye WHERE ye.Date = '201202' AND ye.Consumption > 528.3 / (SELECT COUNT(DISTINCT ye.CustomerID) FROM yearmonth ye WHERE ye.Date = '201202') as Percentage_consumed_over_528.3 FROM yearmonth ye WHERE ye.Date = '201202'
SELECT ROUND((COUNT(DISTINCT gasstations.GasStationID) * 100) / (SELECT COUNT(DISTINCT gasstations.GasStationID) FROM gasstations WHERE Country = 'Slovakia'), 2) AS PercentagePremiumGasStations FROM gasstations WHERE Country = 'Slovakia' AND Segment = 'premium'
SELECT CustomerID FROM transactions_1k WHERE Date LIKE '201309' GROUP BY CustomerID ORDER BY SUM(Amount) DESC LIMIT 1
SELECT customers.Segment, SUM(transactions_1k.Amount) FROM customers JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201309' GROUP BY customers.Segment ORDER BY SUM(transactions_1k.Amount) ASC LIMIT 1
SELECT CustomerID, SUM(Consumption) AS TotalConsumption FROM yearmonth WHERE Date = '201206' AND CustomerID IN (SELECT CustomerID FROM customers WHERE Segment = 'SME') GROUP BY CustomerID ORDER BY TotalConsumption LIMIT 1
SELECT MAX(Consumption) as highest_monthly_consumption FROM yearmonth WHERE Date LIKE '2012%' GROUP BY Date
SELECT customers.CustomerID, customers.Currency, yearmonth.Date, SUM(yearmonth.Consumption) as MonthlyConsumption FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID WHERE customers.Currency = 'Euro' GROUP BY customers.CustomerID, yearmonth.Date ORDER BY MonthlyConsumption DESC LIMIT 1
SELECT products.Description FROM products JOIN "transactions_1k" ON products.ProductID = "transactions_1k".ProductID WHERE substr("transactions_1k".Date, 1, 4) = '2013' AND substr("transactions_1k".Date, 5, 2) = '09'
SELECT DISTINCT Country FROM gasstations INNER JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID WHERE substr(transactions_1k.Date, 1, 4) || substr(transactions_1k.Date, 6, 2) = '201306'
SELECT ChainID FROM gasstations WHERE GasStationID IN ( SELECT DISTINCT GasStationID FROM transactions_1k WHERE currency = 'Euro' )
SELECT products.Description FROM transactions_1k JOIN products ON transactions_1k.ProductID = products.ProductID WHERE transactions_1k.CustomerID IN (SELECT CustomerID FROM customers WHERE Currency = 'Euro')
SELECT ROUND(AVG(Price), 2) FROM transactions_1k WHERE Date LIKE '2012-01'
SELECT COUNT(*) FROM customers JOIN "yearmonth" ON customers.CustomerID = "yearmonth".CustomerID WHERE customers.Currency = 'Euro' AND "yearmonth".Consumption > 1000
SELECT products.Description FROM transactions_1k JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID JOIN products ON transactions_1k.ProductID = products.ProductID WHERE gasstations.Country = 'CZE'
SELECT transactions_1k.Time FROM transactions_1k JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE gasstations.ChainID = 11
SELECT COUNT(*) FROM transactions_1k tr JOIN gasstations gs ON tr.GasStationID = gs.GasStationID WHERE gs.Country = 'CZE' AND tr.Price > 1000
SELECT COUNT(*) FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE g.Country = 'CZE' AND t.Date > '2012-01-01'
SELECT AVG(Price) FROM transactions_1k JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE gasstations.Country = 'CZE'
SELECT customers.CustomerID, AVG(transactions_1k.Price * transactions_1k.Amount) AS average_total_price FROM customers JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID WHERE customers.Currency = 'Euro' GROUP BY customers.CustomerID
SELECT customers.CustomerID FROM transactions_1k JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Date = '2012-08-25' GROUP BY customers.CustomerID ORDER BY SUM(transactions_1k.Amount * transactions_1k.Price) DESC LIMIT 1
SELECT Country FROM gasstations WHERE GasStationID = ( SELECT GasStationID FROM transactions_1k WHERE Date = '2012-08-25' ORDER BY TransactionID LIMIT 1 )
SELECT customers.Currency FROM transactions_1k JOIN customers ON transactions_1k.CustomerID = customers.CustomerID WHERE transactions_1k.Time = '16:25:00' AND transactions_1k.Date = '2012-08-24'
SELECT customers.Segment FROM transactions_1k AS T1 JOIN customers ON T1.CustomerID = customers.CustomerID WHERE T1.Date = '2012-08-23' AND T1.Time = '21:20:00'
SELECT COUNT(*) FROM transactions_1k WHERE Currency = 'EUR' AND Time < '13:00:00' AND Date = '2012-08-26'
SELECT Segment FROM customers ORDER BY CustomerID LIMIT 1
SELECT gs.Country FROM transactions_1k AS T1 JOIN gasstations AS gs ON T1.GasStationID = gs.GasStationID WHERE T1.Date = '2012-08-24' AND T1.Time = '12:42:00'
SELECT ProductID FROM transactions_1k T1 WHERE Date = '2012-08-23' AND T1.Time = '21:20:00'
SELECT c.CustomerID, c.Segment, c.Currency, t.Date, t.Amount, t.Price FROM customers c JOIN transactions_1k t ON c.CustomerID = t.CustomerID JOIN yearmonth y ON c.CustomerID = y.CustomerID WHERE c.CustomerID = (SELECT CustomerID FROM transactions_1k WHERE Amount = 124.05 AND Date = '2012-08-24') AND y.Date LIKE '2012-01%' ORDER BY y.Date
SELECT COUNT(*) FROM transactions_1k t JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE t.Date = '2012-08-26' AND t.Time >= '08:00' AND t.Time < '09:00' AND g.Country = 'CZE'
SELECT customers.Currency FROM transactions_1k JOIN customers ON transactions_1k.CustomerID = customers.CustomerID JOIN yearmonth ON transactions_1k.CustomerID = yearmonth.CustomerID WHERE yearmonth.Date = '201306' AND yearmonth.Consumption = 214582.17
SELECT gasstations.Country FROM transactions_1k JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE transactions_1k.CardID = 667467
SELECT customers.Currency, gasstations.Country, transactions_1k.Amount FROM customers JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID JOIN gasstations ON transactions_1k.GasStationID = gasstations.GasStationID WHERE Date = '2012-08-24' AND Amount = 548.4
SELECT COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers WHERE Currency = 'EUR') AS Percentage FROM yearmonth WHERE Date = '2012-08-25' AND CustomerID IN (SELECT CustomerID FROM customers WHERE Currency = 'EUR')
SELECT (c.consumption_2012 - c.consumption_2013) / c.consumption_2012 as consumption_decrease_rate FROM (SELECT SUM(t.Amount) as consumption_2012, (SELECT SUM(t2.Amount) FROM transactions_1k t2 WHERE t2.CustomerID = t.CustomerID AND strftime('%Y',t2.Date) = '2013' ) as consumption_2013 FROM transactions_1k t WHERE t.CustomerID = (SELECT CustomerID FROM transactions_1k WHERE Price = 634.8 AND Date = '2012/8/25') AND strftime('%Y',t.Date) = '2012' ) c
SELECT GasStationID, SUM(Amount * Price) as Revenue FROM transactions_1k GROUP BY GasStationID ORDER BY Revenue DESC LIMIT 1
SELECT (SELECT COUNT(*) FROM gasstations WHERE Segment = 'premium' AND Country = 'SVK') * 100.0 / (SELECT COUNT(*) FROM gasstations WHERE Country = 'SVK') AS PremiumPercentageSVK
SELECT SUM(t.Amount) FROM transactions_1k t INNER JOIN customers c ON t.CustomerID = c.CustomerID INNER JOIN gasstations g ON t.GasStationID = g.GasStationID WHERE c.CustomerID = 38508
SELECT products.Description, SUM(transactions_1k.Amount) as TotalAmount FROM transactions_1k JOIN products ON transactions_1k.ProductID = products.ProductID GROUP BY products.Description ORDER BY TotalAmount DESC LIMIT 5
SELECT customers.CustomerID, customers.Currency, SUM(transactions_1k.Price) as TotalSpent, AVG(transactions_1k.Price / transactions_1k.Amount) as AvgPricePerItem FROM customers JOIN transactions_1k ON customers.CustomerID = transactions_1k.CustomerID GROUP BY customers.CustomerID ORDER BY TotalSpent DESC LIMIT 1
SELECT Country FROM gasstations JOIN transactions_1k ON gasstations.GasStationID = transactions_1k.GasStationID JOIN products ON transactions_1k.ProductID = products.ProductID WHERE products.ProductID = 2 ORDER BY transactions_1k.Price DESC LIMIT 1
SELECT customers.CustomerID, customers.Segment, customers.Currency, yearmonth.Consumption FROM customers JOIN yearmonth ON customers.CustomerID = yearmonth.CustomerID JOIN "transactions_1k" ON customers.CustomerID = "transactions_1k".CustomerID JOIN products ON "transactions_1k".ProductID = products.ProductID WHERE products.ProductID = 5 AND "transactions_1k".Price / "transactions_1k".Amount > 29.00 AND yearmonth.Date = '201208'
