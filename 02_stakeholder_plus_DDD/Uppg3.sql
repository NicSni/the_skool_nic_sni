--- Number of applications, number of approvals and proportion of acceptance. Group by educational area(utbildningsområde) and sorted by highest rate of approvals.
SELECT
    UTBILDNINGSOMRÅDE,
    SUM(SÖKTA_UTBILDNINGSOMGÅNGAR) AS Total,
    SUM(BEVILJADE_UTBILDNINGSOMGÅNGAR) AS QTY_BEVILJADE,
    ROUND( 
    SUM(BEVILJADE_UTBILDNINGSOMGÅNGAR)
        / NULLIF(SUM(SÖKTA_UTBILDNINGSOMGÅNGAR), 0),2)
        AS ANDEL_BEVILJADE
FROM myhresults
    GROUP BY UTBILDNINGSOMRÅDE
    ORDER BY ANDEL_BEVILJADE DESC;
EXIT

---Applied for and approved course rounds, with share or approval based on sun5 category. Sorted by highest procentage of approval and showing only top 20%. 
SET PAGESIZE 100
SELECT
    SUN5_INRIKTNING_NAMN,
    SUM(SÖKTA_UTBILDNINGSOMGÅNGAR) AS Total,
    SUM(BEVILJADE_UTBILDNINGSOMGÅNGAR) AS QTY_BEVILJADE,
    ROUND( 
    SUM(BEVILJADE_UTBILDNINGSOMGÅNGAR)
        / NULLIF(SUM(SÖKTA_UTBILDNINGSOMGÅNGAR), 0),2)
        AS ANDEL_BEVILJADE
FROM myhresults
    GROUP BY SUN5_INRIKTNING_NAMN 
    ORDER BY ANDEL_BEVILJADE DESC
FETCH FIRST 20 PERCENT ROWS ONLY;
EXIT

----------------Approval numbers and proportion based on weather or not it's placebound, state/private and sorted by approved or not.

--huvudmannatyp
SET PAGESIZE 100
SELECT
    BESLUT,
    COUNT (*) AS TOTAL,
    COUNT (CASE WHEN HUVUDMANNATYP = 'Kommun' THEN 1 END) AS KOMMUN,
    COUNT (CASE WHEN HUVUDMANNATYP = 'Privat' THEN 1 END) AS PRIVAT,
    ROUND(
    1.0 * COUNT(CASE WHEN HUVUDMANNATYP = 'Kommun' THEN 1 END)
        / NULLIF(COUNT(*), 0),2) AS Andel_Kommun,
    ROUND(
    1.0 * COUNT(CASE WHEN HUVUDMANNATYP = 'Privat' THEN 1 END)
        / NULLIF(COUNT(*), 0),2) AS Andel_privat,
    COUNT (CASE WHEN STUDIEFORM = 'Bunden' THEN 1 END) AS Bunden,
    COUNT (CASE WHEN STUDIEFORM = 'Distans' THEN 1 END) AS Distans,
    ROUND(
    1.0 * COUNT(CASE WHEN STUDIEFORM = 'Bunden' THEN 1 END)
        / NULLIF(COUNT(*), 0),2) AS Andel_Bunden,
    ROUND(
    1.0 * COUNT(CASE WHEN STUDIEFORM = 'Distans' THEN 1 END)
        / NULLIF(COUNT(*), 0),2) AS Andel_Distans
FROM myhresults
    GROUP BY BESLUT;
EXIT

---------------------------the end-------------------------------

