create database Dados;

use Dados;


create table Pessoa (
ID_Pes int auto_increment not null
,Nome varchar(60) not null
,Documento varchar(50) not null
,constraint pk_IDpessoa primary key (ID_Pes)
);

create table Recibo(
Numero int auto_increment not null
,Valor decimal (10,2) not null
,Assinatura varchar(50) not null
,DataRecibo date not null
,Emitente_fk int not null
,Prestador_fk int not null
,constraint pk_IDnumero primary key (Numero)
,constraint fk_Emitente foreign key (Emitente_fk) references Pessoa(ID_Pes)
,constraint fk_Prestador foreign key (Prestador_fk) references Pessoa(ID_Pes)
);

create table UF (
ID_uf int auto_increment not null
,Sigla varchar (15) not null
,constraint pk_ID_UF primary key (ID_uf)
);

create table Cidade (
ID_Cid int auto_increment not null
,Cidade varchar (50) not null
,Uf_fk int not null
,constraint pk_IDcid primary key (ID_Cid)
,constraint fk_Id_uf foreign key (Uf_fk) references UF(ID_uf)
);

create table Endereço (
ID_End int auto_increment not null
,Logradouro varchar (60) not null
,TipoLogradouro varchar (60) not null
,Numero int not null
,Complemento varchar (50) not null
,CEP varchar (15) not null
,Tipo int not null
,Pessoa_fk int not null
,Cidade_fk int not null
,constraint pk_IDendereço primary key (ID_End)
,constraint fk_Pessoa foreign key (Pessoa_fk) references Pessoa(ID_Pes)
,constraint fk_Cidade foreign key (Cidade_fk) references Cidade(ID_Cid)
);

## 1
insert into uf (Sigla) values ('AC');
insert into uf (Sigla) values ('PR'); ##2
insert into uf (Sigla) values ('SP'); ##3
insert into uf (Sigla) values ('SC'); ##4 
insert into uf (Sigla) values ('AC');
insert into uf (Sigla) values ('AL'); 
insert into uf (Sigla) values ('AP');
insert into uf (Sigla) values ('AM');
insert into uf (Sigla) values ('BA');
insert into uf (Sigla) values ('CE');    
insert into uf (Sigla) values ('DF');
insert into uf (Sigla) values ('ES');
insert into uf (Sigla) values ('GO');
insert into uf (Sigla) values ('MA');
insert into uf (Sigla) values ('MT');
insert into uf (Sigla) values ('MS');
insert into uf (Sigla) values ('MG');
insert into uf (Sigla) values ('PA');
insert into uf (Sigla) values ('PB');
insert into uf (Sigla) values ('PE');
insert into uf (Sigla) values ('PI');
insert into uf (Sigla) values ('RJ');
insert into uf (Sigla) values ('RN');
insert into uf (Sigla) values ('RS');
insert into uf (Sigla) values ('RO');
insert into uf (Sigla) values ('RR');
insert into uf (Sigla) values ('SE'); 
insert into uf (Sigla) values ('TO'); 

## 3
DELETE from uf where id_uf = 1;
DELETE from uf where id_uf = 5; 
DELETE from uf where id_uf = 6;
DELETE from uf where id_uf = 7;
DELETE from uf where id_uf = 8;
DELETE from uf where id_uf = 9;
DELETE from uf where id_uf = 10;
DELETE from uf where id_uf = 11;  
DELETE from uf where id_uf = 12; 
DELETE from uf where id_uf = 13;  
DELETE from uf where id_uf = 14;
DELETE from uf where id_uf = 15;
DELETE from uf where id_uf = 16;
DELETE from uf where id_uf = 17;
DELETE from uf where id_uf = 18;
DELETE from uf where id_uf = 19;
DELETE from uf where id_uf = 20;
DELETE from uf where id_uf = 21;
DELETE from uf where id_uf = 22;
DELETE from uf where id_uf = 23;
DELETE from uf where id_uf = 24;
DELETE from uf where id_uf = 25;
DELETE from uf where id_uf = 26;
DELETE from uf where id_uf = 27;
DELETE from uf where id_uf = 28;
DELETE from uf where id_uf = 29;                   
##29 ufs


