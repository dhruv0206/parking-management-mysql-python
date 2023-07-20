"""Define customer CLI functions for interacting with the database."""
import configparser
import curses
from datetime import datetime
import time
import cli
import db

options = [
    "I have a reservation",
    "I don't have a reservation",
    "Exit Parking Lot",
    "Logout",
]

selected_option = 0


def print_options(stdscr, index):
    """Print the available options for the users.

    Args:
        stdscr (curses.window): The curses window to print to.
        index (int): The index of the currently selected option.
    """
    stdscr.clear()
    stdscr.addstr("Select an option:\n\n")
    for i, option in enumerate(options):
        radio = "( )" if i != index else "(*)"
        stdscr.addstr(f"{radio} {option}\n")
    stdscr.refresh()


def generate_receipt():
    """Generate the receipt for the customer."""
    total_amount_due = 0
    parking_event_id = input("Enter your parking event id (if lost ticket, enter 0): ")

    if parking_event_id == 0:
        fine = 50
        total_amount_due += fine
    else:
        price = 10
        # Query the database and get JSON with entrytime, exittime
        duration = db.get_duration(parking_event_id)
        total_amount_due += duration * price

    print(f"Total amount due: {total_amount_due}")
    db.create_transaction(parking_event_id, total_amount_due, "card")
    print("Please tap or swipe your card")
    time.sleep(5)
    # In a real implementation, this method would wait for a payment.
    # However, for the sake of this example, we'll just return a message.
    print("Thank you for your payment!")
    time.sleep(7)
    cli.run_cli()


def run_cli():
    """
    Run the Parking Management System command-line interface.

    The function initializes the curses library, displays the available
    options, and waits for the user to make a selection. Once the user
    selects an option, the corresponding function is called.
    """
    curses.wrapper(main)

    if selected_option == 0:
        reservation_id = input("Enter reservation id: ")
        try:
            reservation_to, parking_event_id = db.get_reservation_to_time(
                reservation_id
            )
            dt_obj = datetime.strptime(reservation_to, "%Y-%m-%d %H:%M:%S.%f")
            formatted_time = dt_obj.strftime("%d %b %Y, %I:%M %p")
            print(f"Welcome! Your parking event ID is: {parking_event_id}")
            print(f"Please note that your reservation ends at {formatted_time}")
        except TypeError:
            print("Please reverify details and try again.")
        finally:
            time.sleep(10)
            run_cli()
    elif selected_option == 1:
        if cli.get_available_spots() == 0:
            print("The parking lot is full, please come back later.")
            time.sleep(5)
            cli.run_cli()

        config = configparser.ConfigParser()
        config.read("config.ini")

        # Get parking lot ID from the 'PARKING' section
        lot_id = config.getint("PARKING", "lot_id")
        disability_status = input("Do you need disability accessible spot?(Y/N): ")
        try:
            if disability_status == "Y":
                disability_status = 1
            else:
                disability_status = 0
            parking_event_id, parking_spot = db.get_unreserved_parking_spot(
                lot_id, disability_status
            )
            print(f"Welcome! Your parking event ID is: {parking_event_id}")
            print(f"Please park your vehicle at spot: {parking_spot}")
        except TypeError:
            print("Please try again.")
        finally:
            time.sleep(10)
            cli.run_cli()
    elif selected_option == 2:
        generate_receipt()
    elif selected_option == 3:
        cli.run_cli()


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
