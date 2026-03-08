-- ============================================================
--                    BLOODBANK PROJECT
-- ============================================================

CREATE DATABASE bloodBankDB;
USE bloodBankDB;

-- -----------------------1. Manager Table--------------------
-- ----------------> Manages requests From Hospital

CREATE TABLE Manager(
    M_id INT,
    M_name VARCHAR(40),
    M_age INT,
    M_phno VARCHAR(40),
    PRIMARY KEY(M_id)
);

-- ------------------------2. Blood Bank--------------------
-- ---------------> It manages requests received from manager

CREATE TABLE Bloodbank(
    BB_id INT,
    BB_name TEXT,
    Street INT,
    BB_add VARCHAR(50),
    PRIMARY KEY(BB_id)
);

-- -------------------------3. Manager_BloodBank----------------
-- --> Links Manager and Bloodbank using foreign keys

CREATE TABLE Bloodbank_manager(
    M_id INT,
    BB_id INT,
    CONSTRAINT PK_Bloodbank_manager PRIMARY KEY (M_id, BB_id),
    CONSTRAINT FK_Bloodbank_manager_Manager FOREIGN KEY (M_id) REFERENCES Manager(M_id),
    CONSTRAINT FK_Bloodbank_manager_Bloodbank FOREIGN KEY (BB_id) REFERENCES Bloodbank(BB_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------4. Register Team--------------------------------
-- --------------> Works in Blood bank, registers patients and donors

CREATE TABLE Registration_teamm(
    RT_id INT PRIMARY KEY,
    RT_Name VARCHAR(20),
    RT_members INT,
    BB_id INT,
    CONSTRAINT FK_Registration_teamm_Bloodbank FOREIGN KEY(BB_id) REFERENCES Bloodbank(BB_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -------------------------5. Technical Analyst--------------------------
-- ----------------> Works in blood bank, examines donor blood

CREATE TABLE Technical_analyst137(
    TA_id INT PRIMARY KEY,
    TA_Name VARCHAR(40),
    TA_ph_nO VARCHAR(30),
    BB_id INT,
    CONSTRAINT FK_Technical_analyst137_Bloodbank FOREIGN KEY(BB_id) REFERENCES Bloodbank(BB_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------6. Blood Donated---------------------------
-- -----------------> Records donated blood type and manager

CREATE TABLE Blood_donated(
    BG_id INT,
    BG_type VARCHAR(3),
    M_id INT,
    CONSTRAINT PK_Blood_donated PRIMARY KEY(BG_id, BG_type),
    CONSTRAINT FK_Blood_donated_Manager FOREIGN KEY(M_id) REFERENCES Manager(M_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------7. Patient---------------------------

CREATE TABLE Patient137(
    P_id INT PRIMARY KEY,
    P_Name VARCHAR(40),
    P_Gender VARCHAR(20),
    P_phno VARCHAR(30),
    P_add VARCHAR(30),
    BG_type VARCHAR(3),
    RT_id INT,
    M_id INT,
    DATE_REG DATE,
    CONSTRAINT FK_Patient137_Registration_teamm FOREIGN KEY (RT_id) REFERENCES Registration_teamm(RT_id),
    CONSTRAINT FK_Patient137_Manager FOREIGN KEY(M_id) REFERENCES Manager(M_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -----------------------------------8. Blood Request------------------------

CREATE TABLE BloodRequest(
    RQ_id INT PRIMARY KEY,
    BG_type VARCHAR(3),
    Amount_blood INT  -- Amount in number of bags
);

-- ------------------------------9. Patient Request----------------------------------

CREATE TABLE PatientRequest(
    P_id INT,
    RQ_id INT,
    CONSTRAINT PK_PatientRequest PRIMARY KEY (P_id, RQ_id),
    CONSTRAINT FK_PatientRequest_Patient137 FOREIGN KEY(P_id) REFERENCES Patient137(P_id),
    CONSTRAINT FK_PatientRequest_BloodRequest FOREIGN KEY(RQ_id) REFERENCES BloodRequest(RQ_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -------------------------------10. Hospital--------------------------------

CREATE TABLE Hospital(
    H_id INT PRIMARY KEY,
    H_name VARCHAR(30),
    M_id INT,
    H_add CHAR(30),
    street INT,
    CONSTRAINT FK_Hospital_Manager FOREIGN KEY(M_id) REFERENCES Manager(M_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------11. Hospital Request------------------

CREATE TABLE Hospitalrequestt(
    H_id INT,
    RQ_id INT,
    CONSTRAINT PK_Hospitalrequestt PRIMARY KEY (H_id, RQ_id),
    CONSTRAINT FK_Hospitalrequestt_Hospital FOREIGN KEY(H_id) REFERENCES Hospital(H_id),
    CONSTRAINT FK_Hospitalrequestt_BloodRequest FOREIGN KEY(RQ_id) REFERENCES BloodRequest(RQ_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- -------------------------------12. Blood Received---------------------------

CREATE TABLE BLoodreceived(
    BG_id INT,
    BG_type VARCHAR(3),
    P_id INT,
    CONSTRAINT PK_BLoodreceived PRIMARY KEY(P_id, BG_id, BG_type),
    CONSTRAINT FK_BLoodreceived_Blood_donated FOREIGN KEY(BG_id, BG_type) REFERENCES Blood_donated(BG_id, BG_type),
    CONSTRAINT FK_BLoodreceived_Patient137 FOREIGN KEY(P_id) REFERENCES Patient137(P_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------13. Technical Analyst Blood------------------------

CREATE TABLE Tecanalyst_blood(
    BG_id INT,
    BG_type VARCHAR(3),
    TA_id INT,
    CONSTRAINT PK_Tecanalyst_blood PRIMARY KEY(TA_id, BG_id, BG_type),
    CONSTRAINT FK_Tecanalyst_blood_Technical_analyst137 FOREIGN KEY(TA_id) REFERENCES Technical_analyst137(TA_id),
    CONSTRAINT FK_Tecanalyst_blood_Blood_donated FOREIGN KEY(BG_id, BG_type) REFERENCES Blood_donated(BG_id, BG_type) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ---------------------------14. Donor---------------------------------------------

CREATE TABLE Donor(
    D_id INT PRIMARY KEY,
    D_name VARCHAR(40),
    D_gender CHAR(1),
    D_phno VARCHAR(30),
    Dt_reg DATE,
    D_add VARCHAR(30),
    D_age INT,
    D_disease VARCHAR(30),
    BG_id INT,
    BG_type VARCHAR(3),
    RT_id INT,
    CONSTRAINT FK_Donor_Blood_donated FOREIGN KEY (BG_id, BG_type) REFERENCES Blood_donated(BG_id, BG_type),
    CONSTRAINT FK_Donor_Registration_teamm FOREIGN KEY(RT_id) REFERENCES Registration_teamm(RT_id) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ============================================================
--                  STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- ----------------------1. Manager Procedure------------------------

CREATE PROCEDURE Manager37_PROCE4(
    IN p_id INT,
    IN p_name VARCHAR(40),
    IN p_age INT,
    IN p_phno VARCHAR(40),
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' AND p_id = 0 THEN
        SELECT * FROM Manager;
    END IF;
    IF p_type = 'SELECT' AND p_id != 0 THEN
        SELECT * FROM Manager WHERE M_id = p_id;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Manager(M_id, M_name, M_age, M_phno)
        VALUES(p_id, p_name, p_age, p_phno);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Manager SET M_name = p_name, M_age = p_age, M_phno = p_phno
        WHERE M_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Manager WHERE M_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL Manager37_PROCE4(101, 'M Qasim', 43, '0323-7758373', 'INSERT');
CALL Manager37_PROCE4(102, 'M Bilal', 35, '0312-9374628', 'INSERT');
CALL Manager37_PROCE4(103, 'CH Zaheer', 29, '0303-2084674', 'INSERT');
CALL Manager37_PROCE4(104, 'Muhsin', 35, '0311-0277479', 'INSERT');
CALL Manager37_PROCE4(105, 'Hamza Ali', 23, '0322-9264720', 'INSERT');
CALL Manager37_PROCE4(106, 'Zubair', 51, '0307-0200387', 'INSERT');
CALL Manager37_PROCE4(107, 'Usaman', 26, '0302-2943369', 'INSERT');
CALL Manager37_PROCE4(108, 'Haider Ali', 39, '0319-2842743', 'INSERT');
CALL Manager37_PROCE4(109, 'M Amir', 40, '0342-0123840', 'INSERT');
CALL Manager37_PROCE4(110, 'M Bilal', 33, '0321-1102708', 'INSERT');
CALL Manager37_PROCE4(111, 'Zeeshan', 30, '0348-0282930', 'INSERT');
CALL Manager37_PROCE4(112, 'Hassan Ali', 51, '0301-1277911', 'INSERT');
CALL Manager37_PROCE4(113, 'Faisal', 44, '0309-3107911', 'INSERT');
CALL Manager37_PROCE4(0, '', 0, '', 'SELECT');
CALL Manager37_PROCE4(112, 'Ijaz Ali', 52, '0347-3302300', 'UPDATE');
CALL Manager37_PROCE4(0, '', 0, '', 'DELETE');


DELIMITER $$

-- ---------------------2. Blood Bank Procedure------------------

CREATE PROCEDURE BB73_PROCE4(
    IN p_id INT,
    IN p_name TEXT,
    IN p_street INT,
    IN p_add VARCHAR(50),
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' AND p_id = 0 THEN
        SELECT * FROM Bloodbank;
    END IF;
    IF p_type = 'SELECT' AND p_id != 0 THEN
        SELECT * FROM Bloodbank WHERE BB_id = p_id;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Bloodbank(BB_id, BB_name, Street, BB_add)
        VALUES(p_id, p_name, p_street, p_add);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Bloodbank SET BB_name = p_name, Street = p_street, BB_add = p_add
        WHERE BB_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Bloodbank WHERE BB_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL BB73_PROCE4(210, 'Noor-ul-Ain Dyra', 4, 'Chniot', 'INSERT');
CALL BB73_PROCE4(211, 'Madina Teaching Hospital', 5, 'Faislabad', 'INSERT');
CALL BB73_PROCE4(212, 'Blood Independent university', 9, 'Lahore', 'INSERT');
CALL BB73_PROCE4(213, 'District Blood Transfusion Bank', 12, 'Bahawlnagr', 'INSERT');
CALL BB73_PROCE4(214, 'Regional Blood Center', 18, 'Bahawlnagr', 'INSERT');
CALL BB73_PROCE4(215, 'Blood Bank DHQ Hospital', 14, 'Faislabad', 'INSERT');
CALL BB73_PROCE4(216, 'Blood Bank PIC', 10, 'Lahore', 'INSERT');
CALL BB73_PROCE4(217, 'INMOL Blood Bank', 13, 'Gujrat', 'INSERT');
CALL BB73_PROCE4(218, 'Fatmid Foundation', 16, 'Lahore', 'INSERT');
CALL BB73_PROCE4(219, 'SUNDUS Foundation Blood Bank', 14, 'Gujrat', 'INSERT');
CALL BB73_PROCE4(220, 'Fatmid Foundation Multan', 5, 'Multan', 'INSERT');
CALL BB73_PROCE4(221, 'Samina Amanat Lab & Medical', 17, 'Rawalpindi', 'INSERT');
CALL BB73_PROCE4(222, 'Blood Bank Kalsoom Society', 18, 'Sialkot', 'INSERT');
CALL BB73_PROCE4(0, '', 0, '', 'SELECT');
CALL BB73_PROCE4(213, 'AQ Bloodbank', 2, 'Kashmir', 'UPDATE');
CALL BB73_PROCE4(217, '', 0, '', 'DELETE');


-- ===== INSERT DATA (needs procedures to run first) =====

INSERT INTO Bloodbank_manager VALUES
(101,210),(102,211),(103,212),(104,213),(105,214),(106,215),
(107,216),(108,217),(109,218),(110,219),(111,220),(112,221);
SELECT * FROM Bloodbank_manager;


DELIMITER $$

-- -------3. Registration Team Procedure-----------

CREATE PROCEDURE Register_PROCE4(
    IN p_id INT,
    IN p_Name VARCHAR(20),
    IN p_members INT,
    IN p_BB_id INT,
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' AND p_id = 0 THEN
        SELECT * FROM Registration_teamm;
    END IF;
    IF p_type = 'SELECT' AND p_id != 0 THEN
        SELECT * FROM Registration_teamm WHERE RT_id = p_id;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Registration_teamm(RT_id, RT_Name, RT_members, BB_id)
        VALUES(p_id, p_Name, p_members, p_BB_id);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Registration_teamm SET RT_Name = p_Name, RT_members = p_members, BB_id = p_BB_id
        WHERE RT_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Registration_teamm WHERE RT_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL Register_PROCE4(600, 'Team A', 10, 210, 'INSERT');
CALL Register_PROCE4(601, 'Team B', 15, 211, 'INSERT');
CALL Register_PROCE4(602, 'Team C', 13, 212, 'INSERT');
CALL Register_PROCE4(603, 'Team D', 17, 213, 'INSERT');
CALL Register_PROCE4(604, 'Team E', 20, 214, 'INSERT');
CALL Register_PROCE4(605, 'Team F', 10, 215, 'INSERT');
CALL Register_PROCE4(606, 'Team G', 17, 216, 'INSERT');
CALL Register_PROCE4(607, 'Team H', 14, 217, 'INSERT');
CALL Register_PROCE4(608, 'Team I', 19, 218, 'INSERT');
CALL Register_PROCE4(609, 'Team J', 23, 219, 'INSERT');
CALL Register_PROCE4(610, 'Team K', 15, 220, 'INSERT');
CALL Register_PROCE4(611, 'Team L', 27, 221, 'INSERT');
CALL Register_PROCE4(0, '', 0, 0, 'SELECT');
CALL Register_PROCE4(608, 'TEAM H', 24, 210, 'UPDATE');
CALL Register_PROCE4(608, '', 0, 0, 'DELETE');


DELIMITER $$

-- -------4. Technical Analyst Procedure-----------

CREATE PROCEDURE TA37_PROCE4(
    IN p_id INT,
    IN p_name VARCHAR(40),
    IN p_phno VARCHAR(30),
    IN p_BB_id INT,
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' AND p_id = 0 THEN
        SELECT * FROM Technical_analyst137;
    END IF;
    IF p_type = 'SELECT' AND p_id != 0 THEN
        SELECT * FROM Technical_analyst137 WHERE TA_id = p_id;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Technical_analyst137(TA_id, TA_Name, TA_ph_nO, BB_id)
        VALUES(p_id, p_name, p_phno, p_BB_id);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Technical_analyst137 SET TA_Name = p_name, TA_ph_nO = p_phno, BB_id = p_BB_id
        WHERE TA_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Technical_analyst137 WHERE TA_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL TA37_PROCE4(411, 'M Rashid', '0321-2638201', 211, 'INSERT');
CALL TA37_PROCE4(412, 'Nauman Rao', '0300-1799192', 212, 'INSERT');
CALL TA37_PROCE4(413, 'SHakeel Ahmed', '0301-0126382', 213, 'INSERT');
CALL TA37_PROCE4(414, 'Rana Younas', '0331-2198372', 214, 'INSERT');
CALL TA37_PROCE4(415, 'Ashraf Khan', '0310-3823911', 215, 'INSERT');
CALL TA37_PROCE4(416, 'Sufyan Ali', '0303-2927293', 216, 'INSERT');
CALL TA37_PROCE4(417, 'Ramzan', '0323-1232989', 217, 'INSERT');
CALL TA37_PROCE4(418, 'Yaqoob', '0302-0388182', 218, 'INSERT');
CALL TA37_PROCE4(419, 'Aslam Rana', '0311-0987666', 219, 'INSERT');
CALL TA37_PROCE4(420, 'Rizvan Ali', '0304-2138201', 220, 'INSERT');
CALL TA37_PROCE4(421, 'M Ali', '0341-2138291', 221, 'INSERT');
CALL TA37_PROCE4(422, 'Mujahid', '0340-1349201', 222, 'INSERT');
CALL TA37_PROCE4(0, '', '', 0, 'SELECT');
CALL TA37_PROCE4(419, 'Ramzan Ali', '0304-21382911', 210, 'UPDATE');
CALL TA37_PROCE4(0, '', '', 0, 'DELETE');


-- ===== INSERT Blood Donated Data =====

INSERT INTO Blood_donated VALUES
(1131,'A-',101),(1132,'B+',106),(1133,'O-',102),(1134,'B-',108),(1135,'B-',104),
(1136,'AB-',103),(1137,'A+',105),(1139,'AB+',102),(1140,'A+',108),(1142,'B+',110),
(1144,'AB+',113),(1145,'A-',102),(1147,'B+',104),(1148,'O-',109),(1150,'AB+',107),
(1151,'O+',105),(1152,'AB+',101),(1153,'B+',106),(1154,'A+',108),(1155,'O+',103),
(1156,'O+',102),(1157,'AB-',101);
SELECT * FROM Blood_donated;


DELIMITER $$

-- -------5. Patient Procedure-----------

CREATE PROCEDURE PT37_PROCE4(
    IN p_id INT,
    IN p_name VARCHAR(40),
    IN p_Gender VARCHAR(20),
    IN p_phno VARCHAR(30),
    IN p_addr VARCHAR(30),
    IN p_BG_type VARCHAR(3),
    IN p_RT_id INT,
    IN p_M_id INT,
    IN p_DATE_REG DATE,
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' THEN
        SELECT * FROM Patient137;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Patient137(P_id, P_Name, P_Gender, P_phno, P_add, BG_type, RT_id, M_id, DATE_REG)
        VALUES(p_id, p_name, p_Gender, p_phno, p_addr, p_BG_type, p_RT_id, p_M_id, p_DATE_REG);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Patient137 SET P_Name = p_name, P_Gender = p_Gender, P_phno = p_phno,
        P_add = p_addr, BG_type = p_BG_type, RT_id = p_RT_id, M_id = p_M_id, DATE_REG = p_DATE_REG
        WHERE P_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Patient137 WHERE P_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL PT37_PROCE4(1001,'Zainab','Female','0323-2322443','Gujrat','A+',601,102,'2023-01-12','INSERT');
CALL PT37_PROCE4(1002,'Haider','Male','0301-0273878','Lahore','B-',602,105,'2023-06-11','INSERT');
CALL PT37_PROCE4(1003,'Maryam','Female','0312-8374799','Gujranwala','A+',603,104,'2023-08-25','INSERT');
CALL PT37_PROCE4(1004,'Ahmed','Male','0300-0192829','Peshawar','O-',604,110,'2023-01-27','INSERT');
CALL PT37_PROCE4(1005,'Zain','Male','0321-0987232','Quetta','AB+',605,109,'2022-01-18','INSERT');
CALL PT37_PROCE4(1006,'Mehak','Female','0300-2344213','Lahore','B+',606,113,'2023-11-16','INSERT');
CALL PT37_PROCE4(1007,'Haider Ali','Male','0305-2922443','Gujrat','O+',607,111,'2023-08-23','INSERT');
CALL PT37_PROCE4(1008,'Zubair','Male','0345-2389143','Gujranwala','AB+',608,107,'2022-01-12','INSERT');
CALL PT37_PROCE4(1009,'Laiba','Female','0340-2000233','Gujrat','B+',609,106,'2023-08-02','INSERT');
CALL PT37_PROCE4(1010,'Sadiq','Male','0301-2311143','Faislabad','A+',610,108,'2023-01-22','INSERT');
CALL PT37_PROCE4(0,'','','','','',0,0,NULL,'SELECT');
CALL PT37_PROCE4(1020,'Zain Ali','Male','0343-0019241','Gujrat','A+',6,102,'2023-08-28','UPDATE');
CALL PT37_PROCE4(0,'','','','','',0,0,NULL,'DELETE');


-- ===== INSERT BloodRequest Data =====

INSERT INTO BloodRequest VALUES
(1,'A+',1),(2,'O+',2),(3,'A-',1),(4,'AB-',1),(5,'B+',2),(6,'O-',1),(7,'AB+',3),
(8,'A+',2),(9,'B+',1),(10,'A-',1),(11,'B-',2),(12,'O+',1),(13,'O-',1),
(14,'B+',1),(15,'AB+',1),(16,'AB-',1);
SELECT * FROM BloodRequest;

INSERT INTO PatientRequest VALUES
(1001,4),(1002,6),(1003,1),(1004,14),(1005,9),(1006,15),(1007,12),(1008,3),(1009,13),(1010,10);
SELECT * FROM PatientRequest;


DELIMITER $$

-- -------6. Hospital Procedure-----------

CREATE PROCEDURE Hosp_PROCE4(
    IN p_id INT,
    IN p_name VARCHAR(40),
    IN p_M_id INT,
    IN p_add CHAR(30),
    IN p_Street INT,
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' THEN
        SELECT * FROM Hospital;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Hospital(H_id, H_name, M_id, H_add, street)
        VALUES(p_id, p_name, p_M_id, p_add, p_Street);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Hospital SET H_name = p_name, H_add = p_add, M_id = p_M_id, street = p_Street
        WHERE H_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Hospital WHERE H_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL Hosp_PROCE4(1, 'AKram Eye Hospital', 104, 'Lahore', 3, 'INSERT');
CALL Hosp_PROCE4(2, 'CMH Hospital', 109, 'Lahore', 6, 'INSERT');
CALL Hosp_PROCE4(3, 'Heart care', 102, 'Rawalpindi', 7, 'INSERT');
CALL Hosp_PROCE4(4, 'Noor Hospital', 107, 'Islamabad', 13, 'INSERT');
CALL Hosp_PROCE4(5, 'Zohra Nursing Hospital', 104, 'Rawalpindi', 16, 'INSERT');
CALL Hosp_PROCE4(6, 'Shalimar Hospital', 103, 'Lahore', 25, 'INSERT');
CALL Hosp_PROCE4(0, '', 0, '', 0, 'SELECT');
CALL Hosp_PROCE4(6, 'Shalimar Hospital', 103, 'Gujrat', 15, 'UPDATE');
CALL Hosp_PROCE4(0, '', 0, '', 0, 'DELETE');

INSERT INTO Hospitalrequestt VALUES(1,8),(2,11),(3,7),(4,16),(5,2);
SELECT * FROM Hospitalrequestt;


DELIMITER $$

-- -------7. Donor Procedure-----------

CREATE PROCEDURE Do_PROCE4(
    IN p_id INT,
    IN p_name VARCHAR(40),
    IN p_Gender VARCHAR(20),
    IN p_phno VARCHAR(30),
    IN p_Date_reg VARCHAR(40),
    IN p_addr VARCHAR(30),
    IN p_age INT,
    IN p_disease VARCHAR(30),
    IN p_BG_id INT,
    IN p_BG_type VARCHAR(3),
    IN p_RT_id INT,
    IN p_type VARCHAR(30)
)
BEGIN
    IF p_type = 'SELECT' THEN
        SELECT * FROM Donor;
    END IF;
    IF p_type = 'INSERT' THEN
        INSERT INTO Donor(D_id, D_name, D_gender, D_phno, Dt_reg, D_add, D_age, D_disease, BG_id, BG_type, RT_id)
        VALUES(p_id, p_name, p_Gender, p_phno, p_Date_reg, p_addr, p_age, p_disease, p_BG_id, p_BG_type, p_RT_id);
    END IF;
    IF p_type = 'UPDATE' THEN
        UPDATE Donor SET D_name = p_name, D_gender = p_Gender, D_phno = p_phno,
        Dt_reg = p_Date_reg, D_add = p_addr, D_age = p_age, D_disease = p_disease,
        BG_id = p_BG_id, BG_type = p_BG_type, RT_id = p_RT_id
        WHERE D_id = p_id;
    END IF;
    IF p_type = 'DELETE' THEN
        DELETE FROM Donor WHERE D_id = p_id;
    END IF;
END$$

DELIMITER ;

CALL Do_PROCE4(21,'Hamza','M','0323-2209271','2023-02-07','Lahore',23,'NULL',1131,'A-',603,'INSERT');
CALL Do_PROCE4(22,'Zubair Rana','M','0302-2331270','2023-03-27','Peshawar',34,'NULL',1132,'B+',605,'INSERT');
CALL Do_PROCE4(23,'Yahyah','M','0344-3112270','2023-02-13','Gujrat',31,'NULL',1133,'O-',601,'INSERT');
CALL Do_PROCE4(24,'Saeeda','F','0301-2341710','2023-12-23','Gujranwala',27,'NULL',1134,'B-',602,'INSERT');
CALL Do_PROCE4(25,'Mustafa','M','0343-2341710','2023-06-23','Gujrat',29,'NULL',1135,'B-',608,'INSERT');
CALL Do_PROCE4(26,'Atif','M','0327-8921121','2023-04-26','Lala Musa',39,'NULL',1136,'AB-',604,'INSERT');
CALL Do_PROCE4(27,'Kashif','M','0323-2209271','2023-01-14','Wazirabad',23,'NULL',1137,'A+',601,'INSERT');
CALL Do_PROCE4(28,'Ashraf','M','0300-3200273','2023-05-17','Lahore',43,'Sugar',1138,'O+',609,'INSERT');
CALL Do_PROCE4(29,'Hamza Ali','M','0307-7510270','2023-12-19','Gujrat',19,'NULL',1139,'AB+',601,'INSERT');
CALL Do_PROCE4(30,'Kashif','M','0323-2209271','2023-01-14','Wazirabad',23,'NULL',1140,'A+',606,'INSERT');
CALL Do_PROCE4(31,'Ali Haider','M','0308-9909252','2023-06-15','Lahore',26,'Cough',1141,'O+',607,'INSERT');
CALL Do_PROCE4(32,'Taseer','M','0308-9909000','2023-04-03','Sialkot',31,'NULL',1142,'B+',603,'INSERT');
CALL Do_PROCE4(33,'Usman Ali','M','0308-9931422','2023-07-01','Lahore',19,'Cough',1143,'O+',604,'INSERT');
CALL Do_PROCE4(34,'Ali Luqman','M','0333-1130012','2023-02-15','Lala Musa',27,'NULL',1144,'AB+',605,'INSERT');
CALL Do_PROCE4(35,'Zunaira','F','0318-9909081','2023-09-15','Lahore',26,'NULL',1145,'A-',602,'INSERT');
CALL Do_PROCE4(36,'Abdullah','M','0308-9003411','2023-11-15','Gujrat',36,'Cough',1146,'AB-',601,'INSERT');
CALL Do_PROCE4(37,'Rana Talha','M','0301-1390252','2023-10-28','Lahore',46,'NULL',1147,'B+',610,'INSERT');
CALL Do_PROCE4(38,'Husnain','M','0341-3490145','2023-08-10','Lala Musa',32,'NULL',1148,'O-',601,'INSERT');
CALL Do_PROCE4(39,'Uzair','M','0304-0971451','2023-03-11','Lahore',26,'Cough',1149,'A+',604,'INSERT');
CALL Do_PROCE4(40,'Shazia','F','0334-0104331','2023-10-02','Gujrat',36,'NULL',1150,'AB+',601,'INSERT');
CALL Do_PROCE4(41,'Sohail Rana','M','0300-2305143','2023-01-12','Gujrat',21,'NULL',1151,'O+',601,'INSERT');
CALL Do_PROCE4(42,'Talha','M','0343-2022621','2023-01-12','Quetta',31,'NULL',1152,'AB+',604,'INSERT');
CALL Do_PROCE4(43,'Abdullah','M','0340-2922403','2023-11-12','Peshawar',42,'NULL',1153,'B+',605,'INSERT');
CALL Do_PROCE4(44,'Zain','M','0333-0082241','2023-05-12','Gujrat',45,'NULL',1154,'A+',606,'INSERT');
CALL Do_PROCE4(45,'Ahmed','M','0300-0082241','2023-01-05','Gujrat',51,'NULL',1155,'O+',603,'INSERT');
CALL Do_PROCE4(46,'Abu Bakr','M','0341-0913241','2023-11-06','Lahore',37,'NULL',1156,'O+',602,'INSERT');
CALL Do_PROCE4(47,'Javed','M','0307-0082091','2023-12-25','Gujrat',43,'NULL',1157,'AB-',606,'INSERT');
CALL Do_PROCE4(0,'','','','','',0,'',0,'',0,'SELECT');
CALL Do_PROCE4(0,'','','','','',0,'',0,'',0,'DELETE');
CALL Do_PROCE4(0,'','','','','',0,'',0,'',0,'UPDATE');


-- ===== Remaining INSERTs =====

INSERT INTO BLoodreceived VALUES
(1136,'AB-',1001),(1133,'O-',1002),(1137,'A+',1003),(1157,'AB-',1004),
(1132,'B+',1005),(1144,'AB+',1006),(1151,'O+',1007),(1145,'A-',1008),
(1148,'O-',1009),(1131,'A-',1010);
SELECT * FROM BLoodreceived;

INSERT INTO Tecanalyst_blood VALUES
(1131,'A-',411),(1132,'B+',412),(1133,'O-',413),(1134,'B-',414),(1135,'B-',415),
(1136,'AB-',416),(1137,'A+',417),(1139,'AB+',419),(1140,'A+',420),(1142,'B+',421),
(1144,'AB+',413),(1145,'A-',416),(1147,'B+',414),(1148,'O-',419),(1150,'AB+',417),
(1151,'O+',415),(1152,'AB+',411),(1153,'B+',416),(1154,'A+',418),(1155,'O+',413),
(1156,'O+',412),(1157,'AB-',411);
SELECT * FROM Tecanalyst_blood;


-- ============================================================
--              QUERY STORED PROCEDURES
-- ============================================================

DELIMITER $$

-- -----------------1. Blood Type Donation Info-----------------

CREATE PROCEDURE Blood_typees(
    IN p_Bld_type VARCHAR(3)
)
BEGIN
    DECLARE v_info VARCHAR(100);
    IF p_Bld_type = 'A+' THEN SET v_info = 'A+, AB+'; END IF;
    IF p_Bld_type = 'A-' THEN SET v_info = 'A+, AB+, A-, AB-'; END IF;
    IF p_Bld_type = 'B-' THEN SET v_info = 'B+, AB+, B-, AB-'; END IF;
    IF p_Bld_type = 'B+' THEN SET v_info = 'AB+, B+'; END IF;
    IF p_Bld_type = 'AB+' THEN SET v_info = 'AB+'; END IF;
    IF p_Bld_type = 'AB-' THEN SET v_info = 'AB+, A+'; END IF;
    IF p_Bld_type = 'O+' THEN SET v_info = 'AB+, A+, B+, O+'; END IF;
    IF p_Bld_type = 'O-' THEN SET v_info = 'Can donate every blood type'; END IF;
    SELECT v_info AS 'Groups to which you can donate';
END$$

DELIMITER ;
CALL Blood_typees('O+');


DELIMITER $$

-- -----------------2. List Donors by Blood Group-----------------

CREATE PROCEDURE List_Donor3(
    IN p_B_type VARCHAR(3)
)
BEGIN
    SELECT D_id, D_name, D_gender, BG_type FROM Donor
    WHERE BG_type = p_B_type AND D_disease = 'NULL';
END$$

DELIMITER ;
CALL List_Donor3('A+');


DELIMITER $$

-- -----------------3. Blood Stock (Using temp table)-----------------

CREATE PROCEDURE STOCK()
BEGIN
    CREATE TEMPORARY TABLE IF NOT EXISTS stock_blood6(
        id INT,
        quantity INT,
        B_group VARCHAR(3)
    );
    DELETE FROM stock_blood6;
    INSERT INTO stock_blood6(id, quantity, B_group) VALUES
    (1, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='A+'), 'A+'),
    (2, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='A-'), 'A-'),
    (3, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='B+'), 'B+'),
    (4, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='B-'), 'B-'),
    (5, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='AB+'), 'AB+'),
    (6, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='AB-'), 'AB-'),
    (7, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='O+'), 'O+'),
    (8, (SELECT COUNT(*) FROM Blood_donated WHERE BG_type='O-'), 'O-');
    SELECT quantity AS 'Quantity in stock (bags)', B_group AS 'Bloodgroup' FROM stock_blood6;
END$$

DELIMITER ;
CALL STOCK();


DELIMITER $$

-- -----------------4. Donors by BG_type and Age-----------------

CREATE PROCEDURE Queryy1(
    IN p_type VARCHAR(3),
    IN p_age INT
)
BEGIN
    SELECT D_id, D_name, D_add, D_gender, D_age, BG_type FROM Donor
    WHERE D_age < p_age AND BG_type = p_type;
END$$

DELIMITER ;
CALL Queryy1('O+', 45);


DELIMITER $$

-- -----------------5. Donors by City and Name Pattern-----------------

CREATE PROCEDURE Queryy2(
    IN p_city VARCHAR(30),
    IN p_Wild VARCHAR(10)
)
BEGIN
    SELECT D_id, D_name, D_add, D_gender, D_age, BG_type FROM Donor
    WHERE D_add = p_city AND D_name LIKE p_Wild;
END$$

DELIMITER ;
CALL Queryy2('Gujrat', '%a%');


DELIMITER $$

-- -----------------6. Donors Age Between Range-----------------

CREATE PROCEDURE Queryy3(
    IN p_N1 INT,
    IN p_N2 INT
)
BEGIN
    SELECT Donor.D_name, Donor.D_phno, Donor.BG_type, Donor.D_gender, Donor.D_age,
    Registration_teamm.RT_id, Registration_teamm.RT_Name
    FROM Donor JOIN Registration_teamm ON Registration_teamm.RT_id = Donor.RT_id
    WHERE Donor.D_age BETWEEN p_N1 AND p_N2;
END$$

DELIMITER ;
CALL Queryy3(30, 45);


DELIMITER $$

-- -----------------7. Universal Blood Type (Donors & Patients)-----------------

CREATE PROCEDURE Quer4(
    IN p_Type VARCHAR(3)
)
BEGIN
    SELECT Donor.D_name, Donor.BG_type FROM Donor WHERE Donor.BG_type = p_Type;
    SELECT Patient137.P_Name, Patient137.BG_type FROM Patient137 WHERE Patient137.BG_type = p_Type;
END$$

DELIMITER ;
CALL Quer4('O+');


DELIMITER $$

-- -----------------8. Bloodbanks with specific BG_type donated-----------------

CREATE PROCEDURE Querry5(
    IN p_type VARCHAR(3)
)
BEGIN
    SELECT Bloodbank.BB_name, Bloodbank.BB_id
    FROM Bloodbank_manager
    JOIN Blood_donated ON Bloodbank_manager.M_id = Blood_donated.M_id
    JOIN Bloodbank ON Bloodbank.BB_id = Bloodbank_manager.BB_id
    WHERE Blood_donated.BG_type = p_type;
END$$

DELIMITER ;
CALL Querry5('O-');


DELIMITER $$

-- -----------------9. Donors registered in Date Range-----------------

CREATE PROCEDURE Queryy6(
    IN p_D1 DATE,
    IN p_D2 DATE
)
BEGIN
    SELECT * FROM Donor WHERE Dt_reg BETWEEN p_D1 AND p_D2;
END$$

DELIMITER ;
CALL Queryy6('2023-01-10', '2023-04-30');


DELIMITER $$

-- -----------------10. Patients by Blood Amount-----------------

CREATE PROCEDURE Queryr11(
    IN p_n INT
)
BEGIN
    SELECT Patient137.P_id, Patient137.P_Name, Patient137.P_Gender, BloodRequest.Amount_blood
    FROM PatientRequest
    JOIN Patient137 ON Patient137.P_id = PatientRequest.P_id
    JOIN BloodRequest ON PatientRequest.RQ_id = BloodRequest.RQ_id
    WHERE BloodRequest.Amount_blood = p_n;
END$$

DELIMITER ;
CALL Queryr11(1);


DELIMITER $$

-- -----------------11. Manager + Bloodbank where Age < value-----------------

CREATE PROCEDURE Querryy8(
    IN p_age INT
)
BEGIN
    SELECT * FROM Bloodbank_manager
    JOIN Manager ON Bloodbank_manager.M_id = Manager.M_id
    JOIN Bloodbank ON Bloodbank_manager.BB_id = Bloodbank.BB_id
    WHERE M_age < p_age;
END$$

DELIMITER ;
CALL Querryy8(30);


DELIMITER $$

-- -----------------12. Registration Team + Bloodbank Members < value-----------------

CREATE PROCEDURE Querry9(
    IN p_m INT
)
BEGIN
    SELECT * FROM Registration_teamm
    JOIN Bloodbank ON Bloodbank.BB_id = Registration_teamm.BB_id
    WHERE RT_members < p_m;
END$$

DELIMITER ;
CALL Querry9(20);


DELIMITER $$

-- -----------------13. Managers storing specific BG_type-----------------

CREATE PROCEDURE Querryy9(
    IN p_m VARCHAR(3)
)
BEGIN
    SELECT * FROM Manager
    JOIN Blood_donated ON Manager.M_id = Blood_donated.M_id
    WHERE Blood_donated.BG_type = p_m;
END$$

DELIMITER ;
CALL Querryy9('O+');


DELIMITER $$

-- -----------------14. Total Requests by Patients-----------------

CREATE PROCEDURE Qu13()
BEGIN
    SELECT COUNT(BloodRequest.RQ_id) AS 'NUM_OF Req'
    FROM BloodRequest
    JOIN PatientRequest ON BloodRequest.RQ_id = PatientRequest.RQ_id;
END$$

DELIMITER ;
CALL Qu13();


DELIMITER $$

-- -----------------15. Hospital Blood Requests-----------------

CREATE PROCEDURE Querr14()
BEGIN
    SELECT Hospital.H_name, BloodRequest.Amount_blood, BloodRequest.BG_type
    FROM BloodRequest
    JOIN Hospitalrequestt ON BloodRequest.RQ_id = Hospitalrequestt.RQ_id
    JOIN Hospital ON Hospital.H_id = Hospitalrequestt.H_id;
END$$

DELIMITER ;
CALL Querr14();


DELIMITER $$

-- -----------------16. Total Blood Requests-----------------

CREATE PROCEDURE Que15()
BEGIN
    SELECT COUNT(RQ_id) AS 'Total requests' FROM BloodRequest;
END$$

DELIMITER ;
CALL Que15();


DELIMITER $$

-- -----------------17. Full Bloodbank Detail-----------------

CREATE PROCEDURE Que16()
BEGIN
    SELECT Bloodbank.BB_id, Bloodbank.BB_name, Bloodbank.BB_add,
    Manager.M_id, Manager.M_name, Manager.M_age, Manager.M_phno,
    Registration_teamm.RT_id, Registration_teamm.RT_Name, Registration_teamm.RT_members,
    Technical_analyst137.TA_id, Technical_analyst137.TA_Name, Technical_analyst137.TA_ph_nO
    FROM Bloodbank_manager
    JOIN Manager ON Manager.M_id = Bloodbank_manager.M_id
    JOIN Registration_teamm ON Registration_teamm.BB_id = Bloodbank_manager.BB_id
    JOIN Technical_analyst137 ON Technical_analyst137.BB_id = Bloodbank_manager.BB_id
    JOIN Bloodbank ON Bloodbank.BB_id = Bloodbank_manager.BB_id;
END$$

DELIMITER ;
CALL Que16();


DELIMITER $$

-- -----------------18. Specific Bloodbank Detail-----------------

CREATE PROCEDURE Que17(
    IN p_n INT
)
BEGIN
    SELECT Bloodbank.BB_id, Bloodbank.BB_name, Bloodbank.BB_add,
    Manager.M_id, Manager.M_name, Manager.M_age, Manager.M_phno,
    Registration_teamm.RT_id, Registration_teamm.RT_Name, Registration_teamm.RT_members,
    Technical_analyst137.TA_id, Technical_analyst137.TA_Name, Technical_analyst137.TA_ph_nO
    FROM Bloodbank_manager
    JOIN Manager ON Manager.M_id = Bloodbank_manager.M_id
    JOIN Registration_teamm ON Registration_teamm.BB_id = Bloodbank_manager.BB_id
    JOIN Technical_analyst137 ON Technical_analyst137.BB_id = Bloodbank_manager.BB_id
    JOIN Bloodbank ON Bloodbank.BB_id = Bloodbank_manager.BB_id
    WHERE Bloodbank.BB_id = p_n;
END$$

DELIMITER ;
CALL Que17(214);


DELIMITER $$

-- -----------------19. Manager + Hospital-----------------

CREATE PROCEDURE Que18()
BEGIN
    SELECT * FROM Manager JOIN Hospital ON Hospital.M_id = Manager.M_id;
END$$

DELIMITER ;
CALL Que18();


DELIMITER $$

-- -----------------20. Manager + Blood Donated (LEFT JOIN)-----------------

CREATE PROCEDURE Quey19()
BEGIN
    SELECT * FROM Manager LEFT JOIN Blood_donated ON Manager.M_id = Blood_donated.M_id;
END$$

DELIMITER ;
CALL Quey19();


DELIMITER $$

-- -----------------21. Patient + Manager-----------------

CREATE PROCEDURE Quey20()
BEGIN
    SELECT * FROM Patient137 JOIN Manager ON Manager.M_id = Patient137.M_id;
END$$

DELIMITER ;
CALL Quey20();


DELIMITER $$

-- -----------------22. Technical Analyst Blood Analysis-----------------

CREATE PROCEDURE Queryy22()
BEGIN
    SELECT Technical_analyst137.TA_id, Technical_analyst137.TA_Name, Technical_analyst137.TA_ph_nO,
    Tecanalyst_blood.BG_type
    FROM Tecanalyst_blood
    JOIN Technical_analyst137 ON Tecanalyst_blood.TA_id = Technical_analyst137.TA_id;
END$$

DELIMITER ;
CALL Queryy22();


DELIMITER $$

-- -----------------23. Top Donors by Phone Range-----------------

CREATE PROCEDURE Qurry23(
    IN p_n1 VARCHAR(30),
    IN p_n2 VARCHAR(30)
)
BEGIN
    SELECT * FROM Donor
    WHERE D_phno BETWEEN p_n1 AND p_n2
    ORDER BY D_id DESC;
END$$

DELIMITER ;
CALL Qurry23('0300-0000000', '0320-0000000');

-- ============================================================
