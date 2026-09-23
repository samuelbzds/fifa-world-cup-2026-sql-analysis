/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 06 - Scout

Autor: Samuel Bezerra
====================================================
*/



/*
----------------------------------------------------
Pergunta 1

Quais jogadores têm melhor custo-benefício (gols por milhão de euros)?

*/

-- SELECT 
--     player_id,
--     player_name,
--     market_value_eur,
--     goals,
--     CASE 
--         WHEN market_value_eur > 0
--             THEN ROUND(goals / (market_value_eur / 1000000.0), 2)
--         ELSE 0
--     END AS gols_por_milhao
-- FROM squads_and_players
-- WHERE goals > 0
-- ORDER BY gols_por_milhao DESC;


/*
----------------------------------------------------
Pergunta 2

Quais atacantes possuem mais gols por 90 minutos?

*/

-- SELECT
--     player_id,
--     player_name,
--     position,
--     goals,
--     minutes_played,
--     ROUND(goals * 90.0 / minutes_played, 2) AS gols_por_90
-- FROM player_stats
-- WHERE position = 'FWD'
--   AND minutes_played > 0
-- ORDER BY gols_por_90 DESC;

/*
----------------------------------------------------
Pergunta 2

Quais jovens jogadores possuem maior valor de mercado?

*/

-- SELECT *,
--         strftime('%Y', '2026-07-19') - strftime('%Y', date_of_birth) - 
--        (strftime('%m-%d', '2026-07-19') < strftime('%m-%d', date_of_birth)) AS idade
-- FROM squads_and_players
-- WHERE idade < 21
-- ORDER BY CAST(market_value_eur AS REAL) DESC

/*
----------------------------------------------------
Pergunta 3

Quais jogadores experientes apresentam maior participação em gols?

*/

-- SELECT t1.*,
--         t2.goals as t2_goals,
--         t2.assists,
--         CAST(t2.goals + t2.assists AS INT) AS participacao,
--         strftime('%Y', '2026-07-19') - strftime('%Y', t1.date_of_birth) - 
--        (strftime('%m-%d', '2026-07-19') < strftime('%m-%d', t1.date_of_birth)) AS idade
-- FROM squads_and_players AS t1
-- INNER JOIN player_stats AS t2
-- ON t1.player_id = t2.player_id
-- WHERE idade >= 30
-- ORDER BY participacao DESC


/*
----------------------------------------------------
Pergunta 4

Qual posição possui maior valor médio de mercado?

*/

-- SELECT
--     position,
--     PRINTF(
--         '€ %.2f milhões',
--         AVG(CAST(market_value_eur AS REAL)) / 1000000.0
--     ) AS valor_medio_formatado
-- FROM squads_and_players
-- GROUP BY position
-- ORDER BY AVG(CAST(market_value_eur AS REAL)) DESC;

/*
----------------------------------------------------
Pergunta 5

Quais jogadores de baixo valor de mercado apresentam melhor desempenho ofensivo?

*/

-- WITH calculo_medio AS (
--     SELECT *,
--            AVG(CAST(market_value_eur AS REAL)) OVER() AS media_global
--     FROM squads_and_players
-- )
-- SELECT *,
--        PRINTF('€ %.2f milhões', media_global / 1000000.0) AS valor_medio
-- FROM calculo_medio
-- WHERE market_value_eur < (media_global * 0.90)
-- ORDER BY goals * 1 DESC

/*
----------------------------------------------------
Pergunta 6

Quais jogadores combinam juventude, desempenho e baixo valor de mercado?

*/

-- WITH juventude AS (
--     SELECT 
--         t1.*,
--         strftime('%Y', '2026-07-19') - strftime('%Y', t2.date_of_birth) -
--         (strftime('%m-%d', '2026-07-19') < strftime('%m-%d', t2.date_of_birth)) AS idade
--     FROM player_stats AS t1
--     INNER JOIN squads_and_players AS t2
--         ON t1.player_id = t2.player_id
--     WHERE idade < 24
-- ),

-- calculo_medio AS (
--     SELECT 
--         player_id,
--         market_value_eur,
--         AVG(CAST(market_value_eur AS REAL)) OVER() AS media_global
--     FROM squads_and_players
-- )

-- SELECT 
--     t1.*,
--     t2.market_value_eur,
--     t2.media_global
-- FROM juventude AS t1
-- INNER JOIN calculo_medio AS t2
--     ON t1.player_id = t2.player_id
-- WHERE t1.goals >= (SELECT AVG(goals) FROM player_stats)
--   AND CAST(t2.market_value_eur AS REAL) <= t2.media_global;

/*
----------------------------------------------------
Pergunta 7

Mostre cada jogador, seus gols e sua posição no ranking de gols.

*/

-- SELECT  player_id,
--         player_name,
--         goals,
--         RANK() OVER (ORDER BY goals * 1 DESC,  player_name)
-- FROM player_stats


/*
----------------------------------------------------
Pergunta 7

Qual é a diferença entre os gols de cada jogador e a média de gols dos jogadores?

*/

-- WITH media AS (
-- SELECT 
--     AVG(goals) as media_gols
-- FROM player_stats
-- WHERE goals > 0
-- )

-- SELECT *,
--         goals - media_gols as diferenca
-- FROM player_stats
-- CROSS JOIN media
-- WHERE goals > 0
-- ORDER BY diferenca DESC


/*
----------------------------------------------------
Pergunta 8

Qual percentual dos gols totais do torneio pertence a cada jogador?

*/

WITH soma AS (
SELECT 
    SUM((goals * 1)) as total_gols
FROM player_stats
)
SELECT *,
        ROUND((goals * 100.0) / total_gols, 4) AS porc
FROM player_stats
CROSS JOIN soma
ORDER BY porc DESC

