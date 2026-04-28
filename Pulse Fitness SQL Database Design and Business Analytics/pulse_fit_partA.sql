-- =========================================================
-- STEP 1: Creating and selecting the PulseFitness database
-- =========================================================

CREATE DATABASE PulseFitness;
USE PulseFitness;

-- ==============================================================================================================
-- STEP 2: MembershipType table
-- Purpose: As per business rules defining the three membership tiers (Basic, Premium, Student) and their pricing,
--          class limits, PT sessions, and access hours. Enforcing business rules via CHECKs.
-- ===============================================================================================================

CREATE TABLE MembershipType (
  TypeID                 INT           AUTO_INCREMENT PRIMARY KEY,
  TypeName               VARCHAR(20)   NOT NULL,
  Price                  DECIMAL(6,2)  NOT NULL,
  WeeklyClassLimit       INT           DEFAULT NULL,    -- max classes per week
  MonthlyFreePT          INT           DEFAULT NULL,    -- free PT sessions per month
  AccessHours            VARCHAR(20)   NOT NULL,        -- 'All hours' or 'Off-peak'

  CHECK (Price >= 0),
  CHECK (WeeklyClassLimit IS NULL OR WeeklyClassLimit >= 0),
  CHECK (MonthlyFreePT IS NULL OR MonthlyFreePT >= 0),
  CHECK (AccessHours IN ('All hours','Off-peak')),

  -- restrict tier names
  CHECK (TypeName IN ('Basic','Premium','Student')),

  -- enforce each tier's rules
  CONSTRAINT ck_tier_rules CHECK (
       (TypeName = 'Basic'   AND WeeklyClassLimit = 2  AND MonthlyFreePT = 0 AND AccessHours = 'All hours')
    OR (TypeName = 'Premium' AND WeeklyClassLimit IS NULL AND MonthlyFreePT = 1 AND AccessHours = 'All hours')
    OR (TypeName = 'Student' AND WeeklyClassLimit = 3  AND MonthlyFreePT = 0 AND AccessHours = 'Off-peak')
  )
);

-- ======================================================================================
-- STEP 3: Member table
-- Purpose: Storing each gym member's personal details and link to their membership tier.
--          Enforcing checks so that you cannot join before your birth date
-- ======================================================================================

CREATE TABLE Member (
  MemberID         INT           AUTO_INCREMENT PRIMARY KEY,
  FirstName        VARCHAR(50)   NOT NULL,    
  LastName         VARCHAR(50)   NOT NULL,    
  Email            VARCHAR(100)  NOT NULL UNIQUE,  
  Phone            VARCHAR(20)   DEFAULT NULL, 
  DateOfBirth      DATE          NOT NULL,    
  JoinDate         DATE          NOT NULL,    
  MembershipTypeID INT           NOT NULL,    

  FOREIGN KEY (MembershipTypeID)
    REFERENCES MembershipType(TypeID),
  
  -- ensuring a member cannot join before they are born
  CHECK (DateOfBirth <= JoinDate)
);

-- ====================================================================
-- STEP 4: Trainer table
-- Purpose: Records of trainers, their certifications, and specialties.
--          Preventing empty fields with CHECK constraints.
-- ====================================================================

CREATE TABLE Trainer (
  TrainerID     INT           AUTO_INCREMENT PRIMARY KEY,
  FirstName     VARCHAR(50)   NOT NULL,    
  LastName      VARCHAR(50)   NOT NULL,    
  Certification VARCHAR(50)   NOT NULL,    
  Specialty     VARCHAR(50)   NOT NULL,    

  -- Basic checks to prevent empty strings
  CHECK (FirstName   <> ''),
  CHECK (LastName    <> ''),
  CHECK (Certification <> ''),
  CHECK (Specialty   <> '')
);

-- =======================================================================================
-- STEP 5: FitnessClass table
-- Purpose: Scheduling fitness classes, assigning a trainer, room, capacity, and enforcing
--          basic checks like duration, capacity, non-empty names.
-- =======================================================================================

CREATE TABLE FitnessClass (
  ClassID          INT           AUTO_INCREMENT PRIMARY KEY,
  ClassName        VARCHAR(100)  NOT NULL,    
  ScheduleDateTime DATETIME      NOT NULL,    
  Duration         INT           NOT NULL,    
  Capacity         INT           NOT NULL,    
  Room             VARCHAR(20)   NOT NULL,    
  TrainerID        INT           NOT NULL,    

  -- linking to the trainer who teaches this class
  FOREIGN KEY (TrainerID)
    REFERENCES Trainer(TrainerID),

  -- basic checks
  CHECK (ClassName <> ''),        
  CHECK (Duration > 0),           
  CHECK (Capacity > 0),           
  CHECK (Room <> '' )             

);

-- ======================================================================================
-- STEP 6: Booking table
-- Purpose: Tracking member bookings for classes, including status (confirmed, cancelled,
--          waitlisted)
-- ======================================================================================

CREATE TABLE Booking (
  MemberID     INT         NOT NULL,    
  ClassID      INT         NOT NULL,    
  BookingDate  DATETIME    NOT NULL,    
  Status       VARCHAR(20) NOT NULL,    

  PRIMARY KEY (MemberID, ClassID, BookingDate),

  FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
  FOREIGN KEY (ClassID)  REFERENCES FitnessClass(ClassID),

  -- basic checks to maintain integrity
  CHECK (Status IN ('confirmed','cancelled','waitlisted'))

);

-- ================================================================================
-- STEP 7: PTSession table
-- Purpose: Recording personal training sessions for Premium members, enforcing one
--          free session per member per month via unique generated column.
-- ================================================================================

CREATE TABLE PTSession (
  MemberID         INT           NOT NULL,    
  TrainerID        INT           NOT NULL,    
  SessionDateTime  DATETIME      NOT NULL,    
  Duration         INT           NOT NULL,    
  SessionType      VARCHAR(50)   NOT NULL,   

  PRIMARY KEY (MemberID, TrainerID, SessionDateTime),

  FOREIGN KEY (MemberID)  REFERENCES Member(MemberID),
  FOREIGN KEY (TrainerID) REFERENCES Trainer(TrainerID),
  -- basic checks
  CHECK (Duration > 0),
  CHECK (SessionType IN (
    'Strength','Cardio','Flexibility','Core','Endurance',
    'Functional','Recovery','Nutrition'
  )),
  -- prevent more than one session per member per calendar month
  -- used a generated column to pull out year–month from the timestamp:
  SessionMonth CHAR(7)  AS (DATE_FORMAT(SessionDateTime, '%Y-%m')),
  UNIQUE KEY uk_free_monthly (MemberID, SessionMonth)
);

