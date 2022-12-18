# Title: outlandadvreportquery.py
# Team: Silver
# Author(s): Shayla Bradley, Patrick Ellis, Yawa Hallo, Abigail Klein
# Professor: Professor Sampson
# Date: 12/16/2022
# Description: Outland Adventures python file to display results of queries

import time
from datetime import datetime
import mysql.connector

mydb = mysql.connector.connect(
    user="Blythe_Timmerson",
    password="OutdoorBo$$1",
    host="localhost",
    database="outlandadventures"
)

cursor = mydb.cursor()

# function to generate a time stamp of when the query has been run
def generatedon():
    dateObj = datetime.now()
    timestamp = dateObj.strftime("%d-%b-%Y (%H:%M:%S.%f)")
    print("Report Generated at: ", timestamp)

print("\n---PROFITS FROM EQUIPMENT RENTALS vs PROFITS FROM EQUIPMENT SALES---")

generatedon()
print()

cursor.execute("SELECT COUNT(*) FROM customerorder WHERE rented_or_bought = 'RENT'")
renttotal = cursor.fetchone()

cursor.execute("SELECT SUM(customer_equipment_quantity) FROM customerorder WHERE rented_or_bought = 'RENT'")
renttotalitem = cursor.fetchone()

cursor.execute("SELECT SUM((equipment_rent_price-equipment_unit_price)*customer_equipment_quantity) FROM customerorder "
               "INNER JOIN customer ON customerorder.customer_id=customer.customer_id "
               "INNER JOIN equipment ON customerorder.equipment_id=equipment.equipment_id WHERE rented_or_bought = 'RENT'")

rentProfit = cursor.fetchone()

print("Total Equipment Rental Transactions: {}".format(renttotal[0]))
print("Total Equipment Items Rented: {}".format(renttotalitem[0]))
print("Total Profit from Equipment Rentals: ${}".format(rentProfit[0]))
print()

cursor.execute("SELECT COUNT(*) FROM customerorder WHERE rented_or_bought = 'BUY'")
buytotal = cursor.fetchone()

cursor.execute("SELECT SUM(customer_equipment_quantity) FROM customerorder WHERE rented_or_bought = 'BUY'")
buytotalitem = cursor.fetchone()

cursor.execute("SELECT SUM((equipment_buy_price-equipment_unit_price)*customer_equipment_quantity) FROM customerorder "
               "INNER JOIN customer ON customerorder.customer_id=customer.customer_id "
               "INNER JOIN equipment ON customerorder.equipment_id=equipment.equipment_id WHERE rented_or_bought = 'BUY'")

purchProfit = cursor.fetchone()

print("Total Equipment Sales Transactions: {}".format(buytotal[0]))
print("Total Equipment Items Sold: {}".format(buytotalitem[0]))
print("Total Profit from Equipment Sales: ${}".format(purchProfit[0]))
print("\n--Itemized List of Customers Who Bought Their Equipment--")

generatedon()
print()

cursor.execute("SELECT customer_first_name, customer_last_name, equipment_name, equipment_buy_price, customer_equipment_quantity, "
               "(equipment_buy_price*customer_equipment_quantity), ((equipment_buy_price-equipment_unit_price)*customer_"
               "equipment_quantity), customer_order_id, customer_order_date "
               "FROM customerorder INNER JOIN customer ON customerorder.customer_id=customer.customer_id "
               "INNER JOIN equipment ON customerorder.equipment_id=equipment.equipment_id WHERE rented_or_bought = 'BUY'")

custorder = cursor.fetchall()

for custorder in custorder:
    print("Customer Name: {} {}\nEquipment Name: {}\nEquipment Price: ${}\nQuantity Order: {}\nCustomer Paid: ${}\n"
          "Total Profit: ${}\nReceipt Number: {}\nDate Ordered: {}\n".format(custorder[0], custorder[1], custorder[2], custorder[3],
            custorder[4], custorder[5], custorder[6], custorder[7], custorder[8]))

print("--Itemized List of Customers Who Rented Their Equipment--")

generatedon()
print()

