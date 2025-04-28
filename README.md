# STIG Viewer Installation Scripts

> ⚠️ **CAUTION**: These scripts download and install software from external sources. Before running any installation script:
> - Review the script contents thoroughly
> - Verify the checksums manually if possible
> - Ensure you understand what the script will do
> - Consider running in a test environment first
> - The maintainers are not responsible for any issues that may arise from using these scripts

These scripts automate the installation of different versions of STIG Viewer on Linux systems. STIG Viewer is a tool used to view and analyze Security Technical Implementation Guides (STIGs). 
Please verify the scripts before running them on your machine! 

### Offocial Documentation
- https://public.cyber.mil/stigs/srg-stig-tools/
- https://dl.dod.cyber.mil/wp-content/uploads/stigs/pdf/U_STIG_Viewer_3-x_User_Guide_V1R5.pdf

## Prerequisites

- Linux operating system
- `wget` for downloading files
- `unzip` for extracting the STIG Viewer package
- `sudo` privileges for installation
- `fapolicyd` (for systems that use it)

## Available Installation Scripts

### STIG Viewer 3.5.1
- Script: `install_stig_viewer_3.5.1.sh`
- Installs STIG Viewer version 3.5.1
- Installation directory: `/opt/stigviewer`

### STIG Viewer 2.18
- Script: `install_stig_viewer_2.18.sh`
- Installs STIG Viewer version 2.18
- Installation directory: `/opt/stigviewer`

## Installation

1. Make the desired script executable:
   ```bash
   chmod +x install_stig_viewer_3.5.1.sh  # For version 3.5.1
   # OR
   chmod +x install_stig_viewer_2.18.sh   # For version 2.18
   ```

2. Run the installation script:
   ```bash
   ./install_stig_viewer_3.5.1.sh  # For version 3.5.1
   # OR
   ./install_stig_viewer_2.18.sh   # For version 2.18
   ```

The scripts will:
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

## Troubleshooting

If you encounter any issues:
1. Ensure you have all prerequisites installed
2. Check that you have sufficient disk space
3. Verify your internet connection
4. Make sure you have sudo privileges
