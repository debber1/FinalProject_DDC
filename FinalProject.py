from pynq import Overlay
from pynq import GPIO
from time import sleep

# Writing the bitstream to the FPGA
ps_pgio_design = Overlay("./design_1_wrapper.bit")

# Initialising the GPIO pins assigned in the blockdesign
iPush = GPIO(GPIO.get_gpio_pin(0), 'out')
iStop = GPIO(GPIO.get_gpio_pin(1), 'out')
iRst = GPIO(GPIO.get_gpio_pin(2), 'out')

# Defining BG colours:
bgRed0 = GPIO(GPIO.get_gpio_pin(3), 'out')
bgRed1 = GPIO(GPIO.get_gpio_pin(4), 'out')
bgRed2 = GPIO(GPIO.get_gpio_pin(5), 'out')
bgRed3 = GPIO(GPIO.get_gpio_pin(6), 'out')
bgGreen0 = GPIO(GPIO.get_gpio_pin(7), 'out')
bgGreen1 = GPIO(GPIO.get_gpio_pin(8), 'out')
bgGreen2 = GPIO(GPIO.get_gpio_pin(9), 'out')
bgGreen3 = GPIO(GPIO.get_gpio_pin(10), 'out')
bgBlue0 = GPIO(GPIO.get_gpio_pin(11), 'out')
bgBlue1 = GPIO(GPIO.get_gpio_pin(12), 'out')
bgBlue2 = GPIO(GPIO.get_gpio_pin(13), 'out')
bgBlue3 = GPIO(GPIO.get_gpio_pin(14), 'out')

# Defining text colours:
tRed0 = GPIO(GPIO.get_gpio_pin(15), 'out')
tRed1 = GPIO(GPIO.get_gpio_pin(16), 'out')
tRed2 = GPIO(GPIO.get_gpio_pin(17), 'out')
tRed3 = GPIO(GPIO.get_gpio_pin(18), 'out')
tGreen0 = GPIO(GPIO.get_gpio_pin(19), 'out')
tGreen1 = GPIO(GPIO.get_gpio_pin(20), 'out')
tGreen2 = GPIO(GPIO.get_gpio_pin(21), 'out')
tGreen3 = GPIO(GPIO.get_gpio_pin(22), 'out')
tBlue0 = GPIO(GPIO.get_gpio_pin(23), 'out')
tBlue1 = GPIO(GPIO.get_gpio_pin(24), 'out')
tBlue2 = GPIO(GPIO.get_gpio_pin(25), 'out')
tBlue3 = GPIO(GPIO.get_gpio_pin(26), 'out')

# Defining enables for the colour mux components
bgMux = GPIO(GPIO.get_gpio_pin(27), 'out')
tMux = GPIO(GPIO.get_gpio_pin(28), 'out')


def allOne(number):
  '''
  This function sets the entire screen to the number you want :D
  '''
  print("Start allOne")
  for cell in range(600):
    for x in range(number):
      iPush.write(1)
      sleep(0.01)
      iPush.write(0)
      sleep(0.01)
    # Pressing the iStop button
    iStop.write(1)
    sleep(0.01)
    iStop.write(0)
  print("End allOne")

def countUp():
  '''
  This function counts up from 0 to F and displays this on the screen, over and over again
  '''
  print("Start countUp")
  for cell in range(600):
    for x in range(cell%16):
      iPush.write(1)
      sleep(0.01)
      iPush.write(0)
      sleep(0.01)
    # Pressing the iStop button
    iStop.write(1)
    sleep(0.01)
    iStop.write(0)
  print("End countUp")

def countDown():
  '''
  This function counts down from F to 0 and displays this on the screen, over and over again
  '''
  print("Start countDown")
  for cell in range(600):
    for x in range(16-cell%16):
      iPush.write(1)
      sleep(0.01)
      iPush.write(0)
      sleep(0.01)
    # Pressing the iStop button
    iStop.write(1)
    sleep(0.01)
    iStop.write(0)
  print("End countDown")

