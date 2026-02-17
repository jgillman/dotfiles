#!/usr/bin/env bash

# Sets reasonable macOS defaults.
#
# The original idea (and a couple settings) were grabbed from:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.osx

# Ask for the administrator password upfront
sudo -v

current_name=$(sudo scutil --get ComputerName)
echo "Name of computer? (currently: ${current_name})"
read -r computer_name

if [ -z "$computer_name" ]; then
  echo "You must name your machine."
  exit 1
fi

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "${computer_name}"
sudo scutil --set HostName "${computer_name}"
sudo scutil --set LocalHostName "${computer_name}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${computer_name}"

# Show the ~/Library folder.
chflags nohidden ~/Library


# Use AirDrop over every interface. srsly this should be a default.
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.AppleMultitouchTrackpad -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the gesture in System Preferences → Accessibility → Zoom

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a fast keyboard repeat rate and a short delay
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false



###############################################################################
# Screen                                                                      #
###############################################################################

# Require password 3 seconds after sleep or screen saver begins
# Note: On newer macOS versions, verify this in System Settings → Lock Screen
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 3

# Save screenshots to the Downloads folder
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

###############################################################################
# Dock
###############################################################################

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Put dock on the left so I never have to see it again.
defaults write com.apple.dock orientation -string "left"

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

###############################################################################
# Animations
###############################################################################

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.15

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

###############################################################################
# Finder and Panels
###############################################################################

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the desktop (bye bye, clutter!)
defaults write com.apple.finder CreateDesktop -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Calendar" "Contacts" "Dock" "Finder" "Mail" "Safari" \
	"SystemUIServer" "Terminal"; do
	killall "$app" > /dev/null 2>&1
done
echo "Done. Note that some of these changes require a logout/restart to take effect."
