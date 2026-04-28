# Pulse Fitness SQL Database Design and Business Analytics

## Project Summary

This project designs and implements a relational database for Pulse Fitness, a modern fitness centre that offers membership plans, group fitness classes, personal training sessions, attendance tracking, and payment management.

The project focuses on SQL database design, Entity Relationship Diagram modelling, database implementation, dummy data insertion, and business analytics queries. The main goal is to show how a well-structured database can support operational decision-making, improve member engagement, optimise class scheduling, manage trainer workload, and support revenue growth.

## Business Background

Pulse Fitness is a fitness centre that offers services such as:

- Membership plans
- Group fitness classes
- Personal training sessions
- Class bookings
- Attendance tracking
- Payment management

The business wants to improve its data management and use SQL-based analytics to make better decisions about class utilisation, attendance, member retention, trainer allocation, and customer satisfaction.

## Project Objectives

The objectives of this project are to:

1. Design a relational database for Pulse Fitness.
2. Create an Entity Relationship Diagram using Chen's notation.
3. Implement the database using SQL.
4. Apply primary keys, foreign keys, and check constraints.
5. Insert realistic sample data into the database.
6. Develop SQL queries to answer business questions.
7. Provide insights and recommendations for Pulse Fitness management.

## Entity Relationship Diagram

The ERD below shows the main entities, attributes, and relationships in the Pulse Fitness database.

![Pulse Fitness ERD](ERD%20Diagram.jpeg)

## Database Design

The database includes the following main tables:

1. `Membership_Type`
2. `Member`
3. `Trainer`
4. `Fitness_Class`
5. `Booking`
6. `Attendance`
7. `PTSession`
8. `Payment`

These tables represent the core operations of Pulse Fitness, including member registration, membership tiers, class scheduling, trainer assignments, bookings, attendance records, personal training sessions, and payments.

## Database Tables

## 1. Membership_Type

The `Membership_Type` table stores the details of each membership plan offered by Pulse Fitness.

### Key Columns

- **Type_ID**: Unique identifier for each membership type.
- **Type_Name**: Name of the membership type, such as Basic, Premium, or Student.
- **Price**: Monthly price of the membership.
- **Weekly_Class_Limit**: Maximum number of group fitness classes allowed per week.
- **Monthly_Free_PT**: Number of free personal training sessions included per month.
- **Access_hours**: Access rules for the membership type.

### Business Purpose

This table helps Pulse Fitness manage different membership plans and apply usage limits based on each member’s subscription type.

## 2. Member

The `Member` table stores personal and membership information for each gym member.

### Key Columns

- **Member_ID**: Unique identifier for each member.
- **First_Name**: Member's first name.
- **Last_Name**: Member's last name.
- **Email**: Member's email address.
- **Date_Of_Birth**: Member's date of birth.
- **Phone**: Member's phone number.
- **Join_Date**: Date when the member joined Pulse Fitness.
- **Type_ID**: Foreign key linking the member to a membership type.

### Business Purpose

This table helps Pulse Fitness track member profiles, membership type, contact details, and joining date.

## 3. Trainer

The `Trainer` table stores details about trainers working at Pulse Fitness.

### Key Columns

- **Trainer_ID**: Unique identifier for each trainer.
- **First_Name**: Trainer's first name.
- **Last_Name**: Trainer's last name.
- **Certification**: Trainer's professional certification.
- **Speciality**: Trainer's area of specialisation.

### Business Purpose

This table helps Pulse Fitness manage trainer information and assign trainers to fitness classes and personal training sessions.

## 4. Fitness_Class

The `Fitness_Class` table stores details of scheduled group fitness classes.

### Key Columns

- **Class_ID**: Unique identifier for each class.
- **Class_Name**: Name of the class, such as Yoga, Zumba, CrossFit, HIIT, or Pilates.
- **Scheduled_time**: Date and time when the class is scheduled.
- **Duration**: Duration of the class.
- **Capacity**: Maximum number of members allowed in the class.
- **Room**: Room where the class is held.
- **Trainer_ID**: Foreign key linking the class to a trainer.

### Business Purpose

This table helps Pulse Fitness manage class schedules, class capacity, rooms, and trainer allocation.

## 5. Booking

The `Booking` table records member bookings for group fitness classes.

### Key Columns

- **Member_ID**: Foreign key linking the booking to a member.
- **Class_ID**: Foreign key linking the booking to a fitness class.
- **Booking_Date**: Date when the booking was made.
- **Status**: Booking status, such as confirmed, cancelled, or waitlisted.

