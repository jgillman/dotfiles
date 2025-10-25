# Sets up OS X with my preferences.
#
# Enable Option as Meta key for the current profile
defaults write com.apple.Terminal useOptionAsMetaKey -bool true

# Remap Caps Lock to Left Option
hidutil property --set '{"UserKeyMapping":[
  {
    "HIDKeyboardModifierMappingSrc": 0x700000039,
    "HIDKeyboardModifierMappingDst": 0x7000000E2
  }
]}'

# Enable dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string Dark

# Position dock on the right and restart dock
defaults write com.apple.dock orientation -string right

# set dock size
defaults write com.apple.dock tilesize -int 30

# Restart dock
killall Dock


