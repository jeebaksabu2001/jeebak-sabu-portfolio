-- ==============================================================================================
-- 1. Class Utilization & Capacity Management
-- Why it matters: Compares confirmed reservations to capacity for each class or week.
-- What it addresses:  Identifies classes that are either overcrowded or underfilled.
-- Management action: Depending on usage, add or remove sessions or change the size of the rooms.
-- ==============================================================================================

SELECT
  c.ClassName,
  WEEK(c.ScheduleDateTime) AS WeekOfYear,
  COUNT(b.MemberID) AS ConfirmedBookings,
  c.Capacity,
  ROUND(COUNT(b.MemberID) / c.Capacity * 100, 1) AS UtilizationPercent
FROM FitnessClass AS c
LEFT JOIN Booking AS b
  ON c.ClassID = b.ClassID
  AND b.Status = 'confirmed'
  AND b.BookingDate = c.ScheduleDateTime
WHERE c.ScheduleDateTime
      BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  c.ClassName,
  WEEK(c.ScheduleDateTime),
  c.Capacity
ORDER BY
  c.ClassName,
  WeekOfYear;
  
-- ==========================================================================================
-- 2. Attendance Conversion Rate
-- Why it matters: Compares confirmed bookings to attendance for each class or week.
-- What it addresses: Identifies classrooms with a high number of no-shows.
-- Management action: To increase attendance, implement reminders or modify booking policies.
-- ==========================================================================================

SELECT
  c.ClassID,
  c.ClassName,
  WEEK(c.ScheduleDateTime) AS WeekOfYear,
  COUNT(*) AS TotalBookings,
  COUNT(IF(a.AttendanceStatus = 'attended', 1, NULL)) AS AttendedCount,
  COUNT(IF(a.AttendanceStatus = 'no-show',  1, NULL)) AS NoShowCount,
  ROUND(
    COUNT(IF(a.AttendanceStatus = 'attended', 1, NULL))
    / COUNT(*) * 100
  , 1) AS ConversionPercent
FROM Booking AS b
JOIN Attendance AS a
  ON b.MemberID    = a.MemberID
 AND b.ClassID     = a.ClassID
 AND b.BookingDate = a.BookingDate
JOIN FitnessClass AS c
  ON b.ClassID     = c.ClassID
 AND b.BookingDate = c.ScheduleDateTime
WHERE
  b.Status = 'confirmed'
  AND b.BookingDate BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  c.ClassID,
  WEEK(c.ScheduleDateTime)
ORDER BY
  c.ClassID,
  WeekOfYear;
  
-- ===================================================================================================
-- 3. Check-In Channel Effectiveness
-- Why it matters: Compares the success of attendance by check-in method (app vs. kiosk).
-- What it addresses: Identifies which method(app vs kiosk) performs better in encouraging members.
-- Management action: To lower no-shows, enhance or advertise the more successful channel.
-- ====================================================================================================

SELECT
  a.AttendanceSource,
  COUNT(*) AS TotalBookings,
  SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END)   AS Attended,
  SUM(CASE WHEN a.AttendanceStatus = 'no-show'   THEN 1 ELSE 0 END)   AS NoShows,
  ROUND(
    SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END)
    / COUNT(*) * 100, 1
  ) AS AttendanceRatePct
FROM Attendance AS a
JOIN Booking AS b
  ON a.MemberID = b.MemberID
 AND a.ClassID = b.ClassID
 AND a.BookingDate = b.BookingDate
WHERE
  b.Status = 'confirmed'
  AND b.BookingDate BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  a.AttendanceSource
ORDER BY
  AttendanceRatePct DESC;

-- ====================================================================================================
-- 4. Member Engagement & Retention Risk
-- Why it matters: Describes the booking and attendance patterns using attendance source of each member.
-- What it addresses: Identifies attendance rate of members who booked classes.
-- Management action: To increase retention, target at-risk members with outreach,offers and reminders.
-- =====================================================================================================

SELECT
  m.MemberID,
  m.FirstName,
  m.LastName,
  COUNT(b.BookingDate) AS TotalBookings,
  SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END) AS AttendedCount,
  SUM(CASE WHEN b.Status IN ('cancelled','no-show') THEN 1 ELSE 0 END) AS MissedCount,
  ROUND(
    SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END)
    / COUNT(b.BookingDate) * 100
  , 1) AS AttendanceRatePct,
  MAX(b.BookingDate) AS LastBookingDate
