# Exemplo de organização do projeto

Este arquivo mostra uma forma de organizar o projeto sem alterar as consultas SQL existentes.

## Estrutura sugerida

```text
fifa-world-cup-2026-sql-analysis/
├── README.md
├── EXEMPLO_ORGANIZACAO.md
├── 01_exploracao_dos_dados.sql
├── 02_analise_selecao.sql
├── 03_desempenho_jogadores.sql
├── 04_analise_das_partidas.sql
├── data/
└── resultados/
```

## Organização de cada arquivo SQL

Cada arquivo pode conter apenas consultas executáveis, separadas por títulos curtos:

```sql
-- =========================================
-- Análise: seleções com mais gols
-- =========================================

SELECT
    t.team_name,
    SUM(p.goals) AS total_gols
FROM player_stats AS p
JOIN teams AS t
    ON p.team_id = t.team_id
GROUP BY t.team_name
ORDER BY total_gols DESC;


-- =========================================
-- Análise: média de posse de bola
-- =========================================

SELECT
    t.team_name,
    ROUND(AVG(s.possession_pct), 2) AS media_posse
FROM match_team_stats AS s
JOIN teams AS t
    ON s.team_id = t.team_id
GROUP BY t.team_name
ORDER BY media_posse DESC;
```

## Onde colocar as explicações

- **SQL:** somente a pergunta e os comentários necessários para entender uma decisão da consulta.
- **README.md:** objetivo do projeto, fonte dos dados, tabelas utilizadas e instruções para execução.
- **resultados/:** capturas de tela, gráficos ou arquivos exportados das consultas.

As consultas que não devem ser executadas podem ficar em arquivos separados de rascunho, por exemplo:

```text
rascunhos/
└── consultas_em_desenvolvimento.sql
```

Dessa forma, os arquivos principais ficam mais limpos sem precisar modificar a pasta `data` ou apagar as consultas que ainda estão sendo estudadas.
