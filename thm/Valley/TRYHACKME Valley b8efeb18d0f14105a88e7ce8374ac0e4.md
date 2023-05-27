# TRYHACKME Valley

# RECONNAISSANCE

Well I’m using rustscan for scanning 

![2023-05-27_17-58.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_17-58.png)

Here We have 3 ports 

# GAINNING ACCESS

I checked Port 80 and found a web page, same as what you’ll be seeing on yours

I clicked on “VIEW GALLERY” I saw some pictures, I double clicked on a picture

I noticed the url ‘[http://10.10.38.62/static/1](http://10.10.38.62/static/1)’ And I thought IDOR

![2023-05-27_18-03_1.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-03_1.png)

Since **‘0’ is known to be used by admins i tried but got nothing, I tried multiple numbers also and just got the pictures or nothing.**

I decided to try **“00” and I got something interesting** 😲

![2023-05-27_18-07.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-07.png)

It asking to remove a particular page, I copied and visit the page and found a login page, well its something.

I tried default creds, nothing 

i checked the source code of the login-page and I saw 2 JS files

![2023-05-27_18-09.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-09.png)

I checked the first one dev.js and  boom I got the username and password

![2023-05-27_18-09_1.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-09_1.png)

I logged in and found another note

```
dev notes for ftp server:
-stop reusing credentials
-check for any vulnerabilies
-stay up to date on patching
-change ftp port to normal port

```

It says here FTP, with this I knew the third port is FTP and it also mentioned something on credentials reuse

I logged in to the FTP server ound some files and get them

![2023-05-27_18-15.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-15.png)

they are all pcap files 

I used strings command to view them all and grep for username, password, pass, user, name

![2023-05-27_18-18.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-18.png)

I used that to login via ssh and I got user.txt

# PRIVELEDGE ESCALATION

![2023-05-27_18-21.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-21.png)

I checked to see number of users on the system and found an executable file valleyAuthenticator

I copied it to my terminal and execute it

![2023-05-27_17-45.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_17-45.png)

It requires password and username, since its user Valley’s definitely password is username

I wrote a bash script to brute force for the password since username is known

![2023-05-27_18-34.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-34.png)

[brute.sh](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/brute.sh)

I got the password
i switched user to valley

I tried sudo -l, finding suid misconf and got nothing 
i then checked crontab for automations and  got

![2023-05-27_18-39.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-39.png)

I checked the file and I dont have any permission over it except read

I cant help but notice it import base64 cool
Let’s hijack the module

I tried creating a [base64.py](http://base64.py) file in the same directory, but I can;t no perms

We have write permissions over one of the base64 library

I edited it to change the permission of ‘/binbash’

![2023-05-27_18-47.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-47.png)

I saved it then waited 

![2023-05-27_18-48.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-48.png)

“watch ls -la /bin/bash”

![2023-05-27_18-50.png](TRYHACKME%20Valley%20b8efeb18d0f14105a88e7ce8374ac0e4/2023-05-27_18-50.png)