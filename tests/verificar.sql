-- Execute após consertodolele.sql em um banco MySQL descartável.
USE consertodolele;
DELIMITER //
CREATE PROCEDURE verificar_exercicio()
BEGIN
    IF (SELECT COUNT(*) FROM pecascomputador) <> 10 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esperadas 10 pecas';
    END IF;
    IF (SELECT COUNT(*) FROM pedidocliente) <> 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Esperados 5 pedidos';
    END IF;
    IF (SELECT COUNT(*) FROM pedidocliente c
        INNER JOIN pecascomputador p ON p.id = c.idproduto) <> 5 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Relacionamento de pedidos incorreto';
    END IF;
    IF (SELECT COUNT(*) FROM pecascomputador WHERE quantidade > 20 AND valor > 300) <> 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Filtro AND incorreto';
    END IF;
    IF (SELECT COUNT(*) FROM pecascomputador
        WHERE nome_peca LIKE '%RAM%' OR fornecedor = 'Periféricos SP') <> 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Filtro OR incorreto';
    END IF;
    IF (SELECT id FROM pecascomputador ORDER BY valor DESC, id ASC LIMIT 1) <> 7 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ordenacao de valor incorreta';
    END IF;
END//
DELIMITER ;
CALL verificar_exercicio();
DROP PROCEDURE verificar_exercicio;
SELECT 'PASS: dados, relacionamentos, filtros e ordenacao' AS resultado;