FROM Member AS m
JOIN Booking AS b
  ON m.MemberID = b.MemberID
LEFT JOIN Attendance AS a
  ON b.MemberID = a.MemberID
 AND b.ClassID = a.ClassID
 AND b.BookingDate = a.BookingDate
WHERE b.BookingDate BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  m.MemberID,
  m.FirstName,
  m.LastName
ORDER BY
  AttendanceRatePct ASC,
  LastBookingDate ASC;

-- ======================================================================================================
-- 5. Trainer Workload Balance & Effectiveness
-- Why it matters: Measures the number of reserved seats for each trainer to the capacity and attendance.
-- What it addresses: Identifies trainers who are either over or underutilized.
-- Management action: To ensure fairness, rebalance lessons or modify schedules.
-- =======================================================================================================

SELECT
  tr.TrainerID,
  tr.FirstName,
  tr.LastName,
  COUNT(DISTINCT c.ScheduleDateTime) AS ClassesScheduled,
  COUNT(b.MemberID)  AS ConfirmedBookings,
  SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END) AS AttendedCount,
  ROUND(
    COUNT(b.MemberID) /               -- total bookings
    SUM(c.Capacity) * 100, 1          -- total capacity across their classes
  ) AS UtilizationPercent,
  ROUND(
    SUM(CASE WHEN a.AttendanceStatus = 'attended' THEN 1 ELSE 0 END)
    / NULLIF(COUNT(b.MemberID), 0) * 100, 1
  ) AS AttendanceRatePercent
FROM FitnessClass AS c
JOIN Trainer AS tr
  ON c.TrainerID = tr.TrainerID
LEFT JOIN Booking AS b
  ON c.ClassID = b.ClassID
 AND c.ScheduleDateTime = b.BookingDate
 AND b.Status = 'confirmed'
LEFT JOIN Attendance AS a
  ON b.MemberID = a.MemberID
 AND b.ClassID = a.ClassID
 AND b.BookingDate = a.BookingDate
WHERE c.ScheduleDateTime
      BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  tr.TrainerID,
  tr.FirstName,
  tr.LastName
ORDER BY
  UtilizationPercent DESC,
  AttendanceRatePercent DESC;

-- ============================================================================
-- 6. Booking Frequency Distribution
-- Why it matters: Shows the number of bookings made by members in a month.
-- What it addresses: Identifies segments with low and high levels of engagement.
-- Management action: Design tiered promotions or loyalty rewards for members.
-- ============================================================================
-- 6a) Bookings per member
SELECT
  b.MemberID,
  m.FirstName,
  m.LastName,
  COUNT(*) AS BookingCount
FROM Booking AS b
JOIN Member AS m
  ON b.MemberID = m.MemberID
WHERE b.BookingDate
      BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  b.MemberID,
  m.FirstName,
  m.LastName
ORDER BY
  BookingCount DESC;

-- 6b) Summarize how many members fall into each booking-count bucket
SELECT
  BookingCount,
  COUNT(*) AS NumMembers
FROM (
  SELECT
    MemberID,
    COUNT(*) AS BookingCount
  FROM Booking
  WHERE BookingDate
        BETWEEN '2025-04-01' AND '2025-04-30'
  GROUP BY MemberID
) AS freq
GROUP BY BookingCount
ORDER BY BookingCount;

-- ===========================================================================================
-- 7. Class Variety
-- Why it matters: Counts the number of different class kinds that each participant tries.
-- What it addresses: Members with little variation in their routines are flagged.
-- Management action: Provide cross-class bundles to add variety to the experiences of members.
-- ============================================================================================

SELECT
  m.MemberID,
  m.FirstName,
  m.LastName,
  COUNT(DISTINCT c.ClassName) AS DistinctClassesBooked
FROM Booking AS b
JOIN Member AS m
  ON b.MemberID = m.MemberID
JOIN FitnessClass AS c
  ON b.ClassID = c.ClassID
 AND b.BookingDate = c.ScheduleDateTime
WHERE b.Status = 'confirmed'
  AND b.BookingDate BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY
  m.MemberID,
  m.FirstName,
  m.LastName
ORDER BY
  DistinctClassesBooked DESC,
  m.LastName;
