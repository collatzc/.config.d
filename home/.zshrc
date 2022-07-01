# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
# User configuration

# export PATH=$HOME/bin:/usr/local/bin:$PATH

# [darwin/*] icu4c
if [ -d "/usr/local/opt/icu4c/bin" ]; then
	export PATH=/usr/local/opt/icu4c/bin:$PATH
	export PATH=/usr/local/opt/icu4c/sbin:$PATH
fi

# [linux] Go
if [ -d "/usr/local/go" ]; then
	export PATH=/usr/local/go/bin:$PATH
fi

# [linux] snap
if [ -d "/snap/bin" ]; then
	export PATH=/snap/bin:$PATH
fi

# [darwin/arm64] flutter
if [ -d "/opt/flutter" ]; then
	export PATH=$PATH:/opt/flutter/bin
	export PUB_HOSTED_URL=https://pub.flutter-io.cn
	export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
fi

# [darwin/arm64] VIMRUNTIME
if [ -d "/usr/share/vim/vim82" ]; then
	export VIMRUNTIME="/usr/share/vim/vim82"
fi

# [darwin/*] if using nodejs@10
# if [ -d "/usr/local/opt/node@10" ]; then
#   export PATH=/usr/local/opt/node@10/bin:$PATH
# fi

# [darwin/*] if using nodejs@16
if [ -d "/opt/homebrew/opt/node@16" ]; then
  export PATH=/opt/homebrew/opt/node@16/bin:$PATH
fi

# [*/*] GOPATH
if [ -d "$HOME/go" ]; then
	export GOPATH=$HOME/go
	export PATH=$GOPATH/bin:$PATH
	# go.mod
	export GO111MODULE=auto
fi

# [*/*] Rust cargo
if [ -d "$HOME/.cargo" ]; then
	source ~/.cargo/env
fi

# [*/*] Android Studio @linux
if [ -d "~/Android/Sdk" ]; then
	export ANDROID_HOME=~/Android/Sdk
	export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

# [darwin/*] Android SDK Command-Line Tools
if [ -d ~/Library/Android/sdk/tools/bin ]; then
	export PATH=$PATH:~/Library/Android/sdk/tools/bin
fi

# [darwin/*] Python
if [ -d /Users/$(whoami)/Library/Python/3.6/bin ]; then
	export PATH=/Users/cc/Library/Python/3.6/bin:$PATH
elif [ -d /Users/cc/Library/Python/2.7/bin ]; then
	export PATH=/Users/cc/Library/Python/2.7/bin:$PATH
elif [ -d ~/Library/Python/2.7/bin ]; then
	export PATH=~/Library/Python/2.7/bin:$PATH
fi

# [darwin/*] mactex
if [ -d /usr/local/texlive/2021/bin/universal-darwin ]; then
	export PATH=/usr/local/texlive/2021/bin/universal-darwin:$PATH
fi
if [ -d "/opt/cuda-10.0/bin" ]; then
	export PATH=/opt/cuda-10.0/bin:$PATH
	export LD_LIBRARY_PATH=/opt/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi

# .local/bin
if [ -d ~/.local/bin ]; then
	export PATH=~/.local/bin:$PATH
fi

# node.js
if [ -d ~/.yarn/bin ]; then
	export PATH=~/.yarn/bin:$PATH
fi

# [linux/*] nvm
if [ -d /usr/share/nvm ]; then
	source /usr/share/nvm/init-nvm.sh
fi
# [wsl] nvm
if [ -d $HOME/.nvm ]; then
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# macOS ruby@2.0
if [ -d /usr/local/opt/ruby@2.0/bin ]; then
	export PATH=/usr/local/opt/ruby@2.0/bin:$PATH
fi

if [ -e /usr/libexec/java_home ]; then
	export JAVA_HOME=$(/usr/libexec/java_home)
fi

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# aliases
alias rm='rm -i -v'
alias cp='cp -i -v'
alias mv='mv -i -v'
#alias diff='diff --color=auto'
alias diff='diff'

# alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="vim ~/.oh-my-zsh"

if [ -d /opt/MonkeyDev ]; then
	export MonkeyDevPath=/opt/MonkeyDev
	export MonkeyDevDeviceIP=
	export PATH=/opt/MonkeyDev/bin:$PATH
fi

# [macOS]
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# [*] nvm
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/cc/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/cc/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/cc/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/cc/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# [macOS] OpenJDK
if [ -d /opt/homebrew/opt/openjdk ]; then
	export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
fi

# [macOS] homebrew
#if [ -d /opt/homebrew/bin ]; then
#	export PATH="/opt/homebrew/bin:$PATH"
#fi
