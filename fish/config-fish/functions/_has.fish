function _has --description 'Returns whether the given command is executable or aliased.'
    type -q "$argv[1]"
end
