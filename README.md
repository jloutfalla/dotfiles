# dotfiles

## About
This repo is organised to use `GNU Stow`. If you want to make it easy
to use, make sure that the package `stow is installed.

## Dependencies
I use [base16-shell](https://github.com/chriskempson/base16-shell) to
set my shell's default ANSI colors and [base16-xresources](https://github.com/binaryplease/base16-xresources)
for my Xresources.

## Installation
Just run this command :

```shell
$ stow -t DEST_FOLDER <CONFIG_FOLDER1 CONFIG_FOLDER2 ...>
```

*(You can ignore a folder thanks to the `--ignore=FOLDER` parameter)*
