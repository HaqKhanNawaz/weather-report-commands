#!/bin/bash
# This script installs Node Exporter 1.7.0 and sets it up to start on system boot.

# Download the latest Node Exporter binaries
wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-amd64.tar.gz

# Extract the binaries
tar -xvf node_exporter-1.7.0.linux-amd64.tar.gz

# Move the binaries to /usr/local/bin
sudo cp node_exporter-1.7.0.linux-amd64/node_exporter /usr/local/bin/

# Create a system service file
echo "[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=nobody
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target" | sudo tee /etc/systemd/system/node_exporter.service

# Reload the system daemon
sudo systemctl daemon-reload

# Enable the Node Exporter service
sudo systemctl enable node_exporter

# Start the Node Exporter service
sudo systemctl start node_exporter

echo "Node Exporter installed and started successfully."
