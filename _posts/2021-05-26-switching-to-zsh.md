# Switching to zsh (updated for Emacs M-x shell)

I may be late to the party, but I've finally switched from ``bash`` to ``zsh``. It wasn't due to any failings of bash, it's because I've been using it inside of [Emacs M-x shell](/2019/11/03/emacsconf) and never felt the need the fancy features of [Oh My Zsh](https://ohmyz.sh/) or any of the other new and improved shells. The [Starship](https://starship.rs/) shell prompt is a vast improvement on the ``PS1`` settings and scripts available in bash as well. What prompted the change was macOS and Arch Linux both defaulting to it on installation.

## Making the Switch

There were a pair of useful articles I read beforehand:

    [Switching to ZSH](http://zpalexander.com/switching-to-zsh/)
    [Moving to zsh](https://scriptingosx.com/2019/06/moving-to-zsh/)

After reading through those, I figured I'd just make the switch and suffer the fallout.

## .zshenv

The [.zshenv](https://github.com/mattray/home-directory/blob/main/.zshenv) file is used for setting user's environment variables. I didn't really have too many to set, but it is convenient to keep them in 1 place.

```
HISTSIZE=200000

GOPATH=$HOME/go
PATH=$PATH:$HOME/bin:$GOPATH/bin

EDITOR=emacsclient
GIT_EDITOR=$EDITOR
```

This ``HISTSIZE`` is used for maintaining the maximum size of the ``.zsh_history`` file. The ``$PATH`` settings are adding my home and local Go ``bin`` directories. ``EDITOR`` is set for anything that needs to access my preferred editor of Emacs and ``GIT_EDITOR`` is specific to Git.

## .zshrc

The [.zshrc](https://github.com/mattray/home-directory/blob/main/.zshrc) is used for setting user's interactive shell configuration and executing commands, and is read when starting an interactive shell. The advice was to forgo using an additional **.zsh_profile** and just use a **.zshrc**.

There are several **setopt** commands for setting **.zsh_history** settings (documented in the file) and the various aliases I prefer. The block
``` shell
# emacs M-x shell
if [[ "dumb" == $TERM ]] ; then
  alias l='cat'
  alias less='cat'
  alias m='cat'
  alias more='cat'
  export PAGER=cat
  export TERM=xterm-256color
else
  alias l='less'
  alias m='more'
fi
```

explicitly sets behavior so ``M-x shell`` and iTerm behaved as expected. The ``GIT_EDITOR`` was not picked up when commiting files from the CLI within ``M-x shell``, so I had to ``export GIT_EDITOR=$EDITOR`` to get the desired behavior of not opening another Emacs window when commiting. The ``export TERM=xterm-256color`` is to get around [this Starship bug](https://github.com/starship/starship/issues/1588).

My ``PS1`` is managed by my [Starship config file](https://github.com/mattray/home-directory/blob/main/.config/starship.toml).

## Emacs

To ensure that ``M-x shell`` used zsh instead of bash I set the custom variables
```
 '(explicit-shell-file-name "/bin/zsh")
 '(explicit-zsh-args '("--interactive" "--login"))
```
and to off echoed commands from zsh added
```
 '(comint-process-echoes 0)
 ```
to my [.emacs.d/init.el](https://github.com/mattray/home-directory/blob/main/.emacs.d/init.el).

I did not use ``AUTO_CD`` settings because Emacs tended to lose track of the ``CWD`` and I don't care enough to figure out how to use [Dirtrack](https://www.emacswiki.org/emacs/ShellDirtrackByPrompt).

I added the following to my ``.zshrc`` to [prevent Tramp from hanging](https://www.emacswiki.org/emacs/TrampMode#h5o-9) on remote ssh zsh connections.
```
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ '
```
