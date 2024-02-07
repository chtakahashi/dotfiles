# direnv
eval "$(direnv hook zsh)"

# Simple script to map aws organizations to different 1password items
map-account-to-mfa () {
  if [[ ${AWS_PROFILE:0:9} == "<PROFILE>" ]]
  then
    echo "$(op item get "mfa-<PROFILE>" --otp)"
  fi;
}

#shorthand aws-vault commands
alias awp='(
  aws-vault login "$AWS_PROFILE" -t "$(map-account-to-mfa)"
)'
alias awe='aws-vault exec "$AWS_PROFILE"'


# git shorthands
## delete all non main/master branches
alias gbd='git branch | grep -v "main\|master" | xargs git branch -D'
## open the remote in browser
alias gweb="git remote -v | head -n 1 | awk -F '@' '{print \$2}' | awk -F ' ' '{print \$1}' | sed 's/:/\//g' | sed 's/.git//g' | awk '{print \"https://\"\$1}' | xargs open"

export PATH="/usr/local/bin:$PATH"

source /usr/local/opt/asdf/libexec/asdf.sh
