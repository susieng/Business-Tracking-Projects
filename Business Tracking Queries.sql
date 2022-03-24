--Select data for Invoice
SELECT
    Website,
    Description,
    Type,
    Color,
    Size,
    Quantity,
    Price,
    Tax,
    ROUND(_Total_ *.08,2) AS Order_Fee,
    ROUND(Quantity*Price + Tax + ROUND(_Total_ *.08,2),2) AS Total
FROM 
    Business_tracking.Orders
WHERE 
    OrderNumber = "MC-A2841798";
  
    
--Customer Status (Gold/Silver/Copper)
SELECT
    CustomerID,
    COUNT(o.OrderNumber) AS number_of_orders,
    (
        SELECT 
            COUNT (*)
        FROM 
            Business_tracking.Orders
    )
    AS total_orders,
    CASE
        WHEN 
            COUNT (o.OrderNumber)/
            (
                SELECT 
                    COUNT (*)
            FROM 
                Business_tracking.Orders
            )   
            <=0.05
        THEN "Copper"
        WHEN 
            COUNT (o.OrderNumber)/
            (
                SELECT 
                    COUNT (*)
            FROM 
                Business_tracking.Orders
            )
            >0.05
        AND
            COUNT (o.OrderNumber)/
            (
                SELECT 
                    COUNT (*)
            FROM 
                Business_tracking.Orders
            )
            <=0.10 
        THEN "Silver"
        ELSE "Gold"
    END AS Customer_status
FROM 
    Business_tracking.Customers AS c
FULL JOIN 
    Business_tracking.Orders AS o
    USING (CustomerID)
GROUP BY
    CustomerID,
    Full_Name   
HAVING
    COUNT(o.OrderNumber)>0
ORDER BY 
    number_of_orders DESC;



