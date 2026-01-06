#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Drive Auto-Mounter
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/drive-icon.png
# @raycast.packageName Utilities
# @raycast.argument1 { "type": "text", "placeholder": "override config file", "percentEncoded": true, "optional": true }

# Documentation:
# @raycast.description Verifies each network drive specified in the config file (located at "~/.config/raycast/auto_smb_mounts.txt"), and if not mounted, mounts it using finder.
# @raycast.author Mike Oertli
# @raycast.authorURL https://github.com/mikeoertli


# Default file is located in: '~/.config/raycast/auto_smb_mounts.txt'
# The format of the document is as follows...
#   - it should contain a newline separated list of SMB mount paths
#   - no quotes
#   - there needs to be a new line after the last entry otherwise it will be ignored

DEFAULT_CONFIG_FILE="$HOME/.config/raycast/auto_smb_mounts.txt"

configFile=${1:-"$DEFAULT_CONFIG_FILE"}
if [[ ! -f $configFile ]]; then
  echo "🚨 Unable to find the specified config file: $configFile"
  exit 1
fi

# Array of SMB share URLs, each will mount to /Volumes/ in a directory matching the share name
# Populated by parsing the config file
smbURLs=()

# Read the file line by line.
while IFS= read -r line || [[ -n $line ]]; do
  # Trim leading/trailing whitespace
  line="${line#"${line%%[![:space:]]*}"}"
  line="${line%"${line##*[![:space:]]}"}"

  # Strip inline comments that follow a network mount path (comments start with '#' char).
  if [[ $line =~ ^([^#]*)[[:space:]]+\# ]]; then
    line="${BASH_REMATCH[1]}"
    # Trim trailing whitespace again
    line="${line%"${line##*[![:space:]]}"}"
  fi

  # Skip empty lines and lines whose first non-space character is non-alphanumeric (comments/special)
  [ -z "$line" ] && continue
  case "$line" in
    [![:alnum:]]*) continue ;;
  esac

  smbURLs+=("$line")
done < "$configFile"

function attempt_mount() {
  local smbUrl=${1:?"Must provide a SMB mount path!"}
  local mntName
  mntName=$(basename "$smbUrl")
  local volPath="/Volumes/${mntName}"

  if [ -d "$volPath" ]; then
    # echo >&2 "Already mounted: ${volPath} for ${mntName}"
    echo -e "👌 ${mntName} already mounted"
  else
    # echo >&2 "Attempting to mount: ${volPath} for ${mntName}"
    # This will open the SMB share in Finder, using stored keychain credentials.
    open "${smbUrl}"
    # Give the system a moment to mount
    sleep 2
    [ -d "$volPath" ] && echo -e "✅ ${mntName} mounted" || echo -e "❌ ${mntName} could not be mounted"
  fi
}

# Loop through each network share
for url in "${smbURLs[@]}"; do
  attempt_mount "$url"
done

