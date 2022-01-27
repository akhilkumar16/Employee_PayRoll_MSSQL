--uc1-Creation of data base
create database payroll_service;
--uc2- Create a employee payroll table
create table Employee_payroll
(Id int IDENTITY,
	Name varchar(200),
	Salary float,
	StartDate date
);
--UC3-Ability to create employee payroll data service database
insert into Employee_PayRoll VALUES('a',12345.00,'2022-01-22');

insert into Employee_PayRoll VALUES('b',245000.00,'2020-01-22');

insert into Employee_PayRoll VALUES('c',120650.00,'2019-01-22');

insert into Employee_PayRoll VALUES('e',210000.00,'2021-02-12');
--UC4-Ability to retrieve all the employee payroll data 
select * from Employee_payroll
select salary from Employee_payroll
select Name,salary from Employee_payroll
---UC5 Ability to retrieve salary data for particular employee
select * from Employee_PayRoll where StartDate between cast('2022-01-22' as date) and getdate();
---UC6 Ability to add gender to table and update table
Alter table Employee_PayRoll ADD Gender varchar(255);

update Employee_PayRoll set Gender='M' where Id=4;

---UC7 Ability to find sum,average,max, min and number of male and female employees
select SUM(Salary) as Sumofsalary from Employee_PayRoll;

select Avg(Salary) as Avgofsalary from Employee_PayRoll;

select MIN(Salary) as Minofsalary from Employee_PayRoll;

select MAX(Salary) as Maxofsalary from Employee_PayRoll;

select count(Id) from Employee_PayRoll;

select count(Id) as NoOfPeople,Gender from Employee_PayRoll group by Gender;

select * from Employee_PayRoll;

---UC8 Ability to extend data to store information like employee phone, address and department
ALTER TABLE Employee_PayRoll ADD Phone int;

ALTER TABLE Employee_PayRoll ADD Address varchar(250) null default 'ABC';

ALTER TABLE Employee_PayRoll ADD Department varchar(250) not null default 'D';

--UC9 Ability to extend employee payroll table to have basic pay, deductions,taxable pay,income tax,net pay
ALTER TABLE Employee_PayRoll ADD Deduction bigint,Taxable_Pay float,Income_Tax float,Net_Pay float;
SELECT * FROM EMPLOYEE_PAYROLL
--Er diagram
create table PayrollDetails(
Payroll_id int not null Primary Key,
BasePay int not null,
Deduction int not null,
TaxtablePay as (BasePay-Deduction) persisted,
NetPay as (BasePay-Deduction-0.05*( BasePay-Deduction)) persisted,
IncomeTax as 0.05*(BasePay-Deduction) persisted
);
select * from PayrollDetails

--Insert Values PayrollDetails Table
insert into PayrollDetails values (1,500000,40000),(2,400000,8000),(3,450000,50000),(4,300000,45000);
select * from PayrollDetails


--UC11.2:- Create EmployeeDetails Table
create table EmployeeDetails 
(
Emp_id int not null Primary Key identity(1,1),
Emp_Name varchar(50) not null,
Gender char(1) not null,
Phone_Number varchar(50),
Payroll_id int not null Foreign key References PayrollDetails(Payroll_id),
Start_Date Date default GetDate()
);
select * from EmployeeDetails; 

--insert values into EmployeeDetails Table
INSERT into EmployeeDetails(Emp_Name,Gender,Phone_Number,Payroll_id) values
('ak','M','123456','1'),
('pk','M','654123','2'),
('rk','M','987456','3'),
('Terissa','F','654789','4');