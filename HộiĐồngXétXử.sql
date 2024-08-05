
	-- Create Database if not exists
	IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'DiamondStore')
	BEGIN
		CREATE DATABASE DiamondStore;
	END
	GO

	USE DiamondStore;
	GO

	--1
	CREATE TABLE Roles(
		RoleID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
		RoleName VARCHAR(50),
		Transportation NVARCHAR(50),
		BonusPoints INT,
		NumberOfOrdersDelivered INT,
		Rank VARCHAR(50),
	);

	PRINT 'Roles table created';
	--2
	CREATE TABLE Account (
		AccountID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
		FirstName NVARCHAR(50),
		LastName NVARCHAR(50),
		Gender NVARCHAR(10),
		Birthday DATE,
		Password VARCHAR(100),
		Email VARCHAR(100),
		PhoneNumber VARCHAR(20),
		Address NVARCHAR(MAX),
		Country NVARCHAR(50),
		City NVARCHAR(50),
		Province NVARCHAR(50),
		PostalCode VARCHAR(50),
		RoleID INT unique,
		Status VARCHAR(50),
		Image VARCHAR(MAX),
		
		--FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),

	);
	PRINT 'Account table created';

	ALTER TABLE Account ADD Token VARCHAR(MAX);
	ALTER TABLE Account ADD ResetToken VARCHAR(64), ResetTokenExpire DATETIME;
	ALTER TABLE Account ADD CreatedAt Date DEFAULT GETDATE();

	ALTER TABLE Account
ADD CONSTRAINT FK_Account_Roles FOREIGN KEY([RoleID]) 
    REFERENCES [Roles]([RoleID]);
	--3
	CREATE TABLE Diamond (
		DiamondID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		DiamondOrigin VARCHAR(50),
		CaratWeight DECIMAL(5, 2),
		Color VARCHAR(50),
		Clarity VARCHAR(50),
		Cut VARCHAR(50),
		Price DOUBLE PRECISION,
		Shape VARCHAR(50),
		[Image] VARCHAR(MAX),
		Polish VARCHAR(50),
		Symmetry VARCHAR(50),
		TablePercentage DECIMAL(5, 2),
		Depth DECIMAL(5, 2),
		Measurements VARCHAR(100),
		GIAReportNumber VARCHAR(50),
		StockNumber VARCHAR(50),
		LabReportNumber VARCHAR(50),
		Gemstone VARCHAR(50),
		GradingReport VARCHAR(50),
		Descriptors TEXT,
		Fluorescence VARCHAR(50),
		Inventory INT
	);

	PRINT 'Diamond table created';

	--4
	-- Create the Bridal table
BEGIN TRANSACTION;

-- Tạo bảng Bridal
CREATE TABLE Bridal (
    BridalID INT IDENTITY(1,1) PRIMARY KEY,
    BridalStyle VARCHAR(50),
    NameBridal VARCHAR(50),
    Category VARCHAR(MAX),
    BrandName VARCHAR(50),
    Material VARCHAR(MAX),
    SettingType VARCHAR(MAX),
    Gender VARCHAR(MAX),
    Weight DECIMAL(10, 2),
    CenterDiamond VARCHAR(MAX),
    DiamondCaratRange VARCHAR(MAX),
    RingSizeRange DECIMAL(10, 2),
    TotalCaratWeight DECIMAL(10, 2),
    TotalDiamond INT,
    Description VARCHAR(MAX),
    ImageBridal VARCHAR(MAX),
    ImageBrand VARCHAR(MAX),
    Inventory INT
);

-- Tạo bảng Material
CREATE TABLE Material (
    MaterialID INT IDENTITY(1,1) PRIMARY KEY,
    MaterialName VARCHAR(50)
);

-- Tạo bảng RingSize
CREATE TABLE RingSize (
    RingSizeID INT IDENTITY(1,1) PRIMARY KEY,
    RingSize DECIMAL(10, 2)
);

-- Tạo bảng BridalPrice
CREATE TABLE BridalPrice (
    PriceID INT IDENTITY(1,1) PRIMARY KEY,
    Price DECIMAL(18, 2)
);

-- Tạo bảng BridalAccessory
CREATE TABLE BridalAccessory (
    BridalID INT,
    MaterialID INT,
    RingSizeID INT,
    PriceID INT,
    FOREIGN KEY (BridalID) REFERENCES Bridal(BridalID),
    FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID),
    FOREIGN KEY (RingSizeID) REFERENCES RingSize(RingSizeID),
    FOREIGN KEY (PriceID) REFERENCES BridalPrice(PriceID)
);

-- Chèn dữ liệu vào bảng Material
INSERT INTO Material (MaterialName)
VALUES 
('Platinum'), 
('14K White Gold'), 
('18K White Gold'), 
('14K Yellow Gold'), 
('18K Yellow Gold');

-- Chèn dữ liệu vào bảng RingSize
INSERT INTO RingSize (RingSize)
VALUES 
(5.00), (5.25), (5.50), (5.75), (6.00), (6.25), 
(6.50), (6.75), (7.00), (7.25), (7.50), (7.75), (8.00);

-- Chèn dữ liệu vào bảng BridalPrice
INSERT INTO BridalPrice (Price)
VALUES 
(5000.00), -- Price for Platinum
(2500.00), -- Price for 14K White Gold
(4500.00), -- Price for 18K White Gold
(2000.00), -- Price for 14K Yellow Gold
(3500.00); -- Price for 18K Yellow Gold

-- Chèn dữ liệu vào bảng Bridal
INSERT INTO Bridal (BridalStyle, NameBridal, Category, BrandName, Material, SettingType, Gender, Weight, CenterDiamond, DiamondCaratRange, RingSizeRange, TotalCaratWeight, TotalDiamond, Description, ImageBridal, ImageBrand, Inventory)
VALUES
--1
('84511-8X6', 'Oval Halo Engagement Ring', 'Engagement Rings', 'Overnight', '', 'Halo', 'Womens', 0.00, 'Not Included', '0.25 - 0.4', 5.00, 0.26, 34, 'This platinum oval halo engagement ring can accommodate a oval diamond shape between 0.25 and 3.00 carats. Includes 32 diamonds weighing 0.32 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84511-E.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/00008w.jpg', 1),
--2
('84510-7', 'Halo Engagement Ring', 'Engagement Rings', 'Overnight', '', 'Halo', 'Womens', 0.00, 'Not Included', '0.25 - 0.3', 6.00, 0.50, 30, 'This platinum oval halo engagement ring can accommodate a oval diamond shape between 0.25 and 3.00 carats. Includes 32 diamonds weighing 0.32 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84510-E.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/00008w.jpg', 1),
--3
('84509-8', 'Round Halo Engagement Ring', 'Engagement Rings', 'Overnight', '', 'Halo', 'Womens', 0.00, 'Not Included', '0.25 - 0.35', 5.00, 0.26, 34, 'This platinum round halo engagement ring can accommodate a round diamond shape of 1.90 carats. Includes 34 diamonds weighing 0.34 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84509-E.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/00008w.jpg', 1),
--4
 ('84373-3',
  'Emerald Halo Engagement Ring', 
    'Engagement Rings',
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Halo',
    'Womens',
    0.00 ,
    'Not Included' ,
    '0.1 - 0.2',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.26 , -- Assuming one of the values
    42 ,
		'This platinum oval halo engagement ring can accommodate a oval diamond shape between 0.25 and 3.00 carats. Includes 32 diamonds weighing 0.32 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
    
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84373-E.jpg?v=14' ,
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
    1 ),
--5
('84335-B',
    'Emerald Halo Engagement Ring' , 
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
    'Womens',
    0.00,
    'Not Included' ,
    '0.26',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.26, -- Assuming one of the values
    36,
		'This platinum Round Halo Engagement Ring can accommodate a oval diamond shape between 0.25 and 3.00 carats. Matching wedding band sold separately.', -- change
 
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84335-E.jpg?v=14', --change   --fix image
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
    1),
--6
( '83879-33-4' ,
    'Emerald Halo Engagement Ring' , 
    'Engagement Rings' ,
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
    'Womens',
    0.00 ,
    'Not Included',
    '0.4- 1.0' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.44 , -- Assuming one of the values
    60 ,
		'This platinum round halo engagement ring can accommodate a round diamond shape of 2.50 carats. Includes 60 diamonds weighing 0.90 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum.
		Center diamond not included. Matching wedding band sold separately.' , --change
    
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83879-E.jpg?v=14', -- change link
		'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
    1 ),
--7
(
 '83503-9' ,
    'Halo Engagement Ring' , 
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo',
    'Womens',
    0.00 ,
    'Not Included' ,
    '0.25 - 0.3',
    5.00, -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    36 ,
		'This platinum halo engagement ring can accommodate princess or cushion diamond shapes between 0.25 and 3.00 carats. Includes 38 diamonds weighing 0.29 carats total.
		Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 

		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83503-E.jpg?v=14',
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
    1 ),
--8
(
 '83501-8',
    'Halo Engagement Ring' , 
    'Engagement Rings',
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
    'Womens',
    0.00 ,
    'Not Included' ,
    '0.75 - 1.13' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    82 ,
		'This platinum halo engagement ring can accommodate princess or cushion diamond shapes between 0.25 and 3.00 carats. Includes 82 diamonds weighing 1.13 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum.
		Center diamond not included. Matching wedding band sold separately.', 
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83501-E.jpg?v=14', -- change link
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
    1),
--9
(
'83498-9X6' ,
    'Pear Halo Engagement Ring' , 
    'Engagement Rings' ,
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo',
    'Womens',
    0.00 ,
    'Not Included' ,
    '0.22 - 0.3' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    29 ,
		'This platinum pear halo engagement ring can accommodate a pear diamond shape between 0.25 and 3.00 carats. Includes 29 diamonds weighing 0.22 carats total.
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83498-E.jpg?v=14' , -- change link\
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
    1 ),
