# Callhome server setup

Use a Raspberry Pi or some other computer with linux on it. Place it in a separate DMZ on your firewall, and allow only your SSH ports to it. You will need two ports for a proper setup with 2FA for jump access.

We do not want to allocate pty´s and no agent forwarding for these callhome reverse tunnels. The syntax of the authorized_keys file is

    **command="/bin/echo \<port\>",no-user-rc,no-X11-forwarding,no-agent-forwarding,no-pty** ssh-rsa \<key\> **name:descriptive_text**

The **\<port\>** is the port number that this particular tunnel with allocate on the callhome server. It will be a tunnel towards the SSH daemon on the remote host.

## Sample /home/__callhome__/.ssh/authorized_keys

```
command="/bin/echo 2001",no-user-rc,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJQVmgEtPBRQoPrILF/VSY2bHO7+so3rFSww6zsVvCaJU7pVZBhnB+x2iyCpzd/PglEZ8YSpoEdOeZgLwqnQbR4qTTOfTUTLbgMiWjNX704Bh5kvINDnBEItjbaAAERcxU9VuvVPgjoirUNHAvaEwag5+msBaeGg8CgO+YvfrqY3MuYULFVRbTfPpT4OeC0/zerFcorKT9Ma5JgHYFhXiDr5Q1+R4J+LUxwVJMaJ1xr37TPzeUZDUkke1plXBX0TDUkwnTeUZFcCiCN1jdt5izMmyLXOYJlG8y//uf15jcPJOki85khfL2vQXsneN/D5Y3LxQZNy236Rsnk4ZOUUeitnqtqOQ1/B7yANOdX4nDpAVW6CgMDWM9AIJtfKNFt/wXYckoEAr27ZjOxL0rB7nyJKiMJb2jv8OvKhwMz97X8EMQCV0UUlS7CABkUPPZmsZYbwnQUjDJflaoOlYPoJQ2B1GpCd0pbG6ytBRGnIPfmTSleZd+FElNsebwprMhdsc= name:descriptive_text
```

## Sample /home/**online**/.ssh/authorized_keys

```
command="/usr/local/bin/online.pl",no-user-rc,no-X11-forwarding,no-agent-forwarding,no-pty ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOj9lxRNmB+HiJQbIWsmcdeAC4q8bGL4rxV1PS7Tre4/k3Qo1H1gdCLurslGeqxIj8NAxg54FW1nYyr5lhKd73prueMjOhMMnn0h5uEUAcWbikclDkROicjX63Tnq2DlPDsBepr5oFN6uietGsRewvplqTJQktnDvJd0aNLtw6pngyDPqd/5dhbNu7O01eTvRWlwqyZhUY4FMq9YzSf0roY5Omt6y8gTfxA/ir/01OHPfO48buc9A9FSVywoOBum+EiVUMETD15OJrzOJHxFSFrIFxM4LM1mnW3GPOKbaiFpHmFPjMhbNBvqeZN2Q5a0QRT+vMD2ST20C9551vOr35+i3lK5+X2+3XLm0OA1Dw0DwVjSwflMNN80ReIbhvQOK3SlnJkVC2t4fsiJSRlr4KTmPhd+59+JFXghXOOxg2ef5VeSGI2EFcIII0+KVUAZGzzICH9v1t1uzn84n/dcJUDQO9ClQsiDE/MYqlu275msvfHvQljPejK/8uCT2j5TE= user@domain.org
```
