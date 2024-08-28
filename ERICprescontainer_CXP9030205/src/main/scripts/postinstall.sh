#Postinstall

WEBROOT=/var/www/html/
WEB_CONTAINER=${WEBROOT}container/

CONTAINER_PATH=/opt/ericsson/com.ericsson.nms.pres.TorContainer

# Put container path under container_var
echo ${WEB_CONTAINER} > ${CONTAINER_PATH}/container_var

# Delete html directory
if [[ -d $CONTAINER_PATH/html ]] ; then
    echo "Removing html directory"
    rm -r $CONTAINER_PATH/html
fi

# Extract tar.gz archive to temporary location
mkdir $CONTAINER_PATH/html
tar -zxvf $CONTAINER_PATH/*.tar.gz -C $CONTAINER_PATH/html/

# Remove package.json file, as not needed
if [[ -f $CONTAINER_PATH/html/package/package.json ]]; then
    echo "Removing package.json, as it is not needed here"
    rm $CONTAINER_PATH/html/package/package.json
fi

# Remove app.json file, as not needed
if [ -f $CONTAINER_PATH/html/package/app.json ]; then
    echo "Removing app.json, as it is not needed here"
    rm $CONTAINER_PATH/html/package/app.json
fi

# Replace files

echo "Copying extra/index.html to $CONTAINER_PATH/html/"
mv $CONTAINER_PATH/extra/index.html $CONTAINER_PATH/html/

# Rename the Package folder to container so we can move the entire folder during the deployment
mv $CONTAINER_PATH/html/package $CONTAINER_PATH/html/container/

# Login magic
    # Delete login directory
    if [[ -d $CONTAINER_PATH/login ]] ; then
        echo "Removing login directory"
        rm -r $CONTAINER_PATH/login
    fi

    # Extract login application archive to temporary location
    tar -zxvf $CONTAINER_PATH/extra/*.tar.gz -C $CONTAINER_PATH/html/
    mv $CONTAINER_PATH/html/package $CONTAINER_PATH/html/login/