select * from cidade;


## PR
insert into Cidade (cidade, Uf_fk) values ('Maringá', 2);
insert into Cidade (cidade, Uf_fk) values ('Curitiba', 2);
insert into Cidade (cidade, Uf_fk) values ('Lunardelli', 2);
insert into Cidade (cidade, Uf_fk) values ('Apucarana', 2);
insert into Cidade (cidade, Uf_fk) values ('Santa Fé', 2);
insert into Cidade (cidade, Uf_fk) values ('São Miguel Do Iguaçu', 2);
insert into Cidade (cidade, Uf_fk) values ('Arapongas', 2);
insert into Cidade (cidade, Uf_fk) values ('Ponta Grossa', 2);
insert into Cidade (cidade, Uf_fk) values ('Jandaia Do Sul', 2);

## SP (2 e 4)
insert into Cidade (cidade, Uf_fk) values ('Ribeirão Preto', 3);
insert into Cidade (cidade, Uf_fk) values ('Campinas', 3);
insert into Cidade (cidade, Uf_fk) values ('Jundiaí', 3);
insert into Cidade (cidade, Uf_fk) values ('São Paulo', 3);

## SC
insert into Cidade (cidade, Uf_fk) values ('Chapecó', 4);
insert into Cidade (cidade, Uf_fk) values ('Joinville', 4);
insert into Cidade (cidade, Uf_fk) values ('Blumenau', 4);


UPDATE Cidade SET cidade = 'lunardelli' where ID_Cid = 4;
UPDATE Cidade SET cidade = 'Jandaia' where ID_Cid = 10;
UPDATE Cidade SET cidade = 'Cidade Canção' where ID_Cid = 2;

## 6
SELECT cidade.cidade, uf.sigla FROM cidade INNER JOIN uf ON uf.Id_uf = CIDADE.Uf_fk ORDER BY uf.sigla;

select  u.sigla, count(c.cidade) from cidade as c
inner join uf as u on u.id_uf = c.uf_fk
group by u.sigla
order by u.sigla, c.cidade;

select count(*) from cidade where uf_fk = 2;
select count(*) from cidade where uf_fk = 3;
select count(*) from cidade where uf_fk = 4;

select * from pessoa;

## 8
insert into Pessoa values (1,'João',11111111120);
insert into Pessoa values (2,'José',22222222210);
insert into Pessoa values (3,'Carlos',33333333340);

insert into endereço values (1, 'Avenida Brasil', 'Centro', 325, 'Prédio', 80251400, 2,1,5);
insert into endereço values (2, 'Rua Alvaro Miranda', 'portal das torres', 755, 'casa', 88800000, 1,1,5);
insert into endereço values (3, 'Avenida Europa', 'Centro', 942, 'Prédio', 82254300, 2,2,2);
insert into endereço values (4, 'Rua Raposo Tavares', 'Jardim Alvorada', 205, 'casa', 87800032, 1,2,2);
insert into endereço values (5, 'Avenida Japão', 'Centro', 165, 'Prédio', 80446600, 2,3,3);
insert into endereço values (6, 'Rua Guarani', 'Jardim Paris', 735, 'casa', 87802500, 1,3,3);

## 9
insert into Pessoa values (4,'Ana',66666666630);
insert into Pessoa values (5,'Bruno',77777777750);

insert into endereço values (7, 'Avenida Colombo', 'Centro', 333, 'Prédio', 80024500, 2,4,10);
insert into endereço values (8, 'Rua Mario Ribeiro Borges', 'Jardim Ipiranga', 125, 'casa', 86631500, 1,4,10);
insert into endereço values (9, 'Avenida Tamandaré', 'Centro', 752, 'Prédio', 84556300, 2,5,17);
insert into endereço values (10, 'Rua Santos Dummont', 'Jardim Montreal', 665, 'casa', 87800032, 1,5,17);

## 10
insert into Pessoa values (6,'Alisson',88888888820);
insert into Pessoa values (7,'Maria',99999999910);

