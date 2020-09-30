remote() {
  echo 'sync with remote, remove all local & remote branch which is gone'
  git fetch -p &&
  local_branchs=$(git for-each-ref refs/heads --format='%(refname:short)') &&
  remote_branchs=$(git branch -vr | awk '{print $1}')
  len=${#array_name[@]}
  for lb in $local_branchs
  do
    a=1
    for rb in $remote_branchs
    do
      if [ "origin/$lb" == $rb ]
      then
        break
        # echo 'delete '$branch" origin/$lb"
      fi
    done
    # git branch -D $branch
  done
}

patch() {
  echo 'pick branch changed area and append to current branch'
  current_branch=$(git branch | awk '$1 == "*"{print $2}')
  git rebase $current_branch $1
  git rebase $1 $current_branch
}

setup() {
  git config --global alias.sync "!bash $PWD/sync.sh"
}

uninstall() {
  git config --global --unset-all alias.sync
}

case $# in 
0)
# usage
;;
*)
case $1 in
  'setup')
  setup $@;;
  'remote')
  remote $@;;
  'patch')
  patch $@;;
  'uninstall')
  uninstall;;
esac
exit
esac