/* PROJET : Analyse du Marché de l'Emploi Data en France
AUTEUR : Emmanuel ENOH
DATE : Novembre 2025
DESCRIPTION : 
Ce script SQL couvre l'intégralité du pipeline de données :
1. Création de la table brute.
2. Nettoyage et transformation des données (Filtrage France, conversion devises, regroupement métiers).
3. Analyse statistique finale (KPIs par niveau d'expérience).
*/


-- 1. CRÉATION DE LA TABLE BRUTE (RAW DATA)

CREATE TABLE data_jobs (
    work_year INT,
    experience_level VARCHAR(50),
    employment_type VARCHAR(50),
    job_title VARCHAR(100),
    salary INT,
    salary_currency VARCHAR(10),
    salary_in_usd INT,
    employee_residence VARCHAR(50),
    remote_ratio INT,
    company_location VARCHAR(50),
    company_size VARCHAR(50)
);

-- 2. EXPLORATION RAPIDE (Qualité des données)

-- Vérification du volume de données pour la France (L'idée c'est de voir si on a assez de données pour la France)
SELECT COUNT(*) as total_offres_france 
FROM data_jobs 
WHERE company_location = 'FR';

-- Vérification des devises utilisées en France (EUR, USD, GBP ?)
SELECT salary_currency, COUNT(*) 
FROM data_jobs 
WHERE company_location = 'FR' 
GROUP BY salary_currency;


-- 3. NETTOYAGE ET TRANSFORMATION (DATA CLEANING)

-- Création d'une table dédiée 'france_jobs_clean' :
-- 1. Filtrage uniquement sur la France.
-- 2. Standardisation des titres de postes (Data Analyst, Scientist, Engineer).
-- 3. Conversion des salaires en EUR (Taux fixes estimés : GBP=1.15, USD=0.95).

CREATE TABLE france_jobs_clean AS
SELECT
    work_year,
    experience_level,
    employment_type,
    -- Regroupement des intitulés de postes (Normalization)
    CASE
        WHEN job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Scientist%' THEN 'Data Scientist'
        WHEN job_title LIKE '%Engineer%' THEN 'Data Engineer'
        ELSE 'Autres' -- Regroupement des titres minoritaires
    END AS job_category,
    
    -- Conversion et harmonisation des salaires en EUR
    CASE salary_currency
        WHEN 'EUR' THEN salary
        WHEN 'GBP' THEN salary * 1.15 
        WHEN 'USD' THEN salary * 0.95 
        ELSE NULL 
    END AS salary_in_eur,
    
FROM data_jobs
WHERE company_location = 'FR';


-- 4. ANALYSE STATISTIQUE (KPIs)

-- Objectif : Comparer les salaires moyens et la volatilité par métier et séniorité.
-- Ce résultat est exporté pour la visualisation dans Tableau/Power BI.

SELECT
    job_category,
    experience_level,
    COUNT(*) AS nombre_emplois,
    ROUND(AVG(salary_in_eur)) AS salaire_moyen_eur, -- Salaires moyen par carégories
    MAX(salary_in_eur) AS salaire_max_eur,
    MIN(salary_in_eur) AS salaire_min_eur,
    ROUND(STDDEV(salary_in_eur)) AS ecart_type_salaire -- Mesure de la dispersion des salaires
FROM france_jobs_clean
GROUP BY 1, 2
ORDER BY job_category, salaire_moyen_eur DESC;


-- Fin du script

