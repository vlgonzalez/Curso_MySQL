create database cadastro
default character set utf8
default collate utf8_general_ci;

use cadastro;

create table pessoas (
id int auto_increment not null ,
nome varchar (30) not null,
nascimento date, 
sexo enum ('M', 'F'),
peso decimal (5,2),
altura decimal (3,2),
nacionalidade varchar (20) default ' Brasil',
primary key (id)	
) default charset = utf8;

INSERT into pessoas
(nome, nascimento, sexo, peso, altura, nacionalidade)
VALUES
('Godofredo', '1984-01-02','M','78.5','1.83','Brasil');

insert into pessoas
(nome, nascimento, sexo, peso, altura, nacionalidade)
values
('Maria', '1985-03-02', 'F', '55.2', '1.65','Portugal');

insert into pessoas values
(default, 'adalgiza', '1930-05-02' , 'F', '56.5', 1.45, 'EUA'); 

insert into pessoas values
(default, 'Claudio', '1970-05-02' , 'F', '56.5', 1.45, 'EUA'),
(default, 'Janaina' ,'1930-05-02' , 'F', '56.5', 1.45, 'Brasil'),
(default, 'Pedro' ,'1930-05-02' , 'F', '56.5', 1.45, 'Portugal');

alter table pessoas
add column profissao varchar (20);

alter table pessoas
drop column profissao;

alter table pessoas
add column profissao varchar (20)  after nome;

alter table pessoas 
add codigo  int first;

alter table pessoas
modify column profissao varchar(30) ;

alter table pessoas
change column profissao prof varchar(20);

alter table pessoas
rename to gafanhotos;

desc gafanhotos;

select * from pessoas;

create table if not exists cursos (
nome varchar(30) not null unique,
descricao text,
carga int unsigned,
totaulas int unsigned,
ano year default '2016'
);

alter table cursos
add id_curso int  first;

alter table cursos
add primary key ( id_curso);

desc cursos;

insert into cursos values
('1','HTML5', 'CURSO SW HTML5','40','37', '2014'),
('2','ALGORITIMO2', 'CURSO DE ALGORITIMO', '20','15','2014'),
('3','ALGORITIMO3', 'CURSO DE ALGORITIMO', '20','15','2014'),
('4','ALGORITIMO4', 'CURSO DE ALGORITIMO', '20','15','2014'),
('5','ALGORITIMO5', 'CURSO DE ALGORITIMO', '20','15','2014'),
('6','ALGORITIMO6', 'CURSO DE ALGORITIMO', '20','15','2014'),
('7','ALGORITIMO7', 'CURSO DE ALGORITIMO', '20','15','2014'),
('8','ALGORITIMO8', 'CURSO DE ALGORITIMO', '20','15','2014'),
('9','ALGORITIMO9', 'CURSO DE ALGORITIMO', '20','15','2014'),
('10','ALGORITIMO10', 'CURSO DE ALGORITIMO', '20','15','2014');

update cursos
set nome = 'html5'
where id_curso = '1';

update cursos
set nome = 'PHP', ano = '2015'
where id_curso = '4';

update cursos
set ano = '2018' , carga ='0'
limit 1;

delete from cursos
where id_curso = '10';

use cadastro;
select * from gafanhotos;

select * from cursos
order by nome;

select nome, carga, ano from cursos
order by ano;

select * from cursos
where ano = '2016'
order by nome;

select nome, descricao, ano from cursos
where ano <>2016
order by ano, nome;

select nome, ano from cursos
where ano between 2014 and 2016;

select nome, descricao, ano from cursos
where ano in (2014,2016);

select nome, carga totaulas from cursos
where carga > 35 and totaulas <30
order by nome;

select nome, carga totaulas from cursos
where carga > 35 or totaulas <30
order by nome;

select * from cursos
where nome = 'PHP';

select *  from cursos
where nome like 'P%';

select *  from cursos
where nome like '%A';

select *  from cursos
where nome like '%A%';

select distinct carga from cursos
order by carga;

select count(nome) from cursos;

select max(carga) from cursos;

select nome, min(totaulas) from cursos where ano ='2016';

select SUM(totaulas) from cursos;

select avg(totaulas) from cursos where ano ='2016';

select * from gafanhotos
where sexo = 'F';

select * from gafanhotos
where nascimento between '2000-01-01' and '2015-12-31';

select * from gafanhotos
where sexo = 'M' and profissao = 'Programador';

select * from gafanhotos
where sexo = 'F' and nacionalidade = 'Brasil' and nome like 'J%';

select nome, nacionalidade, peso from gafanhotos
where sexo = 'M' and nacionalidade <> 'Brasil' and peso <100;

select max(altura) from gafanhotos;

select avg(peso) from gafanhotos;

select min(peso) from gafanhotos
where sexo = 'F' and nacionalidade <> 'Brasil' and nascimento between 1990-01-01 and 2000-12-31;

select count('F') from gafanhotos
where altura > 1.90;

select carga from cursos
group by carga;

select totaulas, count(*) from cursos
group by totaulas
order by totaulas;

select carga, count(nome) from cursos where totaulas = 30
group by carga;

select ano, count(*) from cursos
group by ano
having count(ano) >=5
order by count(*) desc;

select carga, count(*) from cursos
where ano > 2015
group by carga
having carga > (select avg(carga) from cursos);

desc gafanhotos;

select profissao, count(*) from gafanhotos
group by profissao;

select sexo, count(*) from gafanhotos
where nascimento > 2005-01-01
group by sexo;

select nacionalidade, count(*) from gafanhotos
where nacionalidade <> 'Brasil'
having count(nacionalidade)>3;

select altura, count(peso) from gafanhotos
where peso >100
having altura > avg(altura);

alter table gafanhotos
add column cursopreferido int;

desc gafanhotos;

alter table gafanhotos
add foreign key (cursopreferido)
references cursos(idcurso);

update gafanhotos set cursopreferido ='6' where id = '1';

select * from cursos;

select gafanhotos.nome, cursos.nome, cursos.ano
from gafanhotos join cursos
on cursos.idcurso = gafanhotos.cursopreferido;

create table gafanhoto_assiste_curso (
id int not null auto_increment,
data_foi_visto date,
idgafanhoto int,
idcurso int,
primary key (id),
foreign key (idgafanhoto) references gafanhotos(id),
foreign key (idcurso) references cursos(idcurso)
);

insert into  gafanhoto_assiste_curso values
(default, '2014-03-01','1','2');

select * from  gafanhoto_assiste_curso;

select gafanhotos.nome, cursos.nome from gafanhotos
join gafanhoto_assiste_curso 
on gafanhotos.id = gafanhoto_assiste_curso.idgafanhoto
join cursos 
on cursos.idcurso = gafanhoto_assiste_curso.idcurso
order by gafanhotos.nome;