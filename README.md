# Relational-Database-Design-ETL-Project

## Project Explanation

In this project, I designed and built a complete relational database system from the ground up using a real dataset of 100 movies. I started by creating a conceptual ER diagram, then transformed it into a fully normalized logical model, and finally implemented the complete physical schema in MySQL with properly defined primary keys, foreign keys, indexes, and constraints.

I then built the full ETL workflow needed to load the raw CSV data into the new model. This included cleaning inconsistent values, splitting multi-valued attributes (like multiple genres per movie), generating surrogate keys, standardizing reference tables (Language, Genre, Collection), and loading the Movie and Movie-Genre intersection tables.

I also wrote stored procedures, user-defined functions, and several analytical SQL queries, and created a unified reporting view (vw_All_Movies) that reconstructs the full dataset across all normalized tables.

Overall, the project demonstrates end-to-end experience with real database architecture, data modeling, normalization, data cleaning, transformation logic, indexing strategy, and SQL development which has helped me refine all of the newly learned skills directly applicable to data engineering and data science workflows.


## Project Workflow: End-to-End Steps:

1. Dataset Selection & Requirements Review
* Selected a dataset of 100 horror movies.
* Reviewed the project requirements for building conceptual → logical → physical models, loading data, and producing analytical SQL queries.

2. Conceptual Model (High-Level ERD)
* Identified core entities: Movie, Genre, Language, Collection.
* Defined main relationships, including a many-to-many relationship between movies and genres.

3. Logical Model (Normalized Schema)
* Converted entities into 3NF relational tables.
* Added surrogate primary keys (Movie_ID, Genre_ID, Language_ID, Collection_ID).
* Introduced a junction table MOVIE_GENRE to model many-to-many relationships.
* Applied standardized naming conventions for tables and attributes.

4. Physical Model (MySQL Implementation)
* Assigned appropriate data types for every field (INT, TEXT, DATE, DECIMAL, etc.).
* Created tables, constraints, foreign keys, and indexes in MySQL Workbench.
* Added audit columns (Created_Date, Modified_Date) across all tables.
* Exported the complete physical EER diagram.

5. Data Import into Staging Table
* Loaded the raw CSV into a staging table (BULK_MOVIES) using MySQL Workbench.
* Cleaned encoding issues, removed invalid characters, and standardized fields (e.g., poster/backdrop paths).

6. Load Lookup Tables
* Populated reference tables using DISTINCT values:
* LANGUAGE from original_language
* COLLECTIONS from collection & collection_name
* GENRE from multi-genre lists
* Added foreign key mapping columns (Language_ID, Collection_ID) to BULK_MOVIES.

7. Data Cleaning & Transformation
* Converted comma-separated genre lists into structured arrays.
* Used JSON parsing functions to normalize multi-genre entries.
* Ensured NULL handling for missing collection values.
* Updated staging rows to match lookup table IDs.

8. Load the MOVIE Table
* Inserted all 100 movie records into the normalized MOVIE table.
* Included all cleaned fields: titles, runtime, popularity, vote counts, budget, revenue, adult flag, and paths.
* Applied Language_ID and Collection_ID foreign keys.

9. Load MOVIE_GENRE (Many-to-Many Table)
* Used JSON-based splitting to extract 1–4 genres per film.
* Inserted one row per (Movie_ID, Genre_ID) combination.
* Ensured full normalization of all genre relationships.

10. Create Reporting View
* Built the view vw_All_Movies to combine normalized tables into a single analytical dataset.
* Joined MOVIE, LANGUAGE, COLLECTIONS, GENRE, and MOVIE_GENRE for easy querying.

11. Write Analytical SQL Queries
* Developed five meaningful insights, including:
* Highest-grossing movies
* Runtime analysis by genre
* Language distribution
* Top-performing collections
* “Hidden gem” films (high rating, low popularity)

### Creating this project demonstrates the skills I have learned thus far:

**Data Engineering Fundamentals**
* Building 3NF relational schemas
* Creating PKs, FKs, indexes, and constraints
* Designing bridge tables for N:M relationships
* Understanding cardinality, surrogate keys, and referential integrity

**SQL Development**
* Writing DDL, DML, views, stored procedures, and functions
* Using CTEs, joins, EXISTS/NOT EXISTS, and subqueries
* Optimizing queries using indexes and EXPLAIN/ANALYZE

**ETL / Data Cleaning**
* Converting a semi-structured dataset into relational form
* Splitting multi-value fields (genres), normalizing language & collections
* Handling nulls, inconsistent types, improper strings (e.g., poster_path cleanup)

**Analytics**
* Creating a unified reporting view
* Writing exploratory & insight-driven SQL queries

**Professional Workflow**
* Following naming conventions
* Writing modular SQL scripts (DML, DDL, Queries)
* Producing diagrams (conceptual → logical → physical)
