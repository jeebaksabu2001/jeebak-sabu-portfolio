# 🏋️ Pulse Fitness SQL Database Design and Business Analytics

## 📌 Project Summary

This project designs and implements a relational database for Pulse Fitness, a fitness centre offering memberships, group classes, personal training sessions, attendance tracking, and payment management.

The project uses SQL database design, ER modelling, dummy data, constraints, and business analytics queries to support better decisions around class scheduling, member engagement, trainer workload, and operational performance.

## 🎯 Project Objectives

- Design a relational database for Pulse Fitness.
- Create an Entity Relationship Diagram using Chen notation.
- Implement tables using SQL.
- Apply primary keys, foreign keys, and check constraints.
- Insert realistic sample data.
- Write SQL queries to answer business questions.
- Provide insights and recommendations for management.

## 🧩 Entity Relationship Diagram

<img width="3087" height="1544" alt="erd_diagram jpeg" src="https://github.com/user-attachments/assets/bc6afe6b-0f65-4ce7-9aac-b157ca2999ec" />

## 🗃️ Database Design

The database includes the following main tables:

- `Membership_Type`
- `Member`
- `Trainer`
- `Fitness_Class`
- `Booking`
- `Attendance`
- `PTSession`
- `Payment`

These tables represent the main operations of Pulse Fitness, including member registration, class scheduling, trainer assignment, attendance tracking, personal training sessions, and payments.

## 🧾 Database Tables

| Table | Purpose |
|---|---|
| `Membership_Type` | Stores membership plan details such as price, class limits, free PT sessions, and access hours |
| `Member` | Stores member profile, contact, join date, and membership type |
| `Trainer` | Stores trainer details, certifications, and specialisations |
| `Fitness_Class` | Stores scheduled group classes, room, capacity, duration, and assigned trainer |
| `Booking` | Records member class bookings and booking status |
| `Attendance` | Tracks whether members attended or missed booked classes |
| `PTSession` | Stores personal training session records |
| `Payment` | Stores payment records, payment dates, amounts, and payment methods |

## 🛠️ Tools and Technologies Used

- **SQL**
- **Entity Relationship Diagram**
- **Chen Notation**
- **Relational Database Design**
- **SQL Constraints**
- **Dummy Data Creation**
- **Business Analytics Queries**

## 📂 SQL Files

### Part A: Database Design and Implementation

File: `pulse_fit_partA.sql`

This script includes:

- Table creation
- Primary key constraints
- Foreign key constraints
- Check constraints
- Business rule implementation
- Dummy data insertion

### Part B: Business Analytics Queries

File: `pulse_fit_partB.sql`

This script includes SQL queries designed to answer business questions related to class utilisation, attendance, member engagement, trainer workload, and class variety.

## 📈 Analysis Performed

### 1. Class Utilisation and Capacity Management

This analysis compares confirmed bookings with class capacity to identify which classes are underused or close to full capacity.

Key business value:

- Improve class scheduling
- Adjust class capacity
- Promote underbooked classes
- Allocate rooms more efficiently

### 2. Attendance Conversion Rate

This analysis measures how many confirmed bookings resulted in actual attendance.

Key business value:

- Identify classes with high no-show rates
- Reduce wasted capacity
- Improve reminder and cancellation policies

### 3. Check-In Channel Effectiveness

This analysis compares attendance performance between app check-ins and kiosk check-ins.

Key business value:

- Improve digital check-in experience
- Identify whether app or kiosk check-ins perform better
- Reduce app-related no-shows

### 4. Member Engagement and Retention Risk

This analysis identifies members with low attendance or long gaps since their last booking.

Key business value:

- Detect at-risk members
- Support re-engagement campaigns
- Improve retention strategies

### 5. Trainer Workload Balance and Effectiveness

This analysis compares trainer workload, bookings, attendance conversion, and session utilisation.

Key business value:

- Balance trainer schedules
- Identify high-performing trainers
- Improve class assignment decisions

### 6. Booking Frequency Distribution

This analysis examines how often members book classes.

Key business value:

- Identify highly engaged members
- Identify low-engagement members
- Support upselling and loyalty campaigns

### 7. Class Variety

This analysis checks how many different class types each member books.

Key business value:

- Encourage members to try more class types
- Improve satisfaction and retention
- Support class recommendation strategies

## 🔍 Key Findings

- Some classes were underutilised, creating opportunities to adjust schedules.
- Certain classes showed stronger demand during specific weeks.
- Attendance conversion varied across classes and time periods.
- App check-ins had lower attendance conversion compared with kiosk check-ins.
- Some members showed signs of low engagement and potential retention risk.
- Trainer workload and effectiveness varied across sessions.
- Booking frequency can help segment members by engagement level.
- Encouraging class variety may improve member satisfaction and retention.

## 💡 Business Recommendations

- Optimise class scheduling by adding more sessions for high-demand classes.
- Reschedule or redesign low-utilisation classes.
- Reduce no-shows using reminders, simple cancellation rules, and rebooking options.
- Improve app check-in using push notifications, QR codes, or one-tap confirmation.
- Target at-risk members with personalised class recommendations and loyalty incentives.
- Balance trainer workload based on attendance and booking data.
- Encourage class variety through class passports, bundles, and cross-promotions.

## 🧠 Skills Demonstrated

- SQL database design
- Entity Relationship Diagram creation
- Chen notation modelling
- Relational schema design
- Primary key and foreign key implementation
- Check constraint implementation
- Dummy data creation
- SQL joins and aggregation
- Conditional aggregation using CASE statements
- Business analytics using SQL
- Class utilisation analysis
- Attendance analysis
- Member engagement analysis
- Trainer workload analysis
- Database-driven business recommendations

## ✅ Conclusion

This project demonstrates how SQL database design and business analytics can support decision-making for a fitness centre.

By designing a structured relational database and applying targeted SQL queries, Pulse Fitness can monitor class utilisation, attendance behaviour, check-in performance, trainer workload, member engagement, and payment activity.

Overall, the project shows how a well-designed database can become a practical decision-making tool for improving efficiency, customer satisfaction, retention, and revenue performance.
