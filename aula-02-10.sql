create database Hospital;

USE Hospital; 

create table Doencas (
	Codigo_Doenca int not null
    ,Nome varchar(100)
    ,primary key (Codigo_Doenca)
);


create table Pacientes (
	Codigo_Paciente int not null,
    Nome varchar(100) not null,
    Idade int,
    Cod_Doenca int ,
    primary key (Codigo_Paciente)
	,constraint FK_PacientesDoencas foreign key (Cod_Doenca) references Doencas (Codigo_Doenca)
    );
    
insert into Doencas values (1,'Gripe'),(2, 'Peneumonia'),(3, 'Anemia'),(4,'Bulimia');

insert into Pacientes values (1, 'Bruno',23,2),(2, 'José', 55,1),(3,'Maria',75,1);

select Pacientes.Nome, Doencas.Nome from Pacientes, Doencas where Pacientes.Cod_Doenca = Doencas.Codigo_Doenca;

select PAC.Nome, DOE.Nome from Pacientes as PAC, Doencas as DOE;

select pac.nome, doe.nome from pacientes as pac inner join doencas as doe on pac.cod_doenca = doe.codigo_doenca;

select pac.nome, doe.nome from pacientes as pac inner join doencas as doe on pac.cod_doenca = doe.codigo_doenca where pac.Idade > 30;

select pac.nome, doe.nome from doencas as doe left outer join pacientes as pac on pac.cod_doenca = doe.codigo_doenca;

select pac.nome, doe.nome from pacientes as pac right outer join doencas as doe on pac.cod_doenca = doe.codigo_doenca;

//select campo1 from tabela union select campo2 fro tabela2;

select Codigo_Paciente, Nome from Pacientes
union
select Codigo_Paciente, Nome from Pacientes;

select Codigo_Doenca, nome from Doencas
union all
select Codigo_Doenca, nome from Doencas;

select * from Pacientes where idade > (select avg(idade) from pacientes);

select * from doencas where nome in (select nome from doencas where codigo_doenca >2);

select * from doencas where nome > any (select nome from doencas where codigo_doenca >2);

select * from doencas where nome > ALL (select nome from doencas where codigo_doenca >2);

select nome from doencas where not exists (select * from pacientes where pacientes.Cod_doenca = doencas.Codigo_doenca);

create view vw_pacientes as select nome, idade from pacientes;

select * from vw_pacientes;

alter view vw_pacientes as select Codigo_paciente, nome, idade from pacientes;

drop view vw_pacientes;

explain select pac.nome, doe.nome from Pacientes as pac inner join Doencas as doe on pac.cod_doenca = doe.codigo_doenca;

create index ix_Pacientes_Cod_Doenca on Pacientes (Cod_Doenca) using btree;

delimiter $$ 
create procedure sp_insertDoenca (IN codigo int, IN nomedoenca varchar(100))
BEGIN 

start transaction;

insert into Doencas (Codigo_Doenca, nome) values (codigo, nomedoenca);

COMMIT;

END $$

CALL sp_insertDoenca ( 5, 'AIDS');

select * from doencas;

drop procedure sp_insertDoenca;

delimiter $$ 
create function fn_nomedoenca (cod int)
returns varchar(100) deterministic
BEGIN 

return(select nome from doencas where Codigo_Doenca=cod);

END $$

select fn_nomedoenca(1);

drop function fn_nomedoenca;