def printOne(number):
  '''
  This function just prints one number to the screen and then quits
  '''
  for x in range(number):
    iPush.write(1)
    sleep(0.01)
    iPush.write(0)
    sleep(0.01)
  iStop.write(0)
  sleep(0.01)
  iStop.write(0)

def reset():
  '''
  This function resets everything
  '''
  ps_pgio_design = Overlay("./design_1_wrapper.bit")
  iRst.write(1)
  sleep(0.1)
  iRst.write(0)
  sleep(5)

def bgBlack():
  '''
  This function sets the background to black
  '''
  bgRed0.write(0)
  bgRed1.write(0)
  bgRed2.write(0)
  bgRed3.write(0)
  bgGreen0.write(0)
  bgGreen1.write(0)
  bgGreen2.write(0)
  bgGreen3.write(0)
  bgBlue0.write(0)
  bgBlue1.write(0)
  bgBlue2.write(0)
  bgBlue3.write(0)

def textWhite():
  '''
  This function sets the text to white
  '''
  tRed0.write(1)
  tRed1.write(1)
  tRed2.write(1)
  tRed3.write(1)
  tGreen0.write(1)
  tGreen1.write(1)
  tGreen2.write(1)
  tGreen3.write(1)
  tBlue0.write(1)
  tBlue1.write(1)
  tBlue2.write(1)
  tBlue3.write(1)

def bgWhite():
  '''
  This function sets the background to white
  '''
  bgRed0.write(1)
  bgRed1.write(1)
  bgRed2.write(1)
  bgRed3.write(1)
  bgGreen0.write(1)
  bgGreen1.write(1)
  bgGreen2.write(1)
  bgGreen3.write(1)
  bgBlue0.write(1)
  bgBlue1.write(1)
  bgBlue2.write(1)
  bgBlue3.write(1)

def textBlack():
  '''
  This function sets the text to Black
  '''
  tRed0.write(0)
  tRed1.write(0)
  tRed2.write(0)
  tRed3.write(0)
  tGreen0.write(0)
  tGreen1.write(0)
  tGreen2.write(0)
  tGreen3.write(0)
  tBlue0.write(0)
  tBlue1.write(0)
  tBlue2.write(0)
  tBlue3.write(0)

def textPink():
  '''
  This function sets the text to pink
  '''
  tRed0.write(1)
  tRed1.write(1)
  tRed2.write(1)
  tRed3.write(1)
  tGreen0.write(0)
  tGreen1.write(1)
  tGreen2.write(0)
  tGreen3.write(1)
  tBlue0.write(1)
  tBlue1.write(1)
  tBlue2.write(1)
  tBlue3.write(1)

def initSetup():
  '''
  This function sets everything up for when controll by the GPIO pins is desired
  '''
  # Giving python the control over colours
  bgMux.write(1)
  tMux.write(1)

  # Init screen to white text with a black background
  bgBlack()
  textWhite()

  # Initialise values for the GPIO
  iPush.write(0)
  iStop.write(0)
  iRst.write(0)

def cleanup():
  '''
  This function cleans up the GPIO signals when they are not needed anymore
  '''
  # Removing control over the colours
  bgMux.write(0)
  tMux.write(0)
  
  # Clean up values for the buttons
  iPush.write(0)
  iStop.write(0)
  iRst.write(0)

  
#==============================================================================
# This is the start of the automated sequence 
#==============================================================================

# Reset everything before we start
reset()

# Set the screen to show the same number on every cel
allOne(5)
sleep(10)
reset()

# Set the text colour to pink
textPink()

# Make a countdown appear on screen for every cel
countDown()
sleep(10)
reset()

# Set the bg colour to white
bgWhite()

# Make a countup appear on screen for every cel
countUp()
sleep(10)
reset()
