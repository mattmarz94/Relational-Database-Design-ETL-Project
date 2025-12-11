# Relational-Database-Design-ETL-Project

## Project Explanation

In this project, I designed and built a complete relational database system from the ground up using a real dataset of 100 movies. I started by creating a conceptual ER diagram, then transformed it into a fully normalized logical model, and finally implemented the complete physical schema in MySQL with properly defined primary keys, foreign keys, indexes, and constraints.

I then built the full ETL workflow needed to load the raw CSV data into the new model. This included cleaning inconsistent values, splitting multi-valued attributes (like multiple genres per movie), generating surrogate keys, standardizing reference tables (Language, Genre, Collection), and loading the Movie and Movie-Genre intersection tables.

I also wrote stored procedures, user-defined functions, and several analytical SQL queries, and created a unified reporting view (vw_All_Movies) that reconstructs the full dataset across all normalized tables.

Overall, the project demonstrates end-to-end experience with real database architecture, data modeling, normalization, data cleaning, transformation logic, indexing strategy, and SQL development which has helped me refine all of the newly learned skills directly applicable to data engineering and data science workflows.


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