insert into endereço values (11, 'Avenida Mandacaru', 'Centro', 456, 'Prédio', 80123440, 2,6,15);
insert into endereço values (12, 'Rua Fernando Dias', 'Parque Avenida', 789, 'casa', 85500300, 1,6,15);
insert into endereço values (13, 'Avenida Mauá', 'Centro', 321, 'Prédio', 82326500, 2,7,16);
insert into endereço values (14, 'Rua Carlos Chagas', 'Zona 10', 258, 'casa', 87852632, 1,7,16);


select * from endereço;

## 11
create view vw_dados0 as select Pes.Nome, Ende.logradouro, Ende.tipoLogradouro, Ende.numero, Ende.Complemento, Ende.CEP, Cid.cidade, UF.sigla
from Pessoa as Pes inner join Endereço as Ende on Pes.ID_Pes = Ende.pessoa_fk 
inner join Cidade as Cid on Cid.ID_Cid = Ende.Cidade_fk inner join UF as Uf on Uf.ID_uf = Cid.Uf_fk group by Pes.nome, Uf.sigla, Cid.cidade;

select * from vw_dados0;

## 12
delete from endereço where Id_end in (9,10);

delete from pessoa where Id_Pes = 5 ;

## 13
update endereço set cep = 00000000 where id_end = 1;
update endereço set cep = 00000000 where id_end = 2;
update endereço set cep = 00000000 where id_end = 3;
update endereço set cep = 00000000 where id_end = 4;
update endereço set cep = 00000000 where id_end = 5;
update endereço set cep = 00000000 where id_end = 6;
update endereço set cep = 00000000 where id_end = 7;
update endereço set cep = 00000000 where id_end = 8;
update endereço set cep = 00000000 where id_end = 9;
update endereço set cep = 00000000 where id_end = 10;
update endereço set cep = 00000000 where id_end = 11;
update endereço set cep = 00000000 where id_end = 12;
update endereço set cep = 00000000 where id_end = 13;
update endereço set cep = 00000000 where id_end = 14;

select * from endereço;

## 14
alter table recibo change emitente_fk  cliente_fk integer;

## 15
insert into recibo values (01, 1000.00, '', '2018-01-01', 1,3);
insert into recibo values (02, 1500.00, '', '2018-02-10', 2,3);

## 16
insert into recibo values (03, 1800.00, '', '2018-06-15', 3,1);
insert into recibo values (04, 2000.00, '', '2018-11-01', 3,4);

select * from recibo;

select * from pessoa;

## 17
select cli.nome as nome_cliente, pre.nome as nome_prestador,cid.cidade, Rec.Numero, Rec.DataRecibo, 
Rec.valor, Rec.cliente_fk, Rec.prestador_fk, u.sigla from Recibo as Rec 
inner join Pessoa as cli on Rec.cliente_fk = cli.ID_Pes 
inner join pessoa as pre on Rec.prestador_fk = pre.ID_Pes 
inner join Endereço as ende_pre on ende_pre.pessoa_fk = pre.ID_Pes
inner join Cidade as cid on cid.ID_Cid = ende_pre.Cidade_fk
inner join Uf as u on u.ID_uf = cid.UF_fk where u.sigla = 'pr';

## 18
select count(rec.numero) as QntRecibo from  Recibo as Rec inner join Pessoa as cli on Rec.cliente_fk = cli.ID_Pes 
inner join pessoa as pre on Rec.prestador_fk = pre.ID_Pes 
inner join Endereço as ende_pre on ende_pre.pessoa_fk = pre.ID_Pes
inner join Cidade as cid on cid.ID_Cid = ende_pre.Cidade_fk
inner join Uf as u on u.ID_uf = cid.UF_fk where u.sigla = 'pr';

select sum(valor) as ValorTotal, u.sigla from recibo as rec inner join Pessoa as cli on Rec.cliente_fk = cli.ID_Pes 
inner join pessoa as pre on Rec.prestador_fk = pre.ID_Pes 
inner join Endereço as ende_pre on ende_pre.pessoa_fk = pre.ID_Pes
inner join Cidade as cid on cid.ID_Cid = ende_pre.Cidade_fk
inner join Uf as u on u.ID_uf = cid.UF_fk where u.Id_uf = 2;