-- =====================================================================================
-- STEP 8: Payment table
-- Purpose: Records of membership payments, amount, and payment method with basic checks.
-- ======================================================================================
CREATE TABLE Payment (
  PaymentID    INT           AUTO_INCREMENT PRIMARY KEY,
  MemberID     INT           NOT NULL,    
  PaymentDate  DATE          NOT NULL,    
  Amount       DECIMAL(8,2)  NOT NULL,    
  Pay_method   VARCHAR(20)   NOT NULL,    

  -- every payment ties to a real member
  FOREIGN KEY (MemberID)
    REFERENCES Member(MemberID),

  CHECK (Amount >= 0),  
  CHECK (Pay_method IN ('Credit Card','Direct Debit','Paypal'))
);

-- ============================================================================
-- STEP 9: Attendance table
-- Purpose: Capturing whether a booked class was attended or marked as no-show,
--          plus check-in details and source.
-- ============================================================================

CREATE TABLE Attendance (
  MemberID         INT           NOT NULL,
  ClassID          INT           NOT NULL,
  BookingDate      DATETIME      NOT NULL,
  AttendanceStatus ENUM('attended','no-show') NOT NULL,
  CheckInTime      DATETIME      NULL,              
  AttendanceSource ENUM('kiosk','app')   NOT NULL,  -- where they checked in

  PRIMARY KEY (MemberID, ClassID, BookingDate),

  FOREIGN KEY (MemberID, ClassID, BookingDate)
    REFERENCES Booking(MemberID, ClassID, BookingDate),

  CHECK (AttendanceStatus IN ('attended','no-show')),
  CHECK (AttendanceSource IN ('kiosk','app'))
);

-- ==============================================================================================
-- DUMMY DATA INTEGRATION
-- Purpose: Populating tables with realistic sample data covering all kinds of business scenarios
-- ==============================================================================================
-- 1. Inserting data into MembershipType table
-- ============================================
INSERT INTO MembershipType
  (TypeName, Price, WeeklyClassLimit, MonthlyFreePT, AccessHours)
VALUES
  ('Basic',   60.00,  2,   0, 'All hours'),
  ('Premium',100.00, NULL,  1, 'All hours'),
  ('Student', 40.00,  3,   0, 'Off-peak');
  
-- ===============================================================================================
-- 2. Inserting data into Member table (includes 50 unique members across tiers, join dates, ages)
-- ===============================================================================================

INSERT INTO Member
  (FirstName, LastName, Email,            Phone,        DateOfBirth, JoinDate,   MembershipTypeID)
