# STIG Viewer Installation Script

This script automates the installation of the STIG Viewer on Linux systems. STIG Viewer is a tool used to view and analyze Security Technical Implementation Guides (STIGs).

## Prerequisites

- Linux operating system
- `wget` for downloading files
- `unzip` for extracting the STIG Viewer package
- `sudo` privileges for installation
- `fapolicyd` (for systems that use it)

## Installation

1. Make the script executable:
   ```bash
   chmod +x install_stig_viewer.sh
   ```

2. Run the installation script:
   ```bash
   ./install_stig_viewer.sh
   ```

The script will:
- Download the STIG Viewer package and its checksum file
- Verify the package integrity using SHA256 checksum
- Install STIG Viewer to `/opt/stigviewer`
- Add STIG Viewer to the fapolicyd trust database (if applicable)

## Running STIG Viewer

After installation, you can run STIG Viewer by executing:
```bash
cd /opt/stigviewer
./STIGViewer
```

## Version Information

This script installs STIG Viewer version 3.5.1.

## Troubleshooting

If you encounter any issues:
1. Ensure you have all prerequisites installed
2. Check that you have sufficient disk space
3. Verify your internet connection
4. Make sure you have sudo privileges
