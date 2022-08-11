# Sprint 1 - Conceitos e SQL

## 3. Criar e executar as consultas abaixo sobre o modelo de dados de uma Biblioteca:

### a) Listar todos os livros publicados após 2014
```sh
SELECT 
    Titulo,
    DATE_FORMAT(Publicacao, '%d/%m/%y') AS Data_Publicacao
FROM
    programa_bolsas.LIVRO
WHERE
    YEAR(Publicacao) > 2014
ORDER BY 1 # deixa em ordem alfabética 
;
# Se quiser ordenar por data ORDER BY Publicacao
```
### b) Listar os 10 livros de maior valor
```sh
SELECT 
    GROUP_CONCAT(A.Titulo
        SEPARATOR ' || ') AS Titulos_Mesmo_Valor,
    Valor
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
# considerando que existem livros de mesmo valor 

```
### c) Listar as 5 editoras que mais tem livros na biblioteca
```sh
# considerando que existem EDITORAS com a mesma quantidade de livros
SELECT GROUP_CONCAT(Nome SEPARATOR ' || ') AS Editoras,
A.QTD_LIVROS
FROM 
(SELECT 
    E.Nome, COUNT(L.Cod) AS QTD_LIVROS
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
    A.Nome AS AUTOR, COUNT(L.Cod) AS QTD_LIVROS
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 1
;
;
```
### e) Listar a quantidade de publicações de cada editora
```sh
SELECT 
    E.Nome, COUNT(L.Publicacao) AS qtd_publicacao
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
    A.Nome, COUNT(L.Cod) AS QTD_PUBLI
FROM
    programa_bolsas.AUTOR A
        LEFT JOIN
    programa_bolsas.LIVRO L ON A.CodAutor = L.Autor
GROUP BY A.Nome
ORDER BY 2 DESC
;
```
### g) Listar qual é o autor com menos ou nenhuma publicação
```sh
SELECT  DISTINCT A.Nome, COUNT(L.Cod) AS QTD_PUBLI 
FROM programa_bolsas.AUTOR A
LEFT JOIN programa_bolsas.LIVRO L
ON A.CodAutor = L.Autor 
GROUP BY A.Nome 
HAVING QTD_PUBLI <1
ORDER BY 1 
;
```
## 4. Criar e executar as consultas abaixo sobre o modelo de dados de uma Loja:
### a) selecione o nome e o código do vendedor com o maior número de vendas.
```sh
```
### b) selecione o produto mais vendido entre as datas de 2014-02-03 até 2018-02-02.
```sh
```
### c) calcule a comissão dos vendedores.
```sh
```
### d) selecione o cliente que mais gastou.
```sh
```
### e) selecione a escola que mais gastou
```sh
```
### f) selecione os 10 produtos menos vendidos por ecommerce e pela matriz.
```sh
```
### g) calcule a média de gasto por estado.
```sh
```
### h) selecione todos os registros deletados 
```sh
```
### i) calcule a média da quantidade vendida de cada produto por estado 
```sh
```
### j) selecione os gastos por dependente
```sh
```
