--JANITORIAL MANAGEMENT SYSTEM 
--21pc17 JYOTHISH K S
--21PC19 NANDA PRANESH S
--21PC25 VARUN S
set serveroutput on 30000;

--drop table department;
create table department(
department_id int not null,
department_name varchar(20) not null,
primary key(department_id)
);

insert into department values(1001,'Cleaning');
insert into department values(1002,'Electrician');
insert into department values(1003,'Doorkeeper');

--drop table janitor;
create table janitor(
janitor_id int not null,
janitor_name varchar(20) not null,
janitor_age int not null,
dept_id int not null,
primary key(janitor_id),
foreign key(dept_id) references department(department_id)
);

desc janitor;
create or replace package janitor_management as
    procedure add_janitor(j_id janitor.janitor_id%type,jname janitor.janitor_name%type,jage janitor.janitor_age%type,jdept janitor.dept_id%type);
    procedure upd_janitor(j_id janitor.janitor_id%type);
    procedure del_janitor(j_id janitor.janitor_id%type);
    procedure print_data(j_id janitor.janitor_id%type);
end janitor_management;

create or replace package body janitor_management as
    procedure add_janitor(j_id janitor.janitor_id%type,jname janitor.janitor_name%type,jage janitor.janitor_age%type,jdept janitor.dept_id%type) is
        begin
            insert into janitor values(j_id,jname,jage,jdept);
            dbms_output.put_line('Data inserted.');
        end add_janitor;
    procedure upd_janitor(j_id janitor.janitor_id%type) is
        begin
            update janitor
            set janitor_age = janitor_age + 1 where janitor_id = j_id;
        end upd_janitor;
    procedure del_janitor(j_id janitor.janitor_id%type) is
        begin
            delete from janitor where janitor_id = j_id;
            dbms_output.put_line('Data deleted.');
        end del_janitor;
    procedure print_data(j_id janitor.janitor_id%type) is
        jname janitor.janitor_name%type;
        cursor jan_name is
            select janitor_name from janitor;
        begin
            open jan_name;
            loop
                fetch jan_name into jname;
                exit when jan_name%notfound;
                dbms_output.put_line('JANITOR NAME : ' || jname);
            end loop;
            close jan_name;
        end print_data;
end;
/

declare
    a int := '&a';
    j_id janitor.janitor_id%type := '&j_id';
    jname janitor.janitor_name%type := '&jname';
    jage janitor.janitor_age%type := '&jage';
    jdept janitor.dept_id%type := '&jdept';
begin
    dbms_output.put_line('Enter the number: ');
    dbms_output.put_line('  1.Insert');
    dbms_output.put_line('  2.Update');
    dbms_output.put_line('  3.Delete');
    dbms_output.put_line('  4.Print');
    dbms_output.put_line('  5.Exit');
    if a=1 then
        janitor_management.add_janitor(j_id,jname,jage,jdept);
    elsif a=2 then
        janitor_management.upd_janitor(j_id);
    elsif a=3 then
        janitor_management.del_janitor(j_id);
    elsif a=4 then
        janitor_management.print_data(j_id);
    elsif a=5 then
        dbms_output.put_line('Thank You!');
    else
        dbms_output.put_line('Invalid input!');
    end if;
end;
/

select * from janitor;