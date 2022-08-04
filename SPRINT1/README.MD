# Sprint 1 - Conceitos e SQL

## 3. Criar e executar as consultas abaixo sobre o modelo de dados de uma Biblioteca:

### a) Listar todos os livros publicados após 2014
```sh
SELECT 
Titulo, 
date_format(Publicacao, '%Y-%m-%D') AS Data_Publicacao
FROM programa_bolsas.LIVRO 
WHERE year(Publicacao)>2014
ORDER BY 2 DESC
;
```
### b) Listar os 10 livros mais caros
```sh
SELECT Titulo, Valor
FROM programa_bolsas.LIVRO
ORDER BY 2 DESC
LIMIT 10
;
```
### c) Listar as 5 editoras que mais tem livros na biblioteca
```sh
SELECT  
	E.Nome, 
	COUNT(L.Cod) AS QTD_LIVROS 
FROM programa_bolsas.EDITORA E
LEFT JOIN programa_bolsas.LIVRO L
 ON E.CodEditora=L.Editora
 GROUP BY E.Nome
 ORDER BY 2 DESC
 LIMIT 5
 ;
```
### d) Listar a quantidade de publicações de cada autor
```sh
SELECT COUNT(L.Publicacao) AS qtd_publicacao , 
A.Nome 
FROM programa_bolsas.AUTOR A
LEFT JOIN programa_bolsas.LIVRO L
ON A.CodAutor = L.Autor 
GROUP BY A.Nome 
ORDER BY 1 DESC
;
```
### e) Listar a quantidade de publicações de cada editora
```sh
SELECT COUNT(L.Publicacao) AS qtd_publicacao , 
E.Nome
FROM programa_bolsas.EDITORA E
LEFT JOIN programa_bolsas.LIVRO L
 ON E.CodEditora=L.Editora
 
GROUP BY E.Nome
ORDER BY 1 DESC
;
```
### f) Listar qual é o autor com mais publicações
```sh
SELECT  DISTINCT A.Nome, COUNT(L.Cod) AS QTD_PUBLI 
FROM programa_bolsas.AUTOR A
LEFT JOIN programa_bolsas.LIVRO L
ON A.CodAutor = L.Autor 
GROUP BY A.Nome 
ORDER BY 2 DESC
LIMIT 1
;
```
### g) Listar qual é o autor com menos ou nenhuma publicação
```
SELECT  DISTINCT A.Nome, COUNT(L.Cod) AS QTD_PUBLI 
FROM programa_bolsas.AUTOR A
LEFT JOIN programa_bolsas.LIVRO L
ON A.CodAutor = L.Autor 
GROUP BY A.Nome 
HAVING QTD_PUBLI <1
ORDER BY 1 
;
```