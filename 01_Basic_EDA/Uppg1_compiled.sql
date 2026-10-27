-- a) QTY UTB edu area Order by QTY DESC
SELECT
    UTBILDNINGSOMRÅDE, COUNT (*) AS Quantity
FROM myhresults
GROUP BY UTBILDNINGSOMRÅDE
ORDER BY Quantity DESC;
EXIT

--b+c) qty Accepted/denied edu area 
SELECT
    UTBILDNINGSOMRÅDE,
    COUNT (BESLUT) AS Total,
    COUNT(CASE
        WHEN BESLUT = 'Beviljad'
        THEN 1 END) AS Beviljad,
    COUNT(CASE
        WHEN BESLUT = 'Avslag'
        THEN 1 END) AS Avslag
FROM myhresults
GROUP BY UTBILDNINGSOMRÅDE;
EXIT

--d+e) qty acc/den per edu name in Data/IT
SELECT
    DISTINCT UTBILDNINGSNAMN,
    COUNT (BESLUT) AS Total,
    COUNT(CASE
        WHEN BESLUT = 'Beviljad'
        THEN 1 END) AS Beviljad,
    COUNT(CASE
        WHEN BESLUT = 'Avslag'
        THEN 1 END) AS Avslag
FROM myhresults
    WHERE UTBILDNINGSOMRÅDE = 'Data/IT'
    GROUP BY UTBILDNINGSNAMN;
EXIT

--g) QTY_beviljade 5 first rows


SELECT
    LÄN,
    COUNT(CASE
        WHEN BESLUT = 'Beviljad'
        THEN 1 END) AS QTY_Beviljade
FROM myhresults
    GROUP BY LÄN
    ORDER BY QTY_Beviljade DESC
FETCH FIRST 5 ROWS ONLY;

EXIT


--h) Place bound/distance based on edu area. also added to show only the approved.
SELECT 
    UTBILDNINGSOMRÅDE,
    BESLUT,
    COUNT (STUDIEFORM) AS Total,
    COUNT (CASE WHEN STUDIEFORM = 'Bunden' THEN 1 END) AS Bunden,
    COUNT (CASE WHEN STUDIEFORM = 'Distans' THEN 1 END) AS Distans,
    ROUND(
    1.0 * COUNT(CASE WHEN STUDIEFORM = 'Bunden' THEN 1 END)
        / NULLIF(COUNT(STUDIEFORM), 0),2) AS Andel_Bunden,
    ROUND(
    1.0 * COUNT(CASE WHEN STUDIEFORM = 'Distans' THEN 1 END)
        / NULLIF(COUNT(STUDIEFORM), 0),2) AS Andel_Distans
FROM myhresults
    WHERE BESLUT = 'Beviljad'
    GROUP BY UTBILDNINGSOMRÅDE, BESLUT;
EXIT

--i) Occurence of "AI"

 SELECT
    COUNT(UTBILDNINGSNAMN) AS ANTAL_UTBILDNINGAR
FROM myhresults
    WHERE UTBILDNINGSNAMN LIKE '%AI%';
EXIT



----------THE END---------------------
