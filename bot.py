import sys, os
from selenium import webdriver
from selenium.webdriver.firefox.options import Options

MISSING_OPTIONS_ERROR = "Command ERROR: Available options are: ['start', 'lunch', 'stop']"

def initialize_driver(url):
    options = Options()
    options.headless = True

    driver = webdriver.Firefox(options=options)
    driver.implicitly_wait(10) # seconds
    driver.get(url)
    print("Driver Initialized.")
    return driver

def login(driver, user, password):
    driver.find_element_by_id('txLoginUsuario').send_keys(user)
    driver.find_element_by_id('txLoginContrasena').send_keys(password)
    driver.find_element_by_id('btnLogin').click()

def start_time(driver):
    driver.find_element_by_id('cpContenidoCentral_lnkbtnGeneralInicio').click()
    print("You are working!")

def lunch_time(driver):
    driver.find_element_by_id('cpContenidoCentral_rpActividades_LinkButton3_0').click()
    print("Bon appetit!!")

def stop_time(driver):
    driver.find_element_by_id('cpContenidoCentral_lnkbtnGeneralFin').click()
    print("You are not working!")

if len(sys.argv) > 1:
    cmd = str(sys.argv[1])

    user     = os.environ.get('CLOCKIN_USER')
    password = os.environ.get('CLOCKIN_PASSWORD')

    if user is None or password is None:
        sys.exit()

    driver = initialize_driver("https://app.altaiclockin.com/Inicio.aspx")

    login(driver, user, password)

    if cmd == "start":
        start_time(driver)
    elif cmd == "lunch":
        lunch_time(driver)
    elif cmd == "stop":
        stop_time(driver)
    else:
        print(MISSING_OPTIONS_ERROR)

    driver.quit()
else:
    print(MISSING_OPTIONS_ERROR)



