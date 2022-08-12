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
não é possivel 
#usar case when para mostrar nome da escola 
#exibir  vendedor - escola do filho 
# mostrar reverse eng para mostrar que 
# não existe essa relação 
```
### f) selecione os 10 produtos menos vendidos por ecommerce e pela matriz.
```sh
```
### g) calcule a média de gasto por estado.
```sh
SELECT 
    A.Estado, FORMAT(AVG(Qtd * VrUnt), 2) AS media_gasto
FROM
    TbVendas A
WHERE
    status = 'Concluído'
GROUP BY A.Estado
ORDER BY Estado
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
```
### j) selecione os gastos por dependente
```sh
não é possivel 
```
