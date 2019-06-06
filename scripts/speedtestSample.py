#!/usr/bin/env python
# Determines the time it takes to download a 10MB pkg from the distribution point for the enrollment app to calculate download times.
# Sample code for Open Source project. used examples from https://docs.python.org/3/library/urllib.request.html and
#
# SPDX-License-Identifier: GPL-3.0-only

from __future__ import print_function
import sys
import time
import urllib
import ssl
import plistlib
import os
import subprocess
import commands
import datetime

########### VARIABLES THAT NEED TO BE CHANGED PER ENVIRONMENT ###########
# url is the path of a 10mb pkg to get a sample time from.
'''
url example https://jss_distrobution_point.com/SamplePackage.pkg
If you are using Enable Remote Authentication in the JSS you may need to create a non expiring download.
'''
url="https://my10mb.pkg"
######################################################################
################## DO NOT CHANGE BELOW THIS LINE ##################

lastrun = datetime.datetime.today().strftime('%Y-%m-%d')
speedtest = []
filename="/private/tmp/sample.pkg"

# reporthook function will calculate how long it takes to download the package from the save function.
def reporthook(number, blocksize, totalSize):
    global starttime
    if number == 0:
        starttime = time.time()
        return
    speed = int(int(number * blocksize) / (1024 * (time.time() - starttime)))
    speedtest.append(speed)

# Save function downloads the url specified and saves it to the file location specified in filename.
def save(url, filename):
    ssl._create_default_https_context = ssl._create_unverified_context
    urllib.urlretrieve(url, filename, reporthook)

#__main__

# run the save function passing the url and filename.
result=save(url,filename)
result = str(round(int(sum(speedtest) / float(len(speedtest))) * float(0.000976562),2))
print(result)

# Write the results to the plist file for the enrollment app.
sub_command = "/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4"
loggedInUser = subprocess.Popen(sub_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
loggedInUser = loggedInUser.communicate()[0]
loggedInUser = loggedInUser.strip()

print("logged in user is: %s" % loggedInUser)
filePath = "/Users/%s/Library/Preferences/com.ibm.enrollment.plist" % loggedInUser
print(filePath)

sub_command = ['sudo', '-u', loggedInUser, 'defaults', 'write', filePath, 'speedTestResult', result]
ssUser = subprocess.Popen(sub_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

