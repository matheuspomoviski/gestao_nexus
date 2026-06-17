-- criacao de procedure para atualizar estoque_atual
DELIMITER //

CREATE PROCEDURE atualizar_estoque(
-- o uso de IN é porque esses parâmetros serão preenchidos pelas informações de outra entidade
    IN p_produto_id INT,
    IN p_quantidade DECIMAL(10,3),
    IN p_tipo VARCHAR(20),
    IN p_movimentacao_id INT
)
-- inicio do bloco da procedure
BEGIN
    UPDATE estoque_atual
    SET 
        quantidade_atual = CASE 
            WHEN p_tipo = 'ENTRADA' THEN quantidade_atual + p_quantidade
            WHEN p_tipo = 'SAIDA'   THEN quantidade_atual - p_quantidade
        END,
        id_ultima_atualizacao = p_movimentacao_id
    WHERE id_produto = p_produto_id;
END //

DELIMITER ;