--10
(
 '83477-3-4',
    'Princess Three-Stone Engagement Ring', 
    'Engagement Rings',
    'Overnight' ,
    '', -- This will be updated to have multiple materials later
    'Three Stone' ,
    'Womens' ,
    0.00,
    'Not Included' ,
    '0.14 - 0.4' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    2 ,
		'This platinum pear halo engagement ring can accommodate a pear diamond shape between 0.25 and 3.00 carats. Includes 29 diamonds weighing 0.22 carats total.
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
		'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83477-E.jpg?v=14' , -- change link
			'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
    1
),
--11
(
'82949-3-4',
    'Three-Stone Round Engagement Ring' , --change 
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Three Stone' ,
    'Womens',
    0.00 ,
    'Not Included',
	'0.24 - 0.25', --change
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    2 ,
	'This platinum three-stone round engagement ring can accommodate a round diamond shape of 0.50 carats. Includes 2 diamonds weighing 0.24 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/82949-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 ),
--12
(
'82857-H', --change
    'Trellis Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Single Row' ,
    'Womens' ,
    0.00 ,
    'Not Included' ,
	'0.24 - 0.25', --change
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    8, --change
	'This platinum trellis engagement ring can accommodate princess or cushion diamond shapes between 0.25 and 3.00 carats. Includes 8 diamonds weighing 0.24 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/82857-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--13
(
 '82856-H', --change
    'Antique Engagement Ring' , --change
    'Engagement Rings' ,
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Antique' ,
    'Womens' ,
    0.00,
    'Not Included' ,
	'0.08 - 0.2' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    8 , --change
	'This platinum antique engagement ring can accommodate princess or cushion diamond shapes between 0.25 and 3.00 carats. Includes 8 diamonds weighing 0.19 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/82856-E.jpg?v=14' ,-- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--14
(
 '50934-E' , --change
    'Pavé Engagement Ring MULT ROW', --change
    'Engagement Rings' ,
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Multi Row' ,
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'1.05' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    64, --change
	'This platinum pavé engagement ring mult row can accommodate a round diamond shape of 0.75 carats. Includes 64 diamonds weighing 1.05 carats total.
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50934-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1
),
--15
(
'50898-E', --change
    'Round Halo Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens',
	0.00 ,
	'Not Included' ,
	'0.7 - 1.17' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    18 , --change
	'This platinum round halo engagement ring can accommodate a round diamond shape of 0.80 carats. 
	Includes 18 diamonds weighing 1.17 carats total. Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.' , 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50898-E.jpg?v=14' ,-- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--16
(
'50843-E-3-4', --change
	'Engagement Ring' , --change
    'Engagement Rings',
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Bypass' ,
	'Womens',
	0.00 ,
	'Not Included' ,
	'0.2 -0.25' ,
    5.00, -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    46, --change
	'This platinum engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 46 diamonds weighing 0.25 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50843-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
),
--17
(
'50849-E-1', --change
	'Halo 2-Row Diamond Band' , --change
    'Engagement Rings' ,
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens',
	0.00 ,
	'Not Included' ,
	'0.71' ,
    5.00, -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    46 , --change
	'This platinum halo 2-row diamond band can accommodate a round diamond shape of 1.00 carats. Includes 46 diamonds weighing 0.71 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', --change
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50849-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
),
--18
(
'50774-E-3-4', --change
	'Multi-Row Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Multi Row',
	'Womens',
	0.00,
	'Not Included',
	'0.17 - 0.18',
    5.00, -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    32, --change
	'This platinum multi-row engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 32 diamonds weighing 0.18 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50774-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1
),
--19
(
'50628-E-3-4' , --change
	'Single Row Prong Engagement Ring', --change
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Single Row',
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.25 - 0.35' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    30 , --change
	'This platinum single row prong engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 30 diamonds weighing 0.31 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50628-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1
),
--20
(
  '84693', --change
	'White Gold Bypass-Style Engagement Ring', --change
    'Engagement Rings' ,
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Bypass',
	'Womens',
	0.00,
	'Not Included',
	'0.56',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    94 , --change
	'This 14K white gold bypass-style engagement ring can accommodate a round diamond shape between 0.25 and 3.00 carats. Includes 94 diamonds weighing 0.56 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84693-E.jpg?v=14',-- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1
),
--21
(
 '84598', --change
	'Round Halo Engagement Ring', --change
    'Engagement Rings',
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo',
	'Womens' ,
	0.00 ,
	'Not Included',
	'1.02' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    78 , --change
	'This 14K white gold round halo engagement ring can accommodate a round diamond shape of 1.00 carats. Includes 78 diamonds weighing 1.03 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84598-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
),
--22
(
 '83195', --change
	'Round Halo Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.5' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    40 , --change
	'This 14K white gold round halo engagement ring can accommodate a round diamond shape of 1.00 carats. Includes 40 diamonds weighing 0.50 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/83195-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
),
--23
(
 '50778-E', --change
	'Halo Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.32 - 0.4' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    22 , --change
	'This platinum halo engagement ring can accommodate princess or cushion diamond shapes between 0.25 and 3.00 carats. Includes 22 diamonds. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50778-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1
),
--24
(
 '50920-E-9X7', --change
	'Emerald Halo Engagement Ring', --change
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens' ,
	0.00,
	'Not Included',
	'0.25 - 0.3' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    26 , --change
	'This platinum emerald halo engagement ring can accommodate a emerald diamond shape between 0.25 and 3.00 carats. Includes 26 diamonds weighing 0.20 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50920-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1
),
--25
(
'50630-E-3-4', --change
	'Round Halo Engagement Ring', --change
    'Engagement Rings',
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Halo',
	'Womens',
	0.00 ,
	'Not Included' ,
	'0.5 - 1.55',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    10 , --change
	'This platinum round halo engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 10 diamonds weighing 0.55 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50630-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--26
(
 '50594-E-3-4', --change
	'Round Halo Engagement Ring' , --change
    'Engagement Rings',
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens' ,
	0.00,
	'Not Included' ,
	'0.2 - 0.22',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    58 , --change
	'This platinum round halo engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 58 diamonds weighing 0.87 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50594-E.jpg?v=14' ,-- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
),
--27
(
 '84514', --change
	'Antique Engagement Ring' , --change
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Antique' ,
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.14' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25, -- Assuming one of the values
    14, --change
	'This 14K white gold antique engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 14 diamonds weighing 0.14 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84514-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--28
(
 '84474', --change
	'Round Halo Engagement Ring' , --change
    'Engagement Rings' ,
    'Overnight',
    '', -- This will be updated to have multiple materials later
    'Halo',
	'Womens',
	0.00,
	'Not Included',
	'0.26',
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    42, --change
	'This 14K white gold round halo engagement ring can accommodate a round diamond shape of 1.00 carats. Includes 42 diamonds weighing 0.26 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/84474-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1
),
--29
(
 '50815-E', --change
	'Round Halo Engagement Ring' , --change
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo',
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.2 - 0.21' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    42 , --change
	'This 14K white gold round halo engagement ring can accommodate a round diamond shape of 1.00 carats. Includes 42 diamonds weighing 0.50 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50815-E.jpg?v=14' , -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg', -- insert ImageBrand
	1 
),
--30
(
 '50582-E-3-4' , --change
	'Round Halo Engagement Ring', --change
    'Engagement Rings' ,
    'Overnight' ,
    '' , -- This will be updated to have multiple materials later
    'Halo' ,
	'Womens' ,
	0.00 ,
	'Not Included' ,
	'0.8 - 0.84' ,
    5.00 , -- This will be updated to have multiple ring sizes later
    0.25 , -- Assuming one of the values
    22 , --change
	'This platinum round halo engagement ring can accommodate a round diamond shape of 0.75 carats. Includes 22 diamonds weighing 0.81 carats total. 
	Available in 10K, 14K, and 18K white, yellow, or rose gold, and platinum. Center diamond not included. Matching wedding band sold separately.', 
	'https://cdn.jewelryimages.net/galleries/overnight/Engagement-Rings/50582-E.jpg?v=14', -- change link
	'https://collections.jewelryimages.net/collections_logos/00008w.jpg' , -- insert ImageBrand
	1 
);
-- Chèn dữ liệu vào bảng BridalAccessory
DECLARE @BridalID1 INT = 1;
WHILE @BridalID1 <= 30
BEGIN
    DECLARE @MaterialID1 INT = 1;
    WHILE @MaterialID1 <= 5
    BEGIN
        DECLARE @RingSizeID1 INT = 1;
        WHILE @RingSizeID1 <= 13
        BEGIN
            DECLARE @PriceID1 INT = 1;
            WHILE @PriceID1 <= 5
            BEGIN
                INSERT INTO BridalAccessory (BridalID, MaterialID, RingSizeID, PriceID)
                VALUES (@BridalID1, @MaterialID1, @RingSizeID1, @PriceID1);
                
                SET @PriceID1 = @PriceID1 + 1;
            END;
            SET @RingSizeID1 = @RingSizeID1 + 1;
        END;
        SET @MaterialID1 = @MaterialID1 + 1;
    END;
    SET @BridalID1 = @BridalID1 + 1;
END;

COMMIT TRANSACTION;

	PRINT 'Bridal table created';

	--5
	CREATE TABLE DiamondTimepieces (
		DiamondTimepiecesID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
		TimepiecesStyle VARCHAR(50),
		NameTimepieces VARCHAR(100),
		Collection VARCHAR(50),
		WaterResistance VARCHAR(50),
		CrystalType VARCHAR(50),
		BraceletMaterial VARCHAR(50),
		CaseSize VARCHAR(50),
		DialColor VARCHAR(50),
		Movement VARCHAR(50),
		Gender VARCHAR(10),
		Category VARCHAR(50),
		BrandName VARCHAR(50),
		DialType VARCHAR(50),
		Description VARCHAR(MAX),
		Price DOUBLE PRECISION,
		ImageTimepieces VARCHAR(MAX),
		ImageBrand VARCHAR(MAX),
		Inventory INT
	);

	PRINT 'DiamondTimepieces table created';

-- Create the DiamondRings table
BEGIN TRANSACTION;

CREATE TABLE DiamondRings (
    DiamondRingsID INT IDENTITY(1,1) PRIMARY KEY,
    RingStyle VARCHAR(50),
    NameRings VARCHAR(50) NOT NULL,
    Category VARCHAR(50),
    BrandName VARCHAR(50),
    Material VARCHAR(50),
    CenterGemstone VARCHAR(50),
    CenterGemstoneShape VARCHAR(50),
    Width DECIMAL(10, 2),
    CenterDiamondDimension INT,
    Weight DECIMAL(10, 2),
    GemstoneWeight DECIMAL(5, 2),
    CenterDiamondColor VARCHAR(50),
    CenterDiamondClarity VARCHAR(50),
    CenterDiamondCaratWeight DECIMAL(5, 2),
    RingSize DECIMAL(10, 2),
    Gender VARCHAR(50),
    Fluorescence VARCHAR(50),
    Description VARCHAR(MAX),
    ImageRings VARCHAR(MAX),
    ImageBrand VARCHAR(MAX),
    Inventory INT
);

-- Tạo bảng RingsPrice
CREATE TABLE RingsPrice (
    PriceID INT IDENTITY(1,1) PRIMARY KEY,
    Price DECIMAL(18, 2)
);

-- Tạo bảng BridalAccessory
CREATE TABLE RingsAccessory (
    DiamondRingsID INT,
    MaterialID INT,
    RingSizeID INT,
    PriceID INT,
    FOREIGN KEY (DiamondRingsID) REFERENCES DiamondRings(DiamondRingsID),
    FOREIGN KEY (MaterialID) REFERENCES Material(MaterialID),
    FOREIGN KEY (RingSizeID) REFERENCES RingSize(RingSizeID),
    FOREIGN KEY (PriceID) REFERENCES RingsPrice(PriceID)
);

-- Chèn dữ liệu vào bảng BridalPrice
INSERT INTO RingsPrice (Price)
VALUES 
(5500.00), -- Price for Platinum
(2900.00), -- Price for 14K White Gold
(4800.00), -- Price for 18K White Gold
(2400.00), -- Price for 14K Yellow Gold
(3700.00); -- Price for 18K Yellow Gold

--CHÈN DỮ LIỆU CHO DiamondRings
INSERT INTO DiamondRings (RingStyle, NameRings, Category, BrandName, Material, CenterGemstone, CenterGemstoneShape, Width, CenterDiamondDimension, Weight, GemstoneWeight, CenterDiamondColor, CenterDiamondClarity, CenterDiamondCaratWeight, RingSize, Gender, Fluorescence, Description, ImageRings, ImageBrand, Inventory)
VALUES
--1
(
 'LR2972_WHITE_18K_RING-COLOR',
    '18k White Gold Gemstone Fashion Ring',
    'Gemstone Fashion Rings',
    'Simon G',
    '' ,
    NULL ,
    NULL ,
    0.00 ,
    0 ,
    0.00 ,
    0.00 ,
    NULL ,
    NULL ,
    NULL,
    5.00, -- Temporary value, will insert multiple sizes later
    'Womens',
    NULL,
    'A source of strength and royalty, this 18K white gold ring features .78cttw sapphires and .25cttw diamonds.' , 
    'https://cdn.jewelryimages.net/galleries/simong/LR2972_WHITE_18K_RING-COLOR.png?v=14' ,
    'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg',
    1 
),
--2
(
 'LR1038-A_WHITE-ROSE_18K_RIGHT-HAND',
	'18k White Gold Gemstone Fashion Ring' ,
	'Diamond Fashion Rings',
	'Simon G',
    '',
    NULL ,
    NULL,
    0.00 ,
    0 ,
    0.00 ,
    0.00,
    NULL,
    NULL ,
    NULL ,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL,
    'This lovely nature-inspired design is crafted from 18k rose and white gold, and contains .25 ctw of round white diamonds.', 
	'https://cdn.jewelryimages.net/galleries/simong/LR1038-A_WHITE-ROSE_18K_RIGHT-HAND.png?v=14,https://cdn.jewelryimages.net/galleries/simong/LR1038-A_WHITE-ROSE_18K_RIGHT-HAND_2.png?v=14,https://cdn.jewelryimages.net/galleries/simong/LR1038-A_WHITE-ROSE_18K_RIGHT-HAND_3.png?v=14',
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg' ,
	1 ),
--3
(
'LR1107_WHITE_18K_RIGHT-HAND',
	'18k White Gold Gemstone Fashion Ring' ,
	'Diamond Fashion Rings',
	'Simon G' ,
    '' ,
    NULL ,
    NULL ,
    0.00,
    0 ,
    0.00 ,
    0.00 ,
    NULL ,
    NULL ,
    NULL,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL ,
    'This modern, dynamic ring features an overlapping design of shiny high polished 18k white gold and rows of sparking white diamonds. The ring contains .50 ctw of round diamonds.' , 
	'https://cdn.jewelryimages.net/galleries/simong/LR1107_WHITE_18K_RIGHT-HAND.png?v=14,https://cdn.jewelryimages.net/galleries/simong/LR1107_WHITE_18K_RIGHT-HAND_2.png?v=14,https://cdn.jewelryimages.net/galleries/simong/LR1107_WHITE_18K_RIGHT-HAND_3.png?v=14',
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg' ,
	1 
),
--4
(
  'LP2231_ROSE_18K_RIGHT-HAND' ,
	'18k Rose Gold Diamond Fashion Ring' ,
	'Diamond Fashion Rings',
	'Simon G' ,
    '' ,
    NULL ,
    NULL ,
    0.00 ,
    0 ,
    0.00 ,
    0.00 ,
    NULL ,
    NULL ,
    NULL ,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL,
    'Featuring a striking intertwined design, this modern rose gold ring is set with 1.20 ctw of shimmering round cut white diamonds.', 
	'https://cdn.jewelryimages.net/galleries/simong/LP2231_ROSE_18K_RIGHT-HAND.png?v=14',
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg',
	1 
),
--5
( 'MR2458_WHITE-BROW_18K_RIGHT-HAND',
	'18k White Gold Diamond Fashion Ring' ,
	'Diamond Fashion Rings' ,
	'Simon G' ,
    '' ,
    NULL ,
    NULL ,
    0.00 ,
    0 ,
    0.00 ,
    0.00,
    NULL ,
    NULL,
    NULL ,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL,
    'This extraordinary ring contains 1.24 ctw of white round brilliant diamonds as well as 2.65 ctw of rose cut brown diamonds. Warm-toned and contemporary, this ring makes a lovely statement.', 
	'https://cdn.jewelryimages.net/galleries/simong/MR2458_WHITE-BROW_18K_RIGHT-HAND.png?v=14',
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg' ,
	1 ),
--6
('LR2535_YELLOW_18K_RIGHT-HAND' ,
	'18k Yellow Gold Diamond Fashion Ring' ,
	'Diamond Fashion Rings' ,
	'Simon G',
    '' ,
    NULL ,
    NULL ,
    0.00 ,
    0 ,
    0.00 ,
    0.00 ,
    NULL ,
    NULL ,
    NULL,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens',
    NULL ,
    'Crafted from 18k yellow gold, this wide fashion ring contains with .52 ctw of white diamonds set within repeating round and oval shapes, creating a lovely effect.', 
	'https://cdn.jewelryimages.net/galleries/simong/LR2535_YELLOW_18K_RIGHT-HAND.png?v=14' ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg' ,
	1 ),

	--7
( 'QR1029-Y_YELLOW_18K_RIGHT-HAND' ,
	'Diamond Fashion Ring' ,
	'Diamond Fashion Rings' ,
	'Simon G' ,
    '' ,
    NULL ,
    NULL ,
    0.00 ,
    0,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
    'This diamond eternity band from our stackable collection in 14K yellow gold, has alternating bezel set diamonds 0.31 ctw. and gold beads.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/QR1029-Y_YELLOW_18K_RIGHT-HAND.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--8
	( 'QR1029-R_ROSE_18K_RIGHT-HAND'  ,
	'Diamond Fashion Ring'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
    'This diamond eternity band from our stackable collection in 14K rose gold, has alternating bezel set diamonds 0.31 ctw. and gold beads.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/QR1029-R_ROSE_14K_RIGHT-HAND.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--9
	( 'QR1030_WHITE_PLAT_RIGHT-HAND'  ,
	'Diamond Fashion Ring'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL ,
   'Modern versatility, the perfect ring to stack or wear alone, available featuring .14 cttw sapphires, ruby or tsavorite and 14K white, rose or yellow gold.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/QR1030_WHITE_14K_RIGHT-HAND.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--10
	( 'MR2116-R_WHITE-ROSE_18K_RIGHT-HAND'  ,
	'18k White & Rose Gold Diamond Fashion Ring'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
   'Featuring a delicate floral design, this classically-styled white and rose gold ring is highlighted by .04 ctw of glistening round cut white diamonds.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/MR2116-R_WHITE-ROSE_18K_RIGHT-HAND.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--11
	( 'MR1174_WHITE_PLAT_ANNIV'  ,
	'Anniversary Band'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
   'This detailed, lovely band contains .46 ctw of shining white diamonds in a detailed, vintage-inspired design.', 
	'https://cdn.jewelryimages.net/galleries/simong/MR1174_2T_18K_ANNIV.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--12
	('MR1174_WHITE_PLAT_ANNIV'  ,
	'Anniversary Band'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
   'This detailed, lovely band contains .46 ctw of shining white diamonds in a detailed, vintage-inspired design.' , 
	'https://cdn.jewelryimages.net/galleries/simong/MR1174_2T_18K_ANNIV.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--13
	('DR361_3T_18K_RIGHT-HAND'  ,
	'18k Tri-color Gold Diamond Fashion Ring'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5 , -- Temporary value, will insert multiple sizes later
    'Womens' ,
    NULL ,
   'This modern tri-tone 18k gold ring features an overlapping design containing .73 ctw of shining white round brilliant diamonds.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/DR361_3T_18K_RIGHT-HAND.png?v=14,https://cdn.jewelryimages.net/galleries/simong/DR361_3T_18K_RIGHT-HAND_2.png?v=14,https://cdn.jewelryimages.net/galleries/simong/DR361_3T_18K_RIGHT-HAND_3.png?v=14' ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1  ),
	--14
	(  'MR1780-A_2T_18K_RIGHT-HAND'  ,
	'Diamond Fashion Ring'  ,
	'Diamond Fashion Rings'  ,
	'Simon G'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    0.00  ,
    NULL  ,
    NULL  ,
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens'  ,
    NULL  ,
   'This overlapping two-tone 18k gold ring has a modern look with .15 ctw of white diamonds.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/MR1780-A_2T_18K_RIGHT-HAND.png?v=14'  ,
	'https://collections.jewelryimages.net/collections_logos/Simon-G-logo_white.jpg'  ,
	1 ),
	--15
	( 'K198-38312'  ,
	'14KT Gold Ladies Wedding Ring'  ,
	'Women`s Wedding Bands'  ,
	'Allison Kaufman'  ,
    ''  ,
    NULL  ,
    NULL  ,
    0.00  ,
    0  ,
    0.00  ,
    1.82  ,
    NULL  ,
    'SI1',
    NULL  ,
    6.5  , -- Temporary value, will insert multiple sizes later
    'Womens',
    NULL,
   'This overlapping two-tone 18k gold ring has a modern look with .15 ctw of white diamonds.'  , 
	'https://cdn.jewelryimages.net/galleries/simong/MR1780-A_2T_18K_RIGHT-HAND.png?v=14' ,
	'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
	1  ),
	--16
	( 'K282-91085-14KW'  ,
	'14KT Gold Ladies Wedding Ring'  ,
	'Rings'  ,
	'Allison Kaufman'  ,
	''  ,
	'Yellow Diamond'  ,
	null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.24  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'This overlapping two-tone 18k gold ring has a modern look with .15 ctw of white diamonds.'  , 
		'https://cdn.jewelryimages.net/galleries/simong/MR1780-A_2T_18K_RIGHT-HAND.png?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--17
		('K282-92849-14KY'  ,
		'14KT Gold Semi-Mount Engagement Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		null  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.25  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null ,
		'Womens'  ,
		null  ,
		'LDS SEMI DIA RG .25 TW - HOLDS 0.75 CTR' , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/H300-93120-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1),
		--18
		( 'F282-93767-14KW'  ,
		'14KT Gold Ladies Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Amethyst'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		1.98  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS RG 1.98 TW AMETHYST 2.24 TGW', 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/E300-94038-W.jpg?v=14',
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg',
		1  ),
		--19
		('C282-98304-14KY'  ,
		'14KT Gold Ladies Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman' ,
		''  ,
		'Ruby'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.55  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS RG .55 TW RUBY 1.07 TGW (6X4MM RUBY)'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/B300-98575-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--20
		('F282-05567-14KW'  ,
		'14KT Gold Ladies Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman' ,
		'14KT Gold Ladies'  ,
		'Diamond'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.03  ,
		'G'  ,
		null  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS DIA RG .03 BAG .18 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/E300-05838-W.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--21
		('L282-93758-14KW'  ,
		'14KT Gold Ladies Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		'14K White Gold'  ,
		'Blue Topaz'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		2.46  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS RG 2.46 TW LONDON BLUE TOPAZ 2.72 TGW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/K300-94029-W.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--22
		( 'L282-92876-14KY'  ,
		'Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Garnet'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		1.40  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS RG 1.40 GARNET 1.56 TGW (8X6MM GAR)'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/K300-93147-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--23
		( 'C282-98358-14KY'  ,
		'Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Diamond'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.25  ,
		'G'  ,
		null  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS DIA RG .25 BAG .30 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/B300-98629-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--24
		('H282-95622-14KW'  ,
		'4KT Gold Ladies Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Tanzanite'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		1.02  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS RG 1.02 TANZANITE 1.30 TGW (8X6 OVAL)'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/G300-95893-W.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--25
		('F282-95631-14KY'  ,
		'Diamond Ring'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		null  ,
		null  ,
		0.00  ,
		0 ,
		0.00  ,
		1.20   ,
		'G'  ,
		'SI1',
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS DIA WED RG 1.20 TW EMERALD CUTS'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/E300-95902-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--26
		('L282-98349-14KY'  ,
		'Wrap/Guard'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Diamond'  ,
		null  ,
		0.00  ,
		0 ,
		0.00  ,
		0.22   ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'GUARD RG .22 BAG .38 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/K300-98620-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--27
		( 'E282-98313-14KY',
		'Wrap/Guard'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		'Diamond'  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.12   ,
		'G'  ,
		null  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS DIA RG .12 BAG .14 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/D300-98584-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg',
		1 ),
		--28
		('B282-92895-14KW'  ,
		'Wrap/Guard'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		null  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.16  ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'ENHANCER .16 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/D300-98584-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  ),
		--29
		('B282-91968-14KW'  ,
		'Wrap/Guard'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		null  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		1.00   ,
		'G'  ,
		null  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS DIA RG 1.00 TW'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/A300-92239-W.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg' ,
		1  ),
		--30
		('F282-97449-14KW'  ,
		'Wrap/Guard'  ,
		'Rings'  ,
		'Allison Kaufman'  ,
		''  ,
		null  ,
		null  ,
		0.00  ,
		0  ,
		0.00  ,
		0.50   ,
		'G'  ,
		'SI1'  ,
		null  ,
		null  ,
		'Womens'  ,
		null  ,
		'LDS SEMI DIA RG .50 TW - HOLDS 1.00 CTR'  , 
		'https://cdn.jewelryimages.net/galleries/allisonkaufman/E300-97720-Y.jpg?v=14'  ,
		'https://collections.jewelryimages.net/collections_logos/allison-kaufman-logo-white-2021.jpg'  ,
		1  );

-- Chèn dữ liệu vào bảng BridalAccessory
DECLARE @DiamondRingsID2 INT = 1;
WHILE @DiamondRingsID2 <= 30
BEGIN
    DECLARE @MaterialID2 INT = 1;
    WHILE @MaterialID2 <= 5
    BEGIN
        DECLARE @RingSizeID2 INT = 1;
        WHILE @RingSizeID2 <= 13
        BEGIN
            DECLARE @PriceID2 INT = 1;
            WHILE @PriceID2 <= 5
            BEGIN
                INSERT INTO RingsAccessory (DiamondRingsID, MaterialID, RingSizeID, PriceID)
                VALUES (@DiamondRingsID2, @MaterialID2, @RingSizeID2, @PriceID2);
                
                SET @PriceID2 = @PriceID2 + 1;
            END;
            SET @RingSizeID2 = @RingSizeID2 + 1;
        END;
        SET @MaterialID2 = @MaterialID2 + 1;
    END;
    SET @DiamondRingsID2 = @DiamondRingsID2 + 1;
END;

COMMIT TRANSACTION;



PRINT 'DiamondRings table created';

	--7
	CREATE TABLE Orders (
		OrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		AccountID INT,
		OrderDate DATE,
		Quantity INT,
		OrderStatus VARCHAR(50),
		TotalPrice DECIMAL(10, 2),
		FOREIGN KEY (AccountID) REFERENCES Account(AccountID)
	);

	PRINT 'Orders table created';
	--8
	CREATE TABLE Transactions (
		PaymentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		OrderID INT,
		PaymentAmount DECIMAL(10, 2),
		Method VARCHAR(50),
		PaymentDate DATETIME,
		FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
	);

	PRINT 'Transactions table created';
	--9
	CREATE TABLE ScheduleAppointment (
		NoSchedule INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		FirstName NVARCHAR(50),
		LastName NVARCHAR(50),
		Email VARCHAR(100),
		PhoneNumber VARCHAR(20),
		DesiredDay DATE,
		DesiredTime TIME,
		Message NVARCHAR(MAX),
		DiamondID INT,
		BridalID INT,
		DiamondRingsID INT,
		DiamondTimepiecesID INT,
		AccountID int,
		FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
		FOREIGN KEY (DiamondID) REFERENCES Diamond(DiamondID),
		FOREIGN KEY (BridalID) REFERENCES Bridal(BridalID),
		FOREIGN KEY (DiamondRingsID) REFERENCES DiamondRings(DiamondRingsID),
		FOREIGN KEY (DiamondTimepiecesID) REFERENCES DiamondTimepieces(DiamondTimepiecesID)
	);

	PRINT 'ScheduleAppointment table created';
	--10
	CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderID INT NOT NULL,
    DiamondID INT NULL,
    BridalID INT NULL,
    DiamondRingsID INT NULL,
    DiamondTimepiecesID INT NULL,
    DeliveryAddress NVARCHAR(100),
    AttachedAccessories VARCHAR(100),
    Shipping VARCHAR(100),
    OrderStatus VARCHAR(50) NOT NULL,
    MaterialID INT NULL,
    RingSizeID INT NULL,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    PhoneNumber NVARCHAR(15),
    RequestWarranty VARCHAR(50),
    WarrantyStatus VARCHAR(50),
    CONSTRAINT FK_OrderDetails_Order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderDetails_Diamond FOREIGN KEY (DiamondID) REFERENCES Diamond(DiamondID),
    CONSTRAINT FK_OrderDetails_Bridal FOREIGN KEY (BridalID) REFERENCES Bridal(BridalID),
    CONSTRAINT FK_OrderDetails_DiamondRings FOREIGN KEY (DiamondRingsID) REFERENCES DiamondRings(DiamondRingsID),
    CONSTRAINT FK_OrderDetails_DiamondTimepieces FOREIGN KEY (DiamondTimepiecesID) REFERENCES DiamondTimepieces(DiamondTimepiecesID)
);


	PRINT 'OrderDetails table created';

	--11
	-- Create Certificate table
CREATE TABLE Certificate (
    CertificateID INT IDENTITY(1,1) PRIMARY KEY,
    InspectionDate DATE,
    ClarityGrade VARCHAR(50),
    ShapeAndCuttingStyle VARCHAR(50),
    GIAReportNumber VARCHAR(50),
    Measurements VARCHAR(100),
    CaratWeight DECIMAL(5, 2),
    ColorGrade VARCHAR(50),
    SymmetryGrade VARCHAR(50),
    CutGrade VARCHAR(50),
    PolishGrade VARCHAR(50),
    Fluorescence VARCHAR(50),
    ImageLogoCertificate VARCHAR(MAX),
    BridalID INT UNIQUE,  
    DiamondTimepiecesID INT UNIQUE,
    DiamondRingsID INT UNIQUE,
    DiamondID INT UNIQUE,
  
    --FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails(OrderDetailID),
    --FOREIGN KEY (DiamondID) REFERENCES Diamond(DiamondID),
   -- FOREIGN KEY (BridalID) REFERENCES Bridal(BridalID),
    --FOREIGN KEY (DiamondTimepiecesID) REFERENCES DiamondTimepieces(DiamondTimepiecesID),
    --FOREIGN KEY (DiamondRingsID) REFERENCES DiamondRings(DiamondRingsID)
);
-- Add foreign key constraint for DiamondID
ALTER TABLE Certificate
ADD CONSTRAINT FK_Certificate_Diamond FOREIGN KEY([DiamondID]) 
    REFERENCES [Diamond]([DiamondID]);

ALTER TABLE Certificate
ADD CONSTRAINT FK_Certificate_Bridal FOREIGN KEY([BridalID]) 
    REFERENCES [Bridal]([BridalID]);

ALTER TABLE Certificate
ADD CONSTRAINT FK_Certificate_Rings FOREIGN KEY([DiamondRingsID]) 
    REFERENCES [DiamondRings]([DiamondRingsID]);

ALTER TABLE Certificate
ADD CONSTRAINT FK_Certificate_Timepieces FOREIGN KEY([DiamondTimepiecesID]) 
    REFERENCES [DiamondTimepieces]([DiamondTimepiecesID]);

-- Create unique indexes for nullable columns
CREATE UNIQUE INDEX UQ_Certificate_DiamondTimepieces ON Certificate (DiamondTimepiecesID) WHERE DiamondTimepiecesID IS NOT NULL;
CREATE UNIQUE INDEX UQ_Certificate_DiamondRings ON Certificate (DiamondRingsID) WHERE DiamondRingsID IS NOT NULL;
CREATE UNIQUE INDEX UQ_Certificate_Bridal ON Certificate (BridalID) WHERE BridalID IS NOT NULL;
CREATE UNIQUE INDEX UQ_Certificate_Diamond ON Certificate (DiamondID) WHERE DiamondID IS NOT NULL;
-- Print message indicating table creation
PRINT 'Certificate table created';


	--12
	CREATE TABLE WarrantyReceipt (
		ReportNo VARCHAR(20) PRIMARY KEY,
		Descriptions VARCHAR(MAX),
		Date DATE,
		PlaceToBuy VARCHAR(255),
		Period DATE, -- This will store the expiration date
		WarrantyType VARCHAR(150),
		WarrantyConditions VARCHAR(MAX),
		AccompaniedService VARCHAR(MAX),
		Condition VARCHAR(MAX),
		OrderDetailID INT unique null,
		--FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails(OrderDetailID)
	);


	ALTER TABLE WarrantyReceipt
ADD CONSTRAINT FK_WarrantyReceipt_OrderDEtails FOREIGN KEY(OrderDetailID) 
    REFERENCES OrderDetails (OrderDetailID);

	PRINT 'WarrantyReceipt table created';
	--13
	CREATE TABLE Voucher (
		VoucherID INT IDENTITY(1,1) PRIMARY KEY,
		VoucherName VARCHAR(MAX),
		UsagedQuantity INT,
		TotalQuantity INT,
		Type VARCHAR(MAX),
		ValidFrom DATE,
		ExpirationDate DATE,
		Condition NVARCHAR(MAX),
		 Prerequisites DECIMAL(10,2),
		Discount FLOAT
	);

	PRINT 'Voucher table created';

	--14
	CREATE TABLE VoucherListInOrder(
		OrderID INT NOT NULL PRIMARY KEY,
		VoucherID INT,
		FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
		FOREIGN KEY (VoucherID) REFERENCES Voucher(VoucherID)
	);

	--15
	CREATE TABLE Feedback (
    FeedbackID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
    AccountID INT,
    DiamondID INT,
    BridalID INT,
    DiamondRingsID INT,
    DiamondTimepiecesID INT,
    Content NVARCHAR(MAX),
    Rating INT,
	OrderDetailID INT,
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID),
    FOREIGN KEY (DiamondID) REFERENCES Diamond(DiamondID),
    FOREIGN KEY (BridalID) REFERENCES Bridal(BridalID),
    FOREIGN KEY (DiamondRingsID) REFERENCES DiamondRings(DiamondRingsID),
    FOREIGN KEY (DiamondTimepiecesID) REFERENCES DiamondTimepieces(DiamondTimepiecesID),
	FOREIGN KEY (OrderDetailID) REFERENCES OrderDetails(OrderDetailID)

);


	PRINT 'VoucherListInOrder table created';

	-- Insert Admin roles (5 lines)
	INSERT INTO Roles (RoleName, Transportation, BonusPoints, NumberOfOrdersDelivered, Rank) 
	VALUES 

	('Admin', NULL, NULL, NULL, NULL),
	('Admin', NULL, NULL, NULL, NULL),
	('Admin', NULL, NULL, NULL, NULL),
	('Admin', NULL, NULL, NULL, NULL),
	('Admin', NULL, NULL, NULL, NULL),
	--customer
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 55, NULL, 'Gold'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 60, NULL, 'Platinum'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 50, NULL, 'Silver'),
	('Customer', NULL, 55, NULL, 'Gold'),

	--manager
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),
	('Manager', NULL, NULL, NULL, NULL),

	--sale
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),
	('Sale', NULL, NULL, NULL, NULL),

	--delivery
	('Delivery', 'Truck', NULL, 10, NULL),
	('Delivery', 'Motorbike', NULL, 10, NULL),
	('Delivery', 'Bicycle', NULL, 4, NULL),
	('Delivery', 'Truck', NULL, 20, NULL),
	('Delivery', 'Truck', NULL, 35, NULL),
	('Delivery', 'Motorbike', NULL, 7, NULL),
	('Delivery', 'Motorbike', NULL, 9, NULL),
	('Delivery', 'Bicycle', NULL, 3, NULL),
	('Delivery', 'Truck', NULL, 25, NULL),
	('Delivery', 'Truck', NULL, 30, NULL);

	INSERT INTO Account(
		  [FirstName]
		  ,[LastName]
		  ,[Gender]
		  ,[Birthday]
		  ,[Password]
		  ,[Email]
		  ,[PhoneNumber]
		  ,[Address]
		  ,[Country]
		  ,[City]
		  ,[Province]
		  ,[PostalCode]
		  ,[RoleID]
		  ,[Status]
		  ,[Image]) 
	VALUES 
	--admin
	(N'Đan', N'Huy', N'Nam', '2003-10-19', 'huy1', 'testuserpaypaldiamondshop@gmail.com', 0869872830, N'Tân Trụ - Long An', N'Việt Nam', N'TP. Tân An', N'Long An', 85000, 1, 'Active', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLzpZa8oMjUzdnjd2SsDQASA2DgnGs4AVEmQ&usqp=CAU'),
	(N'Anh', N'Kiệt', N'Nam', '2003-12-4', 'kiet1', 'kietvase172259@fpt.edu.vn', 0987123222, N'Thủ Dầu Một - Bình Dương', N'Việt Nam', N'TP. Thủ Dầu Một', N'Bình Dương', 45666, 2, 'Active', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQF3A5HVX3h4G0x2RXS9fzvlIC-Ea1x7wUc3A&usqp=CAU'),
	(N'Đăng', N'Khoa', N'Nam', '2003-5-7', 'khoa1', 'khoahdse172091@fpt.edu.vn', 0635765189, N'Xã Tân Phú Trung - huyện Củ Chi', N'Việt Nam', N'TP.HCM', N'Tiền Giang', 12333, 3, 'Active', 'https://i0.wp.com/www.appletips.nl/wp-content/uploads/2020/06/facebook-avatar-icon.png?fit=1024%2C1024&ssl=1'),
	(N'Tuấn', N'Kiệt', N'Nam', '2003-3-3', 'kiet1', 'KietNTSE172079@fpt.edu.vn', 0987654321, N'Quận 9 - Thủ Đức', N'Việt Nam', 'TP. Thủ Đức', N'Quận 9', 54666, 4, 'Active', 'https://www.nj.com/resizer/v2/SJGKVE5UNVESVCW7BBOHKQCZVE.jpg?auth=9fc9014b0e999bae584e3b88d87251a96fcbece8c91770c970915a6615a0cb9e&width=1280&quality=90'),
	(N'Văn', N'Quân', N'Nam', '2003-4-3', 'quan1', 'QuanNVSE172057@fpt.edu.vn', 0879654123, N'huyện Củ Chi - TP.HCM', N'Việt Nam', N'TP.HCM', N'Đồng Nai', 88999, 5, 'Active', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSp8i1gMEIAijoS-R7Fifs4ZDUEDoc_qnavHw&usqp=CAU'),

	--customer
	(N'Trần', N'Văn Tuấn', N'Nam', '1975-09-15', 'tuanpassword', 'tran.tuan@gmail.com', '0908765432', N'456 Nguyễn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 6, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/448713971_2730821840406047_8585939182344482807_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGPkueAcnHXBbR3L35EwoKy_ipa3SK4Mqv-KlrdIrgyqzp2y7JRqwd720jt46uojGTNX8XxRQ1qOCiynDqVGw0W&_nc_ohc=T1zsNe3YK_8Q7kNvgE6H2Jo&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYBy2_qVuEC2U7dTBqk9zBrZBio6YZV1m-POtkdKQu3EkA&oe=66917286'),
	(N'Phạm', N'Thị Lan', N'Nữ', '1992-12-24', 'lanpassword', 'pham.lan@gmail.com', '0934567890', N'789 Phan Chu Trinh, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 7, 'Activate', 'https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/imageAccount%2F378874537_2537598763061690_2547914778089286456_n.jpg?alt=media&token=1bf83893-9eb6-4740-be34-0bb607aae9c8'),
	(N'Lê', N'Đức Anh', N'Nam', '1980-07-07', 'anhpassword', 'le.duc.anh@gmail.com', '0918765432', N'321 Lý Thường Kiệt, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 8, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/445757040_2711857682302463_3658796846711854775_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHX5jWwko1OC923N6cWBrbD1XOlN3j7dJLVc6U3ePt0ku_U8e2X6EvKMThOMW5Ry3omPsrJc0MbeNE3TRT9cK_R&_nc_ohc=tZBt-ukUEaYQ7kNvgHGkwHR&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYBE2eAEu06I8_2lYY7gW_y-ke_g9bd_qC8eqaQUOPb9iw&oe=669181AB'),
	(N'Hoàng', N'Minh Châu', N'Nữ', '1985-03-18', 'chaupassword', 'hoang.chau@gmail.com', '0923456789', N'654 Lê Duẩn, Thanh Khê', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 9, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/433882419_2667282796759952_7289079833657097850_n.jpg?stp=cp6_dst-jpg&_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGRiuhVHjzRjNNmkuQNq_um3pLhxY3QrwbekuHFjdCvBmcaKK9pQgq6JGRG9BKH_mGlTD67-QKTiTNIK71im_VV&_nc_ohc=kK16wspFMqcQ7kNvgFnRhxN&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYBeg7zdKe5F8V1bRpbLPwV4XYEd-UE9dz0xgTolcGDvzg&oe=669170B1'),
	(N'Bùi', N'Quang Huy', N'Nam', '1990-10-25', 'huypassword', 'bui.huy@gmail.com', '0987654321', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 10, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/433861860_2667282786759953_1280919665583937122_n.jpg?stp=cp6_dst-jpg&_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEd2QLYBzCF6VErLruy0918UExPHGLzC1BQTE8cYvMLUIJeGcIQkkZRFJMMc6fpJQsdisq78M04Q96jHHqnQBOK&_nc_ohc=KT743tMdwt0Q7kNvgG9SrEZ&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYA-_v55BHv6xUtS7NTT0OmCI0vkbu9wchCXyxeenCBIuQ&oe=66917774'),
	(N'Nguyễn', N'Thị Hoa', N'Nữ', '1982-01-30', 'hoapassword', 'nguyen.hoa@gmail.com', '0901234567', N'123 Hai Bà Trưng, Hai Bà Trưng', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 11, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/433875463_2667282746759957_2221522535566812397_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFQp0WNRgdZUbz2uSlIhKwH9N1Git-LCSn03UaK34sJKXD5kLPl25ijTuEtfAEBVwwMUTBKorxlen673zN4cXh2&_nc_ohc=eLxCH-ZpQjwQ7kNvgH_9CAD&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYDHbxBSpBOBApjqlGc-YFqQA2vk17UJhXhXkWEaNIp3aA&oe=66917D71'),
	(N'Võ', N'Duy Khánh', N'Nam', '1983-11-12', 'khanhpassword', 'vo.khanh@gmail.com', '0976543210', N'456 Trần Hưng Đạo, Sơn Trà', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 12, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/433875463_2667282746759957_2221522535566812397_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFQp0WNRgdZUbz2uSlIhKwH9N1Git-LCSn03UaK34sJKXD5kLPl25ijTuEtfAEBVwwMUTBKorxlen673zN4cXh2&_nc_ohc=eLxCH-ZpQjwQ7kNvgH_9CAD&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYDHbxBSpBOBApjqlGc-YFqQA2vk17UJhXhXkWEaNIp3aA&oe=66917D71'),
	(N'Đỗ', N'Thanh Phong', N'Nam', '1987-05-06', 'phongpassword', 'do.phong@gmail.com', '0910987654', N'789 Nguyễn Văn Cừ, Long Biên', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 13, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/431522101_2663715710449994_6445406936723742692_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEWn3NGiD7VleSJlvDIuManY8ABJakFTG1jwAElqQVMbbBxRd7gFsCA7ZDATdOIeyQPzeBq8CK03586GxRAF2sj&_nc_ohc=7tjmq4n7DhsQ7kNvgEXdxuv&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYByX6joLQNhfTCCq_YjkKUNA2LaxEFp16PmKAvc4gmfxg&oe=6691941E'),
	(N'Lê', N'Thúy Linh', N'Nữ', '1995-08-22', 'linhpassword', 'le.linh@gmail.com', '0932109876', N'321 Trần Quốc Toản, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 14, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/431522101_2663715710449994_6445406936723742692_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEWn3NGiD7VleSJlvDIuManY8ABJakFTG1jwAElqQVMbbBxRd7gFsCA7ZDATdOIeyQPzeBq8CK03586GxRAF2sj&_nc_ohc=7tjmq4n7DhsQ7kNvgEXdxuv&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYByX6joLQNhfTCCq_YjkKUNA2LaxEFp16PmKAvc4gmfxg&oe=6691941E'),
	(N'Đặng', N'Thị Thu', N'Nữ', '1991-11-11', 'thupassword', 'dang.thu@gmail.com', '0943210987', N'654 Bạch Đằng, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 15, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/433964250_2663715667116665_1595292521221684024_n.jpg?stp=cp6_dst-jpg&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEeoXfNv_WI-VU7tKAUthFfuAkieO_qtX24CSJ47-q1fWEjcALhPzdkU9MoxLEvsV2J-4I8ULNXkIeM5v3j-sYF&_nc_ohc=J9JG48UGzFgQ7kNvgFyyvh7&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYDbHPe9Z7k5kyojaiDn3O5bS7Q6NohRmIO4teZ6v1wMIw&oe=66916FFA'),
	(N'Phan', N'Minh Tuấn', N'Nam', '1984-02-14', 'tuanpassword', 'phan.tuan@gmail.com', '0967890123', N'987 Điện Biên Phủ, Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 16, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/433898966_2663715650450000_1938284654443732089_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEHB2fwRLOZU490LMsHpSc_SIj-jCmJlbdIiP6MKYmVt7T7B70nQbI5eK4edsDHGvED7AdlwMr2aRJSm1YSqs9A&_nc_ohc=BGnJOs3fP7cQ7kNvgGRodoa&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYBQSjUDvhveEJlCHP6_TAg3Xbfz8dcUJrmlspAwHT6yRQ&oe=66916CDE'),
	(N'Trần', N'Thanh Nga', N'Nữ', '1993-07-19', 'ngapassword', 'tran.nga@gmail.com', '0912345678', N'432 Hai Bà Trưng, Hoàn Kiếm', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 17, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/428630980_2644747225680176_3098482807645560775_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEXwtuajLRdxIdD16NhYoCuiZrKgRig8_iJmsqBGKDz-Purb1cDjBG0dk-0jYaEgW1bLJxV7izGcjYEfBAd8OOn&_nc_ohc=zEmtvlUvMG8Q7kNvgFObhNN&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYDQgc0lT6SwK2mcuFkIuyEceG1zEJtny1yn6IJPhW3dEA&oe=66916940'),
	(N'Vũ', N'Quang Minh', N'Nam', '1986-09-22', 'minhpassword', 'vu.minh@gmail.com', '0987654321', N'765 Lê Thánh Tôn, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 18, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/419240621_2618972904924275_3604051801257929171_n.jpg?stp=cp6_dst-jpg&_nc_cat=102&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFzmGN-WBsgg-Fgs9mKqrNpjvLyA_12sKCO8vID_XawoAMf2DDlLlxWdx1yj0dn_pKX3JulB4kITUb72bfB3oRm&_nc_ohc=xp-cFNbIT7gQ7kNvgFXA53q&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYBWK3jdbtxWVT50bUjgzUgIomnDTXjo6rgjpjT6r79LDw&oe=66918044'),
	(N'Ngô', N'Thị Hương', N'Nữ', '1989-03-03', 'huongpassword', 'ngo.huong@gmail.com', '0923456789', N'567 Tôn Đức Thắng, Quận 3', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 19, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/411052307_2599734146848151_9146141640618930225_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeH6Vm-31oYDHAooZx7ZyqG7ouyfs6WQVNqi7J-zpZBU2mlpqut3OPUCfbYfhDw1h3d_5li-xuYDxupN8y7X33FZ&_nc_ohc=80YLNHdO5JAQ7kNvgFT26yH&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYCCwN6GxW9Ut_mkEpp10jYBGjoZ6Oox_lG1FSzVi0ipwA&oe=66918EEA'),
	(N'Lê', N'Minh Đức', N'Nam', '1978-12-05', 'ducpassword', 'le.duc@gmail.com', '0912345678', N'789 Trần Nhân Tôn, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 20, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/411052307_2599734146848151_9146141640618930225_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeH6Vm-31oYDHAooZx7ZyqG7ouyfs6WQVNqi7J-zpZBU2mlpqut3OPUCfbYfhDw1h3d_5li-xuYDxupN8y7X33FZ&_nc_ohc=80YLNHdO5JAQ7kNvgFT26yH&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYCCwN6GxW9Ut_mkEpp10jYBGjoZ6Oox_lG1FSzVi0ipwA&oe=66918EEA'),
	(N'Nguyễn', N'Thị Bích', N'Nữ', '1987-06-07', 'bichpassword', 'nguyen.bich@gmail.com', '0943210987', N'321 Nguyễn Văn Trỗi, Phú Nhuận', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 21, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/412856245_2599734110181488_9136811645201222109_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFsSzaJgC2bbND3Rxu2PDm80UH5xGeFvvHRQfnEZ4W-8RwUzaSRjBIEx4Lb48BpJK_DxtjgfIIRYQF5PLB_mdsO&_nc_ohc=w4fI-DBPQhYQ7kNvgH4rByV&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYBNIWL4ZWz_baRimWX64SwYzN4KSgZwvB1doe-HyVBLZg&oe=66915C9A'),
	(N'Trần', N'Quốc Bảo', N'Nam', '1981-04-14', 'baopassword', 'tran.bao@gmail.com', '0976543210', N'654 Trần Quang Khải, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 22, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/412711240_2599734096848156_2142569318868099859_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEZC1x9jG0cBwIokPv5DuaqVOt9qo8XnXlU632qjxedefu8v_r-lny5-DiT4S7tcpk0Y9ismJNWzqv7IoXdP7y9&_nc_ohc=g3GdbaYUVsAQ7kNvgH6nyyY&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYBFiKV9Corwebvt_6MYAd0GTXQg1a08lzMwO8USKG7nRA&oe=6691876C'),
	(N'Phạm', N'Ngọc Lan', N'Nữ', '1990-05-15', 'lanpassword', 'pham.lan@gmail.com', '0932109876', N'987 Lê Hồng Phong, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 23, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/407422563_2587773924710840_6540293562149420768_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEscgLN3d9tqOKzQ3O9aEml5mBkRRMHXJPmYGRFEwdckw6JgUZodaFAt7o_TRD6FgqGtLynqJiUr6kQ-Fn41VHY&_nc_ohc=XoJsc--F5qYQ7kNvgEzX5Op&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYB4F-_b5xwU4LH1p2GVfSf9F8nOQ-p6XqINOW2oEa-D1w&oe=66917D2A'),
	(N'Lê', N'Thị Hồng', N'Nữ', '1992-10-28', 'hongpassword', 'le.hong@gmail.com', '0910987654', N'123 Võ Văn Tần, Quận 3', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 24, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/407746066_2587773911377508_6469217727275570084_n.jpg?stp=cp6_dst-jpg&_nc_cat=106&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG7ZBUtnZLg07rsARuEEzLnwTyTPS3covzBPJM9Ldyi_KfuBSPXlPtTq4D_rzRhTEFcp4gp45adSDhub8-LLREM&_nc_ohc=dB-19bo7MIgQ7kNvgGt4OeE&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYArZyqdjiUir82ZVWuiWjDImaVtVVqTgsoNvur-fQX7yw&oe=669182B4'),
	(N'Hồ', N'Thị Lệ', N'Nữ', '1985-02-17', 'lepassword', 'ho.le@gmail.com', '0912345678', N'123 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 25, 'Activate', 'https://scontent.fsgn8-1.fna.fbcdn.net/v/t39.30808-6/407421464_2587773844710848_7417205853269726874_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGBiFlTqWEHCp-iXu0zOOYQ1zDqGMxU_X_XMOoYzFT9f_YC6f78ahXRg2iqYVQEIEK7aF1mW4FBBJ_P6bmJ51OL&_nc_ohc=DKuP6LrWQz8Q7kNvgHKmV3Z&_nc_zt=23&_nc_ht=scontent.fsgn8-1.fna&oh=00_AYBo_qBnmhkQ3-hn6ToIcaqwk5Gtzu7whWQJNhMaoMG9JA&oe=669167E3'),
	(N'Đặng', N'Thành', N'Nam', '1983-11-12', 'thanhpassword', 'dang.thanh@gmail.com', '0987654321', N'456 Nguyễn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 26, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/406037586_2583974731757426_443120397873545022_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeE6pqwmiCT1qj5bQgSK2S6kFnHRbOg2jzcWcdFs6DaPN02tWSxNXLeGuLReShbm3l5wjr-jorVY3R3pNJ9yJib8&_nc_ohc=nxE2L-8YcpYQ7kNvgEeijOM&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYBz4kcBJINjwT9G_z9tckYmCT7nguyQWgkJv-1QyNJExQ&oe=66917DE5'),
	(N'Trương', N'Minh Khang', N'Nam', '1990-08-19', 'khangpassword', 'truong.khang@gmail.com', '0934567890', N'789 Phan Chu Trinh, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 27, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/405772885_2583974718424094_9079373289776725887_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGKyO5pL5B5hS5nog8CubJl5cs5bkLAxVflyzluQsDFV3Qwp9j_Ke2QiMXpFsGpbeg8Qk6BO2Wi_EQDts5NyX2r&_nc_ohc=gsQOeHeaJ8AQ7kNvgGAtNiU&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYAQVDVYRxBq7uT_1QqzzFyqVJMMoCfSBLAIdzcfQWc2KA&oe=6691823F'),
	(N'Tô', N'Mai Hương', N'Nữ', '1981-03-25', 'huongpassword', 'to.huong@gmail.com', '0918765432', N'321 Lý Thường Kiệt, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 28, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/405773944_2583974678424098_4731396971556615348_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEZKFheAjffSH_Ra5IK-mhY86AXB9wxqETzoBcH3DGoRAT6rC5EHSn50_ge0DuIYu3KcFaqFoF4tKAxYueS3dkB&_nc_ohc=RrROmIyazqgQ7kNvgHpq5vG&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYB-KALmEbelt6wMSIPgdkImkADCYK78bJoDfQ6dFdc-Cw&oe=669177EC'),
	(N'Tạ', N'Thị Bích Ngọc', N'Nữ', '1987-09-10', 'ngocpassword', 'ta.ngoc@gmail.com', '0923456789', N'654 Lê Duẩn, Thanh Khê', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 29, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/405761549_2583974668424099_1562831122783857137_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEcX1O5w-5ltm6KogpUDgGbK6iu6cG3Sz8rqK7pwbdLPzMFRed4KuiaszqEnFftmsP9jeuInbZniMW5nE-XwqM6&_nc_ohc=Z2BN3zpyuYMQ7kNvgHdZ_bR&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYCJmbFTaEmciMhkSSgpHAH-NRYUtZetpgvQ5parfgAmAQ&oe=66917248'),
	(N'Phạm', N'Quang Bình', N'Nam', '1992-06-15', 'binhpassword', 'pham.binh@gmail.com', '0987654321', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 30, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/387768885_2555593427928890_8259934399634570146_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuVsQjRQOwbSpB2gl1yUsveP3Ibi0r2-94_chuLSvb76U1kv7fwdvgXpxQUpkQVCs5qqeAuqB-nRe9Gg5UOxus&_nc_ohc=gr22EkEgYmgQ7kNvgFjfmtn&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYCH_5zZfe2o4jcF-e9S3yNMB_4p-NkefB4dmZ83NwVNNA&oe=66918C48'),
	(N'Nguyễn', N'Thị Kim', N'Nữ', '1989-04-12', 'kimpassword', 'nguyen.kim@gmail.com', '0901234567', N'123 Hai Bà Trưng, Hai Bà Trưng', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 31, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/387784605_2555593347928898_4524030981173192336_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG2e5Cblc5TIj6JE16nRO9P6Sp5EcI-wcbpKnkRwj7BxhNlfJ7nOMXHDGKvU44v9SljD1-y-dnYL3-MibcdsJt4&_nc_ohc=jDr5mzMMfEUQ7kNvgH5l4lB&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYB7prH7ynHIG5OcUtVxUNLfv26XLiQ2oD3Q672TuywopA&oe=6691751D'),
	(N'Lý', N'Thị Ngọc', N'Nữ', '1993-07-19', 'ngocpassword', 'ly.ngoc@gmail.com', '0976543210', N'456 Trần Hưng Đạo, Sơn Trà', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 32, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/387771246_2555593314595568_7641235705724422595_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHtBkSw7vPwdg9kmOH4DLB0BDa4seS_b_0ENrix5L9v_WOYs089vk8DCRiUzhdMZof3pCkIIuCP499MkUDdRQ4m&_nc_ohc=mBmVBPTi-1oQ7kNvgFQ5SG_&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYAbWUs-MN4VykisUi5vwPsTa_1C8U0T_p5SK5m608mRyw&oe=669171E1'),
	(N'Đinh', N'Minh Thu', N'Nữ', '1980-02-15', 'thupassword', 'dinh.thu@gmail.com', '0910987654', N'789 Nguyễn Văn Cừ, Long Biên', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 33, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/387771246_2555593314595568_7641235705724422595_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHtBkSw7vPwdg9kmOH4DLB0BDa4seS_b_0ENrix5L9v_WOYs089vk8DCRiUzhdMZof3pCkIIuCP499MkUDdRQ4m&_nc_ohc=mBmVBPTi-1oQ7kNvgFQ5SG_&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYAbWUs-MN4VykisUi5vwPsTa_1C8U0T_p5SK5m608mRyw&oe=669171E1'),
	(N'Tran', N'Hoàng Nam', N'Nam', '1991-08-08', 'nampassword', 'tran.nam@gmail.com', '0932109876', N'321 Trần Quốc Toản, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 34, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/387780066_2555593304595569_4535338480836826377_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHx1mFmQAjy7YxU_V7iuM7h_GOVkwy7Ouf8Y5WTDLs655VzUJadxT-d5OY-Zq9ERRe8Bj3Sqs6HezYZTidhXu4B&_nc_ohc=ZwPYYwF9cIsQ7kNvgFOI7oS&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYCGWLM1jincbzCg0plY2_njt6LifwrFtveHgbguZbhLMw&oe=66916DAD'),
	(N'Hoàng', N'Thị Hà', N'Nữ', '1985-05-18', 'hapassword', 'hoang.ha@gmail.com', '0943210987', N'654 Bạch Đằng, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 35, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/383785488_2546005805554319_8762145805320805535_n.jpg?stp=cp6_dst-jpg&_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeF9RPedU9Bk87tHNFcNmZK6SGrocyW-cndIauhzJb5ydyvRM9FQNXGd8Y-7W-v6kPr721H9L6VjgwnzCNWY_QBP&_nc_ohc=4R_07AVMGsMQ7kNvgHIB3nM&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYBqVpEwBEP3NBFH-UoA8yteLpxifYbvX5RFTlhoCRk1EA&oe=669185F7'),
	(N'Vũ', N'Thị Dung', N'Nữ', '1992-11-12', 'dungpassword', 'vu.dung@gmail.com', '0967890123', N'987 Điện Biên Phủ, Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 36, 'Activate', 'https://scontent.fsgn13-1.fna.fbcdn.net/v/t39.30808-6/383785488_2546005805554319_8762145805320805535_n.jpg?stp=cp6_dst-jpg&_nc_cat=111&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeF9RPedU9Bk87tHNFcNmZK6SGrocyW-cndIauhzJb5ydyvRM9FQNXGd8Y-7W-v6kPr721H9L6VjgwnzCNWY_QBP&_nc_ohc=4R_07AVMGsMQ7kNvgHIB3nM&_nc_zt=23&_nc_ht=scontent.fsgn13-1.fna&oh=00_AYBqVpEwBEP3NBFH-UoA8yteLpxifYbvX5RFTlhoCRk1EA&oe=669185F7'),
	(N'Ngô', N'Quang Hùng', N'Nam', '1988-02-24', 'hungpassword', 'ngo.hung@gmail.com', '0912345678', N'432 Hai Bà Trưng, Hoàn Kiếm', N'Việt Nam', N'Hà Nội', N'Hà Nội', '100000', 37, 'Activate', 'https://scontent.fsgn8-2.fna.fbcdn.net/v/t39.30808-6/384305199_2545943545560545_3830589559242750394_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGlLC1b134NsF1gCXm-VqUBwueAChUi2VLC54AKFSLZUkuNmj8CDX60MxR8FhmwXJZzf2r2BOBL0aow4u8cZfXk&_nc_ohc=7BYfpLgwpnUQ7kNvgH6znb6&_nc_zt=23&_nc_ht=scontent.fsgn8-2.fna&oh=00_AYCAmhw2m-SoPem_eyGo6C2Tf5byPdxGZU5SGURaumx4fQ&oe=6691724D'),
	(N'Tôn', N'Thị Hằng', N'Nữ', '1993-06-22', 'hangpassword', 'ton.hang@gmail.com', '0987654321', N'765 Lê Thánh Tôn, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 38, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/382829924_2545943538893879_2505454589889043866_n.jpg?stp=cp6_dst-jpg&_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHlG8uy-8RzhbN7A3tgMxqKf2RD6e-G-cJ_ZEPp74b5wvdYxMjgZIjDHm3Vm6tIJdyUScv4QOSkE7fJPEhd1Jz7&_nc_ohc=pQfIdCkj5x8Q7kNvgHde1z7&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYBGuNTYqTWRc0v9DTnaWKgC15EIeABrkNM5WjQH86acXA&oe=66916EDA'),
	(N'Trịnh', N'Thị Lan Anh', N'Nữ', '1984-09-19', 'lananhpassword', 'trinh.lananh@gmail.com', '0923456789', N'567 Tôn Đức Thắng, Quận 3', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 39, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/382841482_2545943518893881_4627321738734576295_n.jpg?stp=cp6_dst-jpg&_nc_cat=108&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFc3ibqMyurt_1he438NGjwXlo1d8bdFXxeWjV3xt0VfCYv2hTbMW2fJY89xZ0SS26UWju4YaIWQWRamF0xO3vf&_nc_ohc=vwfKvIjTYl4Q7kNvgEaA74N&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCsKykXMNmwrdiwkal48i88xfveHhvOwUoS3YYIy_ZC9Q&oe=6691673B'),
	(N'Tống', N'Thị Liên', N'Nữ', '1986-12-12', 'lienpassword', 'tong.lien@gmail.com', '0912345678', N'789 Trần Nhân Tôn, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 40, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379299111_2538393619648871_2850814638028494466_n.jpg?stp=cp6_dst-jpg&_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGU7Bo_UDgbLIZp-AqtyOrSAsNl8BftA34Cw2XwF-0DfpNr2cvV8LAkUzksiNUTT3xGcVyTz2MEXN1LxH0WbXcL&_nc_ohc=qvoy2qyxDFIQ7kNvgFYiTAy&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYB7U_yY5uDbAiD4kmYvi4S3lkCErtP86IYP7pPPPuhlJA&oe=669190B6'),
	(N'Nguyễn', N'Thị Hương', N'Nữ', '1991-07-30', 'huongpassword', 'nguyen.huong@gmail.com', '0943210987', N'321 Nguyễn Văn Trỗi, Phú Nhuận', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 41, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379333171_2538393599648873_7893379368710033409_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGtVOZ8kYt0LfGPKEIJqo70R4wfQvjYWwBHjB9C-NhbAOq2t4Qvm5z1K6Uzl6EIdcRQfUK9M5aI_BOFIec48s3c&_nc_ohc=27cBsgLMTSMQ7kNvgEnkNXr&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYACFn3171J_bEnmb1s-iD-IzQL8JaBesPVESbt_StAnbA&oe=66916ECC'),
	(N'Tran', N'Quang Khải', N'Nam', '1987-03-15', 'khaipassword', 'tran.khai@gmail.com', '0976543210', N'654 Trần Quang Khải, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 42, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379333171_2538393599648873_7893379368710033409_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGtVOZ8kYt0LfGPKEIJqo70R4wfQvjYWwBHjB9C-NhbAOq2t4Qvm5z1K6Uzl6EIdcRQfUK9M5aI_BOFIec48s3c&_nc_ohc=27cBsgLMTSMQ7kNvgEnkNXr&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYACFn3171J_bEnmb1s-iD-IzQL8JaBesPVESbt_StAnbA&oe=66916ECC'),
	(N'Phạm', N'Thị Hồng Nhung', N'Nữ', '1982-08-14', 'nhungpassword', 'pham.nhung@gmail.com', '0932109876', N'987 Lê Hồng Phong, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 43, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378976969_2538393516315548_2776559561709242805_n.jpg?stp=cp6_dst-jpg&_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEbpUS_QQZSHoZu0ricgAJpnb1xQzkuxbSdvXFDOS7FtCMOuaDs8ktFOu9i3fpvDtNEXKigMDDcvlz7oxOQg-4G&_nc_ohc=myo0jVNS07kQ7kNvgG2Ai6k&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYA84rImtytVYS7YuN-Jo5ZoHre5nc-IYOSfj_NLYSAc4w&oe=66917F5E'),
	(N'Trần', N'Hoàng Anh', N'Nam', '1995-10-20', 'anhpassword', 'tran.anh@gmail.com', '0910987654', N'123 Võ Văn Tần, Quận 3', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 44, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378976969_2538393516315548_2776559561709242805_n.jpg?stp=cp6_dst-jpg&_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeEbpUS_QQZSHoZu0ricgAJpnb1xQzkuxbSdvXFDOS7FtCMOuaDs8ktFOu9i3fpvDtNEXKigMDDcvlz7oxOQg-4G&_nc_ohc=myo0jVNS07kQ7kNvgG2Ai6k&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYA84rImtytVYS7YuN-Jo5ZoHre5nc-IYOSfj_NLYSAc4w&oe=66917F5E'),
	(N'Lê', N'Thị Lan', N'Nữ', '1990-01-11', 'lanpassword', 'le.lan@gmail.com', '0934567890', N'456 Nguyễn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 45, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379065814_2538393509648882_5855405104896580420_n.jpg?stp=cp6_dst-jpg&_nc_cat=104&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGjQHjh0mDUO7q7SgPfhoBO3FgJJIPdnBDcWAkkg92cEH3AYqqCPMYcebKjbcGehF99izQMHXobVkQm4xKioadd&_nc_ohc=ucsZQmBsusEQ7kNvgFOtgf_&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYASC9gNi57Y8pOF_6_oihI_GOZZGFMnwBJiIyzy2X9_lQ&oe=66917B71'),
	(N'Ngô', N'Thị Duyên', N'Nữ', '1985-11-23', 'duyenpassword', 'ngo.duyen@gmail.com', '0908765432', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 46, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),

	--manager 47 - 56
	(N'Trần', N'Thị Lan Anh', N'Nữ', '1985-02-17', 'lananhpassword', 'tran.lananh@gmail.com', '0912345678', N'123 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 47, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Phan', N'Thành Hưng', N'Nam', '1983-11-12', 'hưngpassword', 'phan.thanhhung@gmail.com', '0987654321', N'456 Nguyễn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 48, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Trần', N'Quốc Bảo', N'Nam', '1990-08-19', 'baopassword', 'tran.quocbao@gmail.com', '0934567890', N'789 Phan Chu Trinh, Hải Châu', N'Việt Nam', N'Đà Nẵng', N'Đà Nẵng', '550000', 49, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Trương', N'Minh Khang', N'Nam', '1981-03-25', 'khangpassword', 'truong.minhkhang@gmail.com', '0918765432', N'321 Lý Thường Kiệt, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 50, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Tô', N'Mai Hương', N'Nữ', '1987-09-10', 'huongpassword', 'to.maihuong@gmail.com', '0923456789', N'432 Nguyễn Văn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 51, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Tạ', N'Thị Bích Ngọc', N'Nữ', '1984-08-14', 'ngocpassword', 'ta.bichngoc@gmail.com', '0932109876', N'543 Phan Xích Long, Phú Nhuận', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 52, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Phạm', N'Quang Bình', N'Nam', '1992-06-15', 'binhpassword', 'pham.quangbinh@gmail.com', '0943210987', N'456 Nguyễn Công Trứ, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 53, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Nguyễn', N'Thị Kim', N'Nữ', '1989-04-12', 'kimpassword', 'nguyen.kim@gmail.com', '0901234567', N'789 Lê Hồng Phong, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 54, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Lý', N'Thị Ngọc', N'Nữ', '1993-07-19', 'ngocpassword', 'ly.ngoc@gmail.com', '0976543210', N'321 Trần Hưng Đạo, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 55, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),
	(N'Đinh', N'Minh Thu', N'Nữ', '1980-02-15', 'thupassword', 'dinh.minhthu@gmail.com', '0910987654', N'123 Nguyễn Thị Minh Khai, Quận 3', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 56, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379129459_2537598833061683_585959665998403977_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG3ID0XB_Z3NpVuMASmQUWNJ-IS8q92zB4n4hLyr3bMHjv1UIVIHTFyIxJPxkdswtUbXWFxCqbaRCo3sN7nhhLt&_nc_ohc=x2VBLsUr6kMQ7kNvgGQtKy4&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYCJOS0IA1aC7idbmcMiqMI5wsC2_ufxHFx4t48ruLsPTQ&oe=66917ACD'),

	--sale 57 - 76
	(N'Trần', N'Hoàng Anh', N'Nam', '1995-10-20', 'anhpassword', 'tran.hoanganh@gmail.com', '0910987654', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 57, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379116469_2537598809728352_5708243306899972662_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGICvAKjza7yw1plo3z-LrAd2d1F1yAjEF3Z3UXXICMQU4vfJuW4yv7DL-pDDRhWxgsSKiHvmGmeqb0RJIdnRYQ&_nc_ohc=8MKuNRPFx4wQ7kNvgF0DVVL&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYAwakxSPVhWJjjLG3XIr84wPkMzR5Meb4c6TMTu_4wtkA&oe=6691768E'),
	(N'Lê', N'Thị Lan', N'Nữ', '1990-01-11', 'lanpassword', 'le.thilan@gmail.com', '0934567890', N'789 Điện Biên Phủ, Quận Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 58, 'Activate', 'https://scontent.fsgn13-2.fna.fbcdn.net/v/t39.30808-6/379116469_2537598809728352_5708243306899972662_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeGICvAKjza7yw1plo3z-LrAd2d1F1yAjEF3Z3UXXICMQU4vfJuW4yv7DL-pDDRhWxgsSKiHvmGmeqb0RJIdnRYQ&_nc_ohc=8MKuNRPFx4wQ7kNvgF0DVVL&_nc_zt=23&_nc_ht=scontent.fsgn13-2.fna&oh=00_AYAwakxSPVhWJjjLG3XIr84wPkMzR5Meb4c6TMTu_4wtkA&oe=6691768E'),
	(N'Ngô', N'Thị Duyên', N'Nữ', '1985-11-23', 'duyenpassword', 'ngo.thiduyen@gmail.com', '0908765432', N'321 Trần Hưng Đạo, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 59, 'Deactivate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/379311979_2537598789728354_666402223697821659_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeG-7YkzwncHBlNEKlYrwMRlfTmMNLI5Spt9OYw0sjlKm3_N9Bhz1Wkjm8AfKjaS4Uudv1T0-B0cFWCFhsAzXdYp&_nc_ohc=EJMzgb2KT-EQ7kNvgHICUvP&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYAKnHoTBS65L7aDU_YXYTLd21lxGGxfXK3paJOjtK4W8Q&oe=6691882F'),
	(N'Tạ', N'Thị Hoa', N'Nữ', '1992-12-24', 'hoapassword', 'ta.thihoa@gmail.com', '0923456789', N'987 Điện Biên Phủ, Quận Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 60, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Nguyễn', N'Thị Mai', N'Nữ', '1988-03-10', 'maipassword', 'nguyen.mai@gmail.com', '0976543210', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 61, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Hoàng', N'Quang Trung', N'Nam', '1991-09-15', 'trungpassword', 'hoang.quangtrung@gmail.com', '0918765432', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 62, 'Deactivate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Nguyễn', N'Thị Tâm', N'Nữ', '1993-04-18', 'tampassword', 'nguyen.thitam@gmail.com', '0901234567', N'123 Điện Biên Phủ, Quận Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 63, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Lê', N'Quang Khánh', N'Nam', '1987-07-07', 'khanhpassword', 'le.quangkhanh@gmail.com', '0923456789', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 64, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Lý', N'Thị Thảo', N'Nữ', '1990-10-10', 'thaopassword', 'ly.thithao@gmail.com', '0934567890', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 65, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Trần', N'Thị Minh Thúy', N'Nữ', '1992-11-22', 'thuypassword', 'tran.thiminhthuy@gmail.com', '0943210987', N'123 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 66, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Vũ', N'Quang Huy', N'Nam', '1985-12-25', 'huypassword', 'vu.quanghuy@gmail.com', '0967890123', N'456 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 67, 'Deactivate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Phạm', N'Thị Kim', N'Nữ', '1982-06-20', 'kimpassword', 'pham.thikim@gmail.com', '0912345678', N'789 Nguyễn Huệ, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 68, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Đặng', N'Thị Hải', N'Nữ', '1995-01-30', 'haipassword', 'dang.thihai@gmail.com', '0987654321', N'123 Phan Chu Trinh, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 69, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063' ),
	(N'Đinh', N'Quang Linh', N'Nam', '1989-09-22', 'linhpassword', 'dinh.quanglinh@gmail.com', '0910987654', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 70, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Nguyễn', N'Thị Hồng', N'Nữ', '1983-07-12', 'hongpassword', 'nguyen.hong@gmail.com', '0932109876', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 71, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Tran', N'Văn Nam', N'Nam', '1988-04-05', 'nampassword', 'tran.vannam@gmail.com', '0976543210', N'123 Điện Biên Phủ, Quận Bình Thạnh', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000',72, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Ngô', N'Thị Hằng', N'Nữ', '1992-11-29', 'hangpassword', 'ngo.thihang@gmail.com', '0901234567', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 73, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Phan', N'Quang Minh', N'Nam', '1984-12-17', 'minhpassword', 'phan.quangminh@gmail.com', '0923456789', N'789 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 74, 'Deactivate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Hoàng', N'Thị Thu', N'Nữ', '1993-03-20', 'thupassword', 'hoang.thithu@gmail.com', '0934567890', N'123 Nguyễn Huệ, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 75, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),
	(N'Trần', N'Quang Anh', N'Nam', '1989-08-25', 'anhpassword', 'tran.quanganh@gmail.com', '0943210987', N'456 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 76, 'Activate', 'https://scontent.fsgn4-1.fna.fbcdn.net/v/t39.30808-6/378874537_2537598763061690_2547914778089286456_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHkK4eXNO_UCcNA5bHWZ3jnAJj6uVLbqn0AmPq5UtuqfUeuZv_vCzNbrk3tkaLauoJMH1aMaG8dOReTIW66ycUW&_nc_ohc=maVzJnZphnUQ7kNvgGhBaZy&_nc_zt=23&_nc_ht=scontent.fsgn4-1.fna&oh=00_AYCBcmnlMrO2z6SaiRrH_8-okqVc544iKTu7Q1LjClvjmw&oe=66917063'),

	--delivery 77 - 86
	(N'Nguyễn', N'Văn A', N'Nam', '1990-01-01', 'deliverypass', 'nguyen.vana@gmail.com', '0912345678', N'123 Phan Xích Long, Phú Nhuận', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 77, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Trần', N'Thị B', N'Nữ', '1995-02-02', 'deliverypass', 'tran.thib@gmail.com', '0923456789', N'456 Lê Hồng Phong, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 78, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Hoàng', N'Văn C', N'Nam', '1988-03-03', 'deliverypass', 'hoang.vanc@gmail.com', '0934567890', N'789 Nguyễn Huệ, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 79, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Lê', N'Thị D', N'Nữ', '1992-04-04', 'deliverypass', 'le.thid@gmail.com', '0943210987', N'987 Nguyễn Trãi, Quận 5', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 80, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Phạm', N'Văn E', N'Nam', '1985-05-05', 'deliverypass', 'pham.vane@gmail.com', '0956789012', N'123 Lê Lợi, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 81, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Võ', N'Thị F', N'Nữ', '1993-06-06', 'deliverypass', 'vo.thif@gmail.com', '0967890123', N'456 Trần Hưng Đạo, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 82, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Đặng', N'Văn G', N'Nam', '1980-07-07', 'deliverypass', 'dang.vang@gmail.com', '0978901234', N'789 Phan Chu Trinh, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 83, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Trần', N'Thị H', N'Nữ', '1994-08-08', 'deliverypass', 'tran.thih@gmail.com', '0989012345', N'123 Hai Bà Trưng, Quận 1', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 84, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Nguyễn', N'Văn I', N'Nam', '1983-09-09', 'deliverypass', 'nguyen.vani@gmail.com', '0990123456', N'456 Nguyễn Văn Cừ, Long Biên', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 85, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A'),
	(N'Lê', N'Thị K', N'Nữ', '1991-10-10', 'deliverypass', 'le.thik@gmail.com', '0910987654', N'789 Lê Hồng Phong, Quận 10', N'Việt Nam', N'TP Hồ Chí Minh', N'TP Hồ Chí Minh', '700000', 86, 'Activate', 'https://scontent.fsgn3-1.fna.fbcdn.net/v/t39.30808-6/379063707_2537598729728360_9077597820526882397_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeHuunR9ek1olbJo6539RQcvLNF4DJ9NvsQs0XgMn02-xMqaU-qL0GDUAOgobF9gdsRpEbLu0UDhc36IuFPodeOU&_nc_ohc=UQu8-dH0KRoQ7kNvgHA8u2i&_nc_zt=23&_nc_ht=scontent.fsgn3-1.fna&oh=00_AYDZx3G83ei1JC-EaWhUWYu7rVO8R7AKgdWU2Ffy0wyoBQ&oe=6691687A');

	--Type Cushion
	INSERT INTO Diamond(DiamondOrigin, CaratWeight, Color, Clarity, Cut, Price, Shape,
	[Image], Polish, Symmetry, TablePercentage, Depth, Measurements, GIAReportNumber, StockNumber, LabReportNumber,
	Gemstone, GradingReport, Descriptors, Fluorescence, Inventory) 
	VALUES('natural', 1.05, 'F', 'Internally Flawless', 'N/A', 5000.8, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Excellent',
			'Very Good', 60.00, 68.00, '6.07x5.56x3.78', 1572890265, 'D60057-01', 7212544074, 'Natural, untreated diamond', 'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 2.40, 'G', 'Very Slightly Included', 'N/A', 3970, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Very Good',
		  'Very Good', 72.00, 69.90, '8.22x6.82x4.76', 6105728492, 'E44608-05', 2436749586, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 2.01, 'I', 'Very Slightly Included', 'N/A', 1499, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Excellent',
		  'Excellent', 63.00, 67.90, '7.58x6.86x4.66', 7106382930, 'D59719-02', 1455727479, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 0.71, 'G', 'Slightly Included', 'N/A', 1599, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Very Good',
		  'Good', 70.00, 59.90, '5.34x5.33x3.19', 8104930128, 'EM45555-61', 6455135410, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 0.70, 'K', 'Slightly Included', 'N/A', 2099, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Excellent',
		  'Excellent', 62.00, 71.30, '5.35x4.52x3.23', 9105828392, 'E45386-03', 7441327424, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'MB', 1),
		  ('natural', 1.80, 'J', 'Slightly Included', 'N/A', 3099, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Excellent',
		  'Excellent', 65.00, 69.60, '6.9x6.7x4.66', 1019473856, 'D59682-05', 1468655080, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique. ', 'NON', 1),
		  ('natural', 1.20, 'E', 'Slightly Included', 'N/A', 1999, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Excellent',
		  'Very Good', 60.00, 66.30, '6.84x5.8x3.84', 1119485763, 'E45658-02', 5456420816, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique. ', 'STG BL', 1),
	  	('natural', 0.91, 'F', 'Very Slightly Included', 'N/A', 1650, 'Cushion', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-cushion.png', 'Very Good',
		  'Good', 70.00, 67.40, '6.33x5.1x3.44', 2119374856, 'E46061-02', 2456248164, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1)

	--Type Emerald
	INSERT INTO Diamond(DiamondOrigin, CaratWeight, Color, Clarity, Cut, Price, Shape,
	[Image], Polish, Symmetry, TablePercentage, Depth, Measurements, GIAReportNumber, StockNumber, LabReportNumber,
	Gemstone, GradingReport, Descriptors, Fluorescence, Inventory) 
	VALUES('natural', 0.80, 'J', 'Internally Flawless', 'N/A', 2000.9, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
			'Very Good', 65.00, 69.60, '6x4.46x3.1', 1105994015, 'D59770-07', 1469890896, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 1.22, 'H', 'Internally Flawless', 'N/A', 3099, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
			'Very Good', 59.00, 64.10, '8.48x4.67x2.99', 2108341923, 'E44126-17', 2223211406, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'MB', 1),
		  ('natural', 0.80, 'H', 'Internally Flawless', 'N/A', 1099, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
			'Good', 57.00, 67.30, '6.75x4.25x2.86', 3104992657, 'D46518-16', 2476243687, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 0.79, 'H', 'Very Very Slightly Included', 'N/A', 2688, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
			'Very Good', 73.00, 66.10, '6.38x4.45x2.94', 4107629834, 'E44486-17', 1433128082, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 0.81, 'H', 'Very Very Slightly Included', 'N/A', 1299, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
			'Very Good', 61.00, 65.60, '6.58x4.31x2.83', 5108431928, 'E43304-34', 6217893588, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
	  

		  ('natural', 1.71, 'H', 'Very Slightly Included', 'N/A', 2654, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
		  'Excellent', 65.00, 68.60, '8.13x5.55x3.81', 1129384756, 'D46907-25', 2487561261, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 2.01, 'H', 'Very Slightly Included', 'N/A', 2780, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
		  'Excellent', 68.00, 68.80, '8.06x5.99x4.12', 2129384756, 'D59898-02', 7473899047, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		  ('natural', 3.03, 'G', 'Very Slightly Included', 'N/A', 2899, 'Emerald', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-emerald.png', 'Excellent',
		  'Excellent', 67.00, 64.10, '10.59x6.91x4.43', 3129384756, 'D59895-04', 2487573140, 'Natural, untreated diamond',
		  'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNL BL', 1)
	-- Type Round
	INSERT INTO Diamond(DiamondOrigin, CaratWeight, Color, Clarity, Cut, Price, Shape,
	[Image], Polish, Symmetry, TablePercentage, Depth, Measurements, GIAReportNumber, StockNumber, LabReportNumber,
	Gemstone, GradingReport, Descriptors, Fluorescence, Inventory) 
	VALUES('natural', 1.77, 'G', 'Very Slightly Included', 'Excellent', 1399, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 57.00, 62.50, '7.68x7.72x4.81', 1015830291, 'D46807', 2486971594, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
		   ('natural', 3.01, 'J', 'Slightly Included', 'Excellent', 1199, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 59.00, 62.10, '9.18x9.23x5.71', 1109273845, 'D59888-01', 2476888789, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1),
			('natural', 1.20, 'F', 'Slightly Included', 'Very Good', 1099, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 61.00, 62.30, '6.72x6.78x4.21', 2108394756, 'E43290-06', 1409199287, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
			('natural', 0.91, 'G', 'Slightly Included', 'Excellent', 1599, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 57.00, 62.80, '6.13x6.17x3.86', 3109485764, 'D46949-04', 2486908409, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
			('natural', 1.60, 'F', 'Very Slightly Included', 'Excellent', 2099, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 58.00, 62.80, '7.36x7.42x4.65', 4109857362, 'D59855-01', 1489401343, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1),

			('natural', 2.51, 'H', 'Very Slightly Included', 'Excellent', 3561, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 58.00, 63.10, '8.57x8.64x5.43', 4109851265, 'D59806-01', 1455862873, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1),
			('natural', 3.50, 'G', 'Slightly Included', 'Excellent', 2167, 'Round', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-round.png', 'Excellent',
			'Excellent', 56.00, 62.60, '9.69x9.74x6.08', 6712394756, 'D59808-03', 1427063406, 'Natural, untreated diamond',
			'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1)
	--Type 	Princess
	INSERT INTO Diamond(DiamondOrigin, CaratWeight, Color, Clarity, Cut, Price, Shape,
	[Image], Polish, Symmetry, TablePercentage, Depth, Measurements, GIAReportNumber, StockNumber, LabReportNumber,
	Gemstone, GradingReport, Descriptors, Fluorescence, Inventory) 
	VALUES	('natural', 0.51, 'G', 'Very Slightly Included', 'N/A', 2399, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Good',
				'Good', 80.00, 74.20, '4.38x4.35x3.23', 5108374956, 'E43762-03', 6415448331, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
			('natural', 2.01, 'J', 'Very Slightly Included', 'N/A', 2599, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Excellent',
				'Excellent', 74.00, 73.90, '6.93x6.81x5.03', 6109384756, 'D59802-01', 1479104116, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
			('natural', 0.71, 'E', 'Very Slightly Included', 'N/A', 2499, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Good',
				'Good', 79.00, 73.20, '5.07x4.87x3.57', 7108493756, 'D59361-01', 16511768, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1),
			('natural', 1.01, 'K', 'Very Very Slightly Included', 'N/A', 2899, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Excellent',
				'Excellent', 71.00, 74.40, '5.41x5.33x3.97', 8109374658, 'E43757', 6415471473, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'STG BL', 1),
			('natural', 0.53, 'I', 'Very Slightly Included', 'N/A', 3099, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Excellent',
				'Very Good', 75.00, 74.90, '4.35x4.29x3.22', 9108465973, 'E43664-75', 2416377753, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'FNT BL', 1),
		
		
			('natural', 0.51, 'G', 'Very Slightly Included', 'N/A', 1367, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Good',
				'Good', 80.00, 74.20, '4.38x4.35x3.23', 7129384756, 'E43762-03', 6415448331, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique.', 'NON', 1),
			('natural', 1.00, 'J', 'Slightly Included', 'N/A', 1890, 'Princess', 'https://s3.amazonaws.com/jewelry-static-files/static/diamond-search/diamondshape-princess.png', 'Good',
				'Good', 70.00, 73.70, '5.4x5.2x3.83', 8129384757, 'E43233-05', 6392426951, 'Natural, untreated diamond',
				'GIA', 'The carat is the unit of weight of a diamond. Carat is often confused with size even though it is actually a measure of weight. One carat equals 200 milligrams or 0.2 grams. The scale below illustrates the typical size relationship between diamonds of increasing carat weights. Remember that while the measurements below are typical, every diamond is unique', 'NON', 1)

		

	--Timepieces
	INSERT INTO DiamondTimepieces (
		   TimepiecesStyle
		  ,[NameTimepieces]
		  ,[Collection]
		  ,[WaterResistance]
		  ,[CrystalType]
		  ,[BraceletMaterial]
		  ,[CaseSize]
		  ,[DialColor]
		  ,[Movement]
		  ,[Gender]
		  ,[Category]
		  ,[BrandName]
		  ,[DialType]
		  ,[Description]
		  ,[Price]
		  ,[ImageTimepieces]
		  ,[ImageBrand]
		  ,[Inventory]
	) VALUES
	('EM0234-59D','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Crystal Eco','0030M','Mineral Crystal','Two-Tone Stainless Steel Bracelet',34,'White','Eco-Drive','Women','Timepieces','Citizen','Crystall','Share your fashionable point of view starting with this hip watch with 64 crystals on the two-tone stainless steel case. A sleek pink two-tone stainless steel bracelet and a white Mother-of-Pearl dial dotted with 6 crystals. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number E031.',350.00,'https://cdn.jewelryimages.net/galleries/citizen/EM0234-59D.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),

	('BY3005-56G','Citizen Stainless Steel Promaster Eco Mens Watch','Promaster Eco - Nothern Hemisphere','0200M','Anti-Reflective Sapphire Crystal','Gray Stainless Steel Bracelet',46,'Black','Eco-Drive','Men','Timepieces','Citizen',null,'Touch the edge of the sky with the new Promaster. A bold 45mm stainless steel case in a dark gray tone centers the design, with the professional-grade pilot watch mission-ready on the wrist– fully equipped with a bold set of chronograph pushers, 5-link stainless steel bracelet, and an outer slide rule bezel. Underneath a scratch-resistant sapphire crystal, the watch data-driven display is on view, with white, red, and silver-tone accents working against a dark background for a rapid legibility for the wearer. Towards the 6 o`clock position, a namesake northern hemisphere disc rotates counter clockwise, with the detail showcasing the world time with a map inspired design. Other standard and advanced functions of the watch include running hours and minutes, date indication, power reserve indication, world time, and a slide rule bezel function. This distinctive sports watch utilizes Citizen`s Eco-Drive technology that’s sustainably powered by any light and never needs a battery. Water resistant up to 200 meters. Caliber H864.',850.00,'https://cdn.jewelryimages.net/galleries/citizen/BY3005-56G.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BY3005-56G_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EM1110-56N','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Arcly','0050M','Spherical Sapphire Crystal','Silver-Tone Stainless Steel Bracelet',29.8,'Blue','Eco-Drive','Women','Timepieces','Citizen','Diamond','Classic lines and hints of romance make this newest piece to our women`s collection, the Citizen L Arcly, a captivating addition of sustainable luxury. With a design inspired by the original Citizen "Sunrise", the distinctive stainless-steel timepiece is a charming accent on the wrist that`s perfect for glamorous wear. Sleek lines define the watch`s 29.8mm silhouette, with a subtle 4 o`clock crown and 7 o`clock diamond accent adding to its entrancingly delicate look. On its blue-tinged mother-of-pearl dial, applied diamond markers and sharp hands indicate the time in style atop a subtle flower motif, keeping the attention on the pure aestheticism of the timepiece. Sustainably powered by any light with our proprietary Eco-Drive technology that never needs a battery, this elegant ladies watch is the perfect addition to elevate any outfit. Water resistant to 50 meters. Caliber E031.',950.00,'https://cdn.jewelryimages.net/galleries/citizen/EM1110-56N.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EM1110-56N_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BY3006-53H','Citizen Stainless Steel Promaster Eco Mens Watch','Promaster Eco - Nothern Hemisphere','0200M','Anti-Reflective Sapphire Crystal','Silver-Tone Stainless Steel Bracelet',46,'Gray','Eco-Drive','Men','Timepieces','Citizen',null,'Touch the edge of the sky with the new Promaster. A bold 45mm stainless steel case in silver-tone centers the design, with the professional-grade pilot`s watch mission-ready on the wrist – fully equipped with a bold set of chronograph pushers, 5-link stainless steel bracelet, and an outer slide rule bezel. Underneath a scratch-resistant sapphire crystal, the watch`s data-driven display is on view, with white and silver-tone accents working against a dark background for a rapid legibility for the wearer. Towards the 6 o`clock position, a namesake northern hemisphere disc rotates counter clockwise, with the detail showcasing the world time with a map inspired design. Other standard and advanced functions of the watch include running hours and minutes, date indication, power reserve indication, world time, and a slide rule bezel function. This distinctive sports watch utilizes Citizen`s Eco-Drive technology that’s sustainably powered by any light and never needs a battery. Water resistant up to 200 meters. Caliber H864.',795.00,'https://cdn.jewelryimages.net/galleries/citizen/BY3006-53H.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BY3006-53H_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('CA4377-53H','Citizen Stainless Steel Weekender Mens Watch','Weekender - Nighthawk Sport Casual','0200M','Mineral Crystal','Gray Stainless Steel Bracelet',43,'Gray','Eco-Drive','Men','Timepieces','Citizen',null,'Style meets function in the Citizen Nighthawk with a sporty appeal. Designed with a granite ion-plated stainless steel case and bracelet with a charcoal gray dial with red accents, the advanced features include a 1/5 second chronograph that measures up to 60 minutes, 12/24 hour time, and a tachymeter that measures speed based on time traveled over a distance. This must-have men`s watch features a safety foldover clasp with push button, and water resistance to 200 meters. Made with our proprietary Eco-Drive technology that’s sustainably powered by any light and never needs a battery, this versatile men`s watch becomes your weekday to weekend wardrobe staple. Caliber number B620.',575.00,'https://cdn.jewelryimages.net/galleries/citizen/CA4377-53H.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/CA4377-53H_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),


	('CA4583-01E','Citizen Stainless Steel Modern Eco Mens Watch','Modern Eco - Modern Eco','0050M','Sapphire Crystal','Brown Leather Strap',43,'Black','Eco-Drive','Men','Timepieces', 'Citizen' ,null,'The Citizen Axiom features a sophisticated blend of sports watch aesthetics with refined styling for the ultimate workday to weekend watch to wear. The timepiece features a rose gold-tone stainless steel case with an integrated leather strap, embodying a distinct, contemporary sports watch design. The black dial has a streamlined look, with two sub-dials at 3 and 9 o`clock, outlined with more rose gold-tone details to match the style of the applied indices and hands, while an understated 6 o`clock sub-dial for the running seconds rounds out the style. Capabilities of the watch include a 1/5 second chronograph that measures up to 60 minutes, 12- and 24-hour time indication, and a date indicator. Powered by Citizen`s proprietary Eco-Drive technology to provide light-powered vitality continuously and sustainably without ever needing a battery. Caliber B620.',625.00,'https://cdn.jewelryimages.net/galleries/citizen/CA4583-01E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/CA4583-01E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('AT8267-51X','Citizen Stainless Steel Sport Luxury Mens Watch','Sport Luxury - Radio Control','0100M','Sapphire Crystal','Gray Stainless Steel Bracelet',43,'Red','Eco-Drive','Men','Timepieces','Citizen',null,'Innovative technology once again meets elevated chronograph styling in Citizen`s latest: the new Radio Control AT8267. A 43mm stainless steel case in gray and rose gold-tones solidifies the design, with a matching bracelet securing the watch to the wrist. A faceted crown and chronograph pushers add a stylish touch, balancing traditional details with smart, modern accents. On the deep red dial, a vertical three-register chronograph is at work, with appliques of more rose gold-tones adding dimensionality alongside the utility of a 3 o`clock date display. Other advanced features include world time in 26 time zones, a perpetual calendar with day and date indicators, 12/24-hour timekeeping, and a power reserve display. Featuring light-powered Eco-Drive Atomic Timekeeping functionality, the radio controlled timepiece self-adjusts to time or calendar when traveling overseas by receiving local time signals in four different regions. Water resistant up to 100 meters. Caliber H800.',695.00,'https://cdn.jewelryimages.net/galleries/citizen/AT8267-51X.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AT8267-51X_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('AU1062-05E','Citizen Stainless Steel Modern Eco Mens Watch','Modern Eco - Axiom',null,'Mineral Crystal','Black Leather Strap',40,'Black','Eco-Drive','Men','Timepieces','Citizen',null,'Axiom`s refined yet sleek design offers a day-to-night fashion options for the avid trendsetter. A watch with CITIZEN`s Eco-Drive technology, not just a solar watch, but powered by any light, featured in a men`s gold-tone stainless steel case, black leather strap with black dial and the intriguing feature of edge-to-edge glass. Caliber number J165.',325.00,'https://cdn.jewelryimages.net/galleries/citizen/AU1062-05E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AU1062-05E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW2712-55E','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Corso','0100M','Mineral Crystal','Gold-Tone Stainless Steel Bracelet',28,'Black','Eco-Drive','Women','Timepieces','Citizen','Diamond','A classic timepiece is always in style in the Corso ladies watch from Citizen, now with an added touch of sparkle. Featuring a diamond-accented bezel on a gold-tone stainless steel 28mm case and matching bracelet and a three-hand black dial with date indicator, luminous hands and gold-tone markers – this elegant timepiece also has a fold-over clasp closure with hidden push buttons and is water resistant to 100 meters. If you`re looking for a dress watch to add elevated style to your wardrobe, look no further – the Corso is the perfect choice. Featuring Citizen`s Eco-Drive technology, so it is sustainably powered by any light and will never need a battery. Caliber E011.',575.00,'https://cdn.jewelryimages.net/galleries/citizen/EW2712-55E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW2712-55E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW5600-01E','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Bianca','0050M','Curved Sapphire Crystal','Black Leather Strap',21.5,'Black','Eco-Drive','Women','Timepieces','Citizen',null,'Classic lines and subtle sophistication make this latest piece to our womens collection, the Citizen L Bianca, a charming addition of sustainable luxury. With?a design inspired and celebrating feminine motifs in art deco, the distinctive stainless-steel timepiece is a captivating accent on the wrist that`s perfect for everyday wear. A curved rectangular shape defines the watch`s 22mm silhouette, with a subtle crown and black leather strap rounding out the look. On its deep black dial, alternating applied and printed markers work with a pair of silver-tone hands for a highly aesthetic style, with its printed inner square once again pointing to glamorous inspirations. Sustainably powered by any light with our proprietary Eco-Drive technology that never needs a battery, this elegant ladies’ watch is the perfect addition to any outfit. Water resistant to 50 meters. Caliber B035.',325.00,'https://cdn.jewelryimages.net/galleries/citizen/EW5600-01E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW5600-01E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),


	('AW0087-58H','Citizen Stainless Steel Weekender Mens Watch','Weekender - Sport Casual','0100M','Domed Mineral Crystal','Gray Stainless Steel Bracelet',42,'Gray','Eco-Drive Ring','Men','Timepieces','Citizen',null,'The Drive from CITIZEN CTO collection. A collection of watches with classically modern design. Featured here in a gray ion plated stainless steel with gray dial and day/date. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number J800.',325.00,'https://cdn.jewelryimages.net/galleries/citizen/AW0087-58H.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AW0087-58H_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BJ6517-52E','Citizen Stainless Steel Modern Eco Mens Watch','Modern Eco - Axiom','0030M','Mineral Crystal','Gray Stainless Steel Bracelet',41,'Black','Eco-Drive','Men','Timepieces','Citizen',null,'Axiom`s refined yet sleek design offers a day-to-night fashion options for the avid trendsetter. A watch with Eco-Drive technology, not just a solar watch but powered by any light, featuring a men`s grey stainless steel case and bracelet with a black dial and the intriguing feature of edge-to-edge glass. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number E031.',395.00,'https://cdn.jewelryimages.net/galleries/citizen/BJ6517-52E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BJ6517-52E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('AO9020-84E','Citizen Stainless Steel Dress/Classic Eco Mens Watch','Dress/Classic Eco - Classic Eco','0100M','Mineral Crystal','Silver-Tone Stainless Steel Bracelet',42,'Black','Eco-Drive','Men','Timepieces','Citizen',null,'A modern classic rediscovered with this analog day/date dress timepiece. In stainless steel with a black dial and day-date feature. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number 8635.',325.00,'https://cdn.jewelryimages.net/galleries/citizen/AO9020-84E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AO9020-84E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('AT8260-51M','Citizen Stainless Steel Sport Luxury Mens Watch','Sport Luxury - Radio Control','0100M','Sapphire Crystal','Silver-Tone Stainless Steel Bracelet',43,'Light Blue','Eco-Drive','Men','Timepieces','Citizen',null,'Innovative technology once again meets elevated chronograph styling in Citizen`s latest: the new Radio Control AT8260. A 43mm stainless steel case with contrasting brushed and polished finishing techniques solidifies the design, while a matching bracelet secures the watch to the wrist. A faceted crown and chronograph pushers add a stylish touch, balancing traditional details with smart, modern accents. On the sky blue dial, a vertical three-register chronograph is at work, with appliques of silver-tones adding dimensionality alongside the utility of a 3 o`clock date display. Other advanced features include world time in 26 time zones, a perpetual calendar with day and date indicators, 12/24-hour timekeeping, and a power reserve display. Featuring light-powered Eco-Drive Atomic Timekeeping functionality, the radio controlled timepiece self-adjusts to time or calendar when traveling overseas by receiving local time signals in four different regions. Water resistant up to 100 meters. Caliber H800.',650.00,'https://cdn.jewelryimages.net/galleries/citizen/AT8260-51M.jpg?v=14,', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW2710-51X','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Corso','0100M','Mineral Crystal','Silver-Tone Stainless Steel Bracelet',28,'Taupe','Eco-Drive','Women','Timepieces','Citizen','Diamond','A classic timepiece is always in style in the Corso ladies watch from Citizen, now with added touch of sparkle. Featuring a diamond-accented bezel on a silver-tone stainless steel bracelet and 28mm case and matching bracelet, and a 3-hand taupe dial and date indicator, luminous hands, and applied indices – this elegant timepiece also has a fold-over clasp closure with hidden push buttons and is water resistant to 100 meters. If you’re looking for a dress watch to add elevated, diamond-touched style to your wardrobe, look no further – the Corso is the perfect choice. It also uses Citizen`s Eco-Drive technology, so it is sustainably powered by any light and will never need a battery. Caliber E011.',525.00,'https://cdn.jewelryimages.net/galleries/citizen/EW2710-51X.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW2710-51X_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),


	('EM1113-58Y','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Arcly','0050M','Spherical Sapphire Crystal','Rose Gold-Tone Stainless Steel Bracelet',29.8,'Green','Eco-Drive','Women','Timepieces','Citizen','Diamond','Classic lines and hints of romance make this newest piece to our women`s collection, the Citizen L Arcly, a captivating addition of sustainable luxury. With?a design inspired by the original Citizen "Sunrise", the distinctive rose gold-tone stainless steel timepiece is a charming accent on the wrist that`s perfect for glamorous wear. Sleek lines define the watch`s 29.8mm silhouette, with a subtle 4 o`clock crown and 7 o`clock diamond accent adding to its entrancingly delicate look. On its green-tinged mother-of-pearl dial, applied diamond markers and sharp hands indicate the time in style atop a subtle flower motif, keeping the attention on the pure aestheticism of the timepiece. Sustainably powered by any light with our proprietary Eco-Drive technology that never needs a battery, this elegant ladies watch is the perfect addition to elevate any outfit. Caliber E031.',995.00,'https://cdn.jewelryimages.net/galleries/citizen/EM1113-58Y.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EM1113-58Y_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BU2112-06E','Citizen Stainless Steel Dress/Classic Eco Mens Watch','Dress/Classic Eco - Rolan','0100M','Spherical Sapphire Crystal','Brown Leather Strap',40,'Black','Eco-Drive Ring','Men','Timepieces','Citizen',null,'With vintage-inspired style that will never go out-of-date, this latest multi-function Rolan from Citizen takes the classic collection to the next level. The 40mm gold-tone stainless steel case is the perfect base for the watch`s black dial, with three sub-dials upon a textured inner sector adding to its distinct appeal. Applied accents and a brown leather strap round out the look, with features including running and 24h time joining day and date indicators to balance the chic aesthetics with functionality of this sophisticated timepiece. Sustainably powered by any light with Eco-Drive technology and never needs a battery. Water resistant up to 100m. Caliber 8729.',425.00,'https://cdn.jewelryimages.net/galleries/citizen/BU2112-06E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BU2112-06E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BU2110-01A','Citizen Stainless Steel Dress/Classic Eco Mens Watch','Dress/Classic Eco - Rolan','0100M','Spherical Sapphire Crystal','Gray Leather Strap',40,'Silver-Tone','Eco-Drive Ring','Men','Timepieces','Citizen',null,'With vintage-inspired style that will never go out-of-date, this latest multi-function Rolan from Citizen takes the classic collection to the next level. The 40mm stainless steel case is the perfect base for the watch`s matching silver-tone dial, with three sub-dials upon a textured inner sector adding to its unique appeal. Applied accents and a gray leather strap round out the look, with features including running and 24h time joining day and date indicators to balance the chic aesthetics with the functionality of this sophisticated timepiece. Sustainably powered by any light with our proprietary Eco-Drive technology and never needs a battery. Water resistant up to 100m. Caliber 8729.',395.00,'https://cdn.jewelryimages.net/galleries/citizen/BU2110-01A.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BU2110-01A_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EM0233-51A','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Crystal Eco','0030M','Mineral Crystal','Pink Gold-Tone Stainless Steel Bracelet',34,'Silver-Tone','Eco-Drive','Women','Timepieces','Citizen','Crystal','Share your fashionable point of view starting with this hip watch with 64 crystals on the pink gold-tone stainless steel case. A sleek pink gold-tone stainless steel bracelet and a silver dial dotted with 6 crystals. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number E031.',350.00,'https://cdn.jewelryimages.net/galleries/citizen/EM0233-51A.jpg?v=14','https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg',1),
	('AT8265-57L','Citizen Stainless Steel Sport Luxury Mens Watch','Sport Luxury - Radio Control','0100M','Sapphire Crystal','Black Stainless Steel Bracelet',43,'Blue','Eco-Drive','Men','Timepieces','Citizen',null,'Innovative technology once again meets elevated chronograph styling in Citizen`s latest: the new Radio Control AT8265. A 43mm stainless steel case in black ip solidifies the design, with a matching bracelet securing the watch to the wrist. A faceted crown and chronograph pushers add a stylish touch, balancing its traditional details with smart, modern accents. On the deep blue dial, a vertical three-register chronograph is at work, with appliques of rose gold-tones adding dimensionality alongside the utility of a 3 o`clock date display. Other advanced features include world time in 26 time zones, a perpetual calendar with day and date indicators, 12/24-hour timekeeping, and a power reserve display. Featuring light-powered Eco-Drive Atomic Timekeeping functionality, the radio controlled timepiece self-adjusts to time or calendar when traveling overseas by receiving local time signals in four different regions. Water resistant up to 100 meters. Caliber H800.',695.00,'https://cdn.jewelryimages.net/galleries/citizen/AT8265-57L.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AT8265-57L_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),


	('AW1232-04A','Citizen Stainless Steel Dress/Classic Eco Mens Watch','Dress/Classic Eco - Classic Eco','0030M','Mineral Crystal','Brown Leather Strap',40,'Silver-Tone','Eco-Drive Ring','Men','Timepieces','Citizen',null,'Keep it simple with the classic lines and rich leather strap of these men`s CITIZEN strap watches. Featured with gold-tone stainless steel case, brown leather strap, ivory white dial with gold accents and date. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number J810.',250.00,'https://cdn.jewelryimages.net/galleries/citizen/AW1232-04A.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/AW1232-04A_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BN0200-56E','Citizen Super Titanium Promaster Eco Mens Watch','Promaster Eco - Dive','200M','Mineral Crystal','Silver-Tone Super Titanium Bracelet',44,'Black','Eco-Drive','Men','Timepieces','Citizen',null,'Proof that a dive watch can be fun & functional with the CITIZEN ISO-compliant Super Titanium Promaster Diver. With Eco-Drive technology, it is powered by light and never needs a battery, so you`ll never need to open your caseback or compromise your dive again. Featured in a Super Titanium case and bracelet, aluminum bezel and black dial, one-way rotating elapsed time and WR200. Featuring our Eco-Drive technology – powered by light, any light. Never needs a battery. Caliber number E168.',525.00,'https://cdn.jewelryimages.net/galleries/citizen/BN0200-56E.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BN0200-56E_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW5602-57D','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Bianca','0050M','Curved Sapphire Crystal','Gold-Tone Stainless Steel Bracelet',21.5,'White','Eco-Drive','Women','Timepieces','Citizen',null,'Classic lines and subtle sophistication make this latest piece to our women`s collection, the Citizen L Bianca, a charming addition of sustainable luxury. With?a design inspired and celebrating feminine motifs in art deco, the distinctive gold-tone stainless steel timepiece is a captivating accent on the wrist that perfect for everyday wear. A curved rectangular shape defines the watch`s 22mm silhouette, with a subtle crown and gold-tone stainless steel bracelet rounding out the look. On its mother-of-pearl dial, alternating applied and printed markers work with a pair of blue-touched hands for a highly aesthetic style, with its printed inner square once again pointing to chic inspirations. Sustainably powered by any light with our proprietary Eco-Drive technology that never needs a battery, this elegant ladies watch is the perfect addition to any outfit. Water resistant to 50 meters. Caliber B035.',425.00,'https://cdn.jewelryimages.net/galleries/citizen/EW5602-57D.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW5602-57D_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('JY8156-00L','Citizen Stainless Steel Promaster Eco Mens Watch','Promaster Eco - Skyhawk','0200M','Sapphire Crystal','Blue Rubber Strap',46,'Blue','Eco-Drive','Men','Timepieces','Citizen',null,'Reach a higher altitude in style and performance with the new Promaster X Sikorsky S-92 watch. Produced in collaboration with the American aircraft manufacturer and inspired by the Sikorsky S-92 medium utility helicopter used for search and rescue missions, the special edition is a professional-grade timepiece with mission-ready flair. On the wrist, the new chronograph features a silver-tone stainless steel case and an entrancing blue dial, with its bold 46mm shape secured to the wrist via a matching blue rubber strap. Underneath a scratch-resistant sapphire crystal, the watch`s azure display is on view. Red, yellow, and white accents work in tandem with analog and digital components for the Sikorsky S-92 helicopter`s unique aesthetic and technical capabilities. The advanced functions of the watch include atomic time clock synchronization for superior accuracy, time adjustment available in 43 world cities, 1/100 second chronograph measures up to 24 hours, perpetual calendar, GMT dual time (second time zone), 2 alarms, 99-minute countdown timer, digital backlight display, Universal Coordinated Time (UTC) display, and a power reserve indicator. This distinctive sports watch utilizes Citizen`s Eco-Drive technology that`s sustainably powered by any light and never needs a battery. Water resistant up to 200 meters. Caliber U680.',995.00,'https://cdn.jewelryimages.net/galleries/citizen/JY8156-00L.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/JY8156-00L_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW5600-52D','Citizen Stainless Steel Dress/Classic Eco Ladies Watch','Dress/Classic Eco - Bianca','0050M','Curved Sapphire Crystal','Silver-Tone Stainless Steel Bracelet',21.5,'White','Eco-Drive','Women','Timepieces','Citizen',null,'Classic lines and subtle sophistication make this latest piece to our women`s collection, the Citizen L Bianca, a charming addition of sustainable luxury. With a design inspired and celebrating feminine motifs in art deco, the distinctive stainless-steel timepiece is a captivating accent on the wrist that`s perfect for everyday wear. A curved rectangular shape defines the watch`s 22mm silhouette, with a subtle crown and stainless-steel bracelet rounding out the look. On its mother-of-pearl dial, alternating applied and printed markers work with a pair of blue-touched hands for a highly aesthetic style, with its printed inner square once again pointing to chic inspirations. Sustainably powered by any light with our proprietary Eco-Drive technology that never needs a battery, this elegant ladies watch is the perfect addition to any outfit. Water resistant to 50 meters. Caliber B035.',375.00,'https://cdn.jewelryimages.net/galleries/citizen/EW5600-52D.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW5600-52D_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW2706-58X','Citizen Stainless Steel Sport Luxury Ladies Watch','Sport Luxury - Sport','0100M','Spherical Sapphire Crystal','Two-Tone Stainless Steel Bracelet',33,'Pink','Eco-Drive','Women','Timepieces','Citizen','Diamond','When sporty style meets luxury, you get this latest stunner from Citizen. Joining ready-for-anything wearability with feminine elegance, this time-and-date timepiece is the ultimate day-to-evening watch to wear. The two-tone stainless steel case measures 33mm in diameter and is presented on a matching, 3-link stainless steel bracelet for a sleek, versatile wear on the wrist. The radiant pink dial is characterized by its highly legible style and diamond accents, elevating the sporty wearer one step further. A water resistance up to 100 meters helps the dynamic watch maintain a host of functionality without compromising its alluring appearance. Powered by Citizen`s proprietary Eco-Drive technology to provide light-powered vitality continuously and sustainably without ever needing a battery. Caliber E013.',495.00,'https://cdn.jewelryimages.net/galleries/citizen/EW2706-58X.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW2706-58X_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EO2023-00A','Citizen Stainless Steel Promaster Eco Ladies Watch','Promaster Eco - Dive','200M','Mineral Crystal','Pink Polyurethane Strap',36.5,'Silver-Tone','Eco-Drive','Women','Timepieces','Citizen',null,'Submerge yourself in the latest Dive watch to join Citizen''s innovative Promaster line. The new timepiece features a smaller, versatile 37mm case size with a rose gold-tone stainless steel exterior complete with an easy-grip dive bezel and screw-down crown at 4 o''clock, with the bold design secured to the wrist via a soft pink polyurethane strap. The striking white dial features oversized hands and applied markers that add to its high legibility, while accents of more rose gold hues and a bright luminous material ensure sleek styling and quick readability to even the deepest depths. At the 4 o''clock position is a thoughtful date window, adding another element of functionality to this all-purpose diver. Maintaining the robust standards of the Promaster Collection, the timepiece is water resistant up to 200 meters. Sustainably powered by any light with Eco-Drive technology that never needs a battery, this stylish dive watch also comes in an exclusive collector''s scuba tank-inspired box. Caliber E168.',395.00,'https://cdn.jewelryimages.net/galleries/citizen/EO2023-00A.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EO2023-00A_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('EW2702-59D','Citizen Stainless Steel Sport Luxury Ladies Watch','Sport Luxury - Sport','0100M','Spherical Sapphire Crystal','Gold-Tone Stainless Steel Bracelet',33,'White','Eco-Drive','Women','Timepieces','Citizen','Diamond','When sporty style meets luxury, you get this latest stunner from Citizen. Joining ready-for-anything wearability with feminine elegance, this time-and-date timepiece is the ultimate day-to-evening watch to wear. The gold-tone stainless steel case measures 33mm in diameter and is presented on a matching, 3-link stainless steel bracelet for a sleek, versatile wear on the wrist. The radiant white mother-of-pearl dial is characterized by its highly legible style and diamond accents, elevating the sporty wearer one step further. A water resistance up to 100 meters helps the dynamic watch maintain a host of functionality without compromising its alluring appearance. Powered by Citizen`s proprietary Eco-Drive technology to provide light-powered vitality continuously and sustainably without ever needing a battery. Caliber E013.',495.00,'https://cdn.jewelryimages.net/galleries/citizen/EW2702-59D.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/EW2702-59D_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('BN0165-55L','Citizen Stainless Steel Promaster Eco Mens Watch','Promaster Eco - Dive','200M','Mineral Crystal','Silver-Tone Stainless Steel Bracelet',44,'Light Blue','Eco-Drive','Men','Timepieces','Citizen',null,'Submerge yourself in the latest Dive watch to join Citizen`s innovative Promaster line. The robust 44mm silver-tone stainless steel exterior has an easy-grip dive bezel and crown at 4 o`clock, with the monochromatic design secured to the wrist via a matching silver-tone stainless steel bracelet. The sunray-textured, light blue dial features oversized hands and applied markers that add to its high legibility, while accents of a bright luminous material ensure high legibility to even the deepest depths. At the 4 o`clock position is a thoughtful date window, adding another element of functionality to this built-tough diver. Maintaining the robust standards of the Promaster Collection, the timepiece is water resistant up to 200 meters. Powered by Citizen`s proprietary Eco-Drive technology to provide light-powered vitality continuously and sustainably without ever needing a battery. Caliber E168.',450.00,'https://cdn.jewelryimages.net/galleries/citizen/BN0165-55L.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/BN0165-55L_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1),
	('FE6161-54L','Citizen Stainless Steel Sport Luxury Ladies Watch','Sport Luxury - Carson','0100M','Sapphire Crystal','Silver-Tone Stainless Steel Bracelet',35,'Light Blue','Eco-Drive Ring','Women','Timepieces','Citizen','Diamond','When sporty style meets luxury. This women`s timepiece is designed to be versatile yet elevated and features a silver-tone stainless steel case and bracelet with a light blue 3-hand dial with 11 diamond accents and a sapphire crystal, date function and a deployment clasp with push buttons for easy accessibility. Water resistant to 100 meters and sustainably powered by light with Eco-Drive and never needs a battery',525.00,'https://cdn.jewelryimages.net/galleries/citizen/FE6161-54L.jpg?v=14,https://cdn.jewelryimages.net/galleries/citizen/FE6161-54L_2.jpg?v=14', 'https://collections.jewelryimages.net/collections_logos/Citizen_logo_white.jpg', 1);



	--order
	

	--transaction

	--SCHEDULE PRODUCT
	INSERT INTO ScheduleAppointment (FirstName, LastName, Email, PhoneNumber, DesiredDay, DesiredTime, Message, DiamondID, BridalID, DiamondRingsID, DiamondTimepiecesID, AccountID)
	VALUES 
	(N'Nguyễn', N'Văn A', 'nguyenvana@gmail.com', 0123456789, '2025-01-01', '09:00:00', N'Tôi muốn tìm hiểu về kim cương.', 1, NULL, NULL, NULL, 10),
	(N'Trần', N'Thị B', 'tranthib@gmail.com', 0987654321, '2025-01-02', '15:30:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL,8),
	(N'Lê', N'Quốc C', 'lequocc@gmail.com', 0912345677, '2025-01-03', '10:00:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 1, 9),
	(N'Phạm', N'Thị D', 'phamthid@gmail.com', 0912345678, '2025-01-04', '14:00:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL, 6),
	(N'Hoàng', N'Minh E', 'hoangminhe@gmail.com', 0934567890, '2025-01-05', '11:30:00', N'Xin tư vấn về các loại kim cương.', 12, NULL, NULL, NULL,8 ),
	(N'Nguyễn', N'Thanh F', 'nguyenthanhf@gmail.com', 0123456798, '2025-01-06', '09:15:00', N'Tôi muốn tìm hiểu về kim cương.', 25, NULL, NULL, NULL, 6),
	(N'Trần', N'Bảo G', 'tranbaog@gmail.com', 0987654322, '2025-01-07', '16:00:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL, 7),
	(N'Lê', N'Hồng H', 'lehongh@gmail.com', 0912345679, '2025-01-08', '10:15:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 2, 7),
	(N'Phạm', N'Minh I', 'phamminhi@gmail.com', 0908765433, '2025-01-09', '14:15:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL, 8),
	(N'Hoàng', N'Nam J', 'hoangnamj@gmail.com', 0934567891, '2025-01-10', '11:45:00', N'Xin tư vấn về các loại kim cương.', 30, NULL, NULL, NULL, 9),
	(N'Nguyễn', N'Phương K', 'nguyenphuongk@gmail.com', 0123456790, '2025-01-11', '09:30:00', N'Tôi muốn tìm hiểu về kim cương.', 10, NULL, NULL, NULL, 10),
	(N'Trần', N'Khánh L', 'trankhanhl@gmail.com', 098765432, '2025-01-12', '16:30:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL, 11),
	(N'Lê', N'Trung M', 'letrungm@gmail.com', 0912345680, '2025-01-13', '10:30:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 3,12),
	(N'Phạm', N'Mỹ N', 'phammyn@gmail.com', 0908765434, '2025-01-14', '14:30:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL,13),
	(N'Hoàng', N'Anh O', 'hoanganho@gmail.com', 0934567892, '2025-01-15', '12:00:00', N'Xin tư vấn về các loại kim cương.', 4, NULL, NULL, NULL,14),
	(N'Nguyễn', N'Lan P', 'nguyenlanp@gmail.com', 0123456791, '2025-01-16', '09:45:00', N'Tôi muốn tìm hiểu về kim cương.', 9, NULL, NULL, NULL,15),
	(N'Trần', N'Mai Q', 'tranmaiq@gmail.com', 0987654324, '2025-01-17', '16:45:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL,16),
	(N'Lê', N'Phúc R', 'lephucr@gmail.com', 0912345681, '2025-01-18', '10:45:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 4,17),
	(N'Phạm', N'Hoa S', 'phamhoas@gmail.com', 0908765435, '2025-01-19', '14:45:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL,18),
	(N'Hoàng', N'Dũng T', 'hoangdungt@gmail.com', 0934567893, '2025-01-20', '12:15:00', N'Xin tư vấn về các loại kim cương.', 27, NULL, NULL, NULL,18),
	(N'Nguyễn', N'Hà U', 'nguyenhau@gmail.com', 0123456792, '2025-01-21', '10:00:00', N'Tôi muốn tìm hiểu về kim cương.', 29, NULL, NULL, NULL,19),
	(N'Trần', N'Long V', 'tranlongv@gmail.com', 0987654325, '2025-01-22', '17:00:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL,20),
	(N'Lê', N'Quỳnh W', 'lequynhw@gmail.com', 0912345682, '2025-01-23', '11:00:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 5,21),
	(N'Phạm', N'Bình X', 'phambinhx@gmail.com', 0908765436, '2025-01-24', '15:00:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL,22),
	(N'Hoàng', N'Hải Y', 'hoanghaiy@gmail.com', 0934567894, '2025-01-25', '12:30:00', N'Xin tư vấn về các loại kim cương.', 17, NULL, NULL, NULL,23),
	(N'Nguyễn', N'Thanh Z', 'nguyenthanhz@gmail.com', 0123456793, '2025-01-26', '10:15:00', N'Tôi muốn tìm hiểu về kim cương.', 23, NULL, NULL, NULL,24),
	(N'Trần', N'Lan AA', 'tranlana@gmail.com', 0987654326, '2025-01-27', '17:15:00', N'Tôi muốn xem bộ sưu tập nhẫn cưới.', NULL, NULL, NULL, NULL,25),
	(N'Lê', N'Trâm BB', 'letrambb@gmail.com', 0912345683, '2025-01-28', '11:15:00', N'Tôi quan tâm đến đồng hồ kim cương.', NULL, NULL, NULL, 7,26),
	(N'Phạm', N'Như CC', 'phamnhucc@gmail.com', 0908765437, '2025-01-29', '15:15:00', N'Tôi muốn đặt lịch hẹn để xem nhẫn kim cương.', NULL, NULL, NULL, NULL,27),
	(N'Hoàng', N'Dương DD', 'hoangduongdd@gmail.com', 0934567895, '2025-01-30', '12:45:00', N'Xin tư vấn về các loại kim cương.', 7, NULL, NULL, NULL,28);

	--ORDER DETAILS
	

-- CERTIFICATE--
-- Inserting full records into the Certificate table

-- First, ensure the table is empty
DELETE FROM Certificate;

-- Now, insert 30 unique records for each product type
DECLARE @i INT = 1;

WHILE @i <= 30
BEGIN
    INSERT INTO Certificate (
        InspectionDate, ClarityGrade, ShapeAndCuttingStyle, GIAReportNumber, Measurements,
        CaratWeight, ColorGrade, SymmetryGrade, CutGrade, PolishGrade, Fluorescence,
        ImageLogoCertificate, BridalID, DiamondTimepiecesID, DiamondRingsID, DiamondID
    ) VALUES 
    ('2024-07-15', 'VVS1', 'Round', CONCAT('GIA', @i), '10.0x5.0', 1.5, 'D', 'Excellent', 'Excellent', 'Excellent', 'None', 'https://24cara.vn/wp-content/uploads/2018/03/4-2.jpg', @i, @i, @i, @i);

    SET @i = @i + 1;
END




	--VOUCHER
	INSERT INTO Voucher (VoucherName, UsagedQuantity, TotalQuantity, Type, ValidFrom, ExpirationDate, Condition, Prerequisites, Discount) VALUES 
	('SpringSale', 0, 100, 'Percentage', '2024-06-01', '2024-06-30', 'Minimum purchase $1000', 1000, 1),
	('SummerSale', 0, 150, 'Flat', '2024-07-01', '2024-07-31', 'Minimum purchase $1300', 2000, 2),
	('FallSale', 0, 200, 'Percentage', '2024-09-01', '2024-09-30', 'Minimum purchase $1500',4000, 3);
	--('WinterSale', 0, 250, 'Flat', '2024-12-01', '2024-12-31', 'Minimum purchase $1700',1700, 6),
	--('HolidaySale', 0, 300, 'Percentage', '2024-12-15', '2025-01-15', 'Minimum purchase $2000',2000, 7),
	--('NewYearSale', 0, 350, 'Flat', '2025-01-01', '2025-01-31', 'Minimum purchase $2300',2300, 8),
	--('BlackFriday', 0, 400, 'Percentage', '2024-11-20', '2024-11-30', 'Minimum purchase $2500',2500, 9),
	--('CyberMonday', 0, 450, 'Flat', '2024-12-01', '2024-12-05', 'Minimum purchase $2700',2700, 10),
	--('Valentines', 0, 500, 'Percentage', '2025-02-01', '2025-02-14', 'Minimum purchase $3000',3000, 11),
	--('Anniversary', 0, 550, 'Flat', '2025-03-01', '2025-03-31', 'Minimum purchase $5000',5000, 15);

	--VOUCHER LIST OF ORDER
	CREATE TABLE Banner (
		BannerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
		BannerName NVARCHAR(250), 
		ImageBanner NVARCHAR(MAX)
	);

	INSERT INTO Banner (BannerName, ImageBanner) VALUES 
	('Banner1', 'https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F1.png?alt=media&token=654c328b-49b2-48d0-b4d4-49b8481ecde5'),
	('Banner2','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F2.png?alt=media&token=8b3d610e-89f8-4775-b575-52b643b25d6a'),
	('Banner3','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F3.png?alt=media&token=cd9e8909-4929-47d7-8955-f5e445ca86f9'),
	('Banner4','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F4.png?alt=media&token=da272054-917f-4f8f-8fc8-97a19068b976'),
	('Banner5','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F5.png?alt=media&token=e4cc7b79-4d17-44e6-93f4-31e36d8356fb'),
	('Banner6','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F6.png?alt=media&token=8453313d-ca07-4b5a-b4d0-b0ee5c0f1bda'),
	('Banner7','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F7.png?alt=media&token=8555ab68-c0ba-4959-8da3-c90037bf4773'),
	('Banner8','https://firebasestorage.googleapis.com/v0/b/the-diamond-anh3.appspot.com/o/Banner%20Final%2F8.png?alt=media&token=3993bcd7-73a7-42c4-ac6f-34863c675d41');


-- Initialize variables
DECLARE @Counter1 INT = 1;  -- Initialize @Counter variable to 1
DECLARE @AccountID1 INT;    -- Variable to store random AccountID
DECLARE @DiamondID INT;     -- Variable to store random DiamondID
DECLARE @FeedbackContent1 NVARCHAR(MAX);  -- Variable to store feedback content
DECLARE @Rating1 INT;       -- Variable to store random rating

-- List of specific feedback content for diamonds
DECLARE @FeedbackContentList1 TABLE (
    Content NVARCHAR(MAX)
);

-- Populate the table with 20 distinct feedback content about diamonds
INSERT INTO @FeedbackContentList1 (Content)
VALUES
    ('The diamond sparkles beautifully. Very happy with my purchase!'),
    ('Impressive diamond clarity. It looks stunning on my finger.'),
    ('The diamond ring is elegant and timeless. Excellent craftsmanship.'),
    ('I love the design of the diamond ring. It exceeded my expectations.'),
    ('Great quality diamond. I highly recommend this jeweler.'),
    ('The diamond is perfect for our engagement. Thank you for a memorable experience.'),
    ('The diamond is brilliant and eye-catching.'),
    ('The diamond''s cut is exceptional. I am thrilled with my choice.'),
    ('The diamond is stunning. I couldn''t have asked for a better ring.'),
    ('The service was outstanding, and the diamond is flawless.'),
    ('The diamond exceeded all expectations. Perfect for our anniversary.'),
    ('Incredible sparkle and brilliance. The diamond is breathtaking.'),
    ('I am delighted with the diamond''s clarity and brilliance.'),
    ('The craftsmanship of the diamond ring is impeccable.'),
    ('The diamond is a symbol of our love. I couldn''t be happier.'),
    ('The diamond''s quality and brilliance are exceptional.'),
    ('I''m so impressed with the diamond''s shine and clarity.'),
    ('The diamond exceeded my expectations. Highly recommend!'),
    ('The diamond''s design is elegant and sophisticated.'),
    ('The service was excellent, and the diamond is perfect.');

-- Loop to insert random rows into Feedback table
WHILE @Counter1 <= 100  -- Insert up to 100 rows
BEGIN
    -- Generate random AccountID and DiamondID
    SET @AccountID1 = FLOOR(RAND() * (46 - 6 + 1) + 6);     -- Random AccountID between 6 and 46
    SET @DiamondID = FLOOR(RAND() * (30 - 1 + 1) + 1);      -- Random DiamondID between 1 and 30
    
    -- Select a random feedback content from the list
    SET @FeedbackContent1 = (
        SELECT TOP 1 Content 
        FROM @FeedbackContentList1
        ORDER BY NEWID()
    );

    -- Select a random rating from 1 to 5
    SET @Rating1 = FLOOR(RAND() * (5 - 1 + 1) + 1);  -- Random Rating between 1 and 5

    -- Insert into Feedback table
    INSERT INTO Feedback (AccountID, DiamondID, Content, Rating)
    VALUES (@AccountID1, @DiamondID, @FeedbackContent1, @Rating1);

    -- Increment the counter
    SET @Counter1 = @Counter1 + 1;
END;

-- Verify the number of rows inserted
SELECT COUNT(*) AS RowsInserted FROM Feedback;


--feedback Bridal
-- Initialize variables
DECLARE @Counter2 INT = 1;  -- Initialize @Counter variable to 1
DECLARE @BridalID INT;      -- Variable to store random BridalID
DECLARE @AccountID2 INT;    -- Variable to store random AccountID
DECLARE @FeedbackContent2 NVARCHAR(MAX);  -- Variable to store feedback content
DECLARE @Rating2 INT;       -- Variable to store random rating

-- List of possible bridal feedback content
DECLARE @BridalFeedbackList TABLE (
    Content NVARCHAR(MAX)
);

-- Populate the table with sample bridal feedback content
INSERT INTO @BridalFeedbackList (Content)
VALUES
    ('The diamond wedding ring is absolutely stunning. Perfect for our special day!'),
    ('We are delighted with our choice. The ring is elegant and fits perfectly.'),
    ('The craftsmanship is outstanding. We couldn''t be happier with our diamond wedding ring.'),
    ('The diamond wedding ring exceeded our expectations. Highly recommend!'),
    ('I fell in love with the diamond wedding ring as soon as I saw it. It''s perfect!'),
    ('We received so many compliments on our diamond wedding ring. Thank you!'),
    ('The diamond wedding ring symbolizes our love beautifully.'),
    ('Excellent service and a beautiful diamond wedding ring.'),
    ('I am thrilled with the diamond wedding ring. It''s even more beautiful than I imagined.'),
    ('The diamond wedding ring is a timeless piece. We will cherish it forever.'),
    ('The diamond wedding ring is exquisite. Thank you for making our day special.'),
    ('We couldn''t be happier with our diamond wedding ring. It''s everything we wanted and more.'),
    ('The diamond wedding ring is stunning. Thank you for the wonderful experience.'),
    ('Beautifully crafted diamond wedding ring. Highly recommended!'),
    ('The diamond wedding ring is gorgeous. We are very pleased with our purchase.'),
    ('The diamond wedding ring is elegant and sophisticated.'),
    ('The diamond wedding ring is simply perfect. Thank you for the excellent service!'),
    ('The diamond wedding ring is stunning and exceeded our expectations.'),
    ('We are very impressed with the diamond wedding ring. It''s beautiful.'),
    ('The diamond wedding ring is stunning and looks amazing on my finger.');

-- Loop to insert random rows into Feedback table
WHILE @Counter2 <= 30
BEGIN
    -- Set the BridalID to the current counter value
    SET @BridalID = @Counter2;

    -- Select a random AccountID between 6 and 46
    SET @AccountID2 = FLOOR(RAND() * (46 - 6 + 1)) + 6;

    -- Select a random feedback content from the list
    SET @FeedbackContent2 = (
        SELECT TOP 1 Content 
        FROM @BridalFeedbackList
        ORDER BY NEWID()
    );

    -- Select a random rating from 1 to 5
    SET @Rating2 = FLOOR(RAND() * (5 - 1 + 1)) + 1;

    -- Insert into Feedback table
    INSERT INTO Feedback (AccountID, BridalID, Content, Rating)
    VALUES (@AccountID2, @BridalID, @FeedbackContent2, @Rating2);

    -- Increment the counter
    SET @Counter2 = @Counter2 + 1;
END;

-- Verify the number of rows inserted
SELECT COUNT(*) AS RowsInserted FROM Feedback;
GO



-- Feedback for DiamondRings
DECLARE @Counter3 INT = 1;  -- Initialize @Counter variable to 1
DECLARE @AccountID3 INT;    -- Variable to store random AccountID
DECLARE @DiamondRingsID INT;    -- Variable to store DiamondRingsID
DECLARE @FeedbackContent3 NVARCHAR(MAX);  -- Variable to store feedback content
DECLARE @Rating3 INT;       -- Variable to store random rating

-- List of specific feedback content for DiamondRings
DECLARE @FeedbackContentList2 TABLE (
    Content NVARCHAR(MAX)
);

-- Populate the table with 20 distinct feedback content about DiamondRings
INSERT INTO @FeedbackContentList2 (Content)
VALUES
    ('The diamond ring is stunning. Great craftsmanship!'),
    ('I am very pleased with the design and quality of the diamond ring.'),
    ('The diamond ring looks even better in person. Highly recommended!'),
    ('The diamond ring fits perfectly. Very happy with my purchase.'),
    ('Beautiful diamond ring. It exceeded my expectations.'),
    ('The service was excellent, and the diamond ring is exquisite.'),
    ('The diamond ring is elegant and timeless.'),
    ('I love the diamond ring. It''s exactly what I wanted.'),
    ('The diamond ring sparkles beautifully. I couldn''t be happier.'),
    ('The diamond ring is a symbol of our love. Perfect for our anniversary.'),
    ('The diamond ring''s quality is outstanding. I am impressed.'),
    ('I''m so glad I chose this diamond ring. It''s perfect.'),
    ('The diamond ring is brilliant and eye-catching.'),
    ('The craftsmanship of the diamond ring is exceptional.'),
    ('The diamond ring exceeded my expectations. Excellent purchase!'),
    ('I''m impressed with the diamond ring''s clarity and brilliance.'),
    ('The diamond ring''s design is elegant and sophisticated.'),
    ('The service was excellent, and the diamond ring is flawless.'),
    ('The diamond ring is perfect for our engagement.'),
    ('The diamond ring exceeded all expectations. Highly recommend!');

-- Loop to insert random rows into Feedback table
WHILE @Counter3 <= 100  -- Insert up to 100 rows
BEGIN
    -- Generate random AccountID and DiamondRingsID
    SET @AccountID3 = FLOOR(RAND() * (46 - 6 + 1) + 6);     -- Random AccountID between 6 and 46
    SET @DiamondRingsID = FLOOR(RAND() * (30 - 1 + 1) + 1); -- Random DiamondRingsID between 1 and 30
    
    -- Select a random feedback content from the list
    SET @FeedbackContent3 = (
        SELECT TOP 1 Content 
        FROM @FeedbackContentList2
        ORDER BY NEWID()
    );

    -- Select a random rating from 1 to 5
    SET @Rating3 = FLOOR(RAND() * (5 - 1 + 1) + 1);  -- Random Rating between 1 and 5

    -- Insert into Feedback table
    INSERT INTO Feedback (AccountID, DiamondRingsID, Content, Rating)
    VALUES (@AccountID3, @DiamondRingsID, @FeedbackContent3, @Rating3);

    -- Increment the counter
    SET @Counter3 = @Counter3 + 1;
END;

-- Verify the number of rows inserted
SELECT COUNT(*) AS RowsInserted FROM Feedback;

GO


-- Feedback for DiamondTimepieces
DECLARE @Counter4 INT = 1;  -- Initialize @Counter variable to 1
DECLARE @AccountID4 INT;    -- Variable to store random AccountID
DECLARE @DiamondTimepiecesID INT;    -- Variable to store DiamondTimepiecesID
DECLARE @FeedbackContent4 NVARCHAR(MAX);  -- Variable to store feedback content
DECLARE @Rating4 INT;       -- Variable to store random rating

-- List of specific feedback content for DiamondTimepieces
DECLARE @FeedbackContentList3 TABLE (
    Content NVARCHAR(MAX)
);

-- Populate the table with 20 distinct feedback content about DiamondTimepieces
INSERT INTO @FeedbackContentList3 (Content)
VALUES
    ('The diamond timepiece is elegant and sophisticated.'),
    ('I am very pleased with the design and quality of the diamond watch.'),
    ('The diamond watch looks stunning. Highly recommended!'),
    ('The diamond watch fits perfectly. Very happy with my purchase.'),
    ('Beautiful diamond timepiece. It exceeded my expectations.'),
    ('The service was excellent, and the diamond watch is exquisite.'),
    ('The diamond watch is elegant and timeless.'),
    ('I love the diamond watch. It''s exactly what I wanted.'),
    ('The diamond timepiece sparkles beautifully. I couldn''t be happier.'),
    ('The diamond watch is a symbol of our love. Perfect for our anniversary.'),
    ('The diamond watch''s quality is outstanding. I am impressed.'),
    ('I''m so glad I chose this diamond timepiece. It''s perfect.'),
    ('The diamond watch is brilliant and eye-catching.'),
    ('The craftsmanship of the diamond timepiece is exceptional.'),
    ('The diamond watch exceeded my expectations. Excellent purchase!'),
    ('I''m impressed with the diamond timepiece''s clarity and brilliance.'),
    ('The diamond watch''s design is elegant and sophisticated.'),
    ('The service was excellent, and the diamond watch is flawless.'),
    ('The diamond watch is perfect for our engagement.'),
    ('The diamond watch exceeded all expectations. Highly recommend!');

-- Loop to insert random rows into Feedback table
WHILE @Counter4 <= 100  -- Insert up to 100 rows
BEGIN
    -- Generate random AccountID and DiamondTimepiecesID
    SET @AccountID4 = FLOOR(RAND() * (46 - 6 + 1) + 6);     -- Random AccountID between 6 and 46
    SET @DiamondTimepiecesID = FLOOR(RAND() * (30 - 1 + 1) + 1); -- Random DiamondTimepiecesID between 1 and 30
    
    -- Select a random feedback content from the list
    SET @FeedbackContent4 = (
        SELECT TOP 1 Content 
        FROM @FeedbackContentList3
        ORDER BY NEWID()
    );

    -- Select a random rating from 1 to 5
    SET @Rating4 = FLOOR(RAND() * (5 - 1 + 1) + 1);  -- Random Rating between 1 and 5

    -- Insert into Feedback table
    INSERT INTO Feedback (AccountID, DiamondTimepiecesID, Content, Rating)
    VALUES (@AccountID4, @DiamondTimepiecesID, @FeedbackContent4, @Rating4);

    -- Increment the counter
    SET @Counter4 = @Counter4 + 1;
END;

-- Verify the number of rows inserted
SELECT COUNT(*) AS RowsInserted FROM Feedback;

GO

CREATE TABLE PromotionsEvents (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName VARCHAR(100),
    EventDescription NVARCHAR(MAX),
    EventDate DATE,
    EventLocation VARCHAR(100),
    EventType VARCHAR(50)
);

INSERT INTO PromotionsEvents (EventName, EventDescription, EventDate, EventLocation, EventType)
VALUES
    ('Summer Sale', 'Biggest sale event of the year', '2024-07-15', 'New York', 'Sale'),
    ('Spring Festival', 'Celebrate the arrival of spring', '2024-03-21', 'Tokyo', 'Festival'),
    ('Grand Opening', 'Opening ceremony for our new store', '2024-05-10', 'London', 'Opening'),
    ('Black Friday', 'Special discounts and offers', '2024-11-29', 'Various Locations', 'Sale'),
    ('Product Launch', 'Introducing our latest product lineup', '2024-09-05', 'San Francisco', 'Launch'),
    ('Holiday Special', 'Celebrate the holidays with us', '2024-12-20', 'Paris', 'Special'),
    ('Clearance Sale', 'Clearing out last season inventory', '2024-08-15', 'Chicago', 'Sale'),
    ('Customer Appreciation Day', 'Thanking our loyal customers', '2024-10-12', 'Toronto', 'Customer'),
    ('Winter Wonderland', 'Experience winter magic', '2024-12-01', 'Stockholm', 'Festival'),
    ('Spring Clearance', 'Spring cleaning sale', '2024-04-10', 'Berlin', 'Sale'),
    ('Tech Expo', 'Showcasing latest technology innovations', '2024-09-18', 'Las Vegas', 'Expo'),
    ('Anniversary Celebration', 'Marking our anniversary', '2024-06-25', 'Sydney', 'Celebration'),
    ('Back to School', 'Gear up for the new school year', '2024-08-01', 'Boston', 'Sale'),
    ('Summer Festival', 'Fun-filled summer activities', '2024-07-01', 'Rio de Janeiro', 'Festival'),
    ('Gala Dinner', 'Elegant evening with fine dining', '2024-11-10', 'Vienna', 'Dinner'),
    ('Spring Sale', 'Seasonal discounts on selected items', '2024-04-01', 'Seoul', 'Sale'),
    ('Product Workshop', 'Hands-on workshop for our products', '2024-10-05', 'Singapore', 'Workshop'),
    ('Charity Event', 'Supporting a noble cause', '2024-09-15', 'Los Angeles', 'Charity'),
    ('Fashion Show', 'Showcasing latest fashion trends', '2024-05-20', 'Milan', 'Fashion'),
    ('Holiday Gala', 'Celebrating the festive season', '2024-12-15', 'Dubai', 'Gala'),
    ('Summer Camp', 'Outdoor activities for kids', '2024-07-05', 'Cape Town', 'Camp'),
    ('Autumn Harvest', 'Celebrating the autumn season', '2024-10-01', 'Amsterdam', 'Harvest'),
    ('Movie Night', 'Outdoor movie screening', '2024-08-20', 'Mexico City', 'Entertainment'),
    ('Art Exhibition', 'Showcasing local artists', '2024-06-15', 'Barcelona', 'Exhibition'),
    ('Fitness Challenge', 'Join us for a fitness challenge', '2024-09-30', 'Berlin', 'Challenge'),
    ('Winter Sale', 'Chill out with our winter deals', '2024-12-05', 'Moscow', 'Sale'),
    ('Easter Celebration', 'Egg-citing Easter activities', '2024-04-05', 'London', 'Celebration'),
    ('Technology Summit', 'Discussing future tech trends', '2024-11-05', 'San Francisco', 'Summit'),
    ('Community Fair', 'Connecting with the community', '2024-08-10', 'Toronto', 'Fair'),
    ('Halloween Party', 'Spooky fun for everyone', '2024-10-31', 'New York', 'Party');

	PRINT '==================CREATE DATABASE SUCCESSFULLY!=================='