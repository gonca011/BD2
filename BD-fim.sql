DROP TABLE IF EXISTS CampeonatodeConstrutores;
DROP TABLE IF EXISTS Vencedores;
DROP TABLE IF EXISTS Contratos;
DROP TABLE IF EXISTS Classificacoes;
DROP TABLE IF EXISTS Corridas;
DROP TABLE IF EXISTS Pistas;
DROP TABLE IF EXISTS Pilotos;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS Construtores;
DROP TABLE IF EXISTS Temporadas;


CREATE TABLE Pistas (
	cod_Pista int PRIMARY KEY NOT NULL,
  	num_Eventos int,
    nome_Pista varchar(70),
    pais_Pista varchar(2)
);

CREATE TABLE Pilotos (
    cod_Piloto int PRIMARY KEY NOT NULL,
    nome varchar(70),
    nacionalidade varchar (200),
    num_Poles decimal (3,1),
    num_VoltasRapidas decimal (4,1),
    num_Titulos decimal (3,1)
);

CREATE TABLE Classes(
    designacao varchar(10),
    cod_Classes int PRIMARY KEY
);

CREATE TABLE Construtores(
	cod_Construtor int PRIMARY KEY,
    nome_Construtor varchar(255)
);

CREATE TABLE Temporadas(
	cod_Temporada int PRIMARY KEY,
	ano int 
);

CREATE TABLE Corridas(
    cod_Corrida int PRIMARY KEY,
    cod_Temporada int,
    cod_Pista int, 
    FOREIGN KEY (cod_Temporada) REFERENCES Temporadas (cod_Temporada),
    FOREIGN KEY (cod_Pista) REFERENCES Pistas (cod_Pista)
);

CREATE TABLE Classificacoes(
    cod_Piloto int, 
    primeiro_Lugar int,
    segundo_Lugar int,
    terceiro_Lugar int,
    quarto_Lugar int,
    quinto_Lugar int,
    sexto_Lugar int,
    FOREIGN KEY (cod_Piloto) REFERENCES Pilotos (cod_Piloto)
);

CREATE TABLE Vencedores(
	cod_Corrida int,
	cod_Piloto int,
	FOREIGN KEY (cod_Piloto) REFERENCES Pilotos (cod_Piloto),
	FOREIGN KEY (cod_Corrida) REFERENCES Corridas (cod_Corrida)
);

CREATE TABLE CampeonatodeConstrutores(
    cod_Temporada int,
    cod_Construtor int,
   	cod_Classes int,
   	FOREIGN KEY (cod_Temporada) REFERENCES Temporadas (cod_Temporada),
   	FOREIGN KEY (cod_Construtor) REFERENCES Construtores (cod_Construtor),
   	FOREIGN KEY (cod_Classes) REFERENCES Classes (cod_Classes)
);

CREATE TABLE Contratos(
    cod_Construtor int,
    cod_Piloto int,
    FOREIGN KEY (cod_Construtor) REFERENCES Construtores (cod_Construtor),
    FOREIGN KEY (cod_Piloto) REFERENCES Pilotos (cod_Piloto) 
);

-- LOADS

LOAD DATA INFILE '/var/lib/mysql/csv/Pistas.csv'      
INTO TABLE Pistas
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Pilotos.csv'      
INTO TABLE Pilotos
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Classes.csv'
INTO TABLE Classes 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Construtores.csv'
INTO TABLE Construtores
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Temporadas.csv'
INTO TABLE Temporadas 
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Corridas.csv'
INTO TABLE Corridas
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Contratos.csv'
INTO TABLE Contratos
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/CampeonatodeConstrutores.csv'
INTO TABLE CampeonatodeConstrutores
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Vencedores.csv'
INTO TABLE Vencedores
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA INFILE '/var/lib/mysql/csv/Classificacoes.csv'
INTO TABLE Classificacoes
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- selects

SELECT * FROM CampeonatodeConstrutores;
SELECT * FROM Pistas;
SELECT * FROM Pilotos;
SELECT * FROM Classes;
SELECT * FROM Construtores;
SELECT * FROM Temporadas;
SELECT * FROM Corridas;
SELECT * FROM Contratos;
SELECT * FROM Vencedores;
SELECT * FROM Classificacoes;

-- QUERIES

-- 1) PILOTOS QUE CORRERAM EM MAIS PISTAS

