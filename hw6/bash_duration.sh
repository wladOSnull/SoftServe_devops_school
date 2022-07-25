#!/bin/bash
###
### this is BASH script for calculate time working setup (install & build) project with using npm and yarn
###
### example of using: ./bash_duration.sh
###

#
# clean all existing modules, packages and bundles
#
eval rm -rf ./npm/example-app-nodejs-backend-react-frontend/node_modules/ && \
rm -rf ./npm/example-app-nodejs-backend-react-frontend/static && \
rm -rf ./yarn/example-app-nodejs-backend-react-frontend/node_modules && \
rm -rf ./yarn/example-app-nodejs-backend-react-frontend/static &&

#
# calculating time for npm
#
start_time=$(date +%s.%3N)
eval cd ./npm/example-app-nodejs-backend-react-frontend && \
npm install && \
npm run build
end_time=$(date +%s.%3N)

# get time
elapsed_npm=$(echo "scale=3; $end_time - $start_time" | bc)

#
# calculating time for yarn
#
start_time=$(date +%s.%3N)
eval cd ../../yarn/example-app-nodejs-backend-react-frontend && \
yarn install && \
yarn run build
end_time=$(date +%s.%3N)

# get time
elapsed_yarn=$(echo "scale=3; $end_time - $start_time" | bc)

#
# output
#
echo -e "\n\n\n----- ----- ----- ----- -----
----- elapsed time for npm: ${elapsed_npm}s
----- elapsed time for yarn: ${elapsed_yarn}s
----- ----- ----- ----- -----"

###
### there is also variable $SECONDS, it runs after script has been started
### but $SECONDS show elapsed time only in seconds
### 
### example of using:
### 
###     ...
###     <perform a task>
###     ...
###     duration=$SECONDS
###     echo "duration is: ${duration}"
