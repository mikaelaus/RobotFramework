# RobotFramework
Setup

1. Download and install python from https://www.python.org/downloads/
On OSX $ brew install python

2. Verify pip is installed. pip is already installed if you're using Python 2 >=2.7.9 or Python 3 >=3.4 downloaded from python.org, but you'll need to upgrade pip.

3. To install pip, securely download get-pip.py
Then run the following: 
    python get-pip.py

4. Install Robot Framework 
    pip install robotframework

5. Install the Selenium2Library for Robot Framework

    pip install --upgrade robotframework-seleniumlibrary

6. I used Sublime Text as my editor to create/edit tests. To install the plugin for robot framework. The easiest way to install is to use Package Control and search for: Robot Framework Assistant

7. Configure the settings in the User package Robot.sublime-settings file. To Open the file navigate to: Preferences | Package settings | Robot Framework Assistant | Settings - User | The default settings can be found from the Preferences | Package settings| Robot Framework Assistant | Settings - Default 

* The only mandatory settings which user needs to define are the robot_framework_workspace and the path_to_python. 

* The robot_framework_workspace variable should have the path of the Robot framework folder in this repo


Running the Test

To run the test, navigate to the Robot Framework folder and from command line  type

    pybot --outputdir Results --timestampoutputs Tests/*.robot


Viewing Reports

Test results and screenshots will be created in the results folder. Open the log.html and view the suite wise report





