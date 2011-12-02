# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
 COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ssh-agent archlinux)

source $ZSH/oh-my-zsh.sh
setopt extendedhistory

# Customize to your needs...
alias vi='vim'
alias ls='ls --color=auto'
alias ll='ls -lh --color=auto'
alias la='ls -lah --color=auto'
alias lg='ls -lh | less'
alias rm='rm -iv'
alias cp='cp -iv'
alias mv='mv -iv'
alias mvns='mvn clean install -Dmaven.test.skip -Dassembly.skipAssembly'

#common mistake 
alias gs='gst'

export PATH=~/.bin:$PATH
export EDITOR="vim"

#git zsh comp 
fpath=(~/.zsh/zsh-completions $fpath)
