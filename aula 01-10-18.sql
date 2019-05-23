create database comercial;

use comercial;

CREATE TABLE CLIENTE(
codcliente int not null,
nome varchar(60) not null,
datanascimento date not null,
cpf varchar(11) not null,
ddd char(3),
telefone varchar(9),
cidade varchar(50) not null,
CONSTRAINT pk_cliente PRIMARY KEY (codcliente)
);

CREATE TABLE PEDIDO(
codpedido int not null,
codcliente int not null,
datapedido date not null,
nf varchar(12) ,
valortotal decimal(10,2) not null,
CONSTRAINT pk_pedido PRIMARY KEY (codpedido),
CONSTRAINT pk_pedido_cliente FOREIGN KEY (codcliente) REFERENCES CLIENTE(codcliente)
);

CREATE TABLE PRODUTO(
codproduto int not null,
descricao varchar(100) not null,
quantidade int not null,
CONSTRAINT pk_produto PRIMARY KEY (codproduto)
);
CREATE TABLE ITEMPEDIDO(
codpedido int not null,
numeroitem int not null,
valorunitario decimal(10,2) not null,
quantidade int not null,
codproduto int not null,
CONSTRAINT pk_itempedido PRIMARY KEY (codpedido, numeroitem),
CONSTRAINT fk_codpedido FOREIGN KEY (codpedido) REFERENCES PEDIDO (codpedido),
CONSTRAINT fk_itempedido_produto FOREIGN KEY (codproduto) REFERENCES PRODUTO
(codproduto)
);


	

INSERT INTO CLIENTE VALUES (1, 'Sylvio Barbon', '1984-12-05','12315541212','044','981024457', 'Maringá');
INSERT INTO CLIENTE VALUES (2, 'Antonio Carlos da Silva', '1970-11-01','12313345512',NULL,NULL,'Maringá');
INSERT INTO CLIENTE VALUES (3, 'Thiago Ribeiro', '1964-11-15','12315544411','061','297458220','Brasília');
INSERT INTO CLIENTE VALUES (4, 'Carlos Eduardo', '1924-10-25','42515541212','044','810787377','Maringá');
INSERT INTO CLIENTE VALUES (5, 'Maria Cristina Goes', '1981-11-03','67715541212','044','989035479','Maringá');
INSERT INTO CLIENTE VALUES (6, 'Ruan Manoel Fanjo', '1983-12-06','32415541212','044','212447390','Maringá');
INSERT INTO CLIENTE VALUES (7, 'Patrícia Marques', '1944-02-01','77715541212',NULL,NULL,'São Paulo');

INSERT INTO PRODUTO VALUES (1, 'Mouse', 30);
INSERT INTO PRODUTO VALUES (2, 'Teclado', 27);
INSERT INTO PRODUTO VALUES (3, 'Monitor LCD', 10);
INSERT INTO PRODUTO VALUES (4, 'Caixas Acústicas', 22);
INSERT INTO PRODUTO VALUES (5, 'Impressora', 7);

INSERT INTO PEDIDO VALUES (1, 1, '2012-04-01', '00001', 400.00);
INSERT INTO ITEMPEDIDO VALUES (1, 1, 10.90, 1, 1);
INSERT INTO ITEMPEDIDO VALUES (1, 2, 389.10, 1, 3);

INSERT INTO PEDIDO VALUES (2, 2, '2012-04-01', '00002', 10.90);
INSERT INTO ITEMPEDIDO VALUES (2, 1, 10.90, 1, 1);
INSERT INTO PEDIDO VALUES (3, 2, '2012-04-01', '00003', 21.80);
INSERT INTO ITEMPEDIDO VALUES (3, 1, 10.90, 1, 1);

INSERT INTO PEDIDO VALUES (4, 3, '2012-05-01', '00004', 169.10);
INSERT INTO ITEMPEDIDO VALUES (4, 1, 10.90, 1, 1);
INSERT INTO ITEMPEDIDO VALUES (4, 2, 15.90, 2, 2);
INSERT INTO ITEMPEDIDO VALUES (4, 3, 25.50, 1, 4);
INSERT INTO ITEMPEDIDO VALUES (4, 4, 100.90, 1, 5);

INSERT INTO PEDIDO VALUES (5, 4, '2012-05-01', '00005', 100.90);
INSERT INTO ITEMPEDIDO VALUES (5, 1, 100.90, 1, 5);

INSERT INTO PEDIDO VALUES (6, 6, '2012-05-02', '00006', 51.35);
INSERT INTO ITEMPEDIDO VALUES (6, 1, 25.50, 2, 4);

select count(*) from cliente;

select count(*) from cliente where telefone;

select min(datanascimento), max(datanascimento) from cliente; 

select avg(quantidade) from produto;

select sum(valortotal) from pedido;

