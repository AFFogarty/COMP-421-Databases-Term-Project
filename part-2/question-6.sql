/*
(12 Pts) Write four data modification commands for your application. Most of these commands should be \interesting," in the sense that 
they involve some complex feature, such as inserting the result of a query, updating several tuples at once, or deleting a set of tuples 
that is more than one but less than all the tuples in a relation.
Turn in a description of all the relations that you use in your modifications but are not described so far. Provide a short description 
of what each of your statements is supposed to do, the SQL statements themselves and a script or screenshot that shows your modification 
commands running in a convincing fashion.
*/

--Increase the price of all equipments produced by Big Pharma Inc by 10% to reflect recent increases 
--in trade tariffs experienced by this company (updating multiple tuples).
UPDATE Equipment
SET cost = cost*1.1
WHERE manufacturer = 'Big Pharma Inc.';

