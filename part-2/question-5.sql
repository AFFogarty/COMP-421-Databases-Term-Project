/* Query 1 */

SELECT first_name, last_name
FROM Patient
WHERE patient_id IN (SELECT patient_id
                    FROM SufferingFrom
                    WHERE ill_name LIKE '%Gastroenteritis%'
                    INTERSECT 
                    SELECT patient_id
                    FROM SufferingFrom
                    WHERE ill_name LIKE '%Norovirus%' AND ill_until IS NOT NULL);


/* Query 2 */


/* Query 3 */


/* Query 4 */


/* Query 5 */


