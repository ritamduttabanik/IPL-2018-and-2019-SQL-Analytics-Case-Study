-- ==========================================================================================
-- PROJECT: IPL Multi-Season SQL Performance Analytics Case Study (2018 - 2019)
-- DATABASE DIALECT: Google BigQuery / ANSI SQL
-- DESCRIPTION: Production-ready analytical queries solving key performance indicators 
--              for batsmen, bowlers, and franchises across the 2018 & 2019 seasons.
-- ==========================================================================================

-- Q1: Top 11 Bowlers by Total Wickets Captured
SELECT Player, Team, Wkts
FROM `iplanalysis_db.bowlers2018`
ORDER BY Wkts DESC LIMIT 11;

-- Q2: Elite Run Scorers with High Strike Efficiency (S/R >= 130)
SELECT Player, Team, Runs, `S-R` AS Strike_Rate
FROM `iplanalysis_db.batsmen2018`
WHERE `S-R` >= 130
ORDER BY Runs DESC LIMIT 11;

-- Q3: High-Impact Defensive Bowlers (Economy Rate < 7.0 runs per over)
SELECT Player, Team, `E-R` AS Economy_Rate, Wkts
FROM `iplanalysis_db.bowlers2018`
WHERE `E-R` < 7
ORDER BY Wkts DESC LIMIT 11;

-- Q4: Absolute Volume Dominance Across Both 2018 and 2019 Seasons
SELECT Player, STRING_AGG(Team, ', ') AS Historical_Teams, SUM(Runs) AS Total_Aggregated_Runs
FROM (
    SELECT Player, Team, Runs FROM `iplanalysis_db.batsmen2018`
    UNION ALL
    SELECT Player, Team, Runs FROM `iplanalysis_db.batsmen2019`
)
GROUP BY Player
ORDER BY Total_Aggregated_Runs DESC LIMIT 11;

-- Q5: Maximum Boundary Dominance Metrics (Combined 4s and 6s)
SELECT Player, Team, Fours, Sixes, (Fours + Sixes) AS Total_Boundaries
FROM `iplanalysis_db.batsmen2018`
ORDER BY Total_Boundaries DESC LIMIT 11;

-- Q6: Bowlers with Minimal Inning Exposure (Least Overs Bowled)
SELECT Player, Team, Overs
FROM `iplanalysis_db.bowlers2018`
ORDER BY Overs ASC LIMIT 5;

-- Q7: Highest Overall Scoring Franchise of the 2019 Tournament
SELECT Team, SUM(Runs) AS Total_Franchise_Runs
FROM `iplanalysis_db.batsmen2019`
GROUP BY Team
ORDER BY Total_Franchise_Runs DESC LIMIT 1;

-- Q8: Batting Longevity Anchor - Most Combined Half-Centuries (2018 + 2019)
SELECT Player, STRING_AGG(DISTINCT Team, ', ') AS Unique_Teams, SUM(HlfCentury) AS Total_Half_Centuries
FROM (
    SELECT Player, Team, Hlfcentury FROM `iplanalysis_db.batsmen2018` 
    UNION ALL
    SELECT Player, Team, Hlfcentury FROM `iplanalysis_db.batsmen2019`
)
GROUP BY Player
ORDER BY Total_Half_Centuries DESC LIMIT 11;
