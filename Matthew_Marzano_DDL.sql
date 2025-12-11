-- Data Definintion Language DDL

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


ALTER TABLE MOVIE
  ADD CONSTRAINT FK_MOVIE_LANGUAGE_ID
    FOREIGN KEY (Language_ID)
    REFERENCES LANGUAGE(Language_ID);

ALTER TABLE MOVIE
  ADD CONSTRAINT FK_MOVIE_COLLECTION_ID
    FOREIGN KEY (Collection_ID)
    REFERENCES COLLECTIONS(Collection_ID);

ALTER TABLE MOVIE_GENRE
  ADD CONSTRAINT FK_MG_MOVIE_ID
    FOREIGN KEY (Movie_ID)
    REFERENCES MOVIE(Movie_ID);

ALTER TABLE MOVIE_GENRE
  ADD CONSTRAINT FK_MG_GENRE_ID
    FOREIGN KEY (Genre_ID)
    REFERENCES GENRE(Genre_ID);