/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 04 - Análise das Partidas


Autor: Samuel Bezerra
====================================================
*/

/*
----------------------------------------------------
Pergunta 1

Qual partida teve mais gols?

*/

-- SELECT
--     t1.match_id,
--     t1.date,
--     t1.kickoff_time_utc,
--     t2.stage_name AS stage,
--     t3.stadium_name AS venue,
--     t4.team_name AS home_team,
--     t5.team_name AS away_team,
--     t1.home_score,
--     t1.away_score,
--     t1.home_penalty_score,
--     t1.away_penalty_score,
--     t1.status,
--     t1.result_type,
--     t1.home_xg,
--     t1.away_xg,
--     t6.name AS referee,
--     t7.player_name AS player_of_the_match,
--     t1.home_score + t1.away_score AS total_gols
-- FROM matches AS t1
-- INNER JOIN tournament_stages AS t2
--     ON t1.stage_id = t2.stage_id

-- INNER JOIN venues AS t3
--     ON t1.venue_id = t3.venue_id

-- INNER JOIN teams AS t4
--     ON t1.home_team_id = t4.team_id

-- INNER JOIN teams AS t5
--     ON t1.away_team_id = t5.team_id 
    
-- INNER JOIN referees AS t6
--     ON t1.referee_id = t6.referee_id 

-- INNER JOIN player_stats AS t7
--     ON t1.player_of_the_match_id = t7.player_id

-- ORDER BY total_gols DESC
-- LIMIT 10;

/*
----------------------------------------------------
Pergunta 2

Quais partidas terminaram empatadas?

*/

-- SELECT
--     t1.match_id,
--     t1.date,
--     t1.kickoff_time_utc,
--     t2.stage_name AS stage,
--     t3.stadium_name AS venue,
--     t4.team_name AS home_team,
--     t5.team_name AS away_team,
--     t1.home_score,
--     t1.away_score,
--     t1.home_penalty_score,
--     t1.away_penalty_score,
--     t1.status,
--     t1.result_type,
--     t1.home_xg,
--     t1.away_xg,
--     t6.name AS referee,
--     t7.player_name AS player_of_the_match,
--     t1.home_xg + t1.away_xg AS total_xG
-- FROM matches AS t1
-- INNER JOIN tournament_stages AS t2
--     ON t1.stage_id = t2.stage_id

-- INNER JOIN venues AS t3
--     ON t1.venue_id = t3.venue_id

-- INNER JOIN teams AS t4
--     ON t1.home_team_id = t4.team_id

-- INNER JOIN teams AS t5
--     ON t1.away_team_id = t5.team_id 
    
-- INNER JOIN referees AS t6
--     ON t1.referee_id = t6.referee_id 

-- INNER JOIN player_stats AS t7
--     ON t1.player_of_the_match_id = t7.player_id

-- WHERE home_score = 0 AND away_score = 0
-- ORDER BY total_xG DESC

/*
----------------------------------------------------
Pergunta 3

Qual estádio recebeu mais jogos?

*/

-- SELECT
--     t2.stadium_name,
--     t2.city,
--     t2.country,
--     COUNT(*) AS total_jogos
-- FROM matches AS t1

-- JOIN venues AS t2
--     ON t1.venue_id = t2.venue_id

-- GROUP BY
--     t2.venue_id

-- ORDER BY
--     total_jogos DESC

/*
----------------------------------------------------
Pergunta 4

Qual árbitro trabalhou em mais jogos?

*/

-- SELECT
--     t2.referee_id,
--     t2.name,
--     t2.country,
--     t2.avg_cards_per_game,
--     COUNT(*) AS total_jogos
-- FROM matches AS t1

-- JOIN referees AS t2
--     ON t1.referee_id = t2.referee_id

-- GROUP BY
--     t1.referee_id

-- ORDER BY
--     total_jogos DESC

/*
----------------------------------------------------
Pergunta 5

Em qual fase houve mais gols?

*/

SELECT *,
        t2.stage_name,
        SUM(t1.home_score + t1.away_score) AS total_gols

FROM matches AS t1
INNER JOIN tournament_stages AS t2
    ON t1.stage_id = t2.stage_id
GROUP BY t2.stage_id
