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

-- SELECT t1.team_id,
--         t2.team_name,
--         ROUND(AVG(possession_pct), 2) AS media_posse,
--         COUNT(*) AS total_partidas

-- FROM match_team_stats as t1
-- LEFT JOIN teams as t2
-- ON t1.team_id = t2.team_id
-- GROUP BY t1.team_id 
-- ORDER BY media_posse DESC

/*
----------------------------------------------------
Pergunta 6 7 8 9

Qual finalizou mais?
Qual teve melhor aproveitamento das finalizações?
Qual seleção fez mais faltas?
Qual recebeu mais escanteios e impedimentos?
*/

-- WITH estatisticas_ofensivas AS (

--     SELECT
--         t1.team_id,
--         t2.team_name,
--         SUM(t1.total_shots) AS total_finalizacoes,
--         SUM(t1.shots_on_target) AS chutes_no_gol,
--         SUM(fouls) AS faltas,
--         SUM(corners) AS escanteios,
--         SUM(offsides) AS impedimentos,
--         COUNT(*) AS total_partidas

--     FROM match_team_stats AS t1

--     JOIN teams AS t2
--         ON t1.team_id = t2.team_id

--     GROUP BY
--         t1.team_id,
--         t2.team_name

-- )

-- SELECT
--     team_id,
--     team_name,
--     total_finalizacoes,
--     chutes_no_gol,
--     faltas,
--     escanteios,
--     impedimentos,
--     total_partidas,
--     ROUND(chutes_no_gol * 1.0 / total_finalizacoes * 100, 3) AS aproveitamento

-- FROM estatisticas_ofensivas

-- ORDER BY aproveitamento DESC;

/*
----------------------------------------------------
Pergunta 10

Qual teve maior xG acumulado?

*/

SELECT 
    tabela_unificada.team_id,
    t1.team_name,
    SUM(tabela_unificada.xg) AS xg_acumulado,
    COUNT(DISTINCT tabela_unificada.match) AS numero_partidas
FROM (
    SELECT
        home_team_id AS team_id,
        home_xg AS xg,
        match_id AS match
    FROM matches

    UNION ALL

    SELECT
        away_team_id AS team_id,
        away_xg AS xg,
        match_id AS match
    FROM matches
) AS tabela_unificada

JOIN teams AS t1
ON tabela_unificada.team_id = t1.team_id

GROUP BY tabela_unificada.team_id
ORDER BY xg_acumulado DESC;

