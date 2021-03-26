#!/usr/bin/env python2.7
#
# IBM 03/22/2021
# Sample code for Open Source project
# Items used in the UI during enrollment
#
# SPDX-License-Identifier: GPL-3.0-only

import os
import plistlib
import json
import urllib2
import base64
import sys
import time
import subprocess
from subprocess import Popen, PIPE

# Get the logged in user
sub_command = "/bin/ls -la /dev/console | /usr/bin/cut -d ' ' -f 4"
loggedInUser = subprocess.Popen(sub_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
loggedInUser = loggedInUser.communicate()[0]
loggedInUser = loggedInUser.strip()

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
hrFirstName = "User name"
jpsCommSeconds = "60.0"

# Configuration json, see https://github.com/IBM/mac-ibm-enrollment-app/wiki/Configuration-file-(.plist) for more info about the structure.
conf_json = """
{
    "phase": 0,
    "userInfo": {
        "hrFirstName": "%s"
    },
    "networkInfo": {
        "jpsCommSeconds": "%s"
    },
    "policies": {
        "registrationPolicy": "reg",
        "bundleInstallationPolicy": "inst",
        "removeFramework": "rem"
    },
    "registration": {
        "pages": [
            {
                "title": {
                            "label": "Page One"
                },
                "subitile": {
                            "label": "Subtitle",
                            "infoSection": {
                                "fields": [
                                    {
                                        "label": "Label One",
                                        "description": "Description One"
                                    },
                                    {
                                        "label": "Label Two",
                                        "description": "Description Two"
                                    },
                                    {
                                        "label": "Label Three",
                                        "description": "Description Three"
                                    }
                                ]
                            }
                },
                "fields": [
                    {
                        "title" : {
                            "label": "Field Title One"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },
                    {
                        "title" : {
                            "label": "Field Title Two"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },
                    {
                        "title" : {
                            "label": "Field Title Three"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },{
                        "title" : {
                            "label": "Field Title Four"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    }
                ],
                "footer": {
                            "label": "Footer",
                            "infoSection": {
                                "fields": [
                                    {
                                        "label": "Label One",
                                        "description": "Description One"
                                    },
                                    {
                                        "label": "Label Two",
                                        "description": "Description Two"
                                    },
                                    {
                                        "label": "Label Three",
                                        "description": "Description Three"
                                    }
                                ]
                            }
                }
            },
            {
                "title": {
                            "label": "Page Two"
                },
                "subitile": {
                            "label": "Subtitle",
                            "infoSection": {
                                "fields": [
                                    {
                                        "label": "Label One",
                                        "description": "Description One"
                                    },
                                    {
                                        "label": "Label Two",
                                        "description": "Description Two"
                                    },
                                    {
                                        "label": "Label Three",
                                        "description": "Description Three"
                                    }
                                ]
                            }
                },
                "fields": [
                    {
                        "title" : {
                            "label": "Field Title One"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },
                    {
                        "title" : {
                            "label": "Field Title Two"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },
                    {
                        "title" : {
                            "label": "Field Title Three"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    },{
                        "title" : {
                            "label": "Field Title Four"
                        },
                        "key" : "keyone",
                        "multipleChoiseAllowed" : false,
                        "showTitle" : true,
                        "options" : [
                            {
                                "key": "keyOptionOne",
                                "label": "Key Label One"
                            },
                            {
                                "key": "keyOptionTwo",
                                "label": "Key Label Two"
                            },
                            {
                                "key": "keyOptionThree",
                                "label": "Key Label Three"
                            }
                        ]
                    }
                ],
                "footer": {
                            "label": "Footer",
                            "infoSection": {
                                "fields": [
                                    {
                                        "label": "Label One",
                                        "description": "Description One"
                                    },
                                    {
                                        "label": "Label Two",
                                        "description": "Description Two"
                                    },
                                    {
                                        "label": "Label Three",
                                        "description": "Description Three"
                                    }
                                ]
                            }
                }
            }
        ]
    },
    "bundleSelectionPage": {
        "title": {
            "label": "Bundle Selection Page"
        },
        "subitile": {
            "label": "Subtitle",
            "infoSection": {
                "fields": [
                    {
                        "label": "Label One",
                        "description": "Description One"
                    },
                    {
                        "label": "Label Two",
                        "description": "Description Two"
                    },
                    {
                        "label": "Label Three",
                        "description": "Description Three"
                    }
                ]
            }
        },
        "bundles": [
            {
                "title": "First Bundle",
                "extendedTitle": "First Bundle",
                "description": "First Bundle",
                "key": "firstbundle",
                "icon": "firstbundle",
                "status": 0,
                "bundleMessaging": "",
                "time": "300",
                "size": "300",
                "recommended": true,
                "apps": [
                    {
                        "title": "First App",
                        "description": "First App",
                        "key": "firstappfirstbundle",
                        "icon": "firstappfirstbundle",
                        "status": 0
                    },
                    {
                        "title": "Second App",
                        "description": "Second App",
                        "key": "secondappfirstbundle",
                        "icon": "secondappfirstbundle",
                        "status": 0
                    },
                    {
                        "title": "Third App",
                        "description": "First App",
                        "key": "thirdappfirstbundle",
                        "icon": "thirdappfirstbundle",
                        "status": 0
                    }
                ]
            },
            {
                "title": "Second Bundle",
                "extendedTitle": "Second Bundle",
                "description": "Second Bundle",
                "key": "secondbundle",
                "icon": "secondbundle",
                "status": 0,
                "bundleMessaging": "",
                "time": "300",
                "size": "300",
                "recommended": true,
                "apps": [
                    {
                        "title": "First App",
                        "description": "First App",
                        "key": "firstappsecondbundle",
                        "icon": "firstappsecondbundle",
                        "status": 0
                    },
                    {
                        "title": "Second App",
                        "description": "Second App",
                        "key": "secondappsecondbundle",
                        "icon": "secondappsecondbundle",
                        "status": 0
                    },
                    {
                        "title": "Third App",
                        "description": "First App",
                        "key": "thirdappsecondbundle",
                        "icon": "thirdappsecondbundle",
                        "status": 0
                    }
                ]
            },
            {
                "title": "Third Bundle",
                "extendedTitle": "Third Bundle",
                "description": "Third Bundle",
                "key": "thirdbundle",
                "icon": "thirdbundle",
                "status": 0,
                "bundleMessaging": "",
                "time": "300",
                "size": "300",
                "recommended": true,
                "apps": [
                    {
                        "title": "First App",
                        "description": "First App",
                        "key": "firstappthirdbundle",
                        "icon": "firstappthirdbundle",
                        "status": 0
                    },
                    {
                        "title": "Second App",
                        "description": "Second App",
                        "key": "secondappthirdbundle",
                        "icon": "secondappthirdbundle",
                        "status": 0
                    },
                    {
                        "title": "Third App",
                        "description": "First App",
                        "key": "thirdappthirdbundle",
                        "icon": "thirdappthirdbundle",
                        "status": 0
                    }
                ]
            }
        ]
    },
    "bundleInstallationPage": {
        "title": {
            "label": "Installation page"
        },
        "subitile": {
            "label": "Subtitle",
            "infoSection": {
                "fields": [
                    {
                        "label": "Label One",
                        "description": "Description One"
                    },
                    {
                        "label": "Label Two",
                        "description": "Description Two"
                    },
                    {
                        "label": "Label Three",
                        "description": "Description Three"
                    }
                ]
            }
        }
    },
    "postRegistrationPage": {
        "title": {
            "label": "Post registration"
        },
        "subitile": {
            "label": "Subtitle",
            "infoSection": {
                "fields": [
                    {
                        "label": "Label One",
                        "description": "Description One"
                    },
                    {
                        "label": "Label Two",
                        "description": "Description Two"
                    },
                    {
                        "label": "Label Three",
                        "description": "Description Three"
                    }
                ]
            }
        },
        "body": "Post registration page body",
        "needsRestart": true,
        "restartTimeout": 300,
        "footer": {
            "label": "Footer",
            "infoSection": {
                "fields": [
                    {
                        "label": "Label One",
                        "description": "Description One"
                    },
                    {
                        "label": "Label Two",
                        "description": "Description Two"
                    },
                    {
                        "label": "Label Three",
                        "description": "Description Three"
                    }
                ]
            }
        }
    },
    "postInstallationPage": {
        "title": {
            "label": "Post Installation page"
        },
        "subitile": {
            "label": "Subtitle",
            "infoSection": {
                "fields": [
                    {
                        "label": "Label One",
                        "description": "Description One"
                    },
                    {
                        "label": "Label Two",
                        "description": "Description Two"
                    },
                    {
                        "label": "Label Three",
                        "description": "Description Three"
                    }
                ]
            }
        },
        "items": [
            {
                "title": "First Item",
                "description": "First Item",
                "iconName": "firstPostInstallationItem",
                "ctaType": "url",
                "ctaPayload": "https://www.ibm.com"
            },
            {
                "title": "Second Item",
                "description": "Second Item",
                "iconName": "secondPostInstallationItem",
                "ctaType": "url",
                "ctaPayload": "https://www.ibm.com"
            },{
                "title": "Third Item",
                "description": "Third Item",
                "iconName": "thirdPostInstallationItem",
                "ctaType": "url",
                "ctaPayload": "https://www.ibm.com"
            }
            ,{
                "title": "Fourth Item",
                "description": "Fourth Item",
                "iconName": "fourthPostInstallationItem",
                "ctaType": "url",
                "ctaPayload": "https://www.ibm.com"
            }
        ],
        "needsRestart": false
    },
    "environment": "prod"
}
""" % (hrFirstName, jpsCommSeconds)

# Setup for enrollment
filePath = "/Users/%s/Library/Preferences/com.ibm.enrollment.plist" % loggedInUser
if os.path.exists(filePath):
    os.remove(filePath)
    
# Loading the enrollment data json
json_object = json.loads(conf_json)

# Writing the .plist configuration file
plistlib.writePlist(json_object, filePath)

