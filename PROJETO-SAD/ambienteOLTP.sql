CREATE DATABASE PROJETO_CONTRATACOES

USE PROJETO_CONTRATACOES

CREATE TABLE TB_LIGA (
    COD_LIGA VARCHAR(10) NOT NULL PRIMARY KEY,
    LIGA VARCHAR(50) NOT NULL,
    PAIS VARCHAR(50) NOT NULL,
	NR_CLUBS INT NOT NULL,
	VALOR_MERCADO VARCHAR(20) NOT NULL,
	CONFEDERACAO VARCHAR(20) NOT NULL
)

CREATE TABLE TB_TIME (
    COD_TIME VARCHAR(10) PRIMARY KEY NOT NULL,
    NOME_TIME VARCHAR(50) NOT NULL,
    PAIS VARCHAR(20) NOT NULL,
    NR_JOGADORES INT NOT NULL,
    VALOR_MERCADO VARCHAR(20) NOT NULL,
)

CREATE TABLE TB_TEMPORADA (
    ID_TEMPORADA INT IDENTITY(1,1) PRIMARY KEY,
    TEMPORADA VARCHAR(30) NOT NULL,
    DT_INICIO_TEMPORADA DATETIME NOT NULL,
    DT_FIM_TEMPORADA DATETIME NOT NULL
)

CREATE TABLE TB_STATS (
    ID_STATS INT IDENTITY(1,1) PRIMARY KEY,
    GOLS INT NOT NULL,
    ASSISTENCIAS INT NOT NULL,
    JOGOS INT NOT NULL,
    MINUTOS_JOGADOS INT NOT NULL,
    CARTOES_AMARELOS INT NOT NULL,
    CARTOES_VERMELHOS INT NOT NULL,
    FALTAS INT NOT NULL,
    DEFESAS INT NOT NULL,
    ID_TEMPORADA INT NOT NULL,
    CONSTRAINT FK_TB_STATS_TB_TEMPORADA
        FOREIGN KEY (ID_TEMPORADA)
        REFERENCES TB_TEMPORADA (ID_TEMPORADA)
)

CREATE TABLE TB_JOGADOR (
    ID_JOGADOR INT IDENTITY(1,1) PRIMARY KEY,
    NOME VARCHAR(60) NOT NULL,
    DT_NASCIMENTO DATE NOT NULL,
    ALTURA INT NOT NULL,
    PESO DECIMAL(10,2) NOT NULL,
    NACIONALIDADE VARCHAR(40) NOT NULL,
    NATURALIDADE VARCHAR(40) NOT NULL,
    SALARIO DECIMAL(10,2) NOT NULL,
    PE_BOM VARCHAR(20) NOT NULL,
    VALOR_DE_MERCADO INT NOT NULL,
    CONTRATO DATETIME NULL,
    ID_TIME INT NULL,
    ID_STATS INT NOT NULL,
    CONSTRAINT FK_TB_JOGADOR_TB_TIME
        FOREIGN KEY (ID_TIME)
        REFERENCES TB_TIME (ID_TIME),
    CONSTRAINT FK_TB_JOGADOR_TB_STATS
        FOREIGN KEY (ID_STATS)
        REFERENCES TB_STATS (ID_STATS)
)

CREATE TABLE TB_POSICAO (
    ID_POSICAO INT IDENTITY(1,1) PRIMARY KEY,
    POSICAO VARCHAR(20) NOT NULL
)

CREATE TABLE TB_SUBPOSICAO (
    ID_SUBPOSICAO INT IDENTITY(1,1) PRIMARY KEY,
    SUBPOSICAO VARCHAR(30) NOT NULL
)

CREATE TABLE TB_CONTRATACAO (
    ID_CONTRATACAO INT IDENTITY(1,1) PRIMARY KEY,
    VALOR INT NOT NULL,
    DT_CONTRATACAO DATETIME NOT NULL,
    ID_JOGADOR INT NOT NULL,
    ID_TIME INT NULL,
    CONSTRAINT FK_TB_JOGADOR_TB_CONTRATACAO
        FOREIGN KEY (ID_JOGADOR)
        REFERENCES TB_JOGADOR (ID_JOGADOR),
    CONSTRAINT FK_TB_TIME_TB_CONTRATACAO
        FOREIGN KEY (ID_TIME)
        REFERENCES TB_TIME (ID_TIME)
)

CREATE TABLE TB_JOGADOR_POSICAO (
    ID_JOGADOR INT NOT NULL,
    ID_POSICAO INT NOT NULL,
    PRIMARY KEY (ID_JOGADOR, ID_POSICAO),
    CONSTRAINT FK_TB_JOGADOR_POSICAO_TB_JOGADOR
        FOREIGN KEY (ID_JOGADOR)
        REFERENCES TB_JOGADOR (ID_JOGADOR),
    CONSTRAINT FK_TB_JOGADOR_POSICAO_TB_POSICAO
        FOREIGN KEY (ID_POSICAO)
        REFERENCES TB_POSICAO (ID_POSICAO)
)

CREATE TABLE TB_JOGADOR_SUBPOSICAO (
    ID_JOGADOR INT NOT NULL,
    ID_SUBPOSICAO INT NOT NULL,
    PRIMARY KEY (ID_JOGADOR, ID_SUBPOSICAO),
    CONSTRAINT FK_TB_JOGADOR_SUBPOSICAO_TB_JOGADOR
        FOREIGN KEY (ID_JOGADOR)
        REFERENCES TB_JOGADOR (ID_JOGADOR),
    CONSTRAINT FK_TB_JOGADOR_SUBPOSICAO_TB_SUBPOSICAO
        FOREIGN KEY (ID_SUBPOSICAO)
        REFERENCES TB_SUBPOSICAO (ID_SUBPOSICAO)
)

SELECT *FROM TB_JOGADOR
SELECT *FROM TB_TIME


DECLARE @j VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\Natan\Desktop\PROJETO-SAD\campeonatos.json', SINGLE_CLOB) A)

INSERT INTO TB_LIGA (COD_LIGA, LIGA, PAIS, NR_CLUBS, VALOR_MERCADO, CONFEDERACAO)
SELECT id, name, country, clubs, totalMarketValue, continent
FROM OPENJSON(@j, '$.results')
WITH (
    id VARCHAR(10),
    name VARCHAR(50),
    country VARCHAR(50),
    clubs INT,
    totalMarketValue VARCHAR(20),
    continent VARCHAR(20)
)

SELECT * FROM TB_LIGA

DECLARE @j_time VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\Natan\Desktop\PROJETO-SAD\times-GB1.json', SINGLE_CLOB) A)

INSERT INTO TB_TIME (ID_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO)
SELECT id, name, country, squad, marketValue
FROM OPENJSON(@j_time, '$.results')
WITH (
    id VARCHAR(10),
    name VARCHAR(50),
    country VARCHAR(20),
    squad INT,
    marketValue VARCHAR(20)
);

DECLARE @j_time VARCHAR(MAX) = (SELECT BULKCOLUMN FROM OPENROWSET (BULK 'C:\Users\Natan\Desktop\PROJETO-SAD\times-BRA1.json', SINGLE_CLOB) A)

INSERT INTO TB_TIME (ID_TIME, NOME_TIME, PAIS, NR_JOGADORES, VALOR_MERCADO)
SELECT id, name, country, squad, marketValue
FROM OPENJSON(@j_time, '$.results')
WITH (
    id VARCHAR(10),
    name VARCHAR(50),
    country VARCHAR(20),
    squad INT,
    marketValue VARCHAR(20)
);

SELECT * FROM TB_TIME