VALUES
  ('Alice',   'Smith',   'alice.smith1@fit.com',    '0400-000-001','1980-05-15','2025-02-12',1),
  ('Bob',     'Jones',   'bob.jones2@fit.com',      '0400-000-002','1992-11-02','2025-04-05',2),
  ('Carol',   'Taylor',  'carol.taylor3@fit.com',   '0400-000-003','1985-08-21','2025-03-19',3),
  ('David',   'Brown',   'david.brown4@fit.com',    '0400-000-004','1975-02-10','2025-01-28',1),
  ('Emma',    'Davis',   'emma.davis5@fit.com',     '0400-000-005','2001-09-30','2025-04-17',3),
  ('Frank',   'Miller',  'frank.miller6@fit.com',   '0400-000-006','1988-12-11','2025-01-15',2),
  ('Grace',   'Wilson',  'grace.wilson7@fit.com',   '0400-000-007','1995-07-07','2025-03-03',1),
  ('Hannah',  'Moore',   'hannah.moore8@fit.com',   '0400-000-008','1972-03-03','2025-02-25',2),
  ('Ian',     'Anderson','ian.anderson9@fit.com',   '0400-000-009','1990-04-25','2025-03-30',1),
  ('Julia',   'Thomas',  'julia.thomas10@fit.com',  '0400-000-010','1983-06-19','2025-04-09',3),
  ('Kyle',    'Jackson', 'kyle.jackson11@fit.com',  '0400-000-011','1978-10-14','2025-02-07',2),
  ('Laura',   'White',   'laura.white12@fit.com',    '0400-000-012','2003-01-08','2025-01-22',3),
  ('Matt',    'Harris',  'matt.harris13@fit.com',   '0400-000-013','1982-11-28','2025-03-14',1),
  ('Nina',    'Martin',  'nina.martin14@fit.com',   '0400-000-014','1999-12-13','2025-02-03',2),
  ('Oscar',   'Thompson','oscar.thompson15@fit.com', '0400-000-015','1969-05-05','2025-04-24',1),
  ('Paul',    'Garcia',  'paul.garcia16@fit.com',   '0400-000-016','2000-02-22','2025-01-11',3),
  ('Quinn',   'Martinez','quinn.martinez17@fit.com', '0400-000-017','1987-09-17','2025-03-07',2),
  ('Rachel',  'Robinson','rachel.robinson18@fit.com','0400-000-018','1993-03-12','2025-04-01',1),
  ('Steve',   'Clark',   'steve.clark19@fit.com',   '0400-000-019','1984-04-29','2025-02-17',2),
  ('Tara',    'Rodriguez','tara.rodriguez20@fit.com','0400-000-020','1977-01-25','2025-03-25',3),
  ('Uma',     'Lewis',   'uma.lewis21@fit.com',     '0400-000-021','1989-12-05','2025-01-09',1),
  ('Victor',  'Lee',     'victor.lee22@fit.com',    '0400-000-022','1991-07-17','2025-04-13',2),
  ('Wendy',   'Walker',  'wendy.walker23@fit.com',  '0400-000-023','1970-02-14','2025-02-28',1),
  ('Xander',  'Hall',    'xander.hall24@fit.com',   '0400-000-024','1996-08-08','2025-03-02',2),
  ('Yara',    'Allen',   'yara.allen25@fit.com',    '0400-000-025','2004-11-30','2025-04-20',3),
  ('Zach',    'Young',   'zach.young26@fit.com',    '0400-000-026','1981-04-01','2025-02-10',1),
  ('Abby',    'Hernandez','abby.hernandez27@fit.com','0400-000-027','1994-09-09','2025-03-17',2),
  ('Ben',     'King',    'ben.king28@fit.com',      '0400-000-028','1986-06-22','2025-01-30',2),
  ('Chloe',   'Wright',  'chloe.wright29@fit.com',  '0400-000-029','2002-10-31','2025-04-03',3),
  ('Dylan',   'Lopez',   'dylan.lopez30@fit.com',   '0400-000-030','1979-03-25','2025-03-23',1),
  ('Ella',    'Hill',    'ella.hill31@fit.com',     '0400-000-031','1997-05-17','2025-02-21',2),
  ('Finn',    'Scott',   'finn.scott32@fit.com',    '0400-000-032','1983-12-30','2025-04-11',1),
  ('Gina',    'Green',   'gina.green33@fit.com',    '0400-000-033','1992-02-20','2025-03-09',2),
  ('Harry',   'Adams',   'harry.adams34@fit.com',   '0400-000-034','1965-07-07','2025-01-19',1),
  ('Isla',    'Baker',   'isla.baker35@fit.com',    '0400-000-035','1998-03-03','2025-04-27',3),
  ('Jack',    'Nelson',  'jack.nelson36@fit.com',   '0400-000-036','1985-11-11','2025-03-29',2),
  ('Kayla',   'Carter',  'kayla.carter37@fit.com',  '0400-000-037','2005-12-01','2025-02-01',3),
  ('Liam',    'Mitchell','liam.mitchell38@fit.com', '0400-000-038','1990-09-29','2025-04-07',2),
  ('Mia',     'Perez',   'mia.perez39@fit.com',     '0400-000-039','1993-06-25','2025-02-15',1),
  ('Noah',    'Roberts', 'noah.roberts40@fit.com',  '0400-000-040','1988-01-16','2025-01-17',2),
  ('Olivia',  'Turner',  'olivia.turner41@fit.com', '0400-000-041','1973-08-19','2025-04-23',1),
  ('Peter',   'Phillips','peter.phillips42@fit.com','0400-000-042','2001-05-30','2025-03-11',3),
  ('Sophie',  'Campbell','sophie.campbell43@fit.com','0400-000-043','1996-03-14','2025-02-05',2),
  ('Tom',     'Parker',  'tom.parker44@fit.com',    '0400-000-044','1982-02-28','2025-04-29',1),
  ('Uriah',   'Evans',   'uriah.evans45@fit.com',   '0400-000-045','1999-07-21','2025-03-21',3),
  ('Vanessa', 'Edwards', 'vanessa.edwards46@fit.com','0400-000-046','1976-12-12','2025-01-25',1),
  ('Will',    'Collins', 'will.collins47@fit.com',  '0400-000-047','1984-04-04','2025-04-15',2),
  ('Xenia',   'Stewart', 'xenia.stewart48@fit.com', '0400-000-048','1992-10-10','2025-02-22',3),
  ('Yvonne',  'Sanchez', 'yvonne.sanchez49@fit.com','0400-000-049','1995-01-05','2025-03-13',2),
  ('Zack',    'Morris',  'zack.morris50@fit.com',   '0400-000-050','1987-08-23','2025-01-31',1);

-- ==============================================================================================
-- 3. Inserting data into Trainer table (10 unique certified trainers with different specialties)
-- ==============================================================================================
-- Certification Full Forms
-- ================================================================================
-- NASM-CPT   : National Academy of Sports Medicine – Certified Personal Trainer
-- ACE-CPT    : American Council on Exercise – Certified Personal Trainer
-- CF-L1      : CrossFit Level 1 Trainer
-- ZIN        : Zumba Instructor Network
-- ERYT-200   : Yoga Alliance – Registered Yoga Teacher (200-hour)
-- ISSA-CFT   : International Sports Sciences Association – Certified Fitness Trainer
-- ==================================================================================

INSERT INTO Trainer
  (FirstName, LastName, Certification, Specialty)
VALUES
  -- Yoga specialists
  ('Grace', 'Kim', 'ACE-CPT', 'Yoga'),
  ('Laura', 'Davis', 'NASM-CPT', 'Yoga'),

  -- Zumba specialists
  ('Ian', 'Lopez', 'ZIN', 'Zumba'),
  ('Oscar', 'Wright', 'ZIN', 'Zumba'),

  -- CrossFit specialists
  ('Hannah', 'Patel', 'CF-L1', 'CrossFit'),
  ('Nina', 'Lewis', 'CF-L1', 'CrossFit'),

  -- HIIT specialists
  ('Kyle', 'Martinez', 'ISSA-CFT', 'HIIT'),
  ('Matt', 'Clark', 'ACE-CPT', 'HIIT'),

  -- Pilates specialists
  ('Julia',  'Chen', 'ERYT-200', 'Pilates'),
  ('Frank', 'Jones', 'NASM-CPT', 'Pilates');
  
-- =================================================================================================
-- 4. Inserting data into FitnessClass table and all group classes in April 2025, assigning trainers
-- =================================================================================================

INSERT INTO FitnessClass
  (ClassName, ScheduleDateTime, Duration, Capacity, Room, TrainerID)
