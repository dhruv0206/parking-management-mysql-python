"""
This program connects to a MySQL database and executes SQL queries.

Usage: python main.py
"""
import cli

if __name__ == "__main__":
    try:
        cli.run_cli()
    except Exception:
        print("Unknown error encountered, please check your configurations.")