select sum(valortotal > 100) from pedido;

select count(*) from cliente where datanascimento between '1980-01-01' and '1989-12-31';

select sum(valortotal), max(valortotal), min(valortotal), avg(valortotal) from pedido where datapedido = '2012-04-01' ;

select cidade, count(*) from cliente group by cidade;

select datapedido, sum(valortotal) from pedido group by datapedido;

select codproduto, max(quantidade), min(quantidade) from itempedido group by codproduto;

select codcliente, sum(valortotal), max(valortotal) from pedido group by codcliente;

select cidade, min(datanascimento) from cliente group by cidade;

select quantidade, codproduto, avg(valorunitario) from itempedido group by quantidade, codproduto;

select cidade, count(*) from cliente group by cidade having count(*) >2;

select codproduto, sum(valorunitario) from itempedido where codproduto >2 group by codproduto having sum(valorunitario) <100;

select cli.nome, cli.cpf, ped.datapedido, ped.nf, ped.valortotal from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente order by cli.nome; 

select cli.nome, cli.cpf, ped.datapedido, ped.nf, ped.valortotal from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente where ped.datapedido between '2012-04-01' and '2012-04-30' order by cli.nome;

select cli.nome, cli.cpf, cli.telefone, cli.cidade, ped.datapedido, ped.nf, ped.valortotal from cliente as cli left outer join pedido as ped
on cli.codcliente = ped.codcliente order by cli.nome;

select cli.nome, cli.cpf, cli.telefone, cli.cidade, sum(ped.valortotal)as total from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente where ped.datapedido between '2012-01-01' and '2012-12-31' and cli.codcliente = 2 
group by cli.nome, cli.cpf, cli.cidade;

select ped.nf, ped.datapedido, ped.valortotal, itemped.quantidade, prod.descricao from pedido as ped inner join itempedido as itemped 
on ped.codpedido = itemped.codpedido inner join produto as prod on itemped.codpedido = prod.codproduto
where ped.datapedido between '2012-05-01' and '2012-05-31';

select cli.nome, sum(ipe.quantidade) quantidade, prod.descricao from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente inner join itempedido as ipe on ped.codpedido = ipe.codpedido inner join produto as prod
on ipe.codproduto = prod.codproduto where cli.codcliente = 3 group by cli.nome, prod.descricao;

select cli.nome, cli.cpf, cli.cidade from cliente as cli where cli.cidade = 'Maringá'
union
select cli.nome, cli.cpf, cli.cidade from cliente as cli where cli.cidade = 'Maringá' or cli.cidade = 'Brasília';

select codproduto, descricao, prod.quantidade from produto where prod.quantidade between 10 and 25
union
select codproduto, descricao, prod.quantidade from produto where prod.quantidade between 20 and 35
group by prod.codproduto; 

select cli.nome, cli.cpf, cli.telefone, cli.cidade, sum(ped.valortotal) as total from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente where ped.datapedido between '2012-01-01' and '2012-12-31' group by cli.nome, cli.cpf, cli.telefone, cli.cidade
having sum(ped.valortotal) between 100 and 200
union all
select cli.nome, cli.cpf, cli.telefone, cli.cidade, sum(ped.valortotal) as total from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente where ped.datapedido between '2012-01-01' and '2012-12-31' group by cli.nome, cli.cpf, cli.telefone, cli.cidade 
having sum(ped.valortotal) between 150 and 500;

select * from produto where quantidade = (select max(quantidade) from produto);

select * from cliente where datanascimento <> (select min(datanascimento) from cliente);

select * from cliente where cidade <> (select max(cidade) from cliente);

select * from itempedido where numeroitem > (select min(numeroitem) from itempedido where quantidade > 1);

select cli.nome, cli.cpf, ped.valortotal from cliente as cli left join pedido as ped on cli.codcliente = ped.codcliente
where ped.valortotal <= (select avg(valortotal) from pedido where ped.datapedido between '2012-04-01' and '2012-04-31')
order by valortotal;

select * from cliente where cidade in
(select cidade from cliente where datanascimento in('1964-11-15' , '1981-11-03' , '1970-11-01'));

select * from produto where codproduto not in(select codproduto from produto where quantidade in(7, 10, 30));

select cli.nome, cli.cpf, cli.cidade, max(ped.valortotal) as total from cliente as cli left join pedido as ped
on cli.codcliente = ped.codcliente where cli.cidade 
not in(select cidade from cliente where codcliente in (3, 7)) group by cli.nome, cli.cpf, cli.cidade
having max(ped.valortotal) is null;

select * from pedido where codcliente > any (select codcliente from cliente where cidade = 'Maringá');

select * from pedido where codcliente < all (select codcliente from cliente where cidade = 'Brasilia');

select * from itempedido where codpedido >= any (select codpedido from pedido where valortotal > 50);

