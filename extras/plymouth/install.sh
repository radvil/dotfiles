#!/usr/bin/env bash

  spattern="consolefont\ block\ filesystems\ fsck"
  sudo sed -i "s/$spattern/$spattern\ plymouth/g" /etc/mkinitcpio.conf
  sudo sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT/#GRUB_CMDLINE_LINUX_DEFAULT/g" /etc/default/grub
  echo 'GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet splash"' | sudo tee -a /etc/default/grub > /dev/null
  sudo mkinitcpio -p linux
  sudo grub-mkconfig -o /boot/grub/grub.cfg
  ! has_installed plymouth && yay -S plymouth
  yay -S plymouth-theme-sweet-arch-git
  sudo plymouth-set-default-theme -R sweet-arch

