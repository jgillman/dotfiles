#!/bin/bash
#
# Dock Application Management
# Captures and restores macOS Dock applications
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCK_APPS_FILE="${SCRIPT_DIR}/dock-apps.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function print_usage() {
    echo "Usage: $0 {capture|restore}"
    echo ""
    echo "  capture  - Save current Dock applications to dock-apps.json"
    echo "  restore  - Restore Dock applications from dock-apps.json"
    echo ""
}

function capture_dock() {
    echo -e "${YELLOW}Capturing current Dock applications...${NC}"

    # Use Python to parse the plist and extract app information
    python3 <<'PYTHON_SCRIPT' > "${DOCK_APPS_FILE}"
import subprocess
import json
import plistlib
import urllib.parse

# Read the Dock plist
result = subprocess.run(['defaults', 'export', 'com.apple.dock', '-'],
                       capture_output=True, text=False)
plist_data = plistlib.loads(result.stdout)

apps = []
for item in plist_data.get('persistent-apps', []):
    tile_data = item.get('tile-data', {})
    file_data = tile_data.get('file-data', {})

    # Get the app name and path
    app_name = tile_data.get('file-label', '')
    app_path = file_data.get('_CFURLString', '')

    # Decode URL encoding if present
    if app_path.startswith('file://'):
        app_path = urllib.parse.unquote(app_path)

    if app_name and app_path:
        apps.append({
            'name': app_name,
            'path': app_path
        })

# Output as formatted JSON
print(json.dumps(apps, indent=2))
PYTHON_SCRIPT

    if [ $? -eq 0 ]; then
        local app_count=$(python3 -c "import json; data=json.load(open('${DOCK_APPS_FILE}')); print(len(data))")
        echo -e "${GREEN}Successfully captured ${app_count} applications to ${DOCK_APPS_FILE}${NC}"
    else
        echo -e "${RED}Failed to capture Dock applications${NC}"
        exit 1
    fi
}

function restore_dock() {
    if [ ! -f "${DOCK_APPS_FILE}" ]; then
        echo -e "${RED}Error: ${DOCK_APPS_FILE} not found${NC}"
        echo "Run '$0 capture' first to create the configuration file"
        exit 1
    fi

    echo -e "${YELLOW}Restoring Dock applications from ${DOCK_APPS_FILE}...${NC}"

    # Use Python to rebuild the Dock
    python3 <<'PYTHON_SCRIPT'
import subprocess
import json
import os
import sys
import urllib.parse

dock_file = os.environ['DOCK_APPS_FILE']

try:
    with open(dock_file, 'r') as f:
        apps = json.load(f)
except Exception as e:
    print(f"Error reading {dock_file}: {e}", file=sys.stderr)
    sys.exit(1)

# Clear existing persistent apps
subprocess.run(['defaults', 'delete', 'com.apple.dock', 'persistent-apps'],
               stderr=subprocess.DEVNULL)

# Add each app to the Dock
missing_apps = []
for app in apps:
    app_path = app['path']
    app_name = app['name']

    # Convert file:// URL to actual path
    if app_path.startswith('file://'):
        actual_path = urllib.parse.unquote(app_path.replace('file://', ''))
    else:
        actual_path = app_path

    # Check if app exists
    if not os.path.exists(actual_path):
        missing_apps.append(app_name)
        print(f"Warning: {app_name} not found at {actual_path}", file=sys.stderr)
        continue

    # Add the app to the Dock
    subprocess.run([
        'defaults', 'write', 'com.apple.dock', 'persistent-apps',
        '-array-add',
        f'<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>{app_path}</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
    ])

if missing_apps:
    print(f"\nWarning: {len(missing_apps)} app(s) not found and were skipped:")
    for app in missing_apps:
        print(f"  - {app}")

print(f"\nAdded {len(apps) - len(missing_apps)} of {len(apps)} applications to Dock")
PYTHON_SCRIPT

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Dock restoration complete!${NC}"
        echo -e "${YELLOW}Restarting Dock...${NC}"
        killall Dock
        echo -e "${GREEN}Done!${NC}"
    else
        echo -e "${RED}Failed to restore Dock applications${NC}"
        exit 1
    fi
}

# Main script logic
case "${1:-}" in
    capture)
        capture_dock
        ;;
    restore)
        restore_dock
        ;;
    *)
        print_usage
        exit 1
        ;;
esac