### Business Purpose

This table helps Pulse Fitness track class demand, booking behaviour, cancelled bookings, and waitlisted members.

## 6. Attendance

The `Attendance` table records whether a member attended a booked class.

### Key Columns

- **Member_ID**: Foreign key linking the attendance record to a member.
- **Class_ID**: Foreign key linking the attendance record to a fitness class.
- **Booking_Date**: Date of the booking.
- **Attendance_Status**: Attendance result, such as attended or no-show.
- **CheckIn_Time**: Time when the member checked in.
- **Attendance_Source**: Source of check-in, such as app or kiosk.

### Business Purpose

This table helps Pulse Fitness monitor attendance, no-shows, and check-in channel effectiveness.

## 7. PTSession

The `PTSession` table stores personal training session records.

### Key Columns

- **Member_ID**: Foreign key linking the session to a member.
- **Trainer_ID**: Foreign key linking the session to a trainer.
- **Session_Datetime**: Date and time of the personal training session.
- **Duration**: Duration of the session.
- **Session_Type**: Type of personal training session.

### Business Purpose

This table helps Pulse Fitness manage personal training sessions and monitor trainer-member interactions.

## 8. Payment

The `Payment` table stores member payment records.

### Key Columns

- **Payment_ID**: Unique identifier for each payment.
- **Member_ID**: Foreign key linking the payment to a member.
- **Payment_date**: Date when the payment was made.
- **Amount**: Payment amount.
- **Pay_Method**: Payment method used by the member.

### Business Purpose

This table helps Pulse Fitness track membership payments, payment methods, and revenue collection.

## SQL Files

This project includes two SQL scripts.

## Part A: Database Design and Implementation

File: `pulse_fit_partA.sql`

This script includes:

- Table creation
- Primary key constraints
- Foreign key constraints
- Check constraints
- Business rule implementation
- Dummy data insertion

## Part B: Business Analytics Queries

File: `pulse_fit_partB.sql`

This script includes SQL queries created to address business concerns for Pulse Fitness management.

## Business Analytics Questions

The SQL analysis focuses on the following business concerns:

1. Class utilisation and capacity management
2. Attendance conversion rate
3. Check-in channel effectiveness
4. Member engagement and retention risk
5. Trainer workload balance and effectiveness
6. Booking frequency distribution
7. Class variety

## Analysis Performed

## 1. Class Utilisation and Capacity Management

This analysis compares confirmed bookings with class capacity to identify how well each class is being used.

### Purpose

The purpose is to identify classes that are underutilised or close to capacity.

### Business Value

This helps management decide whether to:

- Add more sessions for popular classes
- Reschedule low-demand classes
- Adjust class capacity
- Use rooms more efficiently
- Improve promotions for underbooked classes

### Key Insight

Some classes showed stronger demand during specific weeks, while other classes had low utilisation. This suggests that Pulse Fitness can improve scheduling and room allocation by monitoring utilisation regularly.

## 2. Attendance Conversion Rate

This analysis measures how many confirmed bookings resulted in actual attendance.

### Purpose

The purpose is to identify classes with high no-show rates.

### Business Value

This helps management reduce wasted class capacity and trainer time by introducing reminder systems, cancellation rules, and attendance incentives.

### Key Insight

Some classes had strong attendance conversion, while others showed lower attendance in certain weeks. This indicates possible scheduling issues, member disengagement, or lack of reminders.

## 3. Check-In Channel Effectiveness

This analysis compares attendance performance between app check-ins and kiosk check-ins.

### Purpose

The purpose is to understand whether members are more likely to attend when using a specific check-in method.

### Business Value

This helps management improve the digital check-in process and reduce app-related no-shows.

### Key Insight

Kiosk check-ins showed stronger attendance conversion than app check-ins. This suggests that the app check-in process may need improvements such as push reminders, easier check-in buttons, or QR-code scanning.

## 4. Member Engagement and Retention Risk

This analysis identifies members with low attendance rates or long gaps since their last booking.

### Purpose

The purpose is to detect members who may be at risk of becoming inactive or cancelling their membership.

### Business Value

This helps management target at-risk members with re-engagement campaigns, personalised offers, and class recommendations.

### Key Insight

Members with low attendance and fewer recent bookings may require early intervention. These members can be targeted with loyalty rewards, follow-up calls, or customised class suggestions.

