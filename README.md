
# Parking Management System

The objective of this project is to design and implement a robust database management system for the Parking Management System that will support its day-to-day operations. The database should be designed to store and manage all parking-related data, including customer information, vehicle details, parking space availability, parking history, and billing records. It will be an automated parking management system where users will be able to enter parking lots with or without any prior reservation and use the available spaces of the parking lot.


## Tech Stack

- Python 3.11.1
- MySQL 8.0.32


## Installation

### Install Python

- Go to the official Python website and download the latest stable release of Python for your operating system. You can download Python from https://www.python.org/downloads/.

- Follow the installation instructions for your operating system to complete the installation process. Make sure to add Python to your system's PATH environment variable, so you can run Python from any directory in the command line.

### Install MySQL Workbench

- Download the MySQL Workbench installer for your operating system from the official [MySQL website](https://dev.mysql.com/downloads/workbench/). 

- Run the installer and follow the prompts to complete the installation process.
## Run Locally

Set the configurations in the `config.ini` file.

Example:
```
[DATABASE]
username = root
password = password

[PARKING]
lot_id = 1

```

Note:
- The OTP (One Time Password) implementation is static, so the OTP should always be 012345 to login.
- The administrator email ID is yug.rajani99@gmail.com (from the given dump)
- Customer account can be created after running and can be used for logging in.
- Logging in using customer or administrator email address or phone number will lead to different menus accordingly.
- Use the password "admin" if you want to exit the application using the menu option.

Create a virtual environment

```bash
  python -m venv env
```

Activate the virtual environment

```bash
  source env/bin/activate
```

Install the required packages inside this virtual environment using pip

```bash
  pip install -r requirements.txt
```

*Note*: This application has been built and tested on MacOS. If you are running the application on Windows operating system, please install the dependency `windows-curses` using the command `pip install windows-curses` in the virtual environment for the `curses` library to work correctly on the Windows Machine.

To run the application

```bash
  python main.py
```

After you are done working in the virtual environment, you can deactivate it by running the command
```bash
  deactivate
```

You can later delete the virtual environment by simply deleting the env directory.
## Screenshots

Main Screen:
![Main Screen](https://imgur.com/yFTUwSY.png)

Signup (Customer):
![Signup](https://imgur.com/Aw56h97.png)

Logged in as Customer:
![Customer Menu](https://imgur.com/eEkKDxF.png)

Customer - Invalid reservation (I have a reservation):
![Invalid reservation](https://imgur.com/JREGzt2.png)

Customer - Valid reservation (I have a reservation):
![Valid reservation](https://imgur.com/WyU4G8p.png)

Customer Option (I don't have a reservation):
![No reservation](https://imgur.com/OjIb2Fi.png)

Exit Parking Lot (Generate Receipt):
![Exit Parking Lot](https://imgur.com/OYP98hX.png)

Logged in as Admin:
![Admin Menu](https://imgur.com/SUbotk4.png)

Generate Bar Chart: Busiest hours of the day
![Bar Chart](https://imgur.com/FaPlzYC.png)

Generate Bar Chart: Busiest days of the week
![Bar Chart](https://imgur.com/erdoQEj.png)

Summarize earnings: Transactions summary
![Transactions Summary](https://imgur.com/mS6G49d.png)


## Authors

- [Yug Deepak Rajani](https://www.linkedin.com/in/yug-rajani/)
- [Dhruv Patel](https://www.linkedin.com/in/dhruv-patel-0206)