SELECT Pilotos.nome, COUNT(DISTINCT Corridas.cod_Pista) AS pistas 
FROM Pilotos 
JOIN Vencedores ON Pilotos.cod_Piloto = Vencedores.cod_Piloto 
JOIN Corridas ON Vencedores.cod_Corrida = Corridas.cod_Corrida 
GROUP BY Pilotos.nome 
ORDER BY pistas DESC;

-- 2) PILOTOS QUE CORRERAM EM MAIS TEMPORADAS

SELECT Pilotos.nome, COUNT(DISTINCT Corridas.cod_Temporada) AS temporadas 
FROM Pilotos 
JOIN Vencedores ON Pilotos.cod_Piloto = Vencedores.cod_Piloto 
JOIN Corridas ON Vencedores.cod_Corrida = Corridas.cod_Corrida 
GROUP BY Pilotos.nome 
ORDER BY temporadas DESC;

-- 3) CONSTRUTORES QUE MAIS TIVERAM PILOTOS

SELECT Construtores.nome_Construtor, COUNT(DISTINCT Contratos.cod_Piloto) AS pilotos 
FROM Construtores 
JOIN Contratos ON Construtores.cod_Construtor = Contratos.cod_Construtor 
GROUP BY Construtores.nome_Construtor 
ORDER BY pilotos DESC;

-- 4) TEMPORADAS COM MAIS VENCEDORES DIFERENTES

SELECT Temporadas.ano, COUNT(DISTINCT Vencedores.cod_Piloto) AS vencedores 
FROM Temporadas 
JOIN Corridas ON Temporadas.cod_Temporada = Corridas.cod_Temporada 
JOIN Vencedores ON Corridas.cod_Corrida = Vencedores.cod_Corrida 
GROUP BY Temporadas.ano 
ORDER BY vencedores DESC;

-- 5) TEMPORADA COM MAIS CORRIDAS

SELECT Temporadas.ano, COUNT(Corridas.cod_Temporada) AS corridas 
FROM Temporadas 
JOIN Corridas ON Temporadas.cod_Temporada = Corridas.cod_Temporada 
GROUP BY Temporadas.ano 
ORDER BY corridas DESC 
LIMIT 1;

-- 6) PISTAS ONDE MAIS PILOTOS GANHARAM

SELECT Pistas.nome_Pista, COUNT(DISTINCT Vencedores.cod_Piloto) AS vencedores 
FROM Pistas 
JOIN Corridas ON Pistas.cod_Pista = Corridas.cod_Pista 
JOIN Vencedores ON Corridas.cod_Corrida = Vencedores.cod_Corrida 
GROUP BY Pistas.nome_Pista 
ORDER BY vencedores DESC;

-- 7) CONSTRUTOR CUJOS PILOTOS FICARAM MAIS VEZES EM SEGUNDO LUGAR

SELECT Construtores.nome_Construtor, SUM(Classificacoes.segundo_Lugar) AS segundos_lugares 
FROM Construtores 
JOIN Contratos ON Construtores.cod_Construtor = Contratos.cod_Construtor 
JOIN Classificacoes ON Contratos.cod_Piloto = Classificacoes.cod_Piloto 
GROUP BY Construtores.nome_Construtor 
ORDER BY segundos_lugares DESC;


-- 8) QUANTOS PILOTOS EXISTEM DE QUALQUER NACIONALIDADE

SELECT nacionalidade, COUNT(*) AS num_pilotos 
FROM Pilotos 
GROUP BY nacionalidade;


-- 9) NACIONALIDADES CUJO PILOTOS TIVERAM MAIS SUCESSO A NÍVEL DE VITÓRIAS, POLES, VOLTAS RÁPIDAS E TÍTULOS
SELECT 
    Pilotos.nacionalidade, 
    COUNT(Vencedores.cod_Piloto) AS total_vitorias,
    SUM(Pilotos.num_Poles) AS total_poles,
    SUM(Pilotos.num_VoltasRapidas) AS total_voltas_rapidas,
    SUM(Pilotos.num_Titulos) AS total_titulos
FROM Pilotos 
JOIN Vencedores ON Pilotos.cod_Piloto = Vencedores.cod_Piloto 
GROUP BY Pilotos.nacionalidade
ORDER BY total_vitorias DESC, total_poles DESC, total_voltas_rapidas DESC, total_titulos DESC;


