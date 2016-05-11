# Julien's Dotfiles

## Fresh OS X Setup

Follow these install instructions to setup a new Mac.

1. Update OS X to the latest version with the App Store
2. Install Xcode from the App Store, open it and accept the license agreement
3. Install OS X Command Line Tools by running `xcode-select --install`
4. Copy public and private SSH keys to `~/.ssh` and make sure they're set to `600`
5. Clone this repo to `~/.dotfiles`
6. Append `/usr/local/bin/zsh` to the end of your `/etc/shells` file
7. Run `install.sh` to start the installation
8. Make sure Dropbox is set up (login+installation folder) and synced
9. [Install the remaining apps](./apps.md)
10. Restore preferences by running `mackup restore`, then `mackup uninstall`
11. Restart your computer to finalize the process


## Thanks To Dries :)

Read his awesome blog post: https://driesvints.com/blog/getting-started-with-dotfiles

## License

The MIT License. Please see [the license file](license.md) for more information.
