# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
#
# I use JRuby substantially, and we want to make sure hub is run using MRI
# regardless of which Ruby you're using or else the `git status` in your prompt
# will take seven thousand seconds to run `ls`.
#
# I'm hardcoding it to an installed rvm (using rvm's `rvm 1.8.7,ruby /hub/path`
# syntax is way too slow). It should work fine for those without rvm, though.
# if [[ -s $HOME/.rvm/scripts/rvm ]]
# then
#   if $(which hub &> /dev/null) && [[ -s $HOME/.rvm/rubies/ruby-1.8.7-p334 ]]
#   then
#     alias git='$HOME/.rvm/rubies/ruby-1.8.7-p358/bin/ruby `which hub`'
#   else
#   fi
# fi