VALUES
  -- Yoga (Mondays at 06:30, Trainer 1 & 2 alternate)
  ('Yoga', '2025-04-07 06:30:00', 60, 20, 'Studio A', 1),
  ('Yoga', '2025-04-14 06:30:00', 60, 20, 'Studio A', 2),
  ('Yoga', '2025-04-21 06:30:00', 60, 20, 'Studio A', 1),
  ('Yoga', '2025-04-28 06:30:00', 60, 20, 'Studio A', 2),

  -- Zumba (Tuesdays at 17:30, Trainer 3 & 4 alternate)
  ('Zumba','2025-04-01 17:30:00', 50, 25, 'Studio B', 3),
  ('Zumba', '2025-04-08 17:30:00', 50, 25, 'Studio B', 4),
  ('Zumba', '2025-04-15 17:30:00', 50, 25, 'Studio B', 3),
  ('Zumba', '2025-04-22 17:30:00', 50, 25, 'Studio B', 4),
  ('Zumba', '2025-04-29 17:30:00', 50, 25, 'Studio B', 3),

  -- CrossFit (Wednesdays at 09:00, Trainer 5 & 6 alternate)
  ('CrossFit', '2025-04-02 09:00:00', 60, 15, 'Box 1', 5),
  ('CrossFit', '2025-04-09 09:00:00', 60, 15, 'Box 1', 6),
  ('CrossFit', '2025-04-16 09:00:00', 60, 15, 'Box 1', 5),
  ('CrossFit', '2025-04-23 09:00:00', 60, 15, 'Box 1', 6),
  ('CrossFit', '2025-04-30 09:00:00', 60, 15, 'Box 1', 5),

  -- HIIT (Thursdays at 12:00, Trainer 7 & 8 alternate)
  ('HIIT', '2025-04-03 12:00:00', 45, 18, 'Gym Floor', 7),
  ('HIIT', '2025-04-10 12:00:00', 45, 18, 'Gym Floor', 8),
  ('HIIT', '2025-04-17 12:00:00', 45, 18, 'Gym Floor', 7),
  ('HIIT', '2025-04-24 12:00:00', 45, 18, 'Gym Floor', 8),

  -- Pilates (Fridays at 15:00, Trainer 9 & 10 alternate)
  ('Pilates',  '2025-04-04 15:00:00', 55, 12, 'Studio C',  9),
  ('Pilates',  '2025-04-11 15:00:00', 55, 12, 'Studio C', 10),
  ('Pilates',  '2025-04-18 15:00:00', 55, 12, 'Studio C',  9),
  ('Pilates',  '2025-04-25 15:00:00', 55, 12, 'Studio C', 10);
  
-- ===========================================================================================
-- 5. Inserting data into Booking table spread across all April weeks and ensuring tier limits
-- ===========================================================================================

