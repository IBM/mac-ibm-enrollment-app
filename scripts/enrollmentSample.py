#!/usr/bin/env python2.7
#
# IBM 11/15/2018
# Sample code for Open Source project
# Items used in the UI during enrollment
#
# SPDX-License-Identifier: GPL-3.0-only
import os
import subprocess
import time
from subprocess import Popen, PIPE
from SystemConfiguration import SCDynamicStoreCopyConsoleUser
import urllib2
import base64
import sys
import json

# Get the logged in user
loggedInUser = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]
loggedInUser = [loggedInUser,""][loggedInUser in [u"loginwindow", None, u""]]

print "logged in user is: %s" % loggedInUser
fileUserPath="/Users/%s/Library/Preferences/com.ibm.enrollment.plist" % loggedInUser

# Setup for enrollment
if os.path.exists(fileUserPath):
    os.remove(fileUserPath)

# Sample code for pulling data from the JSS with the api
# sys arguements are pulled from script parameters in the jss
'''
jss_url = sys.argv[4]
jss_url = jss_url.rstrip('/')
jss_api_user = sys.argv[5]
jss_api_passwd = sys.argv[6]

sub_command = "system_profiler SPHardwareDataType | grep UUID | awk '" " { print $NF }'"
result = subprocess.Popen(sub_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
UDID = result.communicate()[0]
UDID = UDID.rstrip('\r\n')

jss_sub_url = str(jss_url + '/JSSResource/computers/udid/%s/subset/general&location&extension_attributes') % UDID
request = urllib2.Request(jss_sub_url)
request.add_header('Accept', 'application/json')
request.add_header('Authorization', 'Basic ' + base64.b64encode(jss_api_user + ':' + jss_api_passwd))
response = urllib2.urlopen(request)
apidata = json.load(response)

# Read the xml
username = apidata['computer']['location']['username']
jssid = apidata['computer']['general']['id']
email = apidata['computer']['location']['email_address']
position = apidata['computer']['location']['position']
'''

# The username to display in the app. You can use the username pulled from the api call above or use your on method to populate.
hrFirstName="%s" % username
#Example for enrollmentAppItems below add the bundle size and the seconds to install.
#enrollmentAppItems= {"LDAPHRFName": hrFirstName, "connectivitySize": "18.0",  "connectivityInstallSeconds": "13.57","jpsCommSeconds": "60.0",}

# Update the plsit file
# First value is the key in the plist Second is the value.
enrollmentAppItems= {"username": hrFirstName, "NameOfBundleSize1": "BundleSize1", "NameOfBundleSize2": "BundleSize2", "NameOfBundleInstallSeconds1": "BundleInstallTime1", "NameOfBundleInstallSeconds2": "BundleInstallTime2","jpsCommSeconds": "60.0",}
print(enrollmentAppItems)
for key, value in enrollmentAppItems.items():
    print(key, value)
    sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', fileUserPath, key, value]
    ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

# Launch the enrollment application
os.system("open /Applications/Enrollment.app")
