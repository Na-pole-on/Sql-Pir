create table "employees" (
	id SERIAL PRIMARY KEY,
	name TEXT  UNIQUE,
	department CHAR(50),
	salary Decimal,
	hire_date Date
);

insert into "employees" (name, department, salary, hire_date) 
values
('John Smith', 'IT', '50000', '2022-01-01'),
('Jane Doe', 'HR', '60000','2021-05-15'),
('Mike Johnson','Sales','70000','2020-10-10');

update "employees"
set salary = 55000
where id = 1;

delete from "employees" where id = 3;

alter table "employees" add email text;

create user "report_user" with password '12345';
grant select on "employees" to "report_user";

REVOKE ALL PRIVILEGES ON "employees" FROM "report_user";
DROP USER IF EXISTS "report_user";

DROP TABLE "employees";