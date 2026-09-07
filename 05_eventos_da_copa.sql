/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 05 - Eventos da Copa

Autor: Samuel Bezerra
====================================================
*/

/*
----------------------------------------------------
Pergunta 1

Quantos gols ocorreram?

*/

-- SELECT
--     COUNT(*) AS total_gols
-- FROM match_events
-- WHERE event_type = 'Goal';

/*
----------------------------------------------------
Pergunta 2

Quantos cartões amarelos?
Quantos vermelhos?
*/

-- SELECT
--     SUM(CASE WHEN event_type = 'Yellow Card' THEN 1 ELSE 0 END) AS total_amarelos,
--     SUM(CASE WHEN event_type = 'Red Card' THEN 1 ELSE 0 END) AS total_vermelhos
-- FROM match_events;


/*
----------------------------------------------------
Pergunta 3
Quem marcou mais gols?
*/

-- SELECT *,
--         count(player_id) as gol_jogador
-- FROM match_events

-- WHERE event_type = 'Goal'
-- GROUP BY player_id
-- ORDER BY gol_jogador DESC

/*
----------------------------------------------------
Pergunta 4
Qual seleção recebeu mais cartões?
*/

-- SELECT t1.team_name,
--         COUNT(*) AS total_cartao
-- FROM match_events

-- INNER JOIN teams AS t1
-- ON match_events.team_id = t1.team_id

-- WHERE event_type LIKE '%Card'

-- GROUP BY match_events.team_id

-- ORDER BY total_cartao DESC


/*
----------------------------------------------------
Pergunta 5

Em qual minuto acontecem mais gols?

DIVIDO POR BLOCOS DE 15
*/

-- SELECT *,
--         COUNT (*) AS gol_minuto
-- FROM match_events
-- WHERE event_type = 'Goal'
-- GROUP BY minute
-- ORDER BY gol_minuto DESC

-- SELECT
--     CASE
--         WHEN CAST(minute AS INT) BETWEEN 0 AND 15 THEN '00-15'
--         WHEN CAST(minute AS INT) BETWEEN 16 AND 30 THEN '16-30'
--         WHEN CAST(minute AS INT) BETWEEN 31 AND 45 THEN '31-45'
--         WHEN CAST(minute AS INT) BETWEEN 46 AND 60 THEN '46-60'
--         WHEN CAST(minute AS INT) BETWEEN 61 AND 75 THEN '61-75'
--         WHEN CAST(minute AS INT) BETWEEN 76 AND 90 THEN '76-90'
--         ELSE '90+'
--     END AS bloco,
--     COUNT(*) AS gols
-- FROM match_events
-- WHERE event_type = 'Goal'
-- GROUP BY bloco

/*
----------------------------------------------------
Pergunta 5

Em qual minuto acontecem mais cartões?

*/
-- SELECT CAST(minute AS INT) as minute,
--         COUNT(*) as cartao_minuto
-- FROM match_events
-- WHERE event_type LIKE '% Card'
-- GROUP BY CAST(minute AS INT)
-- ORDER BY cartao_minuto DESC

/*
----------------------------------------------------
Pergunta 6

Qual jogador aparece em mais eventos?

*/

-- SELECT match_events.player_id,
--         player_stats.player_name,
--         COUNT(*) as eventos
-- FROM match_events
-- INNER JOIN player_stats
-- ON match_events.player_id = player_stats.player_id

-- GROUP BY match_events.player_id
-- ORDER BY eventos DESC

/*
----------------------------------------------------
Pergunta 7

Qual fase possui maior número de eventos?

*/

-- SELECT 
--     t2.stage_id,
--     t3.stage_name,
--     COUNT(*) AS total_eventos
-- FROM match_events AS t1
-- LEFT JOIN matches AS t2
--     ON t1.match_id = t2.match_id
-- LEFT JOIN tournament_stages AS t3
--     ON t2.stage_id = t3.stage_id
-- GROUP BY t2.stage_id, t3.stage_name
-- ORDER BY total_eventos DESC

/*
----------------------------------------------------
Pergunta 8

Qual partida teve mais eventos?
*/

-- SELECT 
--         CAST(t1.match_id AS INT) as id_match,
--         COUNT(*) AS total_eventos

-- FROM match_events AS t1
-- GROUP BY t1.match_id
-- ORDER BY total_eventos DESC
