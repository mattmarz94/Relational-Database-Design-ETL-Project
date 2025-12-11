-- QUERY OBSERVATIONS


-- Top 10 highest-grossing horror movies and their ROI.
-- Shows which movies generated the most revenue and how profitable they were
-- relative to their budget, also known as their Return on Investment ROI

SELECT 
    m.Movie_ID,
    m.Display_Title,
    COALESCE(c.Collection_Name, 'No Collection') AS Collection_Name,
    m.Budget,
    m.Revenue,
    CASE 
        WHEN m.Budget > 0 THEN ROUND((m.Revenue - m.Budget) / m.Budget, 2)
        ELSE NULL
    END AS ROI
FROM MOVIE m
LEFT JOIN COLLECTIONS c
    ON m.Collection_ID = c.Collection_ID
ORDER BY m.Revenue DESC
LIMIT 10;

-- Average runtime by genre longest to shortest.
-- Identifies which genres tend to have longer films

SELECT 
    g.Genre_Name,
    COUNT(DISTINCT m.Movie_ID) AS Movie_Count,
    ROUND(AVG(m.Runtime_Min), 1) AS Avg_Runtime_Min
FROM GENRE g
JOIN MOVIE_GENRE mg
    ON g.Genre_ID = mg.Genre_ID
JOIN MOVIE m
    ON mg.Movie_ID = m.Movie_ID
WHERE m.Runtime_Min IS NOT NULL
GROUP BY g.Genre_Name
HAVING COUNT(DISTINCT m.Movie_ID) >= 3
ORDER BY Avg_Runtime_Min DESC;

-- Movie counts by original language with percentage of total.
-- Shows which languages dominate the dataset.

SELECT 
    l.Language_Code,
    COUNT(*) AS Movie_Count,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM MOVIE), 1) AS Pct_Of_Total
FROM MOVIE m
JOIN LANGUAGE l
    ON m.Language_ID = l.Language_ID
GROUP BY l.Language_Code
ORDER BY Movie_Count DESC, l.Language_Code;

-- Top 5 collections by total revenue, for movies that belong to a collection.
-- Highlights which collections are the most financially successful,
-- based on the sum of revenue across all movies in each collection.

SELECT 
    c.Collection_Name,
    COUNT(m.Movie_ID) AS Movie_Count,
    SUM(m.Revenue) AS Total_Revenue,
    ROUND(AVG(m.Vote_Avg), 2) AS Avg_Vote
FROM COLLECTIONS c
JOIN MOVIE m
    ON m.Collection_ID = c.Collection_ID
GROUP BY c.Collection_Name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- High-rated but under-the-radar movies:
-- Movies with above-average rating but below-average popularity.
-- Finds the potential "hidden gems" that were rated highly (Vote_Avg)
-- but that did not achieve high popularity scores.

WITH stats AS (
    SELECT 
        AVG(Vote_Avg) AS Avg_Rating,
        AVG(Popularity) AS Avg_Popularity
    FROM MOVIE
    WHERE Vote_Count > 0
)
SELECT 
    m.Movie_ID,
    m.Display_Title,
    m.Vote_Avg,
    m.Vote_Count,
    m.Popularity
FROM MOVIE m
CROSS JOIN stats s
WHERE m.Vote_Count > 0
  AND m.Vote_Avg > s.Avg_Rating
  AND m.Popularity < s.Avg_Popularity
ORDER BY m.Vote_Avg DESC, m.Vote_Count DESC
LIMIT 15;