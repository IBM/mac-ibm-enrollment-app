#!/usr/bin/env python2.7
#
# IBM 01/12/2021
# App Installs called by the enrollment app after bundle choices
# Sample code for Open Source project.
#
# SPDX-License-Identifier: GPL-3.0-only

import os
import plistlib
import time
import commands
import time
from AppKit import NSWorkspace
import subprocess
from subprocess import Popen, PIPE
from collections import OrderedDict
import shlex, subprocess

############### Start of function ###############
# Function to run the installs.
def install(section, event, loggedInUser, appText, plistText, appPath):
    print section, event, loggedInUser, appText, plistText, appPath
    appInstall = plistText + "InstallStatus"
    # Set the status of the spinner
    statusstart = '1'
    statusstop = '2'
    
    # Set the message for the end user
    print "%sMessaging %s" % (section, appText)
    Message = "%sMessaging" % (section)
    Text = "%s" % (appText)
    print appText
    print Message

    sub_command = "sudo -u %s open 'macatibmenrollment:updateuistatus?%s=%s&%s=%s'" % (loggedInUser, appInstall, statusstart, Message, Text)
    print sub_command

    args = shlex.split(sub_command)
    ssUser = subprocess.Popen(args, stdout=PIPE)

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
    sub_command = "sudo -u %s open 'macatibmenrollment:updateuistatus?%s=%s'" % (loggedInUser, appInstall, statusstop)
    args = shlex.split(sub_command)
    ssUser = subprocess.Popen(args, stdout=PIPE)
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
print filePath


# Read the plist for the Selected Bundles
sub_command = "sudo -u %s defaults read %s selectedBundles" % (loggedInUser, filePath)
args = shlex.split(sub_command)
bundles = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
bundles = bundles.communicate()[0]
print bundles

statusstart = '1'
statusstop = '2'

# Example install bundle.
#For each bundle you will need to create a loop or duplicate the block below.
################# Start of Block #########################

# Name of bundles in the application plist shown in the Wiki docs under Bundle Selection View page.
if "connectivity" in bundles:
    print "In Loop connectivity"
    section = "connectivity"
    sub_command = "sudo -u %s open 'macatibmenrollment:updateuistatus?connectivityBundleStatus=%s'" % (loggedInUser, statusstart)
    args = shlex.split(sub_command)
    ssUser = subprocess.Popen(args, stdout=PIPE)
    install_event_list = {'AppText1' : ['AppInstallOrder1','AppPlistUpdateName1','AppJPSEventTrigger1', 'AppInstallVerifyPath1'], 'AppText2' : ['AppInstallOrder2','AppPlistUpdateName2','AppJPSEventTrigger2', 'AppInstallVerifyPath2']}
    install_event_list = OrderedDict(sorted(install_event_list.items(), key=lambda t: t[1]))
    for dict in install_event_list:
        plistText = (install_event_list[dict][1])
        event = (install_event_list[dict][2])
        appPath = (install_event_list[dict][3])
        install(section, event, loggedInUser, dict, plistText, appPath)

    Message = "%sMessaging" % (section)
    sub_command = "sudo -u %s open 'macatibmenrollment:updateuistatus?connectivityBundleStatus=%s&%s=Connectivity_bundle_complete'" % (loggedInUser, statusstop, Message)
    args = shlex.split(sub_command)
    ssUser = subprocess.Popen(args, stdout=PIPE)
#################### End of Block ######################

# Set the App Screen to close it
time.sleep(2) # Allow the app to update
sub_command = "sudo -u %s open 'macatibmenrollment:updateuistatus?appScreenStatus=1'" % loggedInUser
args = shlex.split(sub_command)
ssUser = subprocess.Popen(args, stdout=PIPE)

