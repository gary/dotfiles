alias most=less

alias o='sudo -u onsite'
alias onsite='o -s'

alias dirs='dirs -v'
alias pd='pushd'
alias pd1='pushd +1'
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
alias po='popd'
alias po1='popd +1'
alias po2='popd +2'
alias po3='popd +3'
alias po4='popd +4'

DEFAULT=1024

function bigfiles() {
  size=${1-$DEFAULT}

  find . -type f -size +${size}k -exec ls -lh {} \; | awk '{ print $5 ": " $9 }'

  return 0
}