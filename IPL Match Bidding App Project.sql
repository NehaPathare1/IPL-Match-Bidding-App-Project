IPL Match Bidding Analysis Project
Project Overview
This project focuses on analyzing bidding and match statistics for an IPL (Indian Premier League) bidding platform using SQL. The goal is to derive insights related to bidder performance, match details, and player statistics.

SQL Queries

1. Percentage of Wins for Each Bidder
Objective: Calculate the percentage of wins for each bidder, ordered from highest to lowest win percentage.


SELECT 
    B.BIDDER_NAME, 
    COUNT(CASE WHEN BD.BID_STATUS = 'Won' THEN 1 END) AS won, 
    COUNT(BD.BID_STATUS) AS total, 
    ROUND((COUNT(CASE WHEN BD.BID_STATUS = 'Won' THEN 1 END) * 1.0 / COUNT(BD.BID_STATUS)) * 100, 2) AS win_percentage
FROM 
    IPL_BIDDER_DETAILS B
JOIN 
    IPL_BIDDING_DETAILS BD 
    ON B.BIDDER_ID = BD.BIDDER_ID
GROUP BY 
    B.BIDDER_NAME
ORDER BY 
    win_percentage DESC;

2. Number of Matches Conducted at Each Stadium
Objective: Display the number of matches conducted at each stadium along with the stadium name and city.

SELECT 
    S.STADIUM_NAME, 
    S.CITY, 
    COUNT(MS.MATCH_ID) AS no_of_matches
FROM 
    IPL_MATCH_SCHEDULE MS
JOIN 
    IPL_STADIUM S 
    ON MS.STADIUM_ID = S.STADIUM_ID
GROUP BY 
    S.STADIUM_NAME, S.CITY
ORDER BY 
    no_of_matches DESC;

3. Percentage of Wins by Team Winning the Toss
Objective: Calculate the percentage of wins by the team that has won the toss.

SELECT 
    S.STADIUM_NAME,
    COUNT(CASE WHEN M.TOSS_WINNER = M.MATCH_WINNER THEN 1 END) AS won,
    COUNT(M.MATCH_ID) AS total,
    ROUND((COUNT(CASE WHEN M.TOSS_WINNER = M.MATCH_WINNER THEN 1 END) * 1.0 / COUNT(M.MATCH_ID)) * 100, 2) AS won_percentage
FROM 
    IPL_MATCH M
JOIN 
    IPL_MATCH_SCHEDULE MS ON M.MATCH_ID = MS.MATCH_ID
JOIN 
    IPL_STADIUM S ON MS.STADIUM_ID = S.STADIUM_ID
GROUP BY 
    S.STADIUM_NAME
ORDER BY 
    won_percentage DESC;

4. Total Bids with Bid Team and Team Name
Objective: Display the total number of bids made by each team along with the team name.

SELECT 
    bd.BID_TEAM,
    t.TEAM_NAME,
    COUNT(*) AS total_bids
FROM 
    IPL_BIDDING_DETAILS bd
JOIN 
    IPL_TEAM t
ON 
    bd.BID_TEAM = t.TEAM_ID
GROUP BY 
    bd.BID_TEAM, 
    t.TEAM_NAME;

5. Team ID of the Winning Team
Objective: Retrieve the team ID of the winning team based on the win details.

SELECT 
    t.TEAM_ID,
    t.TEAM_NAME,
    m.WIN_DETAILS
FROM 
    IPL_MATCH m
JOIN 
    IPL_TEAM t 
ON 
    m.MATCH_WINNER = t.TEAM_ID
WHERE 
    m.WIN_DETAILS IS NOT NULL;

6. Team Performance Analysis
Objective: Display the total matches played, total matches won, and total matches lost by each team along with its team name.

SELECT 
    t.TEAM_NAME,
    SUM(CASE WHEN ts.MATCHES_WON > 0 THEN ts.MATCHES_WON ELSE 0 END) AS won,
    SUM(CASE WHEN ts.MATCHES_LOST > 0 THEN ts.MATCHES_LOST ELSE 0 END) AS lost,
    COUNT(*) AS total
FROM 
    IPL_TEAM t
JOIN 
    IPL_TEAM_STANDINGS ts ON t.TEAM_ID = ts.TEAM_ID
GROUP BY 
    t.TEAM_NAME;

7. Display Bowlers for Mumbai Indians
Objective: Display the bowlers for the Mumbai Indians team.


SELECT 
    tp.TEAM_ID,
    tp.PLAYER_ID,
    p.PERFORMANCE_DTLS
FROM 
    IPL_TEAM_PLAYERS tp
JOIN 
    IPL_PLAYER p ON tp.PLAYER_ID = p.PLAYER_ID
JOIN 
    IPL_TEAM t ON tp.TEAM_ID = t.TEAM_ID
WHERE 
    t.TEAM_NAME = 'Mumbai Indians'
    AND tp.PLAYER_ROLE = 'Bowler'
    AND p.REMARKS IS NULL;

8. Counting All-rounders in Each Team
Objective: Display the teams with more than 4 all-rounders in descending order.


SELECT 
    t.REMARKS AS TEAM_NAME,
    COUNT(tp.PLAYER_ID) AS total
FROM 
    IPL_TEAM t
JOIN 
    IPL_TEAM_PLAYERS tp ON t.TEAM_ID = tp.TEAM_ID
WHERE 
    tp.PLAYER_ROLE = 'All-Rounder'
GROUP BY 
    t.REMARKS
HAVING 
    COUNT(tp.PLAYER_ID) > 4
ORDER BY 
    total DESC;

Conclusion
This project successfully analyzes key metrics in the IPL bidding process, providing insights into bidder performance, match outcomes, and player contributions. 
The results can be used to improve strategies in future bidding and enhance team performance.










