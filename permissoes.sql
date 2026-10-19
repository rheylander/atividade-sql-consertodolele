-- Parte Usuários
-- 5. CRiar usuário
CREATE USER 'alunoatividade'@'localhost'
IDENTIFIED BY 'senha123';

-- 6. Conceder SELECT
GRANT SELECT ON consertodolele.* 
TO 'alunoatividade'@'localhost';

-- 7. Revogar SELECT
REVOKE SELECT ON consertodolele.* FROM 'alunoatividade'@'localhost';
 
-- 8. Deletar usuário
DROP USER 'alunoatividade'@'localhost';
