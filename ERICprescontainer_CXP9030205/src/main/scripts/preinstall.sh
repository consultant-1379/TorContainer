#Pre-install script
if [[ -d /opt/ericsson/com.ericsson.nms.pres.TorContainer/temp ]] ; then
    echo "Removing temp directory"
    rm -r /opt/ericsson/com.ericsson.nms.pres.TorContainer/temp
fi

if [[ -d /opt/ericsson/com.ericsson.nms.pres.TorContainer/extra ]] ; then
    echo "Removing extra directory"
    rm -r /opt/ericsson/com.ericsson.nms.pres.TorContainer/extra
fi

if [[ -n "`echo /opt/ericsson/com.ericsson.nms.pres.TorContainer/*.tar.gz`" ]] ; then
    echo "Removing old artifacts"
    rm /opt/ericsson/com.ericsson.nms.pres.TorContainer/*.tar.gz
fi