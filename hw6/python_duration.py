#!/usr/bin/python3.8
###
### this is PYTHON script for calculate time working setup (install & build) project with using npm and yarn
###
### example of using: python3.8 ./python_duration.py
###

import shutil, time, os

#
# clean all existing modules, packages and bundles
#
file_path = ["./npm/example-app-nodejs-backend-react-frontend/node_modules/", 
"./npm/example-app-nodejs-backend-react-frontend/static", 
"./yarn/example-app-nodejs-backend-react-frontend/node_modules",
"./yarn/example-app-nodejs-backend-react-frontend/static"]

for i in file_path:
    shutil.rmtree(i, ignore_errors=True)

#
# calculating time for npm
#
start_time=time.time()
os.system("cd ./npm/example-app-nodejs-backend-react-frontend && \
npm install && \
npm run build")
end_time=time.time()

elapsed_npm = round(end_time-start_time,3)

#
# calculating time for yarn
#
start_time=time.time()
os.system("cd ./yarn/example-app-nodejs-backend-react-frontend && \
yarn install && \
yarn run build")
end_time=time.time()

elapsed_yarn = round(end_time-start_time,3)

#
# output
#
print(f"\n\n\n----- ----- ----- ----- -----\n\
----- elapsed time for npm: {elapsed_npm}s \n\
----- elapsed time for yarn: {elapsed_yarn}s \n\
----- ----- ----- ----- -----")
