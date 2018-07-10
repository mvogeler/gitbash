# Add git branch if present to PS1
parse_git_color() {
  color='01:31m'
  if git rev-parse --git-dir >/dev/null 2>&1
  then
    if git status | grep "no changes added to commit" >/dev/null 2>&1
    then
      color='01;31m'
    elif git status | grep "Your branch is ahead of" >/dev/null 2>&1
    then
      color='01:35m'
    elif git status | grep "nothing to commit" >/dev/null 2>&1
    then
      color='01;33m'
    fi
  else
    color='00m'
  fi
  echo -e $color
}

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/(1)/'
}

PS1='{debian_chroot:+($debian_chroot)}\[e[01;32m\]\u[\e[00m\]@\h:[\e[01;34m\]\W\[\e[$(parse_git_color)\]$(parse_git_branch)\e[00m\]\$'
