# Banco de Dados e SQL — Conserto do Lele

Atividade acadêmica desenvolvida em dupla durante os estudos de Banco de Dados. O projeto simula a operação de um negócio de conserto e venda de peças de computador, com registros de peças, fornecedores e pedidos de clientes.

## Objetivo

Praticar conceitos fundamentais de bancos de dados relacionais e SQL, incluindo:

- criação e relacionamento entre tabelas;
- definição de chaves primárias e estrangeiras;
- inserção de registros;
- consultas com filtros, ordenação e `LIKE`;
- consultas com `INNER JOIN`;
- criação e controle de permissões de usuário.

## Modelo relacional

O modelo utilizado no script é composto principalmente pelas entidades:

- **Peças de computador (`pecascomputador`):** registra nome, quantidade, valor, fornecedor e dados de contato.
- **Clientes e pedidos (`pedidocliente`):** registra os dados do cliente e a peça relacionada ao pedido.
- **Usuário do banco:** representa o usuário criado para demonstrar concessão, revogação e remoção de permissões.

### DER textual

```text
PecasComputador (1) ──── (N) PedidoCliente
```

A tabela `pedidocliente` utiliza a coluna `idproduto` como chave estrangeira relacionada à coluna `id` da tabela `pecascomputador`.

> Observação: este exercício não implementa um sistema completo de oficina mecânica. Seu escopo real é um negócio de conserto e venda de peças de computador.

## Principais blocos SQL

### 1. Criação de tabelas — DDL

A definição das tabelas utiliza uma chave primária para identificar cada cliente e uma chave estrangeira para relacionar o pedido à peça.

```sql
CREATE TABLE pedidocliente (
    idcliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sobrenome VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20),
    idproduto INT,
    FOREIGN KEY (idproduto)
        REFERENCES pecascomputador(id)
);
```

### 2. Inserção de dados — DML

O script insere peças e clientes para permitir a realização dos testes e consultas.

```sql
INSERT INTO pedidocliente
    (nome, sobrenome, email, telefone, idproduto)
VALUES
    ('Ana', 'Silva', 'ana.silva@email.com',
     '11988887777', 1),
    ('Carlos', 'Souza', 'carlos.souza@email.com',
     '11999998888', 2);
```

### 3. Consultas com junção — INNER JOIN

A junção relaciona as peças cadastradas aos clientes que realizaram pedidos.

```sql
SELECT
    p.nome_peca,
    p.fornecedor,
    c.nome,
    p.valor
FROM pecascomputador AS p
INNER JOIN pedidocliente AS c
    ON p.id = c.idproduto
ORDER BY p.valor DESC;
```

### 4. Consultas de análise e filtros

O script também utiliza filtros, ordenação e condições para analisar o estoque e os produtos.

```sql
SELECT *
FROM pecascomputador
WHERE quantidade > 20
  AND valor > 300
ORDER BY valor ASC;
```

> O script atual utiliza consultas de seleção e junção, mas não contém funções de agregação como `COUNT`, `SUM` e `GROUP BY`. Esses recursos podem ser incluídos em uma evolução futura do exercício.

## Controle de usuários

Também foram praticados comandos básicos de controle de acesso:

```sql
CREATE USER 'alunoatividade'@'localhost'
IDENTIFIED BY 'senha123';

GRANT SELECT ON consertodolele.*
TO 'alunoatividade'@'localhost';

REVOKE SELECT ON consertodolele.*
FROM 'alunoatividade'@'localhost';

DROP USER 'alunoatividade'@'localhost';
```

## Arquivos

- [consertodolele.sql](./consertodolele.sql) — estrutura, dados e consultas da atividade;
- [Atividade 2 - SQL.pdf](./Atividade%202%20%20-SQL.pdf) — material acadêmico utilizado como referência.

## Como utilizar

1. Instale um sistema gerenciador de banco de dados compatível com MySQL.
2. Abra o arquivo `consertodolele.sql`.
3. Execute os comandos por etapas.
4. Confira a criação das tabelas, os registros e o retorno das consultas.

## Tecnologias

- SQL;
- MySQL;
- Banco de dados relacional;
- Comandos DDL, DML e DCL.

## Autoria

Atividade acadêmica desenvolvida em dupla por:

- **Manuella Caldas Lourenço**;
- **Rheylander Soares Rodrigues**.

O conteúdo foi produzido colaborativamente para fins educacionais e não representa um sistema de produção.

## Aprendizados

A atividade reforçou a relação entre estrutura de dados, regras de negócio e consultas SQL, além da importância de documentar um banco de dados para que outra pessoa consiga compreendê-lo e executá-lo.
