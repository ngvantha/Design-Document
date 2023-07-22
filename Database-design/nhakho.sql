/*============================== CREATE DATABASE =======================================*/
/*======================================================================================*/
DROP DATABASE IF EXISTS WAREHOUSE;
CREATE DATABASE WAREHOUSE;
USE WAREHOUSE;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/
DROP TABLE IF EXISTS `UNITS`;
CREATE TABLE `UNITS`(
	UNIT_ID						TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	UNIT_NAME					NVARCHAR(200) NOT NULL,
    UNIT_DESCRIPTION    		NVARCHAR(200),
    --  IS_STATUS					BIT,
	DELETE_STATUS       		BIT
);
/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCTS`;
CREATE TABLE `PRODUCTS`(
	PRODUCT_ID 					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PRODUCT_NAME 				NVARCHAR(200) NOT NULL,
	VIEWCOUNT					INT,												-- SO LA XEM SAN PHAM		
    SEOALIAS					NVARCHAR(200),										-- SEO WEB
    -- PRODUCT_IMG_ID  			INT,												-- HINH ANH HIEN THI
    IS_STATUS					BIT,												-- HIEN THI
    DELETE_STATUS       		BIT													-- TRANG THAI XOA
);

/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCT_DETAILS`;
CREATE TABLE `PRODUCT_DETAILS`(
	PRODUCT_DETAIL_ID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PRODUCT_ID 					TINYINT,
	PRODUCT_CODE				NVARCHAR(200),										-- SO LA XEM SAN PHAM		
    -- SEOALIAS					NVARCHAR(200),										-- SEO WEB
    -- PRODUCT_IMG_ID  			INT,												-- HINH ANH HIEN THI
    IS_STATUS					BIT,
    PRODUCT_DETAIL_DESCRIPTION	TEXT,												-- KHONG GIOI HAN DO DAI CHUOI
    FOREIGN KEY (PRODUCT_ID) REFERENCES `PRODUCTS` (PRODUCT_ID)
);

/*======================================================================================*/

DROP TABLE IF EXISTS `PRODUCT_DETAILS_UNITS`;
CREATE TABLE `PRODUCT_DETAILS_UNITS`(
	PRODUCT_DETAIL_UNIT_ID					TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_DETAIL_ID						TINYINT UNSIGNED NOT NULL,
	UNIT_ID    								TINYINT NOT NULL,
    PRODUCT_DETAIL_CODE						NVARCHAR(200),										-- SO LA XEM SAN PHAM
	IS_MAIN									BIT,
	CONVERSIONRATIO     					INT,												-- TY LE SO VOI DON VI TINH DUOC CHON TRUOC DO
    RATIO_TYPE  							NVARCHAR(10),										-- KIEU CHUYEN DOI %, DVT
    RATIO_TO_UNIT							TINYINT,											-- DVT PHU THUOC VAO
    IS_STATUS								BIT,
	-- PRIMARY KEY (PRODUCT_ID,PRODUCT_DETAIL_ID,UNIT_ID),
    FOREIGN KEY (PRODUCT_DETAIL_ID) REFERENCES `PRODUCT_DETAILS` (PRODUCT_DETAIL_ID),
    FOREIGN KEY (UNIT_ID) REFERENCES `UNITS` (UNIT_ID)
);

/*======================================================================================*/
DROP TABLE IF EXISTS `PRODUCT_DETAIL_UNIT_INVENTORIES`;
-- 1 SP CO NHIEU SP PHAM TAO THANH BO SAN PHAM NEN SP SE CO NHIEU SP NHAP VAO THOI DIEM KHAC NHAU NEN
-- SE QUAN LY SO LUONG SP VA DON GIA CUA TUNG SP THEO RIENG BIET
CREATE TABLE `PRODUCT_DETAIL_UNIT_INVENTORIES`(
	PRODUCT_DETAIL_UNIT_INVENTORIE_ID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_DETAIL_UNIT_ID					TINYINT UNSIGNED NOT NULL,
	INPUT_DATE								DATETIME NOT NULL,
    UNIT_PRICE		    					DOUBLE,												-- GIA VON
	RETAIL_PRICE       						DOUBLE,												-- GIA BAN LE
    WHOLESALE_PRICE 						DOUBLE,												-- GIA SI
    SALE_PRICE								DOUBLE,												-- GIA SALE
    RATIO_TO_UNIT							TINYINT,											-- DVT PHU THUOC VAO
    QUANTITY								DOUBLE,
    IS_STATUS								BIT,
	-- FOREIGN KEY (RATIO_TO_UNIT_ID) REFERENCES `UNITS` (ID),
    FOREIGN KEY (PRODUCT_DETAIL_UNIT_ID) REFERENCES `PRODUCT_DETAILS_UNITS` (PRODUCT_DETAIL_UNIT_ID)
);


/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
