## 5. Trainer Workload Balance and Effectiveness

This analysis compares trainer workload, booking volume, attendance conversion, and session utilisation.

### Purpose

The purpose is to identify whether trainers are being used effectively and whether their classes are converting bookings into attendance.

### Business Value

This helps management make decisions about trainer allocation, class assignments, coaching, and schedule adjustments.

### Key Insight

Some trainers had stronger attendance conversion than others. This suggests that Pulse Fitness can learn from high-performing trainers and rebalance sessions where needed.

## 6. Booking Frequency Distribution

This analysis examines how frequently members book classes.

### Purpose

The purpose is to segment members based on booking activity.

### Business Value

This helps management identify:

- Highly engaged members
- Low-engagement members
- Members suitable for upselling
- Members at risk of disengagement

### Key Insight

Some members booked frequently, while others booked only a few times. This supports targeted engagement strategies such as class bundles, loyalty badges, and follow-up communication.

## 7. Class Variety

This analysis examines how many different class types members book.

### Purpose

The purpose is to understand whether members are exploring different class options or only attending one type of class.

### Business Value

This helps management encourage class variety and improve member satisfaction.

### Key Insight

Members who attend a wider range of classes may be more engaged. Pulse Fitness can encourage variety through class passport programs, in-app recommendations, and instructor cross-promotions.

## Key Findings

- Some classes were underutilised, creating opportunities to adjust class schedules.
- Certain classes had stronger demand during specific weeks.
- Attendance conversion varied across classes and weeks.
- App check-ins had lower attendance conversion compared with kiosk check-ins.
- Some members showed signs of low engagement and potential retention risk.
- Trainer workload and effectiveness varied across sessions.
- Booking frequency can be used to segment members by engagement level.
- Encouraging class variety may improve member satisfaction and retention.

## Business Recommendations

Based on the SQL analysis, Pulse Fitness should consider the following recommendations:

1. **Optimise class scheduling**
   - Add more sessions for high-demand classes.
   - Reschedule or redesign classes with low utilisation.
   - Adjust room allocation based on booking patterns.

2. **Reduce no-shows**
   - Send automated reminders before classes.
   - Introduce a simple cancellation policy for repeat no-shows.
   - Offer rebooking options for missed sessions.

3. **Improve app check-in**
   - Add push notifications before class start time.
   - Make check-in easier through QR codes or one-tap confirmation.
   - Release unconfirmed spots to waitlisted members.

4. **Target at-risk members**
   - Identify members with low attendance rates.
   - Send personalised class recommendations.
   - Offer loyalty credits or re-engagement incentives.

5. **Balance trainer workload**
   - Reassign trainers where sessions are underfilled or overloaded.
   - Use strong trainer performance as a benchmark.
   - Match trainers to classes based on member demand and attendance data.

6. **Increase member engagement**
   - Create booking milestones and loyalty badges.
   - Offer class packs or bundles for low-frequency members.
   - Encourage members to build consistent weekly booking habits.

7. **Promote class variety**
   - Introduce a digital class passport program.
   - Recommend new classes based on previous attendance.
   - Use instructor cross-promotions to encourage members to try different class types.

## Files Included

- `pulse_fit_partA.sql` – SQL script for database design, table creation, constraints, and dummy data
- `pulse_fit_partB.sql` – SQL script containing business analytics queries
- `ERD Diagram.jpeg` – Entity Relationship Diagram using Chen's notation
- `48085847_jeebak_report.docx` – Written report explaining the database design, SQL analysis, insights, and recommendations
- `README.md` – Project documentation

## Skills Demonstrated

- SQL database design
- Entity Relationship Diagram creation
- Chen notation modelling
- Relational schema design
- Primary key implementation
- Foreign key implementation
- Check constraint implementation
- Dummy data creation
- SQL joins
- SQL aggregation
- Conditional aggregation using CASE statements
- Business analytics using SQL
- Class utilisation analysis
- Attendance analysis
- Member engagement analysis
- Trainer workload analysis
- Database-driven business recommendations

## Conclusion

This project demonstrates how SQL database design and business analytics can support operational decision-making for a fitness centre. By designing a structured relational database and applying targeted SQL queries, Pulse Fitness can monitor class utilisation, attendance behaviour, check-in performance, trainer workload, member engagement, and payment activity.

The project shows that a well-designed database can do more than store information. It can become a practical decision-making tool that helps improve efficiency, customer satisfaction, retention, and revenue performance.
