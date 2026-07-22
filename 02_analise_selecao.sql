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

SELECT t2.team_name,
        SUM(goals) as totalGols
FROM player_stats as t1

LEFT JOIN teams as t2 
ON t1.team_id = t2.team_id
GROUP BY t1.team_id
ORDER BY totalGols DESC 