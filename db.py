"""Define functions for interacting with the database."""
import configparser
import json
import math
import cli
import time
import pymysql
import admin
import matplotlib.pyplot as plt
from datetime import datetime

DB_NAME = "parking_management"


def add_new_customer(first_name, last_name, email, phone, address):
    """Add new customer to database.

    Args:
        first_name (str): First name of the new customer
        last_name (str): Last name of the new customer
        email (str): Email of the new customer
        phone (str): Contact number of the new customer
        address (str): Address of the new customer
    """
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.callproc(
            "insert_customer", args=(first_name, last_name, email, phone, address)
        )

        print("Account created successfully, please login to continue")
        # commit the changes to the database
        db.commit()
    except pymysql.Error:
        print("Unable to create a new account, please try again.")
    finally:
        time.sleep(5)
        cli.run_cli()

    # Close database connection
    db.close()


def connect_to_database(username, password, database):
    """
    Connect to a MySQL database with the provided credentials.

    Args:
    username (str): MySQL username
    password (str): MySQL password
    database (str): Name of the database to connect to

    Returns:
    cursor: Cursor object for executing queries
    """
    try:
        db = pymysql.connect(
            host="localhost", user=username, password=password, db=database
        )
        return db.cursor(), db
    except pymysql.Error as e:
        print(f"Error connecting to MySQL: {e}")
        return None


def check_parking_lot_status(lot_id):
    """Check the parking lot status."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    cursor.execute("SELECT get_all_parking_spaces(%s)", (lot_id,))
    total = cursor.fetchone()[0]

    cursor.execute("SELECT get_available_parking_spaces(%s)", (lot_id,))
    available = cursor.fetchone()[0]

    # Close database connection
    db.close()

    return available, total


def check_customer_exists(email_or_phone):
    """Check if a customer with given email or phone exists."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    cursor.execute("SELECT check_customer_exists(%s)", (email_or_phone,))
    customer_exists = cursor.fetchone()[0] == 1

    # Close database connection
    db.close()

    return customer_exists


def delete_parking_lot(lot_id):
    """Delete a parking lot.

    Args:
        lot_id (int): ID of the lot to be delete
    """
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.callproc("delete_parking_lot", args=(lot_id))

        # commit the changes to the database
        db.commit()
        print("Lot ID deleted successfully")
    except pymysql.Error:
        print("Unable to delete the lot with given id.")
    finally:
        time.sleep(5)
        admin.run_cli()

    # Close database connection
    db.close()


def check_staff_exists(email_or_phone):
    """Check if a staff with given email or phone exists."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    cursor.execute("SELECT check_staff_exists(%s)", (email_or_phone,))
    staff_exists = cursor.fetchone()[0] == 1

    # Close database connection
    db.close()

    return staff_exists


def get_transaction_summary():
    """Get the summary of the transactions.

    Returns:
        json: summary of the transactions in a JSON object
    """
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.execute("SELECT get_transaction_summary()", ())
        result = cursor.fetchone()
        summary = json.loads(result[0])
        # extract values from dictionary
        yesterday_total = summary["yesterday_total"]
        last_week_total = summary["last_week_total"]
        last_month_total = summary["last_month_total"]
        return yesterday_total, last_week_total, last_month_total
    except pymysql.Error:
        print("Unable to fetch transaction history at the moment.")
    finally:
        # Close database connection
        db.close()


def traffic_hourly_summary():
    """Generate a bar chart using the parking events data for hourly summary."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        # Execute the SQL query to get the traffic during hours of the day
        query = (
            "SELECT HOUR(parkingEntryTime) as hour, COUNT(*) as traffic "
            "FROM parkingevent "
            "GROUP BY hour"
        )
        cursor.execute(query)
        hours = []
        traffic = []
        for hour, count in cursor:
            hours.append(hour)
            traffic.append(count)

        # Create a bar chart for the traffic during hours of the day
        plt.bar(hours, traffic)
        plt.xlabel("Hour of the day")
        plt.ylabel("Number of parking events")
        plt.title("Traffic during hours of the day")
        plt.show()
    except pymysql.Error:
        print("Unable to fetch the summary at the moment.")
    finally:
        # Close database connection
        db.close()


def traffic_daily_summary():
    """Generate a bar chart using the parking events data for daily summary."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        # Execute the SQL query to get the traffic during days of the week
        query = (
            "SELECT DAYNAME(parkingEntryTime) as day, COUNT(*) as traffic "
            "FROM parkingevent "
            "GROUP BY day"
        )
        cursor.execute(query)
        days = []
        traffic = []
        for day, count in cursor:
            days.append(day)
            traffic.append(count)

        # Create a bar chart for the traffic during days of the week
        plt.bar(days, traffic)
        plt.xlabel("Day of the week")
        plt.ylabel("Number of parking events")
        plt.title("Traffic during days of the week")
        plt.show()
    except pymysql.Error:
        print("Unable to fetch the summary at the moment.")
    finally:
        # Close database connection
        db.close()


def get_reservation_to_time(reservation_id):
    """Check reservation validity and return end time, parking event id."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.execute("SELECT get_reservation_to_time(%s)", args=(reservation_id))
        result = cursor.fetchone()
        reservation_details = json.loads(result[0])
        # extract values from dictionary
        reservation_to = reservation_details["reservation_to"]
        parking_event_id = reservation_details["parking_event_id"]
        return reservation_to, parking_event_id
    except (pymysql.Error, TypeError):
        print("Invalid reservation.")
    finally:
        # Close database connection
        db.close()


