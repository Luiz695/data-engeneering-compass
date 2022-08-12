# 3a
SELECT 
    Titulo AS Livro
    ,DATE_FORMAT(Publicacao, '%d/%m/%y') AS Data_Publicacao
FROM
    programa_bolsas.LIVRO
WHERE
    YEAR(Publicacao) > 2014
ORDER BY 1
;
# 3b
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
# 3c
SELECT 
	GROUP_CONCAT(Nome SEPARATOR ' || ') AS Editoras
	,A.Quantidade_livros
FROM 
	(SELECT 
		E.Nome
		,COUNT(L.Cod) AS Quantidade_livros
	FROM
		programa_bolsas.EDITORA E
			LEFT JOIN
		programa_bolsas.LIVRO L ON E.CodEditora = L.Editora
	GROUP BY E.Nome)A 
GROUP BY A.Quantidade_livros
ORDER BY 2 DESC
LIMIT 5
;
# 3d
SELECT DISTINCT
    A.Nome AS Autor
    ,COUNT(L.Cod) AS Quantidade_livros
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L 
    ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 1
;
# 3e
SELECT 
    E.Nome AS Editora
    ,COUNT(L.Publicacao) AS Quantidade_livros
FROM
    programa_bolsas.EDITORA E
        LEFT JOIN
    programa_bolsas.LIVRO L ON E.CodEditora = L.Editora
GROUP BY E.Nome
;
# 3f
SELECT DISTINCT
    A.Nome AS Autor
    ,COUNT(L.Cod) AS Quantidade_livros
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 2 DESC
LIMIT 1
;
#3g
# nenhuma publicação
SELECT DISTINCT
    A.Nome
    ,COUNT(L.Cod) AS Quantidade_livros
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
HAVING Quantidade_livros < 1
ORDER BY 1
;
# menos publicações
SELECT DISTINCT
    A.Nome
    ,COUNT(L.Cod) AS Quantidade_livros
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
HAVING Quantidade_livros > 1
ORDER BY 2
LIMIT 1
;
# --- 
#4a
SELECT 
    A.Vendedor
    , MAX(num_vendas) AS Vendas
FROM
    (SELECT 
        Vr.NmVdd AS Vendedor
        , COUNT(Vs.CdVen) AS num_vendas
    FROM
        TbVendedor Vr
    RIGHT JOIN TbVendas Vs ON Vr.CdVdd = Vs.CdVdd
    WHERE
        status = 'Concluído'
    GROUP BY Vr.NmVdd) A
    ;
#4b
SELECT 
    B.NmPro AS Produto
    ,MAX(B.quantidade_vendida) AS Quantidade_vendida
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
#4c
SELECT 
    B.CdVdd AS Codigo_vendedor
    ,B.NmVdd AS Nome_vendedor
    ,A.Qtd * A.VrUnt AS Valor_vendido,
    CONCAT(B.PercComissao, '%') AS Comissão,
    FORMAT(A.Qtd * A.VrUnt * B.PercComissao / 100, 2) AS Valor_comissão,
    FORMAT((A.Qtd * A.VrUnt) + (A.Qtd * A.VrUnt * B.PercComissao / 100), 2) AS Total
FROM
    TbVendas A
        INNER JOIN
    TbVendedor B ON A.CdVdd = B.CdVdd
		WHERE
        status = 'Concluído'
GROUP BY B.CdVdd
;
# 4d
SELECT 
    B.cliente AS Cliente
    ,MAX(B.valor_gasto) AS Gasto
FROM
    (SELECT 
        A.CdCli AS codigo
        ,A.NmCli AS cliente
        ,SUM(Qtd * VrUnt) AS valor_gasto
    FROM
        TbVendas A
    WHERE
        status = 'Concluído'
    GROUP BY A.NmCli) B
;
# 4e
 SELECT 
    *,
    CASE
        WHEN B.InepEscola = '52096602' THEN 'ESCOLA MUNICIPAL CECILIA MEIRELES'
        WHEN B.InepEscola = '35985740' THEN 'CEL JTO A EE MINISTRO JOSE MOURA RESENDE'
         WHEN B.InepEscola = '29464862' THEN 'CENTRO EDUCACIONAL BETH SHALOM'
          WHEN B.InepEscola = '42114322' THEN 'COLEGIO CAMINHO FELIZ'
        ELSE 'ESCOLA NÃO IDENTIFICADA'
    END AS Nome_escola
FROM
    TbVendedor A
        RIGHT JOIN
    TbDependente B ON A.CdVdd = B.CdVdd
;

SELECT * 
FROM TbVendas C
;

# os campos C.CdCli e B.Inep escola não possuem relacionamento na atual base de dados
#4f - inserir
#4g
SELECT 
    A.Estado, FORMAT(AVG(Qtd * VrUnt), 2) AS Media_gasto
FROM
    TbVendas A
WHERE
    status = 'Concluído'
GROUP BY A.Estado
ORDER BY Estado
;
#4h
SELECT 
    *
FROM
    TbVendas
WHERE
    deletado = 1
;
#4i
#4j
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




