#!/bin/bash
set -euo pipefail

# CONFIGURATION
STIG_VERSION="2-18"
STIG_ZIP="U_STIGViewer_${STIG_VERSION}_Linux.zip"
ZIP_URL="https://dl.dod.cyber.mil/wp-content/uploads/stigs/zip/${STIG_ZIP}"
HASH_FILE="U_STIGViewer_${STIG_VERSION}_Hashes.txt"
HASH_URL="https://dl.dod.cyber.mil/wp-content/uploads/stigs/txt/${HASH_FILE}"
INSTALL_DIR="/opt/stigviewer" # change where you want to install the STIG Viewer

# FUNCTION: Print a header
header() {
  echo -e "\n=== $1 ===\n"
}

# Download files
download_files() {
  header "Downloading STIG Viewer and checksum file"

  # Check if hash file exists
  if [[ -f "$HASH_FILE" ]]; then
    echo "Hash file already exists, skipping download"
  else
    echo "Downloading hash file..."
    wget -O "$HASH_FILE" "$HASH_URL"
  fi

  # Check if STIG Viewer zip exists
  if [[ -f "$STIG_ZIP" ]]; then
    echo "STIG Viewer zip already exists, skipping download"
  else
    echo "Downloading STIG Viewer..."
    wget -O "$STIG_ZIP" "$ZIP_URL"
  fi
}

# Verify checksum
verify_checksum() {
  header "Verifying SHA256 checksum"

  # Convert hash file from UTF-16LE to UTF-8
  local tmp_hash_file=$(mktemp)
  iconv -f UTF-16LE -t UTF-8 "$HASH_FILE" > "$tmp_hash_file"

  # Calculate actual SHA256
  actual_sha256=$(sha256sum "$STIG_ZIP" | awk '{print $1}' | tr '[:lower:]' '[:upper:]')

  # Extract expected SHA256 from the converted file and clean it
  expected_sha256=$(grep -A 1 "U_STIGViewer_${STIG_VERSION}_Linux.zip" "$tmp_hash_file" | \
                    grep "SHA256:" | \
                    awk '{print $2}' | \
                    tr -cd '[:alnum:]' | \
                    tr '[:lower:]' '[:upper:]')

  # Clean up temporary file
  rm -f "$tmp_hash_file"

  if [[ -z "$expected_sha256" ]]; then
    echo "❌ Failed to find SHA256 hash for $STIG_ZIP in $HASH_FILE"
    echo "Debug: Hash file contents after UTF-16LE conversion:"
    iconv -f UTF-16LE -t UTF-8 "$HASH_FILE"
    exit 1
  fi

  # Clean actual hash to ensure fair comparison
  actual_sha256=$(echo "$actual_sha256" | tr -cd '[:alnum:]')

  echo "Expected SHA256: $expected_sha256"
  echo "Actual SHA256:   $actual_sha256"

  if [ "$actual_sha256" != "$expected_sha256" ]; then
    echo "❌ Checksum verification failed!"
    exit 1
  else
    echo "✅ Checksum verification successful!"
  fi
}

# Install STIG Viewer
install_stigviewer() {
  header "Installing STIG Viewer"

  sudo mkdir -p "$INSTALL_DIR"
  sudo unzip -q "$STIG_ZIP" -d "$INSTALL_DIR"

  # Add STIG Viewer to fapolicyd trust database (IN NEEDED)

  # header "Adding STIG Viewer to fapolicyd trust database"
  # sudo fapolicyd-cli --file add "$INSTALL_DIR"
  # sudo fapolicyd-cli --update
}

# Show launch instructions
launch_stigviewer() {
  header "Installation complete"
  echo "To run STIG Viewer, execute from /opt/stigviewer:"
  echo "./STIGViewer"
}

# MAIN
download_files
verify_checksum
install_stigviewer
launch_stigviewer
