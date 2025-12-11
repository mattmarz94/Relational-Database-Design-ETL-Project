SELECT * FROM BULK_MOVIES;

ALTER TABLE BULK_MOVIES
ADD Language_ID INT;

INSERT INTO LANGUAGE (Language_Code, Created_Date, Modified_Date)
SELECT DISTINCT original_language, NOW(), NOW()
FROM BULK_MOVIES
WHERE original_language IS NOT NULL
  AND original_language <> '';
  
UPDATE BULK_MOVIES b
JOIN LANGUAGE l
  ON b.original_language = l.Language_Code
SET b.Language_ID = l.Language_ID;

SELECT * FROM COLLECTIONS;

INSERT INTO COLLECTIONS (Collection_ID, Collection_Name, Created_Date, Modified_Date)
SELECT DISTINCT collection, collection_name, NOW(), NOW()
FROM BULK_MOVIES
WHERE collection IS NOT NULL
  AND collection <> '';
  
ALTER TABLE BULK_MOVIES
ADD Collection_ID INT;

UPDATE BULK_MOVIES
SET Collection_ID = collection
WHERE collection IS NOT NULL
  AND collection <> '';
  
SELECT * FROM GENRE;

INSERT INTO GENRE (Genre_Name, Created_Date, Modified_Date)
SELECT DISTINCT TRIM(genre) AS Genre_Name, NOW(), NOW()
FROM (
    SELECT id, TRIM(JSON_EXTRACT(j.genre_json, CONCAT('$[', n.n, ']'))) AS genre
    FROM (
        SELECT id, CONCAT('["', REPLACE(genre_names, ', ', '","'), '"]') AS genre_json,
            JSON_LENGTH(CONCAT('["', REPLACE(genre_names, ', ', '","'), '"]')) AS cnt
        FROM BULK_MOVIES 
        WHERE genre_names IS NOT NULL
    ) j
    JOIN ( SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) n
      ON n.n < j.cnt
) extracted
WHERE genre IS NOT NULL AND genre <> '';

INSERT INTO MOVIE_GENRE (Movie_ID, Genre_ID, Created_Date, Modified_Date)
SELECT b.id AS Movie_ID, g.Genre_ID, NOW(), NOW()
FROM (
    SELECT id, TRIM(JSON_EXTRACT(j.genre_json, CONCAT('$[', n.n, ']'))) AS genre
    FROM (
        SELECT id, CONCAT('["', REPLACE(genre_names, ', ', '","'), '"]') AS genre_json,
            JSON_LENGTH(CONCAT('["', REPLACE(genre_names, ', ', '","'), '"]')) AS cnt
        FROM BULK_MOVIES
    ) j
    JOIN ( SELECT 0 n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) n
      ON n.n < j.cnt
) extracted
JOIN BULK_MOVIES b ON b.id = extracted.id
JOIN GENRE g ON g.Genre_Name = extracted.genre;
  
INSERT INTO MOVIE
(
  Movie_ID,
  Original_Title,
  Display_Title,
  Language_ID,
  Collection_ID,
  Overview,
  Tagline,
  Release_Date,
  Runtime_Min,
  Popularity,
  Vote_Count,
  Vote_Avg,
  Budget,
  Revenue,
  Poster_Path,
  Backdrop_Path,
  Created_Date,
  Modified_Date
)
SELECT
  id,
  original_title,
  title,
  Language_ID,
  Collection_ID,
  overview,
  tagline,
  release_date,
  runtime,
  popularity,
  vote_count,
  vote_average,
  budget,
  revenue,
  poster_path,
  backdrop_path,
  NOW(),
  NOW()
FROM BULK_MOVIES;

INSERT INTO MOVIE_GENRE
(
  Movie_ID,
  Genre_ID,
  Created_Date,
  Modified_Date
)
SELECT
  b.id,
  g.Genre_ID,
  NOW(),
  NOW()
FROM BULK_MOVIES b
JOIN GENRE g
  ON b.genre_names = g.Genre_Name;

CREATE VIEW vw_All_Movies AS
SELECT
  m.Movie_ID,
  m.Original_Title,
  m.Display_Title,
  l.Language_Code,
  c.Collection_Name,
  g.Genre_Name,
  m.Release_Date,
  m.Runtime_Min,
  m.Popularity,
  m.Vote_Count,
  m.Vote_Avg,
  m.Budget,
  m.Revenue,
  m.Adult_Flag,
  m.Poster_Path,
  m.Backdrop_Path
FROM MOVIE m
LEFT JOIN LANGUAGE l
  ON m.Language_ID = l.Language_ID
LEFT JOIN COLLECTIONS c
  ON m.Collection_ID = c.Collection_ID
LEFT JOIN MOVIE_GENRE mg
  ON m.Movie_ID = mg.Movie_ID
LEFT JOIN GENRE g
  ON mg.Genre_ID = g.Genre_ID;

select * from MOVIE;
