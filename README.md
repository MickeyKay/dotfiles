# Mickey's take on Holman's dotfiles

__Installation Note!__  
Make sure to use a recursive `clone` to get any and all submodules (e.g. Gary Jone's gitflow deploy script).

__Another Note__  
Run `dot` (inside `/bin`) every now and then to update all the goodies.

## Installation
First, make sure Homebrew is installed:

`which brew`

If not, install it:

`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

Then set up and run the .dotfiles install:

```
git clone --recursive https://github.com/MickeyKay/.dotfiles
cd ~/.dotfiles
script/bootstrap // Bootstraps .dotfiles stuff
./micktastic/installation/install.sh // Runs micktastic install stuff
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane OS X
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## General Installation Overview
Here is an overview of all the installation to-do list when setting up a new machine:

1. Install XCode Command Line Tools - this should come before just about anything else!  
	[`xcode-select --install`]
1. Install Virtual Box AND VB Extension Pack(used by VVV).  
	[https://www.virtualbox.org/wiki/Downloads]

	#### Pre-Dotfiles
	---

1. Install these dotfiles (/micktastic/installation/install.sh should install some goodies when this happens).  
	[[instructions below](https://github.com/MickeyKay/.dotfiles#installation)]
1. Add GaryJ's deploy script to each dev install's plugins folder, or figure out a way to have this execute from one place.  
	[https://github.com/GaryJones/wordpress-plugin-git-flow-svn-deploy]
1. Run `dot` every now and then to update dotfile dependencies.

## Still To Figure Out

* ZSH probably needs to install before anything else, so consider moving that part of `/micktastic/installation/install.sh`, into a separate top-level `install-me.sh` script that installs homebrew and then calls `script/bootstrap` - or something like that.
* Auto install Virtualbox boxes (IE, Android, etc).
* Port over settings including:
	- Sublime Text

## Before Going Further. . .
Before just installing and running all these dotfile goodies, make sure you've done the following:
* Install XCode command line tools.


## Topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## Components

There's a few special files in the hierarchy.

### Mickey's Custom Stuff
It all lives under **micktastic/**:
- **installation/install.sh**: installs a bunch of good stuff (VVV, updated Git/ZSH, etc).

### Holman's Original Stuff
- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## (Mickey's) Todo's

* Add completion for:
	- delb (branches)
* Create automation for all things I currently need to install manually including:
	- xcode command line
	- homebrew
	- zsh
	- git-completions script (is this even needed?)
