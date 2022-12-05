# Title: outlandadvdisplay.py
# Team: Silver
# Author(s): Shayla Bradley, Patrick Ellis, Yawa Hallo, Abigail Klein
# Professor: Professor Sampson
# Date: December 4, 2022
# Description: Outland Adventures python file to display items in tables

import mysql.connector

mydb = mysql.connector.connect(
    user="Blythe_Timmerson",
    password="OutdoorBo$$1",
    host="localhost",
    database="outlandadventures"
)

# print out airfare table
print("--DISPLAYING airfare RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM airfare')

airfare = cursor.fetchall()

for airfare in airfare:
    print("Airfare ID: {}\nAirfare Price: {}\nSeason: {}\nTrip Location: {}\n".format
          (airfare[0], airfare[1], airfare[2], airfare[3]))

# print out customer table
print("--DISPLAYING customer RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM customer')

customer = cursor.fetchall()

for customer in customer:
    print("Customer ID: {}\nFirst Name: {}\nLast Name: {}\nPhone Number: {}\nEmail: {}\nAddress: {}\n".format
          (customer[0], customer[1], customer[2], customer[3], customer[4], customer[5]))

# print out customerBooking table
print("--DISPLAYING CustomerBooking RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM customerBooking')

customerBooking = cursor.fetchall()

for customerBooking in customerBooking:
    print("Customer Booking ID: {}\nCustomer ID: {}\nTrip Location ID: {}\nTrip Dates: {}\nAirfare ID: {}\nGuide: {}\n"
          .format(customerBooking[0], customerBooking[1], customerBooking[2], customerBooking[3], customerBooking[4],
                  customerBooking[5]))

# print out customerorder table
print("--DISPLAYING CustomerOrder RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM customerOrder')

customerOrder = cursor.fetchall()

for customerOrder in customerOrder:
    print("Customer Order Id: {}\nCustomer ID: {}\nEquipment Id: {}\nQuantity Purchased: {}\nDate Ordered: {}\n"
          "Rent or Buy: {}\n".format(customerOrder[0], customerOrder[1], customerOrder[2], customerOrder[3],
                                     customerOrder[4], customerOrder[5]))

# print out department table
print("--DISPLAYING department RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM department')

department = cursor.fetchall()

for department in department:
    print("Department ID: {}\nDepartment Name: {}\n".format(department[0], department[1]))

# print out employee table
print("--DISPLAYING employee RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM employee')

employee = cursor.fetchall()

for employee in employee:
    print("Employee ID: {}\nFirst Name: {}\nLast Name: {}\nPhone Number: {}\nPhone: {}\nEmail: {}\nDepartment: {}\n"
          .format(employee[0], employee[1], employee[2], employee[3], employee[4], employee[5], employee[6]))

# print out equpiment table
print("--DISPLAYING equipment RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM equipment')

equipment = cursor.fetchall()

for equipment in equipment:
    print("Equipment ID: {}\nEquipment Name: {}\nRental Price: {}\nPurchase Price: {}\nQuantity: {}\n".format(
        equipment[0],
        equipment[1], equipment[2], equipment[3], equipment[4]))

# print out inoculations table
print("--DISPLAYING inoculations RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM inoculations')

inoculations = cursor.fetchall()

for inoculations in inoculations:
    print("Inoculation ID: {}\nInoculation Name: {}\nTrip Location ID: {}\n".format(inoculations[0], inoculations[1],
                                                                                    inoculations[2]))

# print out supplier table
print("--DISPLAYING supplier RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM supplier')

supplier = cursor.fetchall()

for supplier in supplier:
    print("Supplier ID: {}\nSupplier Name: {}\nAddress: {}\nPhone Number: {}\nEmail: {}\nSupplier Rep: {}\n".format
          (supplier[0], supplier[1], supplier[2], supplier[3], supplier[4], supplier[5]))

# print out supplyorder table
print("--DISPLAYING SupplyOrder RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM supplyOrder')

supplyOrder = cursor.fetchall()

for supplyOrder in supplyOrder:
    print("Equipment Order ID: {}\nEquipment ID: {}\nUnit Price: {}\nQuantity Ordered: {}\nOrdered On: {}\nOrdered From"
          ": {}\n".format(supplyOrder[0], supplyOrder[1], supplyOrder[2], supplyOrder[3], supplyOrder[4],
                          supplyOrder[5]))

# print out trip_location table
print("--DISPLAYING trip_location RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM trip_location')

trip_location = cursor.fetchall()

for trip_location in trip_location:
    print("Trip Lcoation ID: {}\nTrip Location Name: {}\n".format(trip_location[0], trip_location[1]))

# print out visa_requirements tabls
print("--DISPLAYING visa_requirements RECORDS--")

cursor = mydb.cursor()

cursor.execute('SELECT * FROM visa_requirements')

visa_requirements = cursor.fetchall()

for visa_requirements in visa_requirements:
    print("Visa Requirements ID: {}\nVisa Requirement Name: {}\nTrip Location ID: {}\n".format
          (visa_requirements[0], visa_requirements[1], visa_requirements[2]))
