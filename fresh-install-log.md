# Goal
The ultimate goal is to write a solution to automate the setup of new 
installations. This can be done using a shell-script or by the usage of 
declarative/imperative Infrastructure as Code tools like Ansible, Puppet, 
Terraform, et cetera.

## Inspiration
The current (2024-02-26) inspiration of writing the tools is derived from 
- https://github.com/snwh/ubuntu-post-install
- https://ae.prasadt.com/
- https://gitlab.com/kikinovak/rocky-el8/-/blob/main/linux-setup.sh

# ubuntu 23.10
## install
### basic nvim
+ nvim using snap

### zsh setup
+ install zsh
+ install zsh dependencies
  + batcat
  + fd-find
  + tree
  + fzf
  + ripgrep
+ install oh-my-zsh
+ install nerd font (FiraCode)
+ install powerlvl10k
+ symbolic link .zshrc to .dotfiles/zsh/zshrc files

### tmux setup
+ install tmux
+ install tpm
+ symbolic link .config/tmux to .dotfiles/tmux folder
+ use tpm to install plugins

### python, pip
+ install python3
+ install pip
+ optional python
  + install pipx
  + install poetry
  + install black
  + install isort

### devtools
+ s