INSERT INTO Booking (MemberID, ClassID, BookingDate, Status)
VALUES
  -- BASIC MEMBERS (max 2 per week)
  ( 1,  5, '2025-04-01 17:30:00','confirmed'),
  ( 1, 10, '2025-04-02 09:00:00','confirmed'),
  ( 1,  1, '2025-04-07 06:30:00','confirmed'),
  ( 1, 16, '2025-04-10 12:00:00','confirmed'),
  ( 1,  3, '2025-04-21 06:30:00','cancelled'),
  ( 1,  8, '2025-04-22 17:30:00','confirmed'),
  ( 1,  4, '2025-04-28 06:30:00','confirmed'),
  ( 1, 18, '2025-04-24 12:00:00','confirmed'),
  ( 4,  1, '2025-04-07 06:30:00','confirmed'),
  ( 4, 11, '2025-04-09 09:00:00','confirmed'),
  ( 4,  2, '2025-04-14 06:30:00','waitlisted'),
  ( 4, 12, '2025-04-16 09:00:00','confirmed'),
  ( 4,  3, '2025-04-21 06:30:00','confirmed'),
  ( 4, 13, '2025-04-23 09:00:00','confirmed'),
  ( 4,  4, '2025-04-28 06:30:00','confirmed'),
  ( 4, 14, '2025-04-30 09:00:00','confirmed'),
  ( 7,  5, '2025-04-01 17:30:00','confirmed'),
  ( 7, 10, '2025-04-02 09:00:00','confirmed'),
  ( 7,  6, '2025-04-08 17:30:00','confirmed'),
  ( 7, 11, '2025-04-09 09:00:00','confirmed'),
  ( 7,  7, '2025-04-15 17:30:00','confirmed'),
  ( 7, 12, '2025-04-16 09:00:00','confirmed'),
  ( 7,  8, '2025-04-22 17:30:00','cancelled'),
  ( 7, 13, '2025-04-23 09:00:00','confirmed'),
  ( 9,  1, '2025-04-07 06:30:00','confirmed'),
  ( 9, 10, '2025-04-02 09:00:00','waitlisted'),
  ( 9,  2, '2025-04-14 06:30:00','confirmed'),
  ( 9, 12, '2025-04-16 09:00:00','confirmed'),
  ( 9,  4, '2025-04-28 06:30:00','confirmed'),
  ( 9, 14, '2025-04-30 09:00:00','confirmed'),
  (13,  5, '2025-04-01 17:30:00','confirmed'),
  (13, 11, '2025-04-09 09:00:00','confirmed'),
  (13,  6, '2025-04-08 17:30:00','waitlisted'),
  (13, 16, '2025-04-10 12:00:00','confirmed'),
  (13,  7, '2025-04-15 17:30:00','confirmed'),
  (13, 17, '2025-04-17 12:00:00','confirmed'),
  (15, 19, '2025-04-04 15:00:00','confirmed'),
  (15, 20, '2025-04-11 15:00:00','confirmed'),
  (15, 21, '2025-04-18 15:00:00','confirmed'),
  (15, 22, '2025-04-25 15:00:00','confirmed'),
  (15,  9, '2025-04-29 17:30:00','cancelled'),
  (15, 14, '2025-04-30 09:00:00','confirmed'),
  (18,  1, '2025-04-07 06:30:00','confirmed'),
  (18,  5, '2025-04-01 17:30:00','cancelled'),
  (18,  2, '2025-04-14 06:30:00','confirmed'),
  (18,  6, '2025-04-08 17:30:00','confirmed'),
  (18,  3, '2025-04-21 06:30:00','confirmed'),
  (18,  7, '2025-04-15 17:30:00','waitlisted'),

  -- STUDENT MEMBERS (max 3 per week)

  ( 3,  5, '2025-04-01 17:30:00','confirmed'),
  ( 3, 10, '2025-04-02 09:00:00','cancelled'),
  ( 3, 19, '2025-04-04 15:00:00','cancelled'),
  ( 3,  6, '2025-04-08 17:30:00','confirmed'),
  ( 3, 11, '2025-04-09 09:00:00','confirmed'),
  ( 3, 20, '2025-04-11 15:00:00','confirmed'),
  ( 3,  7, '2025-04-15 17:30:00','confirmed'),
  ( 3, 12, '2025-04-16 09:00:00','confirmed'),
  ( 3, 21, '2025-04-18 15:00:00','confirmed'),
  ( 3,  8, '2025-04-22 17:30:00','waitlisted'),
  ( 3, 13, '2025-04-23 09:00:00','confirmed'),
  ( 3, 22, '2025-04-25 15:00:00','confirmed'),
  ( 5,  1, '2025-04-07 06:30:00','confirmed'),
  ( 5,  6, '2025-04-08 17:30:00','confirmed'),
  ( 5, 10, '2025-04-09 09:00:00','confirmed'),
  ( 5,  2, '2025-04-14 06:30:00','confirmed'),
  ( 5,  7, '2025-04-15 17:30:00','confirmed'),
  ( 5, 11, '2025-04-16 09:00:00','confirmed'),
  ( 5,  3, '2025-04-21 06:30:00','confirmed'),
  ( 5,  8, '2025-04-22 17:30:00','confirmed'),
  ( 5, 12, '2025-04-23 09:00:00','confirmed'),
  (10,  1, '2025-04-07 06:30:00','cancelled'),
  (10,  5, '2025-04-01 17:30:00','confirmed'),
  (10, 10, '2025-04-02 09:00:00','confirmed'),
  (10,  2, '2025-04-14 06:30:00','confirmed'),
  (10,  6, '2025-04-08 17:30:00','waitlisted'),
  (10, 11, '2025-04-09 09:00:00','confirmed'),
  (10,  3, '2025-04-21 06:30:00','confirmed'),
  (10,  7, '2025-04-15 17:30:00','waitlisted'),
  (10, 12, '2025-04-16 09:00:00','confirmed'),
  (10,  4, '2025-04-28 06:30:00','confirmed'),
  (12,  5, '2025-04-01 17:30:00','confirmed'),
  (12, 15, '2025-04-03 12:00:00','confirmed'),
  (12,  6, '2025-04-08 17:30:00','confirmed'),
  (12, 16, '2025-04-10 12:00:00','confirmed'),
  (12,  7, '2025-04-15 17:30:00','confirmed'),
  (12, 17, '2025-04-17 12:00:00','confirmed'),
  (12,  8, '2025-04-22 17:30:00','confirmed'),
  (12, 18, '2025-04-24 12:00:00','confirmed'),
  (20,  5, '2025-04-01 17:30:00','confirmed'),
  (20, 11, '2025-04-09 09:00:00','cancelled'),
  (20, 19, '2025-04-04 15:00:00','confirmed'),
  (20,  6, '2025-04-08 17:30:00','confirmed'),
  (20, 12, '2025-04-16 09:00:00','confirmed'),
  (20, 20, '2025-04-11 15:00:00','confirmed'),
  (20,  7, '2025-04-15 17:30:00','confirmed'),
  (29, 10, '2025-04-02 09:00:00','confirmed'),
  (29, 19, '2025-04-04 15:00:00','confirmed'),
  (29, 15, '2025-04-03 12:00:00','confirmed'),
  (29, 11, '2025-04-09 09:00:00','cancelled'),
  (29, 20, '2025-04-11 15:00:00','confirmed'),
  (29, 16, '2025-04-10 12:00:00','confirmed'),
  (29, 12, '2025-04-16 09:00:00','confirmed'),
  (29, 21, '2025-04-18 15:00:00','confirmed'),
  (29, 17, '2025-04-17 12:00:00','confirmed'),
  (29, 13, '2025-04-23 09:00:00','confirmed'),
  (29, 22, '2025-04-25 15:00:00','cancelled'),

  -- PREMIUM MEMBERS (no weekly limit)

  ( 2,  5, '2025-04-01 17:30:00','confirmed'),
  ( 2, 10, '2025-04-02 09:00:00','confirmed'),
  ( 2, 15, '2025-04-03 12:00:00','confirmed'),
  ( 2, 19, '2025-04-04 15:00:00','confirmed'),
  ( 2,  1, '2025-04-07 06:30:00','cancelled'),
  ( 2,  6, '2025-04-08 17:30:00','confirmed'),
  ( 2, 16, '2025-04-10 12:00:00','confirmed'),
  ( 2, 20, '2025-04-11 15:00:00','cancelled'),
  ( 2,  2, '2025-04-14 06:30:00','confirmed'),
  ( 2,  7, '2025-04-15 17:30:00','confirmed'),
  ( 2, 12, '2025-04-16 09:00:00','confirmed'),
  ( 2, 21, '2025-04-18 15:00:00','confirmed'),
  ( 2,  3, '2025-04-21 06:30:00','confirmed'),
  ( 2,  8, '2025-04-22 17:30:00','confirmed'),
  ( 2, 13, '2025-04-23 09:00:00','confirmed'),
  ( 2, 18, '2025-04-24 12:00:00','confirmed'),
  ( 2,  4, '2025-04-28 06:30:00','waitlisted'),
  ( 2,  9, '2025-04-29 17:30:00','confirmed'),
  ( 2, 14, '2025-04-30 09:00:00','confirmed'),
  ( 6,  1, '2025-04-07 06:30:00','confirmed'),
  ( 6,  2, '2025-04-14 06:30:00','confirmed'),
  ( 6,  3, '2025-04-21 06:30:00','confirmed'),
  ( 6,  4, '2025-04-28 06:30:00','confirmed'),
  (11, 10, '2025-04-02 09:00:00','confirmed'),
  (11, 16, '2025-04-03 12:00:00','confirmed'),
  (11, 13, '2025-04-23 09:00:00','confirmed'),
  (11, 17, '2025-04-10 12:00:00','confirmed'),
  (11, 12, '2025-04-16 09:00:00','confirmed'),
  (14,  5, '2025-04-01 17:30:00','confirmed'),
  (14,  6, '2025-04-08 17:30:00','confirmed'),
  (14,  7, '2025-04-15 17:30:00','confirmed'),
  (14,  8, '2025-04-22 17:30:00','confirmed'),
  (14,  9, '2025-04-29 17:30:00','confirmed'),
  (17,  1, '2025-04-07 06:30:00','confirmed'),
  (17,  3, '2025-04-21 06:30:00','confirmed'),
  (17,  5, '2025-04-08 17:30:00','confirmed'),
  (17,  8, '2025-04-22 17:30:00','confirmed'),
  (19, 15, '2025-04-03 12:00:00','confirmed'),
  (19, 16, '2025-04-10 12:00:00','cancelled'),
  (19, 17, '2025-04-17 12:00:00','confirmed'),
  (19, 18, '2025-04-24 12:00:00','confirmed');
  
