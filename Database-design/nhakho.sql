/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS WAREHOUSE;
CREATE DATABASE WAREHOUSE;
USE WAREHOUSE;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
DROP TABLE IF EXISTS `UNITS`;
CREATE TABLE `UNITS`(
	UNIT_ID						INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	UNIT_NAME					NVARCHAR(255) NOT NULL UNIQUE KEY,
    UNIT_DESCRIPTION    		NVARCHAR(255),
    --  IS_STATUS					BIT,
	DELETE_STATUS       		BIT DEFAULT 0
);
/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCTS`;
CREATE TABLE `PRODUCTS`(
	PRODUCT_ID 					INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PRODUCT_NAME 				NVARCHAR(255) NOT NULL,
	VIEWCOUNT					INT,												-- SO LA XEM SAN PHAM		
    SEOALIAS					NVARCHAR(255),										-- SEO WEB
    -- PRODUCT_IMG_ID  			INT,												-- HINH ANH HIEN THI
    IS_STATUS					BIT DEFAULT 1,										-- HIEN THI
    DELETE_STATUS       		BIT DEFAULT 0										-- TRANG THAI XOA
);

/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCT_DETAILS`;
CREATE TABLE `PRODUCT_DETAILS`(
	PRODUCT_DETAIL_ID			INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PRODUCT_ID 					INT UNSIGNED NOT NULL,
	PRODUCT_CODE				NVARCHAR(255),										-- SO LA XEM SAN PHAM		
    -- SEOALIAS					NVARCHAR(200),										-- SEO WEB
    -- PRODUCT_IMG_ID  			INT,												-- HINH ANH HIEN THI
    IS_STATUS					BIT DEFAULT 1,
    PRODUCT_DETAIL_DESCRIPTION	TEXT,												-- KHONG GIOI HAN DO DAI CHUOI
    FOREIGN KEY (PRODUCT_ID) REFERENCES `PRODUCTS`(PRODUCT_ID)
);

/*======================================================================================*/

DROP TABLE IF EXISTS `PRODUCT_DETAIL_UNITS`;
CREATE TABLE `PRODUCT_DETAIL_UNITS`(
	PRODUCT_DETAIL_UNIT_ID					INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_DETAIL_ID						INT UNSIGNED NOT NULL,
	UNIT_ID    								INT UNSIGNED NOT NULL,
	IS_MAIN									BIT,
	CONVERSIONRATIO     					INT,													-- TY LE SO VOI DON VI TINH DUOC CHON TRUOC DO
    RATIO_TYPE  							ENUM('Default','Percent'),								-- KIEU CHUYEN DOI %, DVT
    RATIO_TO_UNIT							INT UNSIGNED NOT NULL,								-- DVT PHU THUOC VAO
    IS_STATUS								BIT DEFAULT 1,
	-- PRIMARY KEY (PRODUCT_ID,PRODUCT_DETAIL_ID,UNIT_ID),
    FOREIGN KEY (PRODUCT_DETAIL_ID) REFERENCES `PRODUCT_DETAILS` (PRODUCT_DETAIL_ID),
    FOREIGN KEY (UNIT_ID) REFERENCES `UNITS` (UNIT_ID)
);

