# DesafioDelphi
Script DDL

/******************************************************************************/
/*                 Generated by IBExpert 06/08/2021 09:09:29                  */
/******************************************************************************/

/******************************************************************************/
/*        Following SET SQL DIALECT is just for the Database Comparer         */
/******************************************************************************/
SET SQL DIALECT 3;



/******************************************************************************/
/*                                   Tables                                   */
/******************************************************************************/


CREATE GENERATOR GEN_TB_SIMULACAO_ID;

CREATE TABLE TB_SIMULACAO (
    ID_SIMULACAO              INTEGER NOT NULL,
    QUANTIDADE                INTEGER NOT NULL,
    DATA_ULTIMA_CONTRIBUICAO  DATE NOT NULL,
    VALOR                     DOUBLE PRECISION NOT NULL,
    PERCENTUAL                DOUBLE PRECISION NOT NULL
);



/******************************************************************************/
/*                                Primary keys                                */
/******************************************************************************/

ALTER TABLE TB_SIMULACAO ADD CONSTRAINT PK_TB_SIMULACAO PRIMARY KEY (ID_SIMULACAO);


/******************************************************************************/
/*                                  Triggers                                  */
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/*                            Triggers for tables                             */
/******************************************************************************/



/* Trigger: TB_SIMULACAO_BI */
CREATE OR ALTER TRIGGER TB_SIMULACAO_BI FOR TB_SIMULACAO
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (new.id_simulacao is null) then
    new.id_simulacao = gen_id(gen_tb_simulacao_id,1);
end
^
SET TERM ; ^



/******************************************************************************/
/*                                 Privileges                                 */
/******************************************************************************/

