--Tabela de viola��es para o sistema

/* 

Viola��es:
   1- A data de contrata��o deve ser uma data v�lida na dimens�o tempo
   2- O c�digo do jogador deve ser um c�digo v�lido na dimens�o jogador

*/

--A l�gica das viola��es est� implementada no script de carga para o fato transferencia
use projeto_football_scouting

CREATE TABLE TB_VIO_TRANSFERENCIA_TIME (
    ID_VIOLACAO INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    DATA_CARGA DATETIME NOT NULL,
    COD_JOGADOR INT NOT NULL,
    DATA_CONTRATACAO DATETIME NOT NULL,
    DT_ERRO DATETIME NOT NULL,
    VIOLACAO VARCHAR(150) NOT NULL
)

select *from TB_VIO_TRANSFERENCIA_TIME