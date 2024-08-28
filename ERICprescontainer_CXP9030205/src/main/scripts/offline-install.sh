#!/bin/bash
#
#
# installs any rpms contained in the SDP that it finds according to certain rules.
#
# One arguments are given:
# $1 - The base directory of this software-bundle
#
# SDP Rules:
# 1) RPM packaged in the toplevel software-bundle directory will be installed on all nodes (in Service Group)
# 2) RPMs that should be installed on a sub-set of nodes should be located in a special directory: payload/ and control/
# 4) Any *.rpm files located under 'rpms/control' will be installed on nodes with TIPC address 1 and 2
# 5) Any *.rpm files located under 'rpms/payload' will be installed on nodes with TIPC address 3 and larger.
#

 this_host=`hostname`
 
die () {
  echo "ERROR: $@"
  exit 1
}

install_presentation_server()
{
  local	rpmdir=$1
  local	nodeid=`cmwea tipcaddress-get | sed 's/.*,.*,//'`

	for file in `ls ${rpmdir}/*.rpm 2>/dev/null`
	do
		# cmwea rpm-config-add ${file} ${this_host} || die "Failed to add ${file} on ${this_host}"
		
		### Is this PresentationServer ###
		# IS_UPGRADE=false
		# echo ${file} | grep -i ERICps >/dev/null 2>&1
		# (( ${?} != 0 )) && continue
		
		## Check if installed already ##
		# cmwea rpm-list $this_host | grep ERICps >/dev/null 2>&1
		# (( ${?} == 0 )) && IS_UPGRADE=true
		
		## PresentationServer Specific ###
		# cmwea rpm-config-activate ${this_host} || die "Failed to activate ${file} on ${this_host}"
			
		# if [[ "${IS_UPGRADE}" == true ]]
		# then
			##UPGRADE ##
			# APP_SERVER=jboss-as-1
			# [[ "${this_host}" == SC-2 ]] && APP_SERVER=jboss-as-2
			
		    # python /opt/ericsson/com.ericsson.oss.itpf.common.UpgradeManager/upgrade.py notifyUpgrade \
            # --app_server_address 127.0.0.1:8080 --user guest --password guestp \
            # --app_server_identifier ${APP_SERVER} --service_identifier PresentationServer \
            # --upgrade_operation_type SERVICE --upgrade_phase SERVICE_INSTANCE_UPGRADE_PREPARE 

			###Undeploy EAR from JBoss###
			# /opt/jboss-eap/bin/jboss-cli.sh --connect --user=jboss-eap --password=jboss-eap -c "undeploy presentation-server.ear"
		# fi

		# cp /opt/ericsson/com.ericsson.nms.pres.PresentationServer/presentation-server.ear /opt/jboss-eap/standalone/deployments/

		# Non interactive Jboss cli command
		/opt/jboss-eap/bin/jboss-cli.sh --connect --user=jboss-eap --password=jboss-eap \
        -c "deploy /opt/jboss-eap/standalone/deployments/presentation-server.ear, deployment-info --name=presentation-server.ear"
	done
}
 
install_presentation_server `dirname $0`

exit 0
