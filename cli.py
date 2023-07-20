"""Define CLI functions for interacting with the database."""
import configparser
import curses
import getpass
import time
import db
import customer
import admin
import re


options = [
    "Login (existing user)",
    "Signup (new user)",
    "Exit the application (requires admin credentials)",
]

selected_option = 0


def verify_admin_access():
    """Verify the administrator access to perform restricted functions.

    Returns:
        boolean: True, if the user is an administrator, false otherwise
    """
    admin_password = getpass.getpass(prompt="Enter admin password: ")
    if admin_password == "admin":
        return True
    else:
        return False


def send_otp(email_or_phone):
    """Send OTP to email or phone.

    Args:
        email_or_phone (str): Email or phone number of the user

    Returns:
        str: The OTP that was sent
    """
    # In a real implementation, this method would send an OTP to
    # the given email or phone number.
    # However, for the sake of this example, we'll just return a static OTP

    # Check if the input is an email address or a phone number
    if "@" in email_or_phone:
        print(f"An OTP has been sent to your email: {email_or_phone}")
    else:
        print(f"An OTP has been sent to your phone: {email_or_phone}")

    # Return the static OTP
    return "012345"


def parking_lot_status():
    """Return the live parking lot status.

    Returns:
        str: Status of the parking lot
    """
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get parking lot ID from the 'PARKING' section
    lot_id = config.getint("PARKING", "lot_id")
    available, total = db.check_parking_lot_status(lot_id)

    return f"{available} / {total} parking spots available in this lot"


def get_available_spots():
    """Return the live parking lot status.

    Returns:
        str: Status of the parking lot
    """
    config = configparser.ConfigParser()
    config.read("config.ini")

    # Get parking lot ID from the 'PARKING' section
    lot_id = config.getint("PARKING", "lot_id")
    available, total = db.check_parking_lot_status(lot_id)

    return available


def print_options(stdscr, index):
    """Print the available options for the users.

    Args:
        stdscr (curses.window): The curses window to print to.
        index (int): The index of the currently selected option.
    """
    stdscr.clear()

    stdscr.addstr(f"Select an option:\n\n{parking_lot_status()}\n\n")
    for i, option in enumerate(options):
        radio = "( )" if i != index else "(*)"
        stdscr.addstr(f"{radio} {option}\n")
    stdscr.refresh()


def login_existing_user():
    """Login for the existing user of the application."""
    email_or_phone = input("Enter email/phone: ")

    if db.check_customer_exists(email_or_phone):
        user_type = "customer"
    elif db.check_staff_exists(email_or_phone):
        user_type = "admin"
    else:
        print("Account with this email or phone doesn't exist")
        print("Please sign up and create a new account")
        time.sleep(5)
        run_cli()

    otp_sent = send_otp(email_or_phone)
    otp = input("Enter OTP: ")

    if otp == otp_sent:
        if user_type == "customer":
            customer.run_cli()
        elif user_type == "admin":
            admin.run_cli()
    else:
        print("Invalid OTP!")
        time.sleep(10)
        run_cli()


def signup_new_user():
    """Signup for new user (customer) of the application."""
    # TODO: Ask for user details and insert a tuple
    first_name = input("Please enter first name: ")
    last_name = input("Please enter last name: ")

    while True:
        email = input("Please enter email: ")
        if re.match(r"[^@]+@[^@]+\.[^@]+", email):
            break
        else:
            print("Invalid email entered. Please try again.")

    # Define a regular expression pattern to match a phone number
    # This pattern matches 10-digit phone numbers with or without hyphens
    phone_pattern = re.compile(r"^\d{3}-?\d{3}-?\d{4}$")

    phone = input("Please enter phone number (without country code): ")

    # Loop until a valid phone number is entered
    while not phone_pattern.match(phone):
        print(
            "Invalid phone number. Please enter a 10-digit number with or without hyphens."
        )
        phone = input("Please enter phone number (without country code): ")

    address = input("Please enter your address: ")
    db.add_new_customer(first_name, last_name, email, phone, address)


def exit_application():
    """Exit the Parking Management System Application."""
    if verify_admin_access():
        print("Thank you for using Parking Management System!")
        print("Have a good one!")
    else:
        print("Invalid admin password")
        time.sleep(5)
        run_cli()


def run_cli():
    """
    Run the Parking Management System command-line interface.

    The function initializes the curses library, displays the available
    options, and waits for the user to make a selection. Once the user
    selects an option, the corresponding function is called.
    """
    curses.wrapper(main)
    print(f"Selection: {options[selected_option]}")

    if selected_option == 0:
        login_existing_user()
    elif selected_option == 1:
        signup_new_user()
    elif selected_option == 2:
        exit_application()


def main(stdscr):
    """Start the Parking Management System CLI.

    Args:
        stdscr (curses.window): object to interact with the terminal.
    """
    curses.curs_set(0)
    global selected_option
    print_options(stdscr, selected_option)
    while True:
        key = stdscr.getch()
        if key == ord("\n"):  # enter key
            break
        elif key == curses.KEY_UP:
            selected_option = (selected_option - 1) % len(options)
        elif key == curses.KEY_DOWN:
            selected_option = (selected_option + 1) % len(options)
        print_options(stdscr, selected_option)


if __name__ == "__main__":
    curses.wrapper(main)
