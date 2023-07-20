"""Define admin CLI functions for interacting with the database."""
import curses
import time

import db
import admin
import cli

options = [
    "Add Parking Lot",
    "Update Parking Lot",
    "Delete Parking Lot",
    "Add Parking Space in a lot",
    "Update Parking Space in a lot",
    "Delete Parking Space from a lot",
    "Generate Bar Chart: Busiest hours of the day",
    "Generate Bar Chart: Busiest days of the week",
    "Summarize earnings: Transactions summary",
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


def run_cli():
    """
    Run the Parking Management System command-line interface.

    The function initializes the curses library, displays the available
    options, and waits for the user to make a selection. Once the user
    selects an option, the corresponding function is called.
    """
    curses.wrapper(main)
    print("Selection:")
    print(options[selected_option])

    if selected_option == 0:
        print("Enter the values to create a parking lot")
        lot_name = input("Enter the name of the lot: ")
        lot_address = input("Enter the address of the lot: ")
        lot_capacity = input("Enter the total capacity of the lot: ")
        db.add_new_parking_lot(lot_name, lot_address, lot_capacity)
    elif selected_option == 1:
        print("Enter the values to be updated!")
        print("Press ENTER if you want to skip updation of any value!")
        lot_id = input("Enter the id of the lot to be updated: ")
        lot_name = input("Enter the name of the lot to be updated: ")
        lot_address = input("Enter the address of the lot to be updated: ")
        lot_capacity = input("Enter the total capacity of the lot to be updated: ")
        db.update_parking_lot(lot_id, lot_name, lot_address, lot_capacity)
    elif selected_option == 2:
        lot_id = input("Enter the id of the lot to be deleted: ")
        db.delete_parking_lot(lot_id)
        admin.run_cli()
    elif selected_option == 3:
        print("Enter the values to add a parking space in a parking lot")
        lot_id = input("Enter the id of the lot in which space has to be added: ")
        space_location = input("Enter the location of the space in parking lot: ")
        space_type = input(
            "Enter the type of the vehicle that a space can hold (eg: car/motorcycle): "
        )
        disability_status = input("Do you need disability accessible spot?(Y/N): ")
        db.add_new_parking_space(lot_id, space_location, space_type, disability_status)
    elif selected_option == 4:
        print("Enter the values to be updated!")
        print("Press ENTER if you want to skip updation of any value!")
        lot_id = input("Enter the id of the lot of which space has to be updated: ")
        space_id = input(
            "Enter the id of the space in the lot whose data has to be updated: "
        )
        space_location = input(
            "Enter the location of the space in parking lot to be updated: "
        )
        space_type = input(
            "Enter the type of the vehicle that has to be updated (eg: car/motorcycle): "
        )
        disability_status = input("Is it disability accessible spot?(Y/N): ")
        space_reserved = input("Is it reserved spot?(Y/N): ")
        space_availability = input("Is this space available?(Y/N): ")
        db.update_parking_space(
            lot_id,
            space_id,
            space_location,
            space_type,
            disability_status,
            space_reserved,
            space_availability,
        )
    elif selected_option == 5:
        lot_id = input("Enter the id of the lot from which space is to be deleted: ")
        space_id = input("Enter the id of the space to be deleted: ")
        db.delete_parking_space(space_id, lot_id)
    elif selected_option == 6:
        db.traffic_hourly_summary()
        run_cli()
    elif selected_option == 7:
        db.traffic_daily_summary()
        run_cli()
    elif selected_option == 8:
        try:
            (
                yesterday_total,
                last_week_total,
                last_month_total,
            ) = db.get_transaction_summary()
        except Exception:
            print("Please try again later.")
        print(f"Yesterday's total: {yesterday_total}")
        print(f"Last week's total: {last_week_total}")
        print(f"Last month's total: {last_month_total}")
        time.sleep(5)
        print("Going back to main menu")
        time.sleep(5)
        run_cli()
    elif selected_option == 9:
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
