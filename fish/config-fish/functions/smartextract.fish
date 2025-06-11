# credit: http://nparikh.org/notes/zshrc.txt
# Usage: smartextract <file>
# Description: extracts archived files / mounts disk images
# Note: .dmg/hdiutil is Mac OS X-specific.
function smartextract
  set -l file $argv[1]

  if test -f $file
    switch $file
      case "*.tar.bz2"; tar -jxvf $file
      case "*.tar.gz";  tar -zxvf $file
      case "*.bz2";     bunzip2 $file
      case "*.dmg";     hdiutil mount $file
      case "*.gz";      gunzip $file
      case "*.tar";     tar -xvf $file
      case "*.tbz2";    tar -jxvf $file
      case "*.tgz";     tar -zxvf $file
      case "*.zip";     unzip $file
      case "*.ZIP";     unzip $file
      case "*.pax";     cat $file | pax -r
      case "*.pax.Z";   uncompress $file --stdout | pax -r
      case "*.Z";       uncompress $file
      case "*";         echo "'$file' cannot be extracted/mounted via smartextract()"
    end
  else
    echo "'$file' is not a valid file"
  end
end

