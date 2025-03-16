select * from employees;

--Getting info of each column For Data Expolration and Cleaning
sp_help employees;

--Checking for missing values
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS Name_nulls,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_nulls,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_nulls,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Department_nulls,
    SUM(CASE WHEN Salary IS NULL THEN 1 ELSE 0 END) AS Salary_nulls,
    SUM(CASE WHEN Joining_Date IS NULL THEN 1 ELSE 0 END) AS JoiningDate_nulls,
    SUM(CASE WHEN Performance_Score IS NULL THEN 1 ELSE 0 END) AS PerformanceScore_nulls,
    SUM(CASE WHEN Experience IS NULL THEN 1 ELSE 0 END) AS Experience_nulls,
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS Status_nulls,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Location_nulls,
    SUM(CASE WHEN Session IS NULL THEN 1 ELSE 0 END) AS Session_nulls
FROM Employees;

--filling the null values in Performance_Score Column with the Mean
Select round(AVg(Performance_Score), 0) as Mean_value
from Employees
Where Performance_score is not null;

UPDATE Employees
SET Performance_Score = (Select round(AVg(Performance_Score), 0) as Mean_value
from Employees
Where Performance_Score is not null)
WHERE Performance_Score IS NULL;

select * from Employees;

-- Compare Average Salary Across Departments

Select Avg(Salary) as Average_Salary, Department
From Employees
Group By Department 
Order By Avg(Salary) Desc;

--Compare Average Salary Across Locations

Select Avg(Salary) as Average_Salary, Location
From Employees
Group by Location
Order By Avg(Salary) Desc;

--Best Performing Employees(Top 10)
Select Top 10 ID, Name, Department,Location, Performance_Score
From Employees
Order by Performance_Score Desc;

--Average Performance by Department
Select round(Avg(Performance_Score),2) as Average_Performance_Score, Department
From Employees
Group by Department
Order by Avg(Performance_Score) Desc;

--Count Employees by Status (Active vs Inactive)
Select count(Status) as Employee_count, Status
from Employees
Group by Status;

-- Employees who have been in the company for more than 10years(counting from current date)
select * 
from Employees
where Joining_Date < '2015/01/01';

--Count of Employees by Gender
Select count(Gender) as Gender_count, Gender
From Employees
Group by Gender;

-- Average Salary By Gender
Select Avg(Salary) as Average_Salary, Gender
from Employees
Group by Gender;

--High Performance who left the company
select * 
from Employees
Where Performance_Score >= 4 and Status = 'Inactive';

--Employees at Risk of leaving(Low Performance and Low Salary)
select * 
from Employees
where Performance_Score < 2 and Salary < (Select Avg(Salary) as Average_Salary from Employees);


--Employees at Risk of leaving(high Performance and Low Salary)
select * 
from Employees
where Performance_Score > 3 and Salary < (Select Avg(Salary) as Average_Salary from Employees);