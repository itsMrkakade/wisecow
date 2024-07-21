import requests
import time

# Application URL
APP_URL = "http://your-application-url.com"

# Check interval in seconds
CHECK_INTERVAL = 60

# Log file
LOG_FILE = "app_health.log"

def check_app_status():
    try:
        response = requests.get(APP_URL)
        if response.status_code == 200:
            print("Application is UP")
            return "UP"
        else:
            print("Application is DOWN - Status Code:", response.status_code)
            return "DOWN"
    except requests.exceptions.RequestException as e:
        print("Application is DOWN - Exception:", e)
        return "DOWN"

def log_status(status):
    with open(LOG_FILE, "a") as log_file:
        log_file.write(f"{time.ctime()}: Application is {status}\n")

def main():
    while True:
        status = check_app_status()
        log_status(status)
        time.sleep(CHECK_INTERVAL)

if __name__ == "__main__":
    main()


# Application Health Checker:

# Ensure Python and the requests library are installed.
# Save the script as app_health_checker.py.
# Run the script: python app_health_checker.py.