

# - - - - - - - - - - - - - - - - - - - -
# Zsh Core Configuration
# - - - - - - - - - - - - - - - - - - - -

export CACHEDIR="$HOME/.local/share"
[[ -d "$CACHEDIR" ]] || mkdir -p "$CACHEDIR"

# Load The Prompt System And Completion System And Initilize Them.
autoload -Uz compinit promptinit

# Load And Initialize The Completion System Ignoring Insecure Directories With A
# Cache Time Of 20 Hours, So It Should Almost Always Regenerate The First Time A
# Shell Is Opened Each Day.
# See: https://gist.github.com/ctechols/ca1035271ad134841284
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;
promptinit
setopt prompt_subst

# - - - - - - - - - - - - - - - - - - - -
# ZSH Settings
# - - - - - - - - - - - - - - - - - - - -

autoload -U colors && colors    # Load Colors.
unsetopt case_glob              # Use Case-Insensitve Globbing.
setopt globdots                 # Glob Dotfiles As Well.
setopt extendedglob             # Use Extended Globbing.
setopt autocd                   # Automatically Change Directory If A Directory Is Entered.

# Smart URLs.
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# General.
setopt brace_ccl                # Allow Brace Character Class List Expansion.
setopt combining_chars          # Combine Zero-Length Punctuation Characters ( Accents ) With The Base Character.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt mail_warning           # Don't Print A Warning Message If A Mail File Has Been Accessed.

# Jobs.
setopt long_list_jobs           # List Jobs In The Long Format By Default.
setopt auto_resume              # Attempt To Resume Existing Job Before Creating A New Process.
setopt notify                   # Report Status Of Background Jobs Immediately.
unsetopt bg_nice                # Don't Run All Background Jobs At A Lower Priority.
unsetopt hup                    # Don't Kill Jobs On Shell Exit.
unsetopt check_jobs             # Don't Report On Jobs When Shell Exit.

setopt correct                  # Turn On Corrections

# Completion Options.
setopt complete_in_word         # Complete From Both Ends Of A Word.
setopt always_to_end            # Move Cursor To The End Of A Completed Word.
setopt path_dirs                # Perform Path Search Even On Command Names With Slashes.
setopt auto_menu                # Show Completion Menu On A Successive Tab Press.
setopt auto_list                # Automatically List Choices On Ambiguous Completion.
setopt auto_param_slash         # If Completed Parameter Is A Directory, Add A Trailing Slash.
setopt no_complete_aliases

setopt menu_complete            # Do Not Autoselect The First Completion Entry.
unsetopt flow_control           # Disable Start/Stop Characters In Shell Editor.

# Zstyle.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$HOME/.zcompcache"
zstyle ':completion:*' list-colors $LS_COLORS
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' rehash true

# History.
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
HISTSIZE=100000
SAVEHIST=5000
setopt appendhistory notify
unsetopt beep nomatch

setopt bang_hist                # Treat The '!' Character Specially During Expansion.
setopt inc_append_history       # Write To The History File Immediately, Not When The Shell Exits.
setopt share_history            # Share History Between All Sessions.
setopt hist_expire_dups_first   # Expire A Duplicate Event First When Trimming History.
setopt hist_ignore_dups         # Do Not Record An Event That Was Just Recorded Again.
setopt hist_ignore_all_dups     # Delete An Old Recorded Event If A New Event Is A Duplicate.
setopt hist_find_no_dups        # Do Not Display A Previously Found Event.
setopt hist_ignore_space        # Do Not Record An Event Starting With A Space.
setopt hist_save_no_dups        # Do Not Write A Duplicate Event To The History File.
setopt hist_verify              # Do Not Execute Immediately Upon History Expansion.
setopt extended_history         # Show Timestamp In History.


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode compile"handler" for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Provide A Simple Prompt Till The Theme Loads
PS1="READY >"
zinit for \
    light-mode pick"async.zsh" src"pure.zsh" \
                sindresorhus/pure

# - - - - - - - - - - - - - - - - - - - -
# Env
# - - - - - - - - - - - - - - - - - - - -
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# - - - - - - - - - - - - - - - - - - - -
# Plugins gottta go fast
# - - - - - - - - - - - - - - - - - - - -

zinit wait lucid light-mode for \
      OMZ::lib/compfix.zsh \
      OMZ::lib/completion.zsh \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

# - - - - - - - - - - - - - - - - - - - -
# Aliases
# - - - - - - - - - - - - - - - - - - - -
alias ls=exa
alias l='exa -bgl'

# - - - - - - - - - - - - - - - - - - - -
# iTerm
# - - - - - - - - - - - - - - - - - - - -
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# - - - - - - - - - - - - - - - - - - - -
# FZF Setup
# - - - - - - - - - - - - - - - - - - - -
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# - - - - - - - - - - - - - - - - - - - -
# NVM
# - - - - - - - - - - - - - - - - - - - -
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