-- ==========================================================================================
-- 6. Insert data into PTSession table ensuring only one session per Premium member in April
-- ==========================================================================================

INSERT INTO PTSession (MemberID, TrainerID, SessionDateTime, Duration, SessionType)
VALUES

  ( 2,  1, '2025-04-05 10:00:00', 60, 'strength'),
  ( 6,  2, '2025-04-06 14:30:00', 45, 'cardio'),
  ( 8,  3, '2025-04-07 09:15:00', 30, 'flexibility'),
  (11,  4, '2025-04-08 16:00:00', 60, 'strength'),
  (14,  5, '2025-04-09 11:45:00', 45, 'endurance'),
  (17,  6, '2025-04-10 13:30:00', 30, 'core'),
  (19,  7, '2025-04-11 15:00:00', 60, 'strength'),
  (22,  8, '2025-04-12 08:30:00', 45, 'cardio'),
  (24,  9, '2025-04-13 17:15:00', 30, 'flexibility'),
  (27, 10, '2025-04-14 10:00:00', 60, 'strength'),
  (28,  1, '2025-04-15 14:00:00', 45, 'endurance'),
  (31,  2, '2025-04-16 09:00:00', 30, 'core'),
  (33,  3, '2025-04-17 12:30:00', 60, 'strength'),
  (36,  4, '2025-04-18 16:45:00', 45, 'cardio'),
  (38,  5, '2025-04-19 11:15:00', 30, 'flexibility'),
  (40,  6, '2025-04-20 13:00:00', 60, 'strength'),
  (43,  7, '2025-04-21 15:30:00', 45, 'endurance'),
  (47,  8, '2025-04-22 10:30:00', 30, 'core'),
  (49,  9, '2025-04-23 17:00:00', 60, 'strength')
;

-- ====================================================================================
-- 7. Insert data into Payment table with 30 random members paying for April month dues
-- ====================================================================================

INSERT INTO Payment (MemberID, PaymentDate, Amount, Pay_method)
VALUES
  ( 2, '2025-04-02', 100.00, 'Credit Card'),  
  ( 5, '2025-04-05',  40.00, 'Direct Debit'), 
  ( 7, '2025-04-07',  60.00, 'Paypal'),       
  ( 8, '2025-04-08', 100.00, 'Credit Card'),  
  ( 9, '2025-04-09',  60.00, 'Direct Debit'), 
  (11, '2025-04-11', 100.00, 'Paypal'),       
  (12, '2025-04-12',  40.00, 'Credit Card'),  
  (13, '2025-04-03',  60.00, 'Direct Debit'), 
  (14, '2025-04-14', 100.00, 'Paypal'),       
  (16, '2025-04-16',  40.00, 'Credit Card'),  
  (17, '2025-04-17', 100.00, 'Direct Debit'), 
  (19, '2025-04-19', 100.00, 'Paypal'),       
  (21, '2025-04-21',  60.00, 'Credit Card'),  
  (22, '2025-04-04', 100.00, 'Direct Debit'), 
  (23, '2025-04-23',  60.00, 'Paypal'),       
  (24, '2025-04-24', 100.00, 'Credit Card'),  
  (25, '2025-04-25',  40.00, 'Direct Debit'), 
  (26, '2025-04-26',  60.00, 'Paypal'),       
  (27, '2025-04-27', 100.00, 'Credit Card'),  
  (28, '2025-04-28', 100.00, 'Direct Debit'), 
  (29, '2025-04-29',  40.00, 'Paypal'),       
  (30, '2025-04-30',  60.00, 'Credit Card'),  
  (31, '2025-04-10', 100.00, 'Direct Debit'), 
  (32, '2025-04-13',  60.00, 'Paypal'),       
  (33, '2025-04-15', 100.00, 'Credit Card'),  
  (35, '2025-04-18',  40.00, 'Direct Debit'), 
  (36, '2025-04-20', 100.00, 'Paypal'),       
  (38, '2025-04-22', 100.00, 'Credit Card'),  
  (40, '2025-04-06', 100.00, 'Direct Debit'), 
  (42, '2025-04-01',  40.00, 'Paypal');   
  
-- ===============================================================================================================
-- 8. Insert data into Attendance table shwoing attended vs no-show for each confirmed booking, source of checkiIn
-- ===============================================================================================================

 INSERT INTO Attendance
  (MemberID, ClassID, BookingDate, AttendanceStatus, CheckInTime, AttendanceSource)
