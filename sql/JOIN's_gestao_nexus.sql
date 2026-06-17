SELECT
-- passar os nomes que serão exibidos como atributos
u.nome AS nomeResponsavel,
u.tipo_acesso,
m.id AS idMovimentacao,
p.nome AS nomeProduto,
m.data_hora,
m.tipo_movimentacao
-- o FROM recebe a tabela principal onde estão as duas foreign key id_produto e id_responsavel
FROM movimentacao m
-- INNER JOIN para multiplas tabelas e asa tabelas usuario e produto
-- ON verifica na tabela movimentacao o id_responsavel para buscar o nome do responsavel com o mesmo id na tabela usuario
INNER JOIN usuario u ON m.id_responsavel = u.id
INNER JOIN produtos p ON m.id_produto = p.id
ORDER BY m.data_hora DESC; -- mostra das movimentações mais recentes para mais antiga

-- JOIN para verificar ultima alteração de algum produto
SELECT 
    p.nome AS produto,
    ea.quantidade_atual,
    m.data_hora AS ultima_alteracao,
    m.tipo_movimentacao
FROM estoque_atual ea
INNER JOIN produtos p ON ea.id_produto = p.id
INNER JOIN movimentacao m ON ea.id_ultima_atualizacao = m.id;

-- JOIN para verificar asa quantidades atuais e minimas de cada produto
SELECT 
    p.nome AS produto,
    ea.quantidade_atual,
    ea.quantidade_minima,
    -- Uma lógica simples para alertar se precisa comprar
    CASE 
        WHEN ea.quantidade_atual <= ea.quantidade_minima THEN 'REPOR URGENTE'
        ELSE 'OK'
    END AS status_estoque
FROM estoque_atual ea
INNER JOIN produtos p ON ea.id_produto = p.id;
