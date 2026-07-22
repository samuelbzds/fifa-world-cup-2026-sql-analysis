/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 01 - EXPLORAÇÃO DOS DADOS

Objetivo:
Conhecer a estrutura do banco antes de iniciar
as análises.

Autor: Samuel Bezerra
====================================================
*/

/*
----------------------------------------------------
Pergunta 1

Quantas seleções participaram da Copa?

*/

-- SELECT COUNT(DISTINCT team_id) AS total_teams
-- FROM teams;

/*
----------------------------------------------------
Pergunta 2

Quais seleções participaram?

----------------------------------------------------
*/

-- SELECT
--     team_name,
--     fifa_code,
--     confederation
-- FROM teams
-- ORDER BY team_name;

/*
----------------------------------------------------
Pergunta 3

Quantas partidas foram disputadas?

----------------------------------------------------
*/

-- SELECT COUNT(DISTINCT match_id) AS total_matchs
-- FROM matches;

/*
----------------------------------------------------
Pergunta 4

Quantos estádios receberam jogos?

----------------------------------------------------
*/

-- SELECT t1.venue_id,
--         t2.stadium_name,
--         t2.city,
--         COUNT(t2.stadium_name) AS jogos_estadio
-- FROM matches as t1
-- LEFT JOIN venues as t2

-- ON t1.venue_id = t2.venue_id
-- GROUP BY t2.stadium_name
-- ORDER BY jogos_estadio DESC

/*
----------------------------------------------------
Pergunta 5

Quantos árbitros atuaram?

----------------------------------------------------
*/

-- SELECT COUNT(DISTINCT referee_id) as total_arbitros,
--             country
-- FROM referees
-- GROUP BY country

/*
----------------------------------------------------
Pergunta 6

Quais confederações participaram?

----------------------------------------------------
*/

-- SELECT confederation,
--         COUNT(confederation) as qtd_times_conf
-- FROM teams
-- GROUP BY confederation
-- ORDER BY qtd_times_conf DESC

/*
----------------------------------------------------
Pergunta 7

Quantas fases possui o torneio?

----------------------------------------------------
*/

-- SELECT COUNT(*) FROM tournament_stages

/*
----------------------------------------------------
Pergunta 8

Qual seleção possui o maior elenco?

----------------------------------------------------
*/

-- SELECT COUNT(t1.team_id),
--         t2.team_name
-- FROM squads_and_players as t1

-- LEFT JOIN teams as t2 
-- ON t1.team_id = t2.team_id

-- GROUP BY t1.team_id 
-- ORDER BY team_name 

/*
----------------------------------------------------
Pergunta 9

Qual o valor total de mercado de cada seleção?
Qual a idade média dos elencos? (idade calculada a partir de date_of_birth)

----------------------------------------------------
*/

SELECT
    t1.team_id,
    t2.team_name,
    ROUND(SUM(t1.market_value_eur) / 1000000.0, 2) AS valor_mercado_milhoes,
    ROUND(AVG(t1.height_cm), 2) AS media_altura,
    ROUND(AVG(
        (strftime('%Y', 'now') - strftime('%Y', t1.date_of_birth))
        - (strftime('%m-%d', 'now') < strftime('%m-%d', t1.date_of_birth))
    ), 2) AS media_idade
FROM squads_and_players AS t1
JOIN teams AS t2 
    ON t1.team_id = t2.team_id
GROUP BY
    t1.team_id,
    t2.team_name
ORDER BY valor_mercado_milhoes DESC;

