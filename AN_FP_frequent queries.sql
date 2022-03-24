-- Anh Nguyen / MSIS618 Final Project


-- Frequently used queries


# 1. Shows CustomerID, TotalPrice, TotalFee, the sum of TotalPrice and TotalFee as TotalCost in BoxID 1:
select A.CustomerID, B.TotalPrice, C.TotalFee, b.TotalPrice + c.TotalFee as TotalCost
from customer as A join `web order` as B join `order fee` as C
on a.customerid = b.customerid and a.customerid = c.customerid
where b.`VN SHIPMENT_BoxID`='1';

            
# 2. Displays all tracking number(s) and date received of order(s) that contain ItemType ‘bag’:
select tracking, DateReceive
from tracking
where OrderNumber
in (select  OrderNumber
	from `web order` 
    where `web order`.ItemType= 'bag');
    

# 3. Lists item(s) sent to Tuliem District area and its arrival date in Vietnam:
select distinct itemname, ArrivalDate
from `web order` join `vn shipment`
on `web order`.`VN SHIPMENT_BoxID` = `VN SHIPMENT`.boxID
where CustomerID 
in (select customerid 
	from customer 
    where District = 'tuliem');
    

# 4. Shows website and order number that have clothes arrived to Vietnam before April 8th:
select WebName, OrderNumber
from `web order` as a join `vn shipment` as b
on a.`vn shipment_boxid` = b.boxid
where itemtype = 'clothing'
and ArrivalDate < '2018-04-08';


# 5. A total spends of each web order in descending order:
select distinct Webname, sum(TotalPrice) as TotalSpend
from `web order`
group by webname 
order by TotalSpend desc;


# 6. Shows customer’s first name and phone number, who have order fees greater than $10.00, sorting from highest to lowest:
select a.Firstname, a.Email, a.Phone, sum(orderFee) as OrderFeeSum
from customer as a join `order fee` as b
on a.customerid = b.customerid
where orderFee > 5
group by email
order by OrderFeeSum desc;