VALUES

  ( 1,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:32:00','kiosk'),
  ( 1, 10, '2025-04-02 09:00:00','attended',  '2025-04-02 09:03:00','app'),
  ( 1,  1, '2025-04-07 06:30:00','attended',  '2025-04-07 06:29:00','kiosk'),
  ( 1, 16, '2025-04-10 12:00:00','attended',  '2025-04-10 12:02:00','app'),
  ( 1,  8, '2025-04-22 17:30:00','attended',  '2025-04-22 17:31:00','kiosk'),
  ( 1,  4, '2025-04-28 06:30:00','no-show',   NULL,               'kiosk'),
  ( 1, 18, '2025-04-24 12:00:00','attended',  '2025-04-24 12:01:00','app'),

  ( 4,  1, '2025-04-07 06:30:00','attended', '2025-04-07 06:28:00','app'),
  ( 4, 11, '2025-04-09 09:00:00','attended', '2025-04-09 09:04:00','kiosk'),
  ( 4, 12, '2025-04-16 09:00:00','attended', '2025-04-16 09:02:00','app'),
  ( 4,  3, '2025-04-21 06:30:00','attended', '2025-04-21 06:30:00','kiosk'),
  ( 4, 13, '2025-04-23 09:00:00','no-show',  NULL, 'app'),
  ( 4,  4, '2025-04-28 06:30:00','attended', '2025-04-28 06:32:00','kiosk'),
  ( 4, 14, '2025-04-30 09:00:00','attended', '2025-04-30 09:01:00','app'),

  ( 7,  5, '2025-04-01 17:30:00','attended', '2025-04-01 17:31:00','app'),
  ( 7, 10, '2025-04-02 09:00:00','attended', '2025-04-02 09:00:00','kiosk'),
  ( 7,  6, '2025-04-08 17:30:00','attended', '2025-04-08 17:33:00','app'),
  ( 7, 11, '2025-04-09 09:00:00','attended', '2025-04-09 09:05:00','kiosk'),
  ( 7,  7, '2025-04-15 17:30:00','attended', '2025-04-15 17:32:00','app'),
  ( 7, 12, '2025-04-16 09:00:00','attended', '2025-04-16 09:02:00','kiosk'),
  ( 7, 13, '2025-04-23 09:00:00','attended', '2025-04-23 09:01:00','app'),

  ( 9,  1, '2025-04-07 06:30:00','attended', '2025-04-07 06:30:00','kiosk'),
  ( 9,  2, '2025-04-14 06:30:00','attended', '2025-04-14 06:34:00','app'),
  ( 9, 12, '2025-04-16 09:00:00','attended', '2025-04-16 09:03:00','kiosk'),
  ( 9,  4, '2025-04-28 06:30:00','attended', '2025-04-28 06:31:00','app'),
  ( 9, 14, '2025-04-30 09:00:00','no-show',  NULL, 'app'),

  (13,  5, '2025-04-01 17:30:00','attended', '2025-04-01 17:35:00','kiosk'),
  (13, 11, '2025-04-09 09:00:00','attended', '2025-04-09 09:02:00','app'),
  (13, 16, '2025-04-10 12:00:00','attended', '2025-04-10 12:01:00','kiosk'),
  (13,  7, '2025-04-15 17:30:00','attended', '2025-04-15 17:30:00','app'),
  (13, 17, '2025-04-17 12:00:00','attended', '2025-04-17 12:03:00','kiosk'),

  (15, 19, '2025-04-04 15:00:00','attended', '2025-04-04 15:00:00','app'),
  (15, 20, '2025-04-11 15:00:00','attended', '2025-04-11 15:02:00','kiosk'),
  (15, 21, '2025-04-18 15:00:00','attended', '2025-04-18 15:01:00','app'),
  (15, 22, '2025-04-25 15:00:00','attended', '2025-04-25 15:04:00','kiosk'),
  (15, 14, '2025-04-30 09:00:00','no-show',  NULL, 'app'),

  (18,  1, '2025-04-07 06:30:00','attended', '2025-04-07 06:28:00','kiosk'),
  (18,  2, '2025-04-14 06:30:00','attended', '2025-04-14 06:30:00','app'),
  (18,  6, '2025-04-08 17:30:00','attended', '2025-04-08 17:32:00','kiosk'),
  (18,  3, '2025-04-21 06:30:00','attended', '2025-04-21 06:34:00','app'),

  ( 3,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:31:00','app'),
  ( 3,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:29:00','kiosk'),
  ( 3, 11, '2025-04-09 09:00:00','no-show',   NULL, 'app'),
  ( 3, 20, '2025-04-11 15:00:00','attended',  '2025-04-11 15:02:00','kiosk'),
  ( 3,  7, '2025-04-15 17:30:00','attended',  '2025-04-15 17:30:00','app'),
  ( 3, 12, '2025-04-16 09:00:00','attended',  '2025-04-16 09:01:00','kiosk'),
  ( 3, 21, '2025-04-18 15:00:00','attended',  '2025-04-18 15:03:00','app'),
  ( 3, 13, '2025-04-23 09:00:00','attended',  '2025-04-23 09:00:00','kiosk'),
  ( 3, 22, '2025-04-25 15:00:00','attended',  '2025-04-25 15:02:00','app'),

  ( 5,  1, '2025-04-07 06:30:00','attended',  '2025-04-07 06:30:00','app'),
  ( 5,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:31:00','kiosk'),
  ( 5, 10, '2025-04-09 09:00:00','attended',  '2025-04-09 09:02:00','app'),
  ( 5,  2, '2025-04-14 06:30:00','attended',  '2025-04-14 06:30:00','kiosk'),
  ( 5,  7, '2025-04-15 17:30:00','no-show',   NULL, 'app'),
  ( 5, 11, '2025-04-16 09:00:00','attended',  '2025-04-16 09:01:00','kiosk'),
  ( 5,  3, '2025-04-21 06:30:00','attended',  '2025-04-21 06:31:00','app'),
  ( 5,  8, '2025-04-22 17:30:00','attended',  '2025-04-22 17:32:00','kiosk'),
  ( 5, 12, '2025-04-23 09:00:00','attended',  '2025-04-23 09:00:00','app'),

  (10,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:30:00','kiosk'),
  (10, 10, '2025-04-02 09:00:00','attended',  '2025-04-02 09:03:00','app'),
  (10,  2, '2025-04-14 06:30:00','attended',  '2025-04-14 06:29:00','kiosk'),
  (10, 11, '2025-04-09 09:00:00','no-show',   NULL, 'app'),
  (10,  3, '2025-04-21 06:30:00','attended',  '2025-04-21 06:32:00','kiosk'),
  (10, 12, '2025-04-16 09:00:00','attended',  '2025-04-16 09:00:00','app'),
  (10,  4, '2025-04-28 06:30:00','attended',  '2025-04-28 06:28:00','kiosk'),

  (12,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:32:00','app'),
  (12, 15, '2025-04-03 12:00:00','attended',  '2025-04-03 12:05:00','kiosk'),
  (12,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:30:00','app'),
  (12, 16, '2025-04-10 12:00:00','attended',  '2025-04-10 12:01:00','kiosk'),
  (12,  7, '2025-04-15 17:30:00','attended',  '2025-04-15 17:31:00','app'),
  (12, 17, '2025-04-17 12:00:00','attended',  '2025-04-17 12:02:00','kiosk'),
  (12,  8, '2025-04-22 17:30:00','no-show',   NULL, 'app'),
  (12, 18, '2025-04-24 12:00:00','attended',  '2025-04-24 12:00:00','kiosk'),

  (20,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:30:00','kiosk'),
  (20, 19, '2025-04-04 15:00:00','attended',  '2025-04-04 15:02:00','app'),
  (20,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:31:00','kiosk'),
  (20, 12, '2025-04-16 09:00:00','attended',  '2025-04-16 09:00:00','app'),
  (20, 20, '2025-04-11 15:00:00','no-show',   NULL, 'kiosk'),
  (20,  7, '2025-04-15 17:30:00','attended',  '2025-04-15 17:33:00','app'),

  (29, 10, '2025-04-02 09:00:00','attended',  '2025-04-02 09:05:00','kiosk'),
  (29, 19, '2025-04-04 15:00:00','attended',  '2025-04-04 15:00:00','app'),
  (29, 15, '2025-04-03 12:00:00','no-show',   NULL, 'kiosk'),
  (29, 20, '2025-04-11 15:00:00','attended',  '2025-04-11 15:02:00','app'),
  (29, 16, '2025-04-10 12:00:00','attended',  '2025-04-10 12:01:00','kiosk'),
  (29, 21, '2025-04-18 15:00:00','attended',  '2025-04-18 15:02:00','app'),
  (29, 17, '2025-04-17 12:00:00','attended',  '2025-04-17 12:00:00','kiosk'),
  (29, 13, '2025-04-23 09:00:00','attended',  '2025-04-23 09:04:00','app'),
  (29, 22, '2025-04-25 15:00:00','attended',  '2025-04-25 15:00:00','kiosk'),

  ( 2,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:30:00','app'),
  ( 2, 10, '2025-04-02 09:00:00','attended',  '2025-04-02 09:01:00','kiosk'),
  ( 2, 15, '2025-04-03 12:00:00','no-show',   NULL, 'app'),
  ( 2, 19, '2025-04-04 15:00:00','attended',  '2025-04-04 15:02:00','kiosk'),
  ( 2,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:30:00','app'),
  ( 2, 16, '2025-04-10 12:00:00','attended',  '2025-04-10 12:01:00','kiosk'),
  ( 2,  2, '2025-04-14 06:30:00','attended',  '2025-04-14 06:28:00','app'),
  ( 2,  7, '2025-04-15 17:30:00','attended',  '2025-04-15 17:31:00','kiosk'),
  ( 2, 12, '2025-04-16 09:00:00','attended',  '2025-04-16 09:00:00','app'),
  ( 2, 21, '2025-04-18 15:00:00','attended',  '2025-04-18 15:04:00','kiosk'),
  ( 2,  3, '2025-04-21 06:30:00','attended',  '2025-04-21 06:31:00','app'),
  ( 2,  8, '2025-04-22 17:30:00','attended',  '2025-04-22 17:30:00','kiosk'),
  ( 2, 13, '2025-04-23 09:00:00','attended',  '2025-04-23 09:02:00','app'),
  ( 2, 18, '2025-04-24 12:00:00','attended',  '2025-04-24 12:03:00','kiosk'),
  ( 2,  4, '2025-04-28 06:30:00','no-show',   NULL, 'app'),
  ( 2,  9, '2025-04-29 17:30:00','attended',  '2025-04-29 17:30:00','kiosk'),
  ( 2, 14, '2025-04-30 09:00:00','attended',  '2025-04-30 09:05:00','app'),

  ( 6,  1, '2025-04-07 06:30:00','attended',  '2025-04-07 06:30:00','kiosk'),
  ( 6,  2, '2025-04-14 06:30:00','attended',  '2025-04-14 06:31:00','app'),
  ( 6,  3, '2025-04-21 06:30:00','attended',  '2025-04-21 06:32:00','kiosk'),
  ( 6,  4, '2025-04-28 06:30:00','attended',  '2025-04-28 06:28:00','app'),

  (11, 10, '2025-04-02 09:00:00','attended',  '2025-04-02 09:02:00','kiosk'),
  (11, 16, '2025-04-03 12:00:00','attended',  '2025-04-03 12:01:00','app'),
  (11, 13, '2025-04-23 09:00:00','attended',  '2025-04-23 09:00:00','kiosk'),
  (11, 17, '2025-04-10 12:00:00','attended',  '2025-04-10 12:02:00','app'),
  (11, 12, '2025-04-16 09:00:00','attended',  '2025-04-16 09:01:00','kiosk'),

  (14,  5, '2025-04-01 17:30:00','attended',  '2025-04-01 17:30:00','app'),
  (14,  6, '2025-04-08 17:30:00','attended',  '2025-04-08 17:29:00','kiosk'),
  (14,  7, '2025-04-15 17:30:00','attended',  '2025-04-15 17:31:00','app'),
  (14,  8, '2025-04-22 17:30:00','attended',  '2025-04-22 17:32:00','kiosk'),
  (14,  9, '2025-04-29 17:30:00','no-show',   NULL, 'app'),

  (17,  1, '2025-04-07 06:30:00','attended',  '2025-04-07 06:30:00','app'),
  (17,  3, '2025-04-21 06:30:00','attended',  '2025-04-21 06:32:00','kiosk'),
  (17,  5, '2025-04-08 17:30:00','attended',  '2025-04-08 17:31:00','app'),
  (17,  8, '2025-04-22 17:30:00','attended',  '2025-04-22 17:33:00','kiosk'),

  (19, 15, '2025-04-03 12:00:00','attended',  '2025-04-03 12:00:00','app'),
  (19, 17, '2025-04-17 12:00:00','attended',  '2025-04-17 12:00:00','kiosk'),
  (19, 18, '2025-04-24 12:00:00','no-show',   NULL, 'app')
;

-- ==============================================================
-- VERIFICATION QUERIES
-- Purpose: To check whether that data has been loaded correctly.
-- ==============================================================

-- Verify membership tiers
SELECT * FROM MembershipType;

-- Verify members
SELECT * FROM Member LIMIT 5;

-- Verify trainers
SELECT * FROM Trainer LIMIT 6;

-- Verify April classes
SELECT * FROM FitnessClass
 WHERE ScheduleDateTime BETWEEN '2025-04-01' AND '2025-04-30'
 ORDER BY ScheduleDateTime;

-- Verify bookings
SELECT * FROM Booking LIMIT 5;

-- Verify PT sessions
SELECT * FROM PTSession 
 WHERE SessionDateTime BETWEEN '2025-04-01' AND '2025-04-30';

-- Verify payments
SELECT * FROM Payment
 WHERE PaymentDate BETWEEN '2025-04-01' AND '2025-04-30';

-- Verify attendance
SELECT * FROM Attendance LIMIT 5;