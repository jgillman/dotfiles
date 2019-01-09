# Add common node_module paths
_prepend_to_path "${HOME}/node_modules/.bin"
_prepend_to_path "/usr/local/lib/node_modules"
_append_to_path "/usr/local/share/npm/bin"

# Add path for yarn
_prepend_to_path "${HOME}/.yarn/bin"
_prepend_to_path "${HOME}/.config/yarn/global/node_modules/.bin"
