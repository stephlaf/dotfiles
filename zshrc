ZSH=$HOME/.oh-my-zsh

# You can change the theme with another one:
#   https://github.com/robbyrussell/oh-my-zsh/wiki/themes
ZSH_THEME="robbyrussell"

# Useful plugins for Rails development with Sublime Text
plugins=(
  git
  gitfast
  last-working-dir
  common-aliases
  sublime
  zsh-syntax-highlighting
  history-substring-search
  macos
  ruby
)

# Prevent Homebrew from reporting - https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Analytics.md
export HOMEBREW_NO_ANALYTICS=1

# Actually load Oh-My-Zsh
source "${ZSH}/oh-my-zsh.sh"
unalias rm # No interactive rm by default (brought by plugins/common-aliases)

# Load rbenv if installed
export PATH="${HOME}/.rbenv/bin:${PATH}"
type -a rbenv > /dev/null && eval "$(rbenv init -)"

# # Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# NVM automatically switch to correct node version when switching directories
nvm_find_node_version_file() {
  local dir
  dir="$(nvm_find_up '.node-version')"
  if [ -e "${dir}/.node-version" ]; then
    nvm_echo "${dir}/.node-version"
  fi
}
auto-switch-node-version() {
  NODE_VERSION_PATH=$(nvm_find_node_version_file)
  CURRENT_NODE_VERSION=$(nvm version)
  if [[ ! -z "$NODE_VERSION_PATH" ]]; then
    # .node-version file found!
    # Read the file
    REQUESTED_NODE_VERSION=$(cat $NODE_VERSION_PATH)
    # Find an installed Node version that satisfies the .node-version
    MATCHED_NODE_VERSION=$(nvm_match_version $REQUESTED_NODE_VERSION)
    if [[ ! -z "$MATCHED_NODE_VERSION" && $MATCHED_NODE_VERSION != "N/A" ]]; then
      # A suitable version is already installed.
      # Clear any warning suppression
      unset AUTOSWITCH_NODE_SUPPRESS_WARNING
      # Switch to the matched version ONLY if necessary
      if [[ $CURRENT_NODE_VERSION != $MATCHED_NODE_VERSION ]]; then
        nvm use $REQUESTED_NODE_VERSION
      fi
    else
      # No installed Node version satisfies the .node-version.
      # Quit silently if we already just warned about this exact .node-version file, so you
      # only get spammed once while navigating around within a single project.
      if [[ $AUTOSWITCH_NODE_SUPPRESS_WARNING == $NODE_VERSION_PATH ]]; then
        return
      fi
      # Convert the .node-version path to a relative one (if possible) for readability
      RELATIVE_NODE_VERSION_PATH="$(realpath --relative-to=$(pwd) $NODE_VERSION_PATH 2> /dev/null || echo $NODE_VERSION_PATH)"
      # Print a clear warning message
      echo ""
      echo "WARNING"
      echo "  Found file: $RELATIVE_NODE_VERSION_PATH"
      echo "  specifying: $REQUESTED_NODE_VERSION"
      echo "  ...but no installed Node version satisfies this."
      echo "  "
      echo "  Current node version: $CURRENT_NODE_VERSION"
      echo "  "
      echo "  You might want to run \"nvm install\""
      # Record that we already warned about this unsatisfiable .node-version file
      export AUTOSWITCH_NODE_SUPPRESS_WARNING=$NODE_VERSION_PATH
    fi
  else
    # No .node-version file found.
    echo "no .node-version file was found"
    # Clear any warning suppression
    unset AUTOSWITCH_NODE_SUPPRESS_WARNING
    # Revert to default version, unless that's already the current version.
    if [[ $CURRENT_NODE_VERSION != $(nvm version default)  ]]; then
      nvm use default
    fi
  fi
}
# Run the above function in ZSH whenever you change directory
autoload -U add-zsh-hook
add-zsh-hook chpwd auto-switch-node-version
auto-switch-node-version

# # Call `nvm use` automatically in a directory with a `.nvmrc` file
# autoload -U add-zsh-hook
# load-nvmrc() {
#   if nvm -v &> /dev/null; then
#     local node_version="$(nvm version)"
#     local nvmrc_path="$(nvm_find_nvmrc)"

#     if [ -n "$nvmrc_path" ]; then
#       local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#       if [ "$nvmrc_node_version" = "N/A" ]; then
#         nvm install
#       elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         nvm use --silent
#       fi
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#       nvm use default --silent
#     fi
#   fi
# }
# type -a nvm > /dev/null && add-zsh-hook chpwd load-nvmrc
# type -a nvm > /dev/null && load-nvmrc

# Rails and Ruby uses the local `bin` folder to store binstubs.
# So instead of running `bin/rails` like the doc says, just run `rails`
# Same for `./node_modules/.bin` and nodejs
export PATH="./bin:./node_modules/.bin:${PATH}:/usr/local/sbin"

# Store your own aliases in the ~/.aliases file and load the here.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"

# Encoding stuff for the terminal
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"

# Aliases

source ~/.oh-my-zsh/plugins/git/git.plugin.zsh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/Laf1BUp/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;


export PATH="/usr/local/bin:$PATH"

# export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.0.2t/bin:$PATH"

# For capybara-webkit
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"

# Load nvm (to manage your node versions)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias code="/Applications/Visual\ Studio\ Code.app/contents/Resources/app/bin/code"
alias ctt='code .'
alias git_souquez_les_artimuses="open 'https://www.youtube.com/clip/UgkxB9-CfrjcA5OEMAlokTbQYIEdv8-YuPvk'"
alias teach="cd ~/Dropbox/Documents/coding/le_wagon && ll"
alias coding="cd ~/Dropbox/Documents/coding && ll"
alias dotfiles="cd ~/code/stephlaf/dotfiles"
alias hrc='heroku run "rails console -- --noautocomplete"'
alias gsw="git switch"

setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"
export PATH=$PATH:/Users/stephlaf/.spicetify
export BUNDLER_EDITOR="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl' -a"

source ~/.zsh/completion/scalingo_complete.zsh