select * from itempedido where codpedido <= all (select codpedido from pedido where valortotal > (select avg(valortotal)from pedido));

create view vw_cliente as select nome, cpf from cliente;

select * from vw_cliente;

alter view vw_cliente as select datanascimento, nome, cpf from cliente;

alter view vw_cliente as select datanascimento, nome, cpf, cidade from cliente where cidade = 'Maringá';

select * from vw_cliente where cpf like '1%';

drop view vw_cliente;

create view vw_produto as select descricao, quantidade from produto;

select * from vw_produto;

alter view vw_produto as select descricao, quantidade from produto where quantidade > 20 order by descricao asc;

create view vw_pedido1 as select cli.nome, cli.cpf, ped.datapedido, ped.nf, ped.valortotal from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente;

select * from vw_pedido1;

alter view vw_pedido as select cli.nome, cli.cpf, ped.datapedido, ped.nf, ped.valortotal, ped.codpedido from cliente as cli 
inner join pedido as ped on cli.codcliente = ped.codcliente;

select ped.*, sum(ipe.quantidade) as quantidade from vw_pedido as ped inner join itempedido as ipe on ped.codpedido = ipe.codpedido 
group by ped.nome, ped.nf, ped. codpedido, ped.datapedido, ped.valortotal; 

create view vw_cliqtd as select cli.nome, sum(ipe.quantidade) quantidade, prod.descricao from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente inner join itempedido as ipe on ped.codpedido = ipe.codpedido inner join produto as prod
on ipe.codproduto = prod.codproduto group by cli.nome, prod.descricao;

use comercial;

select * from vw_cliqtd;

alter view vw_cliqtd as select cli.nome, sum(ipe.quantidade) quantidade, prod.descricao, ped.nf from cliente as cli inner join pedido as ped 
on cli.codcliente = ped.codcliente inner join itempedido as ipe on ped.codpedido = ipe.codpedido inner join produto as prod
on ipe.codproduto = prod.codproduto group by cli.nome, prod.descricao;

select * from vw_cliqtd where nf = 4;

create table produto_log (
id bigint auto_increment not null,
codproduto int(11) null,
descricao varchar(100) null,
quantidade int (11) null,
operacao varchar (100) null,
constraint pk_id_prdouto primary key (id)
);


delimiter $
create trigger trg_ib_produto before insert on produto for each row begin 
insert into produto_log (codproduto, descricao, quantidade, operacao) values (new.codproduto, new.descricao, new.quantidade, 'insert');
end $


delimiter $
create trigger trg_dl_produto before delete on produto for each row begin
insert into produto_log (codproduto, descricao, quantidade, operacao) values (old.codproduto, old.descricao, old.quantidade, 'delete');
end $


delimiter$
create trigger trg_up_produto after update on produto for each row begin
insert into produto_log (codproduto, descricao, quantidade, operacao) values (new.codproduto, new.descricao, new.quantidade, 'update');
end $


select * from cliente where cidade = 'Maringá';

create index ix_cliente_cidade on cliente (cidade) using btree;

select * from cliente where datanascimento = '1924-10-25';

create index ix_cliente_dtnascimento on cliente (datanscimento) using btree;

select * from cliente where datanascimento = '1924-10-25' and cidade = 'Maringá';

create index ix_cliente_dtnasc_cidade on cliente (datanascimento, cidade) using btree;

delimiter $$ 
create procedure sp_insertProduto (IN cod_produto int, IN descricao varchar(100), IN qnt int)
BEGIN 

start transaction;

insert into produto (codproduto, descricao, quantidade) values (cod_produto, descricao, qnt);

COMMIT;

END $$

call sp_insertProduto (6 ,'teclado', 10);

select * from produto;

drop procedure sp_insertProduto;

delimiter $$ 
create procedure sp_updateProduto (IN cod int, IN descri varchar(100), IN qnt int)
BEGIN 

start transaction;

update produto set  descricao = descri , quantidade = qnt where cod_produto = cod;

COMMIT;

END $$

call sp_insertProduto (7 ,'notebook', 20);

delimiter $$ 
create procedure sp_deleteProduto (IN cod int)
BEGIN 

start transaction;

delete from produto;
COMMIT;

END $$

delimiter $$ 
create procedure sp_selectProduto1 (IN cod int)
BEGIN 

start transaction;

select * from produto where codproduto = codigo;
COMMIT;

END $$

delimiter $$ 
create procedure sp_deleteProduto (IN cod int)
BEGIN 

start transaction;

delete from produto;
COMMIT;

END $$

delimiter $$ 
create function fn_nomeproduto (cod int)
returns int deterministic
BEGIN 

return(select nome from produto where codproduto=cod);

END $$

use comercial;

select fn_nomeproduto(1);