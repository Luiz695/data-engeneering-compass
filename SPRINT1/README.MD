# Sprint 1 - Conceitos e SQL

## 3. Criar e executar as consultas abaixo sobre o modelo de dados de uma Biblioteca:

### a) Listar todos os livros publicados após 2014
```sh
SELECT 
    Titulo
    ,DATE_FORMAT(Publicacao, '%d/%m/%y') AS Data_Publicacao
FROM
    programa_bolsas.LIVRO
WHERE
    YEAR(Publicacao) > 2014
ORDER BY 1
;
```
### b) Listar os 10 livros de maior valor
```sh
SELECT 
    GROUP_CONCAT(A.Titulo
        SEPARATOR ' || ') AS Titulos_Mesmo_Valor
    ,Valor
FROM
    (SELECT 
        Titulo, Valor
    FROM
        programa_bolsas.LIVRO
    ORDER BY 2 DESC) A
GROUP BY A.Valor
ORDER BY 2 DESC
LIMIT 10
;
```
### c) Listar as 5 editoras que tem maior quantidade de livros na biblioteca
```sh
SELECT 
	GROUP_CONCAT(Nome SEPARATOR ' || ') AS Editoras
	,A.QTD_LIVROS
FROM 
	(SELECT 
		E.Nome
		,COUNT(L.Cod) AS QTD_LIVROS
	FROM
		programa_bolsas.EDITORA E
			LEFT JOIN
		programa_bolsas.LIVRO L ON E.CodEditora = L.Editora
	GROUP BY E.Nome)A 
GROUP BY A.QTD_LIVROS
ORDER BY 2 DESC
LIMIT 5
;
```
### d) Listar a quantidade de publicações de cada autor
```sh
SELECT DISTINCT
    A.Nome AS AUTOR
    ,COUNT(L.Cod) AS QTD_LIVROS
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 1
;
```
### e) Listar a quantidade de publicações de cada editora
```sh
SELECT 
    E.Nome
    ,COUNT(L.Publicacao) AS qtd_publicacao
FROM
    programa_bolsas.EDITORA E
        LEFT JOIN
    programa_bolsas.LIVRO L ON E.CodEditora = L.Editora
GROUP BY E.Nome
;
```
### f) Listar qual é o autor com mais publicações
```sh
SELECT DISTINCT
    A.Nome
    ,COUNT(L.Cod) AS QTD_PUBLI
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 2 DESC
LIMIT 1
;
```
### g) Listar qual é o autor com menos ou nenhuma publicação
```sh
# nenhuma publicação
SELECT DISTINCT
    A.Nome
    ,COUNT(L.Cod) AS QTD_PUBLI
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
HAVING QTD_PUBLI < 1
ORDER BY 1
;
# menos publicações
SELECT DISTINCT
    A.Nome
    ,COUNT(L.Cod) AS QTD_PUBLI
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
HAVING QTD_PUBLI > 1
ORDER BY 2
LIMIT 1
;
```
## 4. Criar e executar as consultas abaixo sobre o modelo de dados de uma Loja:
### a) selecione o nome e o código do vendedor com o maior número de vendas.
```sh
SELECT 
    A.Vendedor, MAX(num_vendas) AS max_vendas
FROM
    (SELECT 
        Vr.NmVdd AS Vendedor, COUNT(Vs.CdVen) AS num_vendas
    FROM
        TbVendedor Vr
    RIGHT JOIN TbVendas Vs ON Vr.CdVdd = Vs.CdVdd
    WHERE
        status = 'Concluído'
    GROUP BY Vr.NmVdd) A
    ;
```
### b) selecione o produto mais vendido entre as datas de 2014-02-03 até 2018-02-02.
```sh
SELECT 
    B.NmPro AS produto,
    MAX(B.quantidade_vendida) AS quantidade_vendida
FROM
    (SELECT 
        NmPro, COUNT(NmPro) * A.Qtd AS quantidade_vendida, A.Und
    FROM
        TbVendas A
    WHERE
        DtVen BETWEEN '2014-02-03' AND '2018-02-02'
            AND status = 'Concluído'
    GROUP BY NmPro) B
    ;
```
### c) calcule a comissão dos vendedores.
```sh
SELECT 
    B.CdVdd AS codigo_vendedor,
    B.NmVdd AS nome_vendedor,
    A.Qtd * A.VrUnt AS valor_vendido,
    CONCAT(B.PercComissao, '%') AS comissão,
    FORMAT(A.Qtd * A.VrUnt * B.PercComissao / 100,
        2) AS valor_comissão,
    FORMAT((A.Qtd * A.VrUnt) + (A.Qtd * A.VrUnt * B.PercComissao / 100),
        2) AS Total
FROM
    TbVendas A
        INNER JOIN
    TbVendedor B ON A.CdVdd = B.CdVdd
		WHERE
        status = 'Concluído'
GROUP BY B.CdVdd
;
```
### d) selecione o cliente que mais gastou.
```sh
SELECT 
    B.cliente, MAX(B.valor_gasto) AS gasto
FROM
    (SELECT 
        A.CdCli AS codigo,
            A.NmCli AS cliente,
            SUM(Qtd * VrUnt) AS valor_gasto
    FROM
        TbVendas A
    WHERE
        status = 'Concluído'
    GROUP BY A.NmCli) B
;
```
### e) selecione a escola que mais gastou
```sh
 SELECT 
    *,
    CASE
        WHEN B.InepEscola = '52096602' THEN 'ESCOLA MUNICIPAL CECILIA MEIRELES'
        WHEN B.InepEscola = '35985740' THEN 'CEL JTO A EE MINISTRO JOSE MOURA RESENDE'
         WHEN B.InepEscola = '29464862' THEN 'CENTRO EDUCACIONAL BETH SHALOM'
          WHEN B.InepEscola = '42114322' THEN 'COLEGIO CAMINHO FELIZ'
        ELSE 'ESCOLA NÃO IDENTIFICADA'
    END AS nome_escola
FROM
    TbVendedor A
        RIGHT JOIN
    TbDependente B ON A.CdVdd = B.CdVdd
;

SELECT * 
FROM TbVendas C
;

# os campos C.CdCli e B.Inep escola não possuem relacionamento na atual base de dados

```
### f) selecione os 10 produtos menos vendidos por ecommerce e pela matriz.
```sh

SELECT 
    A.NmPro AS Nome_Produto,
    COUNT(A.CdPro) AS Vendas,
    NmCanalVendas AS Canal
FROM
    TbVendas A
WHERE
    A.status ='Concluido'
        AND NmCanalVendas = 'Matriz'
        OR NmCanalVendas = 'Ecommerce'
GROUP BY A.CdPro , Canal
ORDER BY 2 , Canal ASC;
```
### g) calcule a média de gasto por estado.
```sh
SELECT 
    Estado,
    FORMAT(SUM(Qtd * VrUnt) # valor gasto por registro de venda
    / COUNT(Estado) # quantidade registro de vendas no estado
    ,2) AS media_gastos
FROM
    TbVendas
GROUP BY Estado
ORDER BY 1
;
```
### h) selecione todos os registros deletados 
```sh
SELECT 
    *
FROM
    TbVendas
WHERE
    deletado = 1
;
```
### i) calcule a média da quantidade vendida de cada produto por estado 
```sh
SELECT 
    NmPro AS produto,
    FORMAT(SUM(Qtd) / COUNT(NmPro), 2) AS quantidade_media,
    Estado AS estado
FROM
    TbVendas
GROUP BY Cidade
ORDER BY Estado;
```
### j) selecione os gastos por dependente
```sh
SELECT 
    *
FROM
    TbVendedor A
        RIGHT JOIN
    TbDependente B ON A.CdVdd = B.CdVdd
;

SELECT * 
FROM TbVendas C
;

# os campos C.CdCli e B.CdDep não possuem relacionamento na atual base de dados, 
# apenas C.CdCli podem efetuar compras, por esse motivo não é possível agrupar os gastos por dependente.

```
