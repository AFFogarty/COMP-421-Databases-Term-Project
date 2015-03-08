/* Query 1 */

-- Get first name, last name from patients who have gastroenteritis and had norovirus before and recovered

>>>>>>> d28542aea50b4b213622b0d4b2214d1e18078393
SELECT first_name, last_name
FROM Patient
WHERE patient_id IN (SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Gastroenteritis%'
                    INTERSECT 
                    SELECT patient_id
                    FROM SufferingFrom INNER JOIN Illness
                    ON SufferingFrom.ill_id = Illness.ill_id
                    WHERE ill_name LIKE '%Norovirus%' AND ill_until IS NOT NULL);


/* Query 2 */


/* Query 3 */


/* Query 4 */


/* Query 5 */



