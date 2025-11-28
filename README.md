Analyse_marche_data_France

Analyse PostgreSQL et Tableau des salaires Data en France (2020-2025).
Analyse du Marché de l'Emploi Data en France (2020-2025)

A) Contexte du Projet

En transition vers le métier de Data Analyst, j'ai souhaité analyser la réalité du marché français à partir d'un dataset mondial. Ce projet explore les salaires, les niveaux d'expérience et les disparités entre les rôles clés (Analyst, Scientist, Engineer).

B) Outils Utilisés
SQL (PostgreSQL) : Création de base de données, nettoyage (Data Cleaning), standardisation des devises et calculs statistiques (KPIs).
Tableau : Visualisation des tendances salariales.

C) Étapes du Projet
1. Ingestion & Nettoyage (SQL) : Importation d'un dataset brut et filtrage sur la France (400+ lignes).
2. Transformation : Standardisation des titres de postes (Regroupement via `CASE WHEN`) et conversion des devises (GBP/USD vers EUR).
3. Analyse Exploratoire : Calcul des salaires moyens et de la volatilité (écart-type) par niveau d'expérience.


D) Principaux Résultats

Junior (Entry-Level) : Le Data Scientist commence avec le salaire le plus élevé (~51k€), suivi de près par le Data Analyst.
Anomalie Senior : On observe une anomalie sur les profils Data Analyst Senior (96k€). L'analyse SQL de l'écart-type révèle une forte volatilité, suggérant la présence de profils Freelances/Experts qui tirent la moyenne vers le haut.
Structure du marché : Le marché français recrute majoritairement des profils Juniors et Intermédiaires.

Projet réalisé par Emmanuel Enoh.
