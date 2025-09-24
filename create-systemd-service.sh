#!/bin/bash -e
# Create a systemd service that autostarts & manages a docker-compose instance in the current directory
# by Uli Köhler - https://techoverflow.net
# Licensed as CC0 1.0 Universal
# Modified by Hugo Klepsch

set -euo pipefail

# Unlike the other versions of this script, we don't need to generate the
# service file because it is so simple.
service_unit_name="reverse-proxy-network.service"

if [[ "${INSTALL:-false}" == "true" ]]; then
	echo "Installing systemd service... /etc/systemd/system/${service_unit_name}"
	sudo cp "${service_unit_name}" "/etc/systemd/system/${service_unit_name}"

	sudo systemctl daemon-reload

	if [[ "${ENABLE_NOW:-false}" == "true" ]]; then
		# Start systemd units on startup (and right now)
		echo "Enabling & starting ${service_unit_name}"
		sudo systemctl enable --now "${service_unit_name}"
		exit 0
	else
		echo "Run with INSTALL=true ENABLE_NOW=true ./create... to install and start and enable"
		exit 0
	fi
else
	echo "Run with INSTALL=true ./create... to install"
	exit 0
fi

exit 0
