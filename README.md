# Testin speed of shares NFS vs Samba on/off VPN

Guessed right that NFS is faster, but the quiestion was how much and for what kind of operations (read, write, dir ls) and for what file sizes.

# Used

1 Win 10 VM using VirtualBox
1 CentOS 7 machine in same network
Samba
NFS


# Notes

Because of single user nature of windows and me being unable to ssh to win from linux without loosing session token either as user or administrator script connects from win to linux machine where there are nfs and samba shares.

If using iptables or similar firewall note that testing with VPN can require changing allowed IP address in iptables rules when switching VPN on/off or have same IP after each switch.

Enforcing NFSv4 on server and disabling previous NFS versions made Win NFS client to hang on connecting. (this should be fixed most likely in NFS client configuration maybe in registers, idk)

# ssh

Script needs ssh acces from Win to linux machine [authenticated](http://www.linuxproblem.org/art_9.html) and [passphrase prompts](https://unix.stackexchange.com/questions/12195/how-to-avoid-being-asked-passphrase-each-time-i-push-to-bitbucket).

# To Change

in ./scripts/testSpeed.ps1 change ```$SSH_TARGET="<your ssh...>"```
