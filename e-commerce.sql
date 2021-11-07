CREATE TABLE `Address` (
  `Address_ID` int(11) NOT NULL,
  `NickName` varchar(15) NOT NULL,
  `StreetAddress1` varchar(20) NOT NULL,
  `StreetAddress2` varchar(15) DEFAULT NULL,
  `City` varchar(15) NOT NULL,
  `State` varchar(20) NOT NULL,
  `Country` varchar(15) NOT NULL,
  `ZipCode` varchar(10) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  PRIMARY KEY (`Address_ID`)
);

CREATE TABLE `Card` (
  `CardNum` varchar(20) NOT NULL,
  `PaymentType` varchar(20) NOT NULL,
  `CardHolder_Name` varchar(20) NOT NULL,
  `CardExpireDate` date NOT NULL,
  `SecurityNumber` int(11) NOT NULL,
  `Address_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`CardNum`),
  FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
) ;

CREATE TABLE `Category` (
  `Category_ID` int(11) NOT NULL,
  `Category_Name` varchar(15) NOT NULL,
  `Department_ID` int(11) NOT NULL,
  PRIMARY KEY (`Category_ID`)
  FOREIGN KEY (`Department_ID`) REFERENCES `department` (`Department_ID`)
) ;

CREATE TABLE `Department` (
  `Department_ID` int(11) NOT NULL,
  `Department_Name` varchar(15) NOT NULL,
  PRIMARY KEY (`Department_ID`)
);

CREATE TABLE `Deposit` (
  `Seller_ID` varchar(15) NOT NULL,
  `BankAccountNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`Seller_ID`,`BankAccountNumber`),
  FOREIGN KEY (`BankAccountNumber`) REFERENCES `e_account` (`BankAccountNumber`),
  FOREIGN KEY (`Seller_ID`) REFERENCES `e_seller` (`Seller_ID`)
);
CREATE TABLE `E_Account` (
  `BankAccountNumber` varchar(20) NOT NULL,
  `Account_Holder_Name` varchar(40) NOT NULL,
  `Routing_Number` int(11) NOT NULL,
  PRIMARY KEY (`BankAccountNumber`)
);

CREATE TABLE `E_Customer` (
  `Customer_ID` varchar(15) NOT NULL,
  `FirstName` varchar(15) NOT NULL,
  `LastName` varchar(15) NOT NULL,
  `PhoneNumber` varchar(10) NOT NULL,
  `Address_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`),
  FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
);

CREATE TABLE `Employee` (
  `Employee_ID` varchar(15) NOT NULL,
  `FirstName` varchar(15) NOT NULL,
  `LastName` varchar(15) NOT NULL,
  `Designation` varchar(15) NOT NULL,
  `Manager_ID` int(11) DEFAULT NULL,
  `Department_ID` int(11) DEFAULT NULL,
  `Category_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Employee_ID`),
  FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`),
  FOREIGN KEY (`Department_ID`) REFERENCES `department` (`Department_ID`)
);

CREATE TABLE `E_order` (
  `Order_ID` int(11) NOT NULL,
  `Order_Date` date NOT NULL,
  `Customer_ID` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  FOREIGN KEY (`Customer_ID`) REFERENCES `e_customer` (`Customer_ID`)
);


CREATE TABLE `E_Seller` (
  `Seller_ID` varchar(15) NOT NULL,
  `BusinessName` varchar(25) NOT NULL,
  `BusinessPhoneNum` varchar(10) NOT NULL,
  `WebsiteLink` varchar(300) DEFAULT NULL,
  `Address_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`Seller_ID`),
  FOREIGN KEY (`Address_ID`) REFERENCES `address` (`Address_ID`)
);

CREATE TABLE `E_Transaction` (
  `Transaction_ID` int(11) NOT NULL,
  `Order_ID` int(11) DEFAULT NULL,
  `Transaction_Date` date NOT NULL,
  `Amount` double NOT NULL,
  `CardNum` varchar(20) DEFAULT NULL,
  `BankAccountNumber` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`Transaction_ID`),
  FOREIGN KEY (`Order_ID`) REFERENCES `e_order` (`Order_ID`),
  FOREIGN KEY (`BankAccountNumber`) REFERENCES `e_account` (`BankAccountNumber`),
  FOREIGN KEY (`CardNum`) REFERENCES `card` (`CardNum`)
);

CREATE TABLE `E_User` (
  `User_ID` varchar(15) NOT NULL,
  `User_Email` varchar(60) NOT NULL,
  `User_Password` varchar(45) NOT NULL,
  `RegistrationDate` date NOT NULL,
  PRIMARY KEY (`User_ID`)
);

CREATE TABLE `Item` (
  `Item_ID` int(11) NOT NULL,
  `SellerID` varchar(15) NOT NULL,
  `Item_Name` varchar(15) NOT NULL,
  `Item_Description` varchar(300) DEFAULT NULL,
  `UnitPrice` double NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Category_ID` int(11) NOT NULL,
  PRIMARY KEY (`Item_ID`),
  FOREIGN KEY (`SellerID`) REFERENCES `e_seller` (`Seller_ID`),
  FOREIGN KEY (`Category_ID`) REFERENCES `Category` (`Category_ID`)
);

CREATE TABLE `Offer` (
  `Department_ID` int(11) NOT NULL,
  `Category_ID` int(11) NOT NULL,
  PRIMARY KEY (`Department_ID`,`Category_ID`),
  FOREIGN KEY (`Department_ID`) REFERENCES `department` (`Department_ID`),
  FOREIGN KEY (`Category_ID`) REFERENCES `category` (`Category_ID`)
);

CREATE TABLE `Package` (
  `Tracking_ID` int(11) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `UnitPrice` double DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Tracking_ID`,`Item_ID`),
  FOREIGN KEY (`Item_ID`) REFERENCES `item` (`Item_ID`),
  FOREIGN KEY (`Tracking_ID`) REFERENCES `shipment` (`Tracking_ID`)
);

CREATE TABLE `Pay` (
  `Customer_ID` varchar(15) NOT NULL,
  `CardNum` varchar(20) NOT NULL,
  PRIMARY KEY (`Customer_ID`,`CardNum`),
  FOREIGN KEY (`Customer_ID`) REFERENCES `e_customer` (`Customer_ID`),
  FOREIGN KEY (`CardNum`) REFERENCES `card` (`CardNum`)
);


CREATE TABLE `Shipment` (
  `Tracking_ID` int(11) NOT NULL,
  `Order_ID` int(11) NOT NULL,
  `Depart_Date` date NOT NULL,
  `Arrival_Date` date NOT NULL,
  `Shipment_Carrier` varchar(15) NOT NULL,
  `Shipping_Fee` double NOT NULL,
  `Destination_ID` int(11) NOT NULL,
  `Source_ID` int(11) NOT NULL,
  PRIMARY KEY (`Tracking_ID`),
  FOREIGN KEY (`Order_ID`) REFERENCES `e_order` (`Order_ID`),
  FOREIGN KEY (`Destination_ID`) REFERENCES `address` (`Address_ID`),
  FOREIGN KEY (`Source_ID`) REFERENCES `address` (`Address_ID`)
);

CREATE TABLE `ShoppingCart` (
  `Customer_ID` varchar(15) NOT NULL,
  `Item_ID` int(11) NOT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`,`Item_ID`),
  FOREIGN KEY (`Customer_ID`) REFERENCES `e_customer` (`Customer_ID`),
  FOREIGN KEY (`Item_ID`) REFERENCES `item` (`Item_ID`)
);