cursor.execute("SELECT customer_first_name, customer_last_name, equipment_name, equipment_rent_price, customer_equipment_quantity, "
               "(equipment_rent_price*customer_equipment_quantity), ((equipment_rent_price-equipment_unit_price)*customer_"
               "equipment_quantity), customer_order_id, customer_order_date "
               "FROM customerorder INNER JOIN customer ON customerorder.customer_id=customer.customer_id "
               "INNER JOIN equipment ON customerorder.equipment_id=equipment.equipment_id WHERE rented_or_bought = 'RENT'")

custRentorder = cursor.fetchall()

for custRentorder in custRentorder:
    print("Customer Name: {} {}\nEquipment Name: {}\nEquipment Price: ${}\nQuantity Order: {}\nCustomer Paid: ${}\n"
          "Total Profit: ${}\nReceipt Number: {}\nDate Ordered: {}\n".format(custRentorder[0], custRentorder[1],
            custRentorder[2], custRentorder[3], custRentorder[4], custRentorder[5], custRentorder[6], custRentorder[7],
            custRentorder[8]))

print("\n---TRIPS BOOKED---")

generatedon()
print()

def num_trips_booked(cursor, trip):
    cursor.execute("SELECT COUNT(*) FROM customerbooking")
    totTrips = cursor.fetchone()

    cursor.execute("SELECT trip_location_name FROM trip_location WHERE trip_location_id = {}".format(trip))
    tripname = cursor.fetchone()

    cursor.execute("SELECT COUNT(trip_location_id) FROM customerbooking WHERE trip_location_id = {}".format(trip))
    booked = cursor.fetchall()

    for booked in booked:
        print("{} Trip: {} booked out of {} total trips booked".format(tripname[0], booked[0], totTrips[0]))

num_trips_booked(cursor, "'1'")
num_trips_booked(cursor, "'2'")
num_trips_booked(cursor, "'3'")

def trips_booked(cursor, trip, title):
    cursor.execute("SELECT customer_booking_id, customer_first_name, customer_last_name, customer_trip_date "
                   "FROM customerbooking INNER JOIN customer ON customerbooking.customer_id=customer.customer_id "
                   "INNER JOIN trip_location ON customerbooking.trip_location_id=trip_location.trip_location_id "
                   "WHERE trip_location_name = {}".format(trip))

    trips = cursor.fetchall()

    print("-- {} --".format(title))

    for trips in trips:
        print("Booking ID: {}\nCustomer Name: {} {}\nDate of Trip: {}\n".format(trips[0], trips[1],
               trips[2], trips[3]))

print("\n--List of Trips Booked - Organized By Trip--")

generatedon()
print()

trips_booked(cursor, "'Africa'", "Africa Trip")
trips_booked(cursor, "'Asia'", "Asia Trip")
trips_booked(cursor, "'Southern Europe'", "Southern Europe Trip")

print("\n---EQUIPMENT INVENTORY MORE THAN 5 YEARS OLD---")

generatedon()
print()

cursor.execute("SELECT COUNT(*) FROM supplyorder WHERE YEAR(supply_order_date) <= 2017")
supplyold = cursor.fetchone()

cursor.execute("SELECT SUM(supply_order_quantity) FROM supplyorder WHERE YEAR(supply_order_date) <= 2017")
supplyoldsum = cursor.fetchone()

print("Equipment Items more than 5 Years Old: {}".format(supplyold[0]))
print("Total Quantity of all Equipment Inventory more than 5 Years Old: {}\n".format(supplyoldsum[0]))
print("--Itemized List of Equipment Inventory More Than 5 Years Old--")

generatedon()
print()

cursor.execute("SELECT equipment_name, supply_order_date, supply_order_id, supply_order_quantity, DATEDIFF(CURDATE(), "
               "supply_order_date) FROM supplyorder INNER JOIN equipment ON supplyorder.equipment_id=equipment.equipment_id "
               "WHERE YEAR(supply_order_date) <= 2017")

supplyorder = cursor.fetchall()

for supplyorder in supplyorder:
    print("Equipment Name: {}\nDate Ordered: {}\nInvoice Number: {}\nQuantity Ordered: "
          "{}".format(supplyorder[0], supplyorder[1], supplyorder[2], supplyorder[3]))

    # format DATEDIFF to a Year, Month, Day output
    if supplyorder[4] >= 365:
        totDays = supplyorder[4]
        years = totDays // 365
        months = (totDays - years * 365) // 30
        days = (totDays - years * 365 - months * 30)
        print("Equipment Age:", years, "Years,", months, "Months, and", days, "Days\n")