def get_unreserved_parking_spot(lot_id, disability_status):
    """Get an unreserved parking spot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.execute(
            "SELECT get_unreserved_parking_space(%s, %s)",
            args=(lot_id, disability_status),
        )
        db.commit()
        result = cursor.fetchone()
        spot_details = json.loads(result[0])
        # extract values from dictionary
        space_location = spot_details["space_location"]
        parking_event_id = spot_details["parking_event_id"]
    except (pymysql.Error, TypeError):
        print("Unable to allocate space.")
    finally:
        # Close database connection
        db.close()
    return parking_event_id, space_location


def get_duration(parking_event_id):
    """Get the duration of parking."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.execute(
            "SELECT bill_generation(%s)",
            args=(parking_event_id),
        )
        db.commit()
        result = cursor.fetchone()
        spot_details = json.loads(result[0])
        # extract values from dictionary
        parking_entry_time = spot_details["parking_entry_time"]
        parking_exit_time = spot_details["parking_exit_time"]

        start_time = datetime.strptime(parking_entry_time, "%Y-%m-%d %H:%M:%S.%f")
        end_time = datetime.strptime(parking_exit_time, "%Y-%m-%d %H:%M:%S.%f")

        duration = end_time - start_time
        hours = duration.total_seconds() / 3600
        return math.ceil(hours)
    except (pymysql.Error, TypeError):
        print("Unable to allocate space.")
    finally:
        # Close database connection
        db.close()


def create_transaction(parking_event_id, total_amount_due, payment_method):
    """Add an entry in the transactions table."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.callproc(
            "insert_transaction",
            args=(parking_event_id, total_amount_due, payment_method),
        )
        # commit the changes to the database
        db.commit()
    except pymysql.Error:
        print("Unable to add transaction, please try again.")
    finally:
        time.sleep(5)
        return

    # Close database connection
    db.close()


def delete_parking_space(space_id, lot_id):
    """Delete a parking space in a lot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.callproc("delete_parking_space", args=[lot_id, space_id])

        # commit the changes to the database
        db.commit()
        print("Space deleted successfully")
        # Close database connection
        db.close()
    except pymysql.Error:
        print("Unable to delete the space with given id.")
    finally:
        time.sleep(5)
        admin.run_cli()


def add_new_parking_lot(lot_name, lot_address, lot_capacity):
    """Add a parking lot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        cursor.callproc("insert_lot", args=[lot_name, lot_address, lot_capacity])

        # commit the changes to the database
        db.commit()
        print("Parking lot has been added successfully")
        # Close database connection
        db.close()
    except pymysql.Error:
        print("Unable to add the parking lot.")
    finally:
        time.sleep(5)
        admin.run_cli()


def update_parking_lot(lot_id, lot_name, lot_address, lot_capacity):
    """Update a parking lot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        if len(lot_name) == 0:
            lot_name = None
        if len(lot_address) == 0:
            lot_address = None
        if len(lot_capacity) == 0:
            lot_capacity = None
        cursor.callproc(
            "update_parking_lot", args=[lot_id, lot_name, lot_address, lot_capacity]
        )

        # commit the changes to the database
        db.commit()
        print("Parking lot updated successfully")
        # Close database connection
        db.close()
    except pymysql.Error:
        print("Unable to update the parking lot with given id.")
    finally:
        time.sleep(5)
        admin.run_cli()


def add_new_parking_space(lot_id, space_location, space_type, disability_status):
    """Add a parking space in the parking lot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        if disability_status == "Y":
            disability_status = 1
        else:
            disability_status = 0
        cursor.callproc(
            "insert_parking_space",
            args=[lot_id, space_location, space_type, disability_status],
        )

        # commit the changes to the database
        db.commit()
        print(
            f"Parking space in the parking lot id {lot_id} has been added successfully"
        )
        # Close database connection
        db.close()
    except pymysql.Error:
        print("Unable to add the parking space in the parking lot.")
    finally:
        time.sleep(5)
        admin.run_cli()


def update_parking_space(
    lot_id,
    space_id,
    space_location,
    space_type,
    disability_status,
    space_reserved,
    space_availability,
):
    """Update a parking lot."""
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get username and password from the 'DATABASE' section
    username = config.get("DATABASE", "username")
    password = config.get("DATABASE", "password")

    # Connect to MySQL database
    connection = connect_to_database(username, password, DB_NAME)
    if connection is None:
        return

    cursor, db = connection

    try:
        if len(space_location) == 0:
            space_location = None
        if len(space_type) == 0:
            space_type = None

        if len(disability_status) == 0:
            disability_status = None
        elif disability_status == "Y":
            disability_status = 1
        else:
            disability_status = 0

        if len(space_reserved) == 0:
            space_reserved = None
        elif space_reserved == "Y":
            space_reserved = 1
        else:
            space_reserved = 0

        if len(space_availability) == 0:
            space_availability = None
        if space_availability == "Y":
            space_availability = 1
        else:
            space_availability = 0

        cursor.callproc(
            "update_parking_space",
            args=[
                lot_id,
                space_id,
                space_location,
                space_type,
                disability_status,
                space_reserved,
                space_availability,
            ],
        )

        # commit the changes to the database
        db.commit()
        print("Parking lot updated successfully")
        # Close database connection
        db.close()
    except pymysql.Error:
        print("Unable to update the parking lot with given id.")
    finally:
        time.sleep(5)
        admin.run_cli()
