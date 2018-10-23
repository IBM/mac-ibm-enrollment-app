# mac-ibm-enrollment-app
The Mac@IBM enrollment app makes setting up macOS with Jamf Pro more intuitive for users and easier for IT. The application offers IT admins the ability to gather additional information about their users during setup, allows users to customize their enrollment by selecting apps or bundles of apps to install during setup, and provides users with next steps when enrollment is complete.

## Configuration
### Setting up the privileged helper (JAMFIntegrationHelper)
##### 
1.  Make sure your build targets all have proper signing certificates assigned in the Build Settings/General tab.
2.  Build and run a copy of the app. You will need this build path for step 5.
3.  Download a copy of the [SMJobBlessUtil](https://developer.apple.com/library/archive/samplecode/SMJobBless/Listings/SMJobBlessUtil_py.html#//apple_ref/doc/uid/DTS40010071-SMJobBlessUtil_py-DontLinkElementID_8) from Apple.  
4.  Copy the python tool to the root of your project folder.
5.  From the terminal navigate to the root of your project folder and run the following : 

``` ./SMJobBlessUtil.py setreq /the/path/to/a/buildCopyOfYourApp enrollment/enrollment/Info.plist enrollment/JAMFIntegrationHelper/JAMFIntegrationHelper-Info.plist ```

This should create anchor keys in both the Info.plist for the app and -Info.plist of the helper. You can validate that the certificates are properly matching using the check option of the Utility: 

``` ./SMJobBlessUtil.py check /the/path/to/a/buildCopyOfYourApp```

A blank return means success. You can also see the anchor keys present in Xcode by looking at the corresponding  property lists.

![Main Application Info.plist](https://github.com/ibm/mac-ibm-enrollment-app/blob/master/images/appPlistAnchors.png)
![Helper-Info.plist](https://github.com/ibm/mac-ibm-enrollment-app/blob/master/images/helperPlistAnchor.png)

### Constant files to configure behavior and UI elements.
Stored Properties can be found in constants files located in the Constants directory of the project. 

__Note: you will need to configure the JAMFConstants.swift file with the policy event ID's for removing framework and bundle installation as well as JAMF URL's (primarily the production URL)__.


## Experience
The application experience flows through three phases:
1. Getting to know a little about you. 
2. Installing software bundles to get you up and running.
3. Education / URL link actions for next steps and help. 

The application provided is a UI that takes input from both the customer as well as a jamf event policy script. 

### JAMF Workflow
1.  The application and it's corresponding JAMFIntegrationHelper binary / daemon are deployed on enrollment to the system. 
2.  Additionally a script can be run to retrieve / provide information to the app's plist that lives in the customer's Library/Preferences.
	1. The hrFirstName populated through the LDAP connector, retrieved via API request from the client and written. 
	2. A speed test package to run the background to populate the plist with a download rate value.
	3. The bundle sizes as well as a calculated rate in seconds per bundle for bundle selection screen.

	All key names can be found in corresponding Constants files which are in turn references through the app code.

![phase1-Welcome](https://github.com/ibm/mac-ibm-enrollment-app/blob/master/images/phase1.png)

3.  The customer is greeted by the welcome screen and can move through the steps of answering questions. The data is recorded to keys specified for later retrieval by extension attribute if needed. 
    Should there be a desire to opt-out of management, the cancel button can initiate a jamf event policy for a decommission workflow provided by the JAMF admin.

4.  Once through the registration phase, the app can reboot the system allowing for disc encryption and any security policies to be applied ahead of software installation.

![phase2-Bundle Installation](https://github.com/ibm/mac-ibm-enrollment-app/blob/master/images/phase2.png)

5.  The customer is returned to the application bundle install screen after logging in from the reboot.  

6.  When they have made their selection and choose to move forward, a jamf event request is made to begin the bundle installation. The script behind this event will examine an array of bundle choices
    the customer has made and process accordingly, being sure to update the UI with the corresponding property list keys each step of the way.

![phase3-Further reading](https://github.com/ibm/mac-ibm-enrollment-app/blob/master/images/phase3.png)

7.  Finally, the customer is provided with resources to help them with their new job.
