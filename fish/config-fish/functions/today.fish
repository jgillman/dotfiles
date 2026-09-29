# Helpers for Obsidian
function today --description 'Open todays note in editor'
    set -l vault_path "$(Obsidian vault info=path)"
    nvim "$vault_path/$(Obsidian daily:path)"
end
