# PowerShell script to install node_exporter on Windows

# Set execution policy
Set-ExecutionPolicy Bypass -Scope Process -Force

# Download node_exporter
Invoke-WebRequest -Uri "https://github.com/prometheus/node_exporter/releases/download/v*/node_exporter-*.*-windows-amd64.zip" -OutFile "node_exporter.zip"

# Unzip the package
Expand-Archive -Path "node_exporter.zip" -DestinationPath "C:\Program Files\node_exporter"

# Clean up the zip file
Remove-Item -Path "node_exporter.zip"

# Install nssm
choco install nssm -y

# Set up node_exporter as a service
nssm install NodeExporter "C:\Program Files\node_exporter\node_exporter.exe"
nssm set NodeExporter AppDirectory "C:\Program Files\node_exporter"
nssm start NodeExporter
