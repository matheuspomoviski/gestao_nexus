-- criacao dos triggers

DELIMITER //

CREATE TRIGGER trg_after_insert_produto
-- passado o momento que o trigger será chamado, nesse caso depois do insert em produtos
AFTER INSERT ON produtos
FOR EACH ROW
BEGIN
/*
como está definido vcalor padrao de quantidade na tabela 
estoque_inicial aqui passamos apenas o id, o restante será atualizado coonforme 
o uso da procedure atualizar_estoque
*/
    INSERT INTO estoque_atual (id_produto)
    VALUES (NEW.id);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER trg_after_insert_movimentacao
AFTER INSERT ON movimentacao
/*
Nesse trigger depois de uma movimentacao a entidade estoque_atual recebe um UPDATE e preenche as colunas com NULL
*/
FOR EACH ROW
BEGIN
    CALL atualizar_estoque(NEW.id_produto, NEW.quantidade_movimentada, NEW.tipo_movimentacao, NEW.id);
END //

DELIMITER ;