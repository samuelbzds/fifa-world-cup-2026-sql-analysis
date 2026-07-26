/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 02 - Análise das Seleções


Autor: Samuel Bezerra
====================================================
*/

/*
----------------------------------------------------
Pergunta 1

Qual seleção marcou mais gols?

*/

-- SELECT t2.team_name,
--         SUM(t1.goals) as totalGols
-- FROM player_stats as t1

-- LEFT JOIN teams as t2 
-- ON t1.team_id = t2.team_id
-- GROUP BY t1.team_id
-- ORDER BY totalGols DESC 


/*
----------------------------------------------------
Pergunta 2

Qual sofreu menos gols?

*/

-- SELECT t2.team_name,
--         SUM(CAST(t1.goals_conceded AS INT)) AS golsSofridos
-- FROM player_stats as t1

-- LEFT JOIN teams as t2 
-- ON t1.team_id = t2.team_id
-- GROUP BY t1.team_id
-- ORDER BY golsSofridos DESC 

/*
----------------------------------------------------
Pergunta 3

Qual teve o maior saldo de gols?

*/

-- WITH estatisticas as (
-- SELECT  t2.team_name,
--         SUM(goals) as totalGols, 
--         SUM(CAST(goals_conceded AS INT)) AS golsSofridos
        
-- FROM player_stats as t1
-- LEFT JOIN teams as t2
-- ON t1.team_id = t2.team_id
-- GROUP BY t1.team_id
-- )


-- SELECT *,
--         totalGols - golsSofridos AS saldo
-- FROM estatisticas
-- ORDER BY saldo DESC

/*
----------------------------------------------------
Pergunta 4

Qual teve maior posse de bola média?

*/

SELECT t1.team_id,
        t2.team_name,
        ROUND(AVG(possession_pct), 2) AS media_posse,
        COUNT(*) AS total_partidas

FROM match_team_stats as t1
LEFT JOIN teams as t2
ON t1.team_id = t2.team_id
GROUP BY t1.team_id 
ORDER BY media_posse DESC