/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCT_DETAIL_UNIT_INVENTORIES`;
-- 1 SP CO NHIEU SP PHAM TAO THANH BO SAN PHAM NEN SP SE CO NHIEU SP NHAP VAO THOI DIEM KHAC NHAU NEN
-- SE QUAN LY SO LUONG SP VA DON GIA CUA TUNG SP THEO RIENG BIET
CREATE TABLE `PRODUCT_DETAIL_UNIT_INVENTORIES`(
	PRODUCT_DETAIL_UNIT_INVENTORIE_ID		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_DETAIL_UNIT_ID					INT UNSIGNED NOT NULL,
	INPUT_DATE								DATETIME NOT NULL,
    UNIT_PRICE		    					DOUBLE,												-- GIA VON
	RETAIL_PRICE       						DOUBLE,												-- GIA BAN LE
    WHOLESALE_PRICE 						DOUBLE,												-- GIA SI
    SALE_PRICE								DOUBLE,												-- GIA SALE
    INPUT_QUANTITY							DOUBLE,
    INVENTORY_QUANTITY						DOUBLE,
    IS_STATUS								BIT DEFAULT 1,
    PRODUCT_DETAIL_BARCODE					NVARCHAR(255),										-- SO LA XEM SAN PHAM
	-- FOREIGN KEY (RATIO_TO_UNIT_ID) REFERENCES `UNITS` (ID),
    FOREIGN KEY (PRODUCT_DETAIL_UNIT_ID) REFERENCES `PRODUCT_DETAIL_UNITS` (PRODUCT_DETAIL_UNIT_ID)
);


/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/

INSERT INTO `UNITS` 
(UNIT_NAME, UNIT_DESCRIPTION, DELETE_STATUS) VALUES
("THÙNG"  ,"THUNG"	        ,0				),						
("LON"	  ,"LON"			,0				),						
("LỐC"	  ,"LOC"			,0				),						
("M2"	  ,"MÉT VUÔNG"	    ,0				),						
("CHAI"	  ,"CHAI"			,0				),						
("KIỆN"	  ,"KIỆN"			,0				);						
												
INSERT INTO `PRODUCTS` 
(PRODUCT_NAME, VIEWCOUNT,SEOALIAS				, IS_STATUS, DELETE_STATUS) 	VALUES 	
("PRODUCT 1" 	,0		,"SEOALIAS PRODUC 1"	,1			,0			),				
("PRODUCT 2"	,0		,"SEOALIAS PRODUC 2"	,1			,0			),				
("PRODUCT 3"	,0		,"SEOALIAS PRODUC 3"	,1			,0			),				
("PRODUCT 4"	,0		,"SEOALIAS PRODUC 4"	,1			,0			),				
("PRODUCT 5"	,0		,"SEOALIAS PRODUC 5"	,1			,0			);				
												
INSERT INTO `PRODUCT_DETAILS` 
(PRODUCT_ID, PRODUCT_CODE, IS_STATUS, PRODUCT_DETAIL_DESCRIPTION	) 	VALUES 	
(1			,0001		 ,1			, "PRODUCT_DETAIL_DESCRIPTION_1");					
												
												
INSERT INTO `PRODUCT_DETAIL_UNITS` 
(PRODUCT_DETAIL_ID, UNIT_ID, IS_MAIN, CONVERSIONRATIO, RATIO_TYPE, RATIO_TO_UNIT, IS_STATUS) 	VALUES 	
(1				  ,2	   ,1   	,1			     ,'Default'	 ,2		        ,1	    	),		
(1				  ,3	   ,0	    ,6	             ,'Default'	 ,2	            ,1			),		
(1				  ,1	   ,0	    ,24	             ,'Default'	 ,2				,1			);		
												
																								
INSERT INTO `PRODUCT_DETAIL_UNIT_INVENTORIES` 
(PRODUCT_DETAIL_UNIT_ID, INPUT_DATE, UNIT_PRICE, RETAIL_PRICE, WHOLESALE_PRICE,SALE_PRICE,INPUT_QUANTITY,INVENTORY_QUANTITY,IS_STATUS,PRODUCT_DETAIL_BARCODE) 	VALUES 	
(	1				   ,NOW()	   ,8000	   ,10000	     ,8500			  ,0		 ,240			,240	  ,1		,"1120000800"			   ),
(	2				   ,NOW()	   ,48000	   ,60000	     ,51000			  ,0		 ,40			,40	  ,1		,"1120000850"			   ),
(	3				   ,NOW()	   ,192000	   ,240000	     ,204000		  ,0		 ,10			,10	  ,1		,"1120001920"			   );


/*============================== GET DATABASE =======================================*/
/*======================================================================================*/
SELECT * FROM products join product_details 				on products.PRODUCT_ID = product_details.PRODUCT_ID 
					   join product_detail_units 			on product_details.PRODUCT_DETAIL_ID = product_detail_units.PRODUCT_DETAIL_ID
                       join product_detail_unit_inventories on product_detail_units.PRODUCT_DETAIL_UNIT_ID= product_detail_unit_inventories.PRODUCT_DETAIL_UNIT_ID;


SELECT * FROM products left join product_details 				 on products.PRODUCT_ID = product_details.PRODUCT_ID 
					   left join product_detail_units 			 on product_details.PRODUCT_DETAIL_ID = product_detail_units.PRODUCT_DETAIL_ID
                       left join product_detail_unit_inventories on product_detail_units.PRODUCT_DETAIL_UNIT_ID= product_detail_unit_inventories.PRODUCT_DETAIL_UNIT_ID;











