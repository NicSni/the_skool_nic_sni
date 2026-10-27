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
