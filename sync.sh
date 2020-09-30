remote() {
  echo 'sync with remote, remove all local & remote branch which is gone'
  git fetch -p && for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do git branch -D $branch; done
}

patch() {
  echo 'pick branch changed area and append to current branch'
  current_branch=$(git branch | awk  '$1 == "*"{print $2}')
  git rebase $current_branch $1
  git rebase $1 $current_branch
}

setup() {
  git config --global alias.sync '!bash $PWD/sync.sh'
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
esac
exit
esac