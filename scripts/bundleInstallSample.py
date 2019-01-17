#!/usr/bin/env python2.7
#
# IBM 11/15/2018
# App Installs called by the enrollment app after bundle choices
# Sample code for Open Source project.
#
# SPDX-License-Identifier: GPL-3.0-only

import os
import time
import subprocess
from subprocess import Popen, PIPE
from collections import OrderedDict

'''
# These are the paramaters that are passed from the bundle install to the install function.
install_event_list is a dictionary with multiple values for the install function.
    install_event_list = {AppText1 : [AppInstallOrder1,AppPlistUpdateName1,AppJPSEventTrigger1, AppInstallVerifyPath1]}
    AppText1 = Message that is displayed to the UI for the application being installed.
	AppInstallOrder1 = Order to install
	AppPlistUpdateName1 = Text that is added to the plist key to start the spinner in the UI for that app. anyconnect+InstallStatus = anyconnectInstallStatus
	AppJPSEventTrigger1 = Policy event for the jamf binary to execute
	AppInstallVerifyPath1 = The application path to verify that the install was successful

    Example:
    install_event_list = {Installing AnyConnect : [1,anyconnect,anyconnect_trigger, /Applications/AnyConnect.app]}

'''

'''
# The example bundle install block at the bottom will need to be updated for each bundle in the application.
# This bundles are shown on the wiki under Bundle Selection View page.
bundlename = "connectivity"
'''

############### Start of function ###############
# Function to run the installs.
def install(section, event, loggedInUser, appText, plistText, appPath):
    print section, event, loggedInUser, appText, plistText, appPath
    appInstall = plistText + "InstallStatus"
    # Set the status of the spinner 1=ON, 2=OFF
    statusstart = '1'
    statusstop = '2'

    # Set the install status for the application that is being installed.
    plistbuddy = 'sudo -u %s /usr/libexec/PlistBuddy -c "Set :%sInstallStatus %s" %s' % (loggedInUser, plistText, statusstart, filePath)
    sub_command = [ plistbuddy ]
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)


    # Set the message for the end user
    print "%sMessaging %s" % (section, appText)
    Message = "%sMessaging" % (section)
    Text = "%s" % (appText)
    sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, Message, Text]
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    if "ibmmangement" in appPath:
        os.system("sudo jamf policy -event %s -forceNoRecon" % event)
    else:
        if os.path.exists(appPath):
            print "App %s already installed" % appPath
            time.sleep(2)
        else:
            print "jamf %s" % event
            os.system("sudo jamf policy -event %s -forceNoRecon" % event)


    # Updated the install completion status... 2=Success, 3=Fail
    if os.path.exists(appPath):
        statusstop = '2'
    else:
        statusstop = '3'

    print statusstop
    plistbuddy = 'sudo -u %s /usr/libexec/PlistBuddy -c "Set :%sInstallStatus %s" %s' % (loggedInUser, plistText, statusstop, filePath)
    sub_command = [ plistbuddy ]
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    time.sleep(2)
############### End of function ###############

###################################################################################################################################################
###################################################################################################################################################
## Get the User home directory path.
sub_command = "/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4"
loggedInUser = subprocess.Popen(sub_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
loggedInUser = loggedInUser.communicate()[0]
loggedInUser = loggedInUser.strip()
print "logged in user is: %s" % loggedInUser
filePath = "/Users/%s/Library/Preferences/com.ibm.enrollment.plist" % loggedInUser

# Set the status of the spinner 1=ON, 2=OFF
statusstart = '1'
statusstop = '2'

# Read the plist for the Selected Bundles to install
sub_command = "sudo -u %s defaults read %s SelectedBundles" % (loggedInUser, filePath)
bundles = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
bundles = bundles.communicate()[0]
print bundles

# Example install bundle.
#For each bundle you will need to create a loop or duplicate the block below.
################# Start of Block #########################

# Name of bundles in the application plist shown in the Wiki docs under Bundle Selection View page.
bundlename = "connectivity"
if bundlename in bundles:
    print "Install %s" % bundlename
    section = bundlename
    sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, '%sBundleStatus', '-int', statusstart] % bundlename
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    # You will need to add each app to the install_event_list
    install_event_list = {'AppText1' : ['AppInstallOrder1','AppPlistUpdateName1','AppJPSEventTrigger1', 'AppInstallVerifyPath1'], 'AppText2' : ['AppInstallOrder2','AppPlistUpdateName2','AppJPSEventTrigger2', 'AppInstallVerifyPath2']}
    install_event_list = OrderedDict(sorted(install_event_list.items(), key=lambda t: t[1]))
    for dict in install_event_list:
        plistText = (install_event_list[dict][1])
        event = (install_event_list[dict][2])
        appPath = (install_event_list[dict][3])
        install(section, event, loggedInUser, dict, plistText, appPath)

    Message = "%sMessaging" % (section)
    sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, Message, '%s bundle complete '] % bundlename
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, '%sBundleStatus', '-int', statusstop] % bundlename
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
#################### End of Block ######################

# Set the App Screen to close it
sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, 'appScreenStatus', '-int', '1']
ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
