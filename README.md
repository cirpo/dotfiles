# Cirpo's Dotfiles

This is a collection of dotfiles and scripts I use for customizing OS X to my liking and setting up the software development tools I use on a day-to-day basis.
They should be cloned to your home directory so that the path is `~/.dotfiles/`.

I'm following the howto described here: [https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/) ([discussion on HN](https://news.ycombinator.com/item?id=11070797))


## Starting from scratch

Recently I read about this amazing technique in an Hacker News thread on people's solutions to store their dotfiles.
User StreakyCobra showed his elegant setup and ... It made so much sense! I am in the process of switching my own system to the same technique. The only pre-requisite is to install Git.
In his words the technique below requires:
No extra tooling, no symlinks, files are tracked on a version control system, you can use different branches for different computers, you can replicate you configuration easily on new installation.
The technique consists in storing a Git bare repository in a "side" folder (like $HOME/.cfg or $HOME/.myconfig) using a specially crafted alias so that commands are run against that repository and not the usual .git local folder, which would interfere with any other Git repositories around.
Starting from scratch
If you haven't been tracking your configurations in a Git repository before, you can start using this technique easily with these lines:

```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc
```

The first line creates a folder ~/.dotfiles which is a Git bare repository that will track our files.
Then we create an alias dotfiles which we will use instead of the regular git when we want to interact with our configuration repository.
We set a flag - local to the repository - to hide files we are not explicitly tracking yet. This is so that when you type dotfiles status and other commands later, files you are not interested in tracking will not show up as untracked.
Also you can add the alias definition by hand to your .bashrc or use the the fourth line provided for convenience.
I packaged the above lines into a snippet up on Bitbucket and linked it from a short-url. So that you can set things up with:

```
curl -Lks http://bit.do/cfg-init | /bin/bash
```

After you've executed the setup any file within the $HOME folder can be versioned with normal commands, replacing git with your newly created dotfiles alias, like:

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles add .bashrc
dotfiles commit -m "Add bashrc"
dotfiles push
```

Install your dotfiles onto a new system (or migrate to this setup)
  If you already store your configuration/dotfiles in a Git repository, on a new system you can migrate to this setup with the following steps:
  Prior to the installation make sure you have committed the alias to your .bashrc or .zsh:

  ```
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  ```

  And that your source repository ignores the folder where you'll clone it, so that you don't create weird recursion problems:

  ```
  echo ".dotfiles" >> .gitignore
  ```

  Now clone your dotfiles into a bare repository in a "dot" folder of your $HOME:

  ```
  git clone --bare <git-repo-url> $HOME/.cfg
  ```

  Define the alias in the current shell scope:

  ```
  alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
  ```

  Checkout the actual content from the bare repository to your $HOME:

  ```
  dotfiles checkout
  ```

  The step above might fail with a message like:

  ```
  error: The following untracked working tree files would be overwritten by checkout:
  .bashrc

  .gitignore

  Please move or remove them before you can switch branches.

  Aborting
  ```

  This is because your $HOME folder might already have some stock configuration files which would be overwritten by Git. The solution is simple: back up the files if you care about them, remove them if you don't care. I provide you with a possible rough shortcut to move all the offending files automatically to a backup folder:

  ```
  mkdir -p .dotfiles-bak && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-bak/{}
  ```

  Re-run the check out if you had problems:

  ```
  dofiles checkout
  ```

  Set the flag showUntrackedFiles to no on this specific (local) repository:

  ```
  dotfiles config --local status.showUntrackedFiles no
  ```

  You're done, from now on you can now type dotfiles commands to add and update your dotfiles:

  ```
  dotfiles status
  dotfiles add .vimrc
  dotfiles commit -m "Add vimrc"
  dotfiles add .bashrc
  dotfiles commit -m "Add bashrc"
  dotfiles push
  ```

  Thanks to Nicola Paolucci ([@durdn](https://twitter.com/durdn)) for write all the instructions down on the Atlassian blog!
