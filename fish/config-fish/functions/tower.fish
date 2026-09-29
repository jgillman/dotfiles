# Mount the Unraid tower over sshfs (as root, via the `tower` ssh alias)
#   tower                  mount /mnt/user at ~/mnt/tower and cd into it
#   tower appdata          mount /mnt/user/appdata instead
#   tower -u               unmount
#   tower chown PATH...    chown 99:100 on the tower (chown through the mount
#                          silently does nothing); flags like -R pass through
function tower
  set -l mnt ~/mnt/tower

  if test "$argv[1]" = -u
    umount $mnt; or diskutil unmount force $mnt
    and set -e __tower_remote
    return
  end

  if test "$argv[1]" = chown
    __tower_chown $mnt $argv[2..]
    return
  end

  if mount | string match -q "* on $mnt *"
    cd $mnt
    return
  end

  set -l remote /mnt/user
  if test -n "$argv[1]"
    set remote /mnt/user/$argv[1]
  end

  mkdir -p $mnt
  sshfs tower:$remote $mnt \
    -o volname=tower \
    -o reconnect \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o follow_symlinks
  and set -U __tower_remote $remote
  and cd $mnt
end

function __tower_chown -a mnt
  set -l flags
  set -l remote_paths
  for arg in $argv[2..]
    if string match -q -- '-*' $arg
      set -a flags $arg
      continue
    end

    set -l local (path resolve $arg)
    if not string match -q -- "$mnt*" $local
      echo "tower chown: $arg is not under $mnt" >&2
      return 1
    end

    # The mount predates recording its root, or was the default
    set -l root $__tower_remote
    test -n "$root"; or set root /mnt/user

    set -l remote $root(string replace -- $mnt '' $local)
    # Single-quote for the remote shell
    set -a remote_paths "'"(string replace -a -- "'" "'\\''" $remote)"'"
  end

  if test (count $remote_paths) -eq 0
    echo "usage: tower chown [-R] PATH..." >&2
    return 1
  end

  ssh tower chown $flags 99:100 $remote_paths
  and ssh tower stat -c "'%U:%G %n'" $remote_paths
end
