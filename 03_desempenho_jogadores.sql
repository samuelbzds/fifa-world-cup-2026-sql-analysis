/*
====================================================
PROJETO: FIFA WORLD CUP 2026 ANALYTICS
ENTREGA 03 - Desempenho dos Jogadores


Autor: Samuel Bezerra
====================================================
*/

/*
----------------------------------------------------
Pergunta 1

Quem foi o artilheiro?


*/

-- SELECT  player_name,
--         goals
-- FROM player_stats
-- ORDER BY goals * 1 DESC

/*
----------------------------------------------------
Pergunta 2

Quem participou de mais gols?

*/

-- SELECT  player_id,
--         position,
--         matches_played,
--         player_name,
--         goals + assists AS participacao
-- FROM player_stats
-- ORDER BY participacao * 1 DESC


/*
----------------------------------------------------
Pergunta 3

Quem jogou mais minutos?

*/

-- SELECT  t2.team_name,
--         t1.player_name,
--         SUM(t1.minutes_played) AS minutos_jogados,
--         t1.matches_played,
--         t1.player_id
-- FROM player_stats AS t1

-- JOIN teams AS t2
-- ON t1.team_id = t2.team_id

-- GROUP BY player_id * 1
-- ORDER BY minutos_jogados DESC

/*
----------------------------------------------------
Pergunta 4

Quais goleiros tiveram mais clean sheets?

*/

-- SELECT  t2.team_name,
--         t1.player_name,
--         t1.clean_sheets,
--         t1.player_id
-- FROM player_stats AS t1


-- JOIN teams AS t2
-- ON t1.team_id = t2.team_id

-- WHERE t1.clean_sheets >= 0

-- ORDER BY t1.clean_sheets DESC

/*
----------------------------------------------------
Pergunta 5

Quem recebeu mais cartões?

*/

-- SELECT  t2.team_name,
--         t1.player_name,
--         t1.player_id,
--         (t1.yellow_cards + t1.red_cards) *1 as soma_cartao

-- FROM player_stats AS t1


-- JOIN teams AS t2
-- ON t1.team_id = t2.team_id

-- ORDER BY soma_cartao DESC


/*
----------------------------------------------------
Pergunta 6

Quais jogadores possuem maior valor de mercado?

*/

SELECT * 
FROM squads_and_players
ORDER BY market_value_eur * 1 DESC