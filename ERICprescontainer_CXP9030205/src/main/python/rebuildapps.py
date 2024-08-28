import os
import json
import sys

containerPath = sys.argv[1]

appsJson = {'apps':[]}

subdirs = os.walk(containerPath).next()[1]

for subdir in subdirs:
        if os.path.exists(containerPath + "/" + subdir + "/app.json"):
                appJsonF = open(containerPath + "/" + subdir + "/app.json")
                appJson = json.loads(appJsonF.read())
                appsJson['apps'].append(appJson)

appsJsonF = open(containerPath + "/apps.json", "w")
appsJsonF.write(json.dumps(appsJson))
appsJsonF.close()

