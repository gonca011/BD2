DROP KEYSPACE IF EXISTS bd2_trabalho_cassandra;

CREATE KEYSPACE bd2_trabalho_cassandra WITH REPLICATION = {'class':'SimpleStrategy', 'replication_factor' : 1};

USE bd2_trabalho_cassandra;

-- 1) PILOTOS QUE CORRERAM EM MAIS PISTAS
DROP TABLE IF EXISTS Pergunta1;
CREATE TABLE Pergunta1 (
    cod_Piloto int,
    nome text,
    nacionalidade text,
    num_Poles decimal,
    num_VoltasRapidas decimal,
    num_Titulos decimal,
    pistas int,
    PRIMARY KEY (cod_Piloto, pistas)
)WITH CLUSTERING ORDER BY (pistas DESC);


SELECT nome, pistas FROM Pergunta1;

-- 2) PILOTOS QUE CORRERAM EM MAIS TEMPORADAS
CREATE TABLE Pergunta2 (
	cod_Piloto int PRIMARY KEY,
    nome text,
    nacionalidade text,
    num_Poles decimal,
    num_VoltasRapidas decimal,
    num_Titulos decimal,
    temporadas int
);


SELECT nome, temporadas FROM Pergunta2;

-- 3) CONSTRUTORES QUE MAIS TIVERAM PILOTOS
CREATE TABLE Pergunta3 (
	cod_Construtor int PRIMARY KEY,
    nome_Construtor text,
    num_Pilotos int
);


SELECT nome_Construtor, num_Pilotos FROM Pergunta3;

-- 4) TEMPORADAS COM MAIS VENCEDORES DIFERENTES
CREATE TABLE Pergunta4 (
	cod_Temporada int PRIMARY KEY,
	ano int,
	num_vencedores int
);


SELECT ano, num_vencedores FROM Pergunta4;


-- 5) TEMPORADA COM MAIS CORRIDAS
CREATE TABLE Pergunta5 (
	cod_Temporada int PRIMARY KEY,
	ano int,
	num_corridas int
);


SELECT ano, num_corridas FROM Pergunta5;

-- 6) PISTAS ONDE MAIS PILOTOS GANHARAM
CREATE TABLE Pergunta6 (
	cod_Pista int PRIMARY KEY,
  	num_Eventos int,
    nome_Pista TEXT,
    pais_Pista TEXT,
    num_Vencedores int
);


SELECT nome_Pista, num_Vencedores FROM Pergunta6;

-- 7) CONSTRUTOR CUJOS PILOTOS FICARAM MAIS VEZES EM SEGUNDO LUGAR

CREATE TABLE Pergunta7 (
	cod_Construtor int PRIMARY KEY,
    nome_Construtor text,
    num_Segundos_Lugares int
);

SELECT nome_Construtor, num_Segundos_Lugares FROM Pergunta7;

-- 8) QUANTOS PILOTOS EXISTEM DE QUALQUER NACIONALIDADE

CREATE TABLE Pergunta8 (
	nacionalidade text PRIMARY KEY,
	num_Pilotos int
);


SELECT nacionalidade, num_Pilotos FROM Pergunta8;

-- 9) NACIONALIDADES CUJO PILOTOS TIVERAM MAIS SUCESSO A NÍVEL DE VITÓRIAS, POLES, VOLTAS RÁPIDAS E TÍTULOS

CREATE TABLE Pergunta9 (
	nacionalidade text PRIMARY KEY,
	num_Vitorias decimal,
	num_Poles decimal,
	num_voltas_Rapidas decimal,
	num_Titulos decimal
);

select * from Pergunta9;











