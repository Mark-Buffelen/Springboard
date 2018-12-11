/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT  name,  membercost
FROM    Facilities 
WHERE   membercost > 0.0
ORDER BY  membercost DESC 

name            membercost      

Massage Room 1  9.9             
Massage Room 2  9.9             
Tennis Court 1  5.0             
Tennis Court 2  5.0             
Squash Court    3.5             

/* Q2: How many facilities do not charge a fee to members? */

SELECT  name, membercost 
FROM  Facilities
WHERE membercost = 0
ORDER BY  membercost

name                membercost Descending
Badminton Court     0.0
Table Tennis        0.0
Snooker Table       0.0
Pool Table          0.0

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE (
membercost / monthlymaintenance
) < 0.2
AND membercost > 0.0
ORDER BY facid 

facid       name                membercost      monthlymaintenance
0           Tennis Court 1      5.0             200  
1           Tennis Court 2      5.0             200
4           Massage Room 1      9.9             3000
5           Massage Room 2      9.9             3000
6           Squash Court        3.5             80

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT * 
FROM Facilities
WHERE facid IN ( 1, 5 ) 
ORDER BY facid

facid   name            membercost  guestcost   initialoutlay   monthlymaintenence
1       Tennis Court 2  5.0         25.0        8000            200
5       Massage Room 2  9.9         80.0        4000            3000

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance, 
CASE WHEN monthlymaintenance <=100 THEN  'cheap'
    ELSE  'expensive'
    END AS maintenancequantitative
FROM Facilities
ORDER BY name

name                monthlymaintenance      maintenancequantitative
Badminton Court     50                      cheap
Massage Room 1      3000                    expensive
Massage Room 2      3000                    expensive
Pool Table          15                      cheap
Snooker Table       15                      cheap  
Squash Court        80                      cheap
Table Tennis        10                      cheap
Tennis Court 1      200                     expensive
Tennis Court 2      200                     expensive


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT surname, firstname
FROM Members
ORDER BY joindate DESC 

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT CONCAT(Members.surname, ' ', Members.firstname) AS fullname, Facilities.name
FROM Members
JOIN Bookings ON Members.memid = Bookings.memid
JOIN Facilities ON Bookings.facid = Facilities.facid
WHERE Facilities.name =  'Tennis Court 1'
OR Facilities.name =  'Tennis Court 2'
ORDER BY fullname

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT Bookings.starttime, Facilities.name, 
       CONCAT( Members.surname,  ', ', Members.firstname ) AS name,          Facilities.guestcost, Facilities.membercost
FROM Bookings
JOIN Facilities ON Bookings.facid = Facilities.facid
JOIN Members ON Bookings.memid = Members.memid
WHERE Facilities.membercost >30
AND Bookings.memid !=0
OR Facilities.guestcost >30
AND Bookings.memid =0
AND Bookings.starttime
BETWEEN  '2012-09-14'
AND  '2012-09-14T23:59:59'
ORDER BY membercost, guestcost

/* Q9: This time, produce the same result as in Q8, but using a subquery. */


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
