-- Procedure brh.insere_projeto cadastrar um novo projeto
CREATE OR REPLACE PROCEDURE brh.insere_projeto
(
    p_NOME          BRH.PROJETO.NOME%TYPE,
    p_RESPONSAVEL   BRH.PROJETO.RESPONSAVEL%TYPE,
    p_INICIO        BRH.PROJETO.INICIO%TYPE       
)
IS
BEGIN
    INSERT INTO BRH.PROJETO(NOME, RESPONSAVEL, INICIO)
    VALUES (p_NOME, p_RESPONSAVEL, p_INICIO);
END;

EXECUT brh.insere_projeto ('Alura','D123','01/05/24');
COMMIT;

--=============================================================================
-- Funação brh.calcula_idade informar idade a partir de uma data
CREATE OR REPLACE FUNCTION  brh.calcula_idade
(
    p_DATA_NASCIMENTO IN DATE
)
RETURN NUMBER
IS
    p_IDADE NUMBER;
BEGIN
    p_IDADE := TRUNC(MONTHS_BETWEEN (SYSDATE, p_DATA_NASCIMENTO)/12);
    return p_IDADE;
END;

SELECT brh.calcula_idade('05/12/1993') FROM DUAL;

--=============================================================================
-- Funação brh.finaliza_projeto registrar o término da execução de um projeto
CREATE OR REPLACE FUNCTION brh.finaliza_projeto
(
    p_ID IN BRH.PROJETO.ID%TYPE
)
RETURN DATE
IS
    v_FIM DATE;
BEGIN
    v_FIM := TO_DATE(SYSDATE, 'DD/MM/YYYY');
    UPDATE BRH.PROJETO SET FIM = v_FIM WHERE ID = p_ID;
    RETURN p_FIM;
END;

--=============================================================================
CREATE OR REPLACE PROCEDURE brh.insere_projeto (
    p_nome IN VARCHAR2,
    p_responsavel IN VARCHAR2
) AS
BEGIN
    IF p_nome IS NULL OR LENGTH(p_nome) < 2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Nome de projeto inválido! Deve ter dois ou mais caracteres.');
    END IF;

    INSERT INTO projeto (nome, responsavel)
    VALUES (p_nome, p_responsavel);
    COMMIT;
END;