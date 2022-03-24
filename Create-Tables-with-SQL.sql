-- CREATE DATABASE

drop database an_fp2;
CREATE SCHEMA IF NOT EXISTS `AN_FP2`;
USE `AN_FP2` ;

-- -----------------------------------------------------
-- Table `AN_FP2`.`CUSTOMER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AN_FP2`.`CUSTOMER` 
(
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `LastName` VARCHAR(45) NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(100) NULL,
  `Address` VARCHAR(45) NULL,
  `District` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `Zip` INT NULL,
  `Phone` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `CustomerID_UNIQUE` (`CustomerID` ASC) VISIBLE
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AN_FP2`.`VN SHIPMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AN_FP2`.`VN SHIPMENT` 
(
  `BoxID` INT NOT NULL AUTO_INCREMENT,
  `DepartureDate` DATE NOT NULL,
  `ArrivalDate` DATE NULL,
  `ShipmentCost` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`BoxID`),
  UNIQUE INDEX `BoxID_UNIQUE` (`BoxID` ASC) VISIBLE
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AN_FP2`.`WEB ORDER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AN_FP2`.`WEB ORDER` 
(
  `DateOrder` DATE NULL,
  `WebName` VARCHAR(100) NOT NULL,
  `WebAddress` VARCHAR(100) NOT NULL,
  `OrderNumber` VARCHAR(45) NOT NULL,
  `CustomerID` INT NOT NULL,
  `ItemName` VARCHAR(100) NOT NULL,
  `ItemType` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NULL,
  `Size` VARCHAR(45) NULL,
  `Quality` INT NULL,
  `Price` DECIMAL(10,2) NULL,
  `Tax` DECIMAL(10,2) NULL,
  `ShippingFee` DECIMAL(10,2) NULL,
  `TotalPrice` DECIMAL(10,2) NULL,
  `VN SHIPMENT_BoxID` INT NULL,
  PRIMARY KEY (`WebName`, `OrderNumber`, `ItemName`),
  INDEX `fk_WEB ORDER_CUSTOMER_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_WEB ORDER_VN SHIPMENT1_idx` (`VN SHIPMENT_BoxID` ASC) VISIBLE,
  CONSTRAINT `fk_WEB ORDER_CUSTOMER`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `AN_FP2`.`CUSTOMER` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_WEB ORDER_VN SHIPMENT1`
    FOREIGN KEY (`VN SHIPMENT_BoxID`)
    REFERENCES `AN_FP2`.`VN SHIPMENT` (`BoxID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AN_FP2`.`ORDER FEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AN_FP2`.`ORDER FEE` 
(
  `CustomerID` INT NOT NULL,
  `DateOrder` DATE NOT NULL,
  `OrderFee` DECIMAL(10,2) NULL,
  `CustomsFee` DECIMAL(10,2) NULL,
  `VNShippingFee` DECIMAL(10,2) NULL,
  `TotalFee` DECIMAL(10,2) NULL,
  PRIMARY KEY (`CustomerID`, `DateOrder`),
  INDEX `fk_ORDER FEE_CUSTOMER1_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_ORDER FEE_CUSTOMER1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `AN_FP2`.`CUSTOMER` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `AN_FP2`.`TRACKING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AN_FP2`.`TRACKING` 
(
  `DateOrder` DATE NOT NULL,
  `WebName` VARCHAR(100) NOT NULL,
  `OrderNumber` VARCHAR(45) NOT NULL,
  `ItemName` VARCHAR(100) NOT NULL,
  `Tracking` VARCHAR(45) NULL,
  `DateReceive` DATE NULL,
  PRIMARY KEY (`DateOrder`, `WebName`, `OrderNumber`, `ItemName`),
  INDEX `fk_TRACKING_WEB ORDER1_idx` (`WebName` ASC, `OrderNumber` ASC, `ItemName` ASC) VISIBLE,
  CONSTRAINT `fk_TRACKING_WEB ORDER1`
    FOREIGN KEY (`WebName` , `OrderNumber` , `ItemName`)
    REFERENCES `AN_FP2`.`WEB ORDER` (`WebName` , `OrderNumber` , `ItemName`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  ENGINE = InnoDB;



insert into `customer` (LastName, FirstName, Email, Address, District, City, Zip, Phone)
values ('Nguyen', 'LanAnh', 'anhntl@email.com', '47 QuangTrung St', 'HoanKiem', 'Hanoi', 10000, 1906698888),
       ('Le', 'Huong', 'lehuong@email.com', '48 QuangTrung St', 'HoanKiem', 'Hanoi', 10000, 1912096060),
       ('Dao', 'Quynh', 'quynhdao@email.com', 'The Manor W2003 Metri St', 'Tuliem', 'Hanoi', 10000, 1259996868),
       ('Phan', 'Huyen', 'hphan@email.com', 'The Manor E1904 Metri St', 'Tuliem', 'Hanoi', 10000, 1903222686),
       ('Bui', 'Nga', 'ngabui@email.com', '85 Vu-Trongphung St', 'ThanhXuan', 'Hanoi', 10000, 1937556868),
       ('Nguyen', 'Ngoc', 'npngoc@email.com', '43 Nguyen-Chithanh St', 'Badinh', 'Hanoi', 10000, 1983413079),
       ('Vu', 'Hue', 'vumhue@email.com', 'CT3 Metri-Ha St', 'Tuliem', 'Hanoi', 10000, 1904513951),
       ('Nguyen', 'Phuong', 'npphuong2@email.com', 'CT5C Vankhe St', 'Hadong', 'Hanoi', 10000, 1908408866),
       ('Vu', 'Khuyen', 'khuyenvu@email.com', '12 Binhan St', 'Quan 2', 'Hochiminh City', 70000, 1968937379),
       ('Tong', 'Phuong', 'phuongth@email.com', '74 Batrieu St', 'HoanKiem', 'Hanoi', 10000, 1983739762);

insert into `Vn shipment` (DepartureDate, ArrivalDate, ShipmentCost)
values ('2018-03-12', '2018-03-21', 89.25),
       ('2018-03-25', '2018-04-02', 78.75),
       ('2018-04-01', '2018-04-08', 89.25),
       ('2018-04-08', '2018-04-16', 110.25),
       ('2018-04-16', '2018-05-07', 103.25);
       
insert into `WEB ORDER`
values ('2018-03-02', 'Coachoutlet', 'coachoulet.com', 'Z1494137', 6, 'MINI BENNETT SATCHEL', 'Bag', 'Black', Null, 1, 94.40, 5.90, 0, 100.30, 1),
       ('2018-03-02', 'Coachoutlet', 'coachoulet.com', 'Z1494137', 6, 'MINI CHARLIE BACKPACK', 'Bag', 'Black', Null, 1, 94.40, 5.90, 0, 100.30, 1),
       ('2018-03-02', 'Crocs', 'crocs.com', '15568104CUS', 3, 'Bayaband Clogs', 'Shoes', 'Green/White', Null, 1, 44.99, 0, 4.95, 44.94, 1),
       ('2018-03-03', 'Coachoutlet', 'coachoulet.com', 'Z1502166', 6, 'CARRIE CROSSBODY', 'Bag', 'White', Null, 1, 91, 5.69, 0, 96.69, 1),
       ('2018-03-03', 'Paulas Choice', 'paulaschoice.com', '301573749', 10, 'CLEAR Extra Strength Kit', 'Skincare', Null, Null, 2, 48, 0, 0, 96, 1),
       ('2018-03-05', 'Ralph Lauren', 'ralphlauren.com', '5605286221', 1, 'CUSTOM SLIM FIT MESH POLO', 'Clothing', 'Orange', 4, 1, 31.49, 0, 0, 31.49, 1),
       ('2018-03-05', 'Ralph Lauren', 'ralphlauren.com', '5605286221', 1, 'COTTON MESH POLO SHIRT', 'Clothing', 'Blue', 'S', 1, 23.49, 0, 0, 23.49, 1),
       ('2018-03-13', 'Puritan', 'puritan.com', '476407475', 7, 'Super Collagen +C', 'Vitamin/Supplement', null, Null, 6, 9.57, 0, 3.59, 61.01, 2),
       ('2018-03-14', 'Amazon', 'amazon.com', '114-4488485-3696218', 4, 'GNC Herbal Plus Milk Thistle 200 MG', 'Vitamin/Supplement', null, '180 Tablets', 2, 49.99, 0, 0, 99.98, 2),
       ('2018-03-15', 'Amazon', 'amazon.com', '114-5735708-7372206', 9, 'Calvin Klein Mens Wool Scarf Coat', 'Clothing', 'Black', 'M', 1, 79.54, 0, 0, 79.54, 2);

insert into `TRACKING`
values ('2018-03-02', 'Coachoutlet','Z1494137', 'MINI BENNETT SATCHEL', 'SP9709W00304538682', '2018-03-09'),
       ('2018-03-02', 'Coachoutlet', 'Z1494137', 'MINI CHARLIE BACKPACK', 'SP3709H10365538694', '2018-03-09'),
       ('2018-03-02', 'Crocs', '15568104CUS', 'Bayaband Clogs', 'SP9709W00304538682', '2018-03-09'),
       ('2018-03-03', 'Coachoutlet', 'Z1502166', 'CARRIE CROSSBODY', 'SP9709W4YW01141172', '2018-03-10'),
       ('2018-03-02', 'Paulas Choice', '301573749', 'CLEAR Extra Strength Kit', 'SP98A26AP205165840', '2018-03-07'),
       ('2018-03-05', 'Ralph Lauren', '5605286221', 'CUSTOM SLIM FIT MESH POLO', 'SPA17A69YW47406509', '2018-03-09'),
       ('2018-03-05', 'Ralph Lauren', '5605286221', 'COTTON MESH POLO SHIRT', 'SPA17A69YW47406509', '2018-03-09'),
       ('2018-03-13', 'Puritan', '476407475', 'Super Collagen +C', 'SP144597YW60647941', '2018-03-16'),
       ('2018-03-14', 'Amazon', '114-4488485-3696218', 'GNC Herbal Plus Milk Thistle 200 MG', 'TBA2612999966', '2018-03-18'),
       ('2018-03-15', 'Amazon', '114-5735708-7372206', 'Calvin Klein Mens Wool Scarf Coat', 'TBA406581060876', '2018-03-19');
       
insert into `order fee`
values (6, '2018-03-02', 12.04, 0, 14.40, 26.44),
       (3, '2018-03-02', 2.70, 0, 5.22, 7.92),
       (6, '2018-03-03', 5.80, 0, 7.20, 13.00),       
       (10, '2018-03-02', 7.68, 0, 13.91, 21.59),
       (1, '2018-03-05', 4.40, 0, 5.22, 9.62),
       (7, '2018-03-13', 21.92, 0, 19.48, 41.4),
       (4, '2018-03-14', 8.50, 0, 9.40, 17.9),
       (9, '2018-03-15', 6.36, 0, 20.70, 27.06);
       
 
 
 -- Frequently used queries

# 1. Shows CustomerID, TotalPrice, TotalFee, the sum of TotalPrice and TotalFee as TotalCost in BoxID 1:
SELECT A.CustomerID, B.TotalPrice, C.TotalFee, b.TotalPrice + c.TotalFee as TotalCost
FROM customer AS A 
JOIN `web order` AS B JOIN `order fee` AS C
ON a.customerid = b.customerid AND a.customerid = c.customerid
WHERE b.`VN SHIPMENT_BoxID`='1';

            
# 2. Displays all tracking number(s) and date received of order(s) that contain ItemType ‘bag’:
SELECT tracking, DateReceive
FROM tracking
WHERE OrderNumber
IN (SELECT  OrderNumber
	  FROM `web order` 
    WHERE `web order`.ItemType= 'bag');
    

# 3. Lists item(s) sent to Tuliem District area and its arrival date in Vietnam:
SELECT DISTINCT itemname, ArrivalDate
FROM `web order` 
JOIN `vn shipment`
ON `web order`.`VN SHIPMENT_BoxID` = `VN SHIPMENT`.boxID
WHERE CustomerID 
IN (SELECT customerid 
	  FROM customer 
    WHERE District = 'tuliem');
    

# 4. Shows website and order number that have clothes arrived to Vietnam before April 8th:
SELECT WebName, OrderNumber
FROM `web order` AS a 
JOIN `vn shipment` AS b
ON a.`vn shipment_boxid` = b.boxid
WHERE itemtype = 'clothing'
AND ArrivalDate < '2018-04-08';


# 5. A total spends of each web order in descending order:
SELECT DISTINCT Webname, sum(TotalPrice) AS TotalSpend
FROM `web order`
GROUP BY webname 
ORDER BY TotalSpend DESC;


# 6. Shows customer’s first name and phone number, who have order fees greater than $10.00, sorting from highest to lowest:
SELECT a.Firstname, a.Email, a.Phone, sum(orderFee) as OrderFeeSum
FROM customer AS a 
JOIN `order fee` AS b
ON a.customerid = b.customerid
WHERE orderFee > 5
GROUP BY email
ORDER BY OrderFeeSum DESC;

      

      
