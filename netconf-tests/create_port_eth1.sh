#!/bin/bash
. ./config

netopeer-cli <<KONEC
connect --login $USER $HOST
edit-config --config=create_port_eth1.xml running
get-config --filter=ovs.xml running
disconnect
KONEC
echo ""
exit 0
