# callhome
Make SSH call home and create a reverse tunnel

Use the setup in the **server** folder to have a local Command&Control server that the remote clients connect to. For each remote client use the setup in **client** folder. This setup assumes you are familiar with how SSH works.

The idea is that the remote client upon startup initiates an ssh reverse tunnel to your control server. This tunnel points to the local ssh server (or RDP) on the client, and as such does not pose a security risk. You still will have to login to the client, either by using passwords or preferably, rsa keys. You can then connect to your own server (jump station) and hook up to the reverse tunnel, and hence get a connection to the remote "client" bypassing any firewall in-between.

Your own SSH server can be any linux installation, or even a Raspberry Pi. Please turn off password login and only allow rsa keys to access this one. For added security we have put 2FA in the form of Duo and Google authenticator as backup. 

To make use of the jump station from your desktop, put something like this in your **.ssh/config** file (using tunnel 2001 as an example):

```
Host remotehost
  Hostname remotehost
  User root
  ProxyCommand ssh -p 8080 jump@your.control.server nc localhost 2001
```

In case you only have access to a single tunnel, this can be put as
```
Host remotehost
  Hostname remotehost
  User root
  ProxyCommand ssh -p 8080 jump@your.control.server no-command
```

Or, when using the supplied **commands.pl** script for authorizing multiple tunnels:
```
Host remotehost
  Hostname remotehost
  User root
  ProxyCommand ssh -p 8080 jump@your.control.server 2001
```
To allow RDP towards a Windows computer (that has created a tunnel towards its RDP port):
```
Host remotehost
  Hostname your.control.server
  User root
  Port 8080
  LocalForward 2001 localhost:2001
  RemoteCommand no-command
```
