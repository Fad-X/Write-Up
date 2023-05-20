# Hack The Box Precious

I joined the machine and got **10.10.11.189** as IP, I paste it in my browser and I got 

![2023-05-20_10-03.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-03.png)

I added it to /etc/hosts with the domain name

## Enumeration

I use threader3000 for my scan , only 2 ports are open.

![2023-05-20_10-06.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-06.png)

On the web page, is a website that converts webpages to pdf.

I tried directory bruteforce, i got nothing

I then started a python web server to convert a controlled web page to PDF’ i tried intercepting with burp to figure how it does the conversion or tool used but still nothing

I proceeded to checking with Subdomain bruteforce still got nothing.

after a while I decided to trace my step back, and I started again, stopping after downloading the PDF file, a thought came to my mind to check it probably there’s hidden file, creds or anything useful in it.

I used exiftool and found the tool used **pdfkit v0.8.6**

![2023-05-20_10-14.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-14.png)

I copied and paste it in my browser, and boom its vulnerable to rce

I found and used this exploit 

[pdfkit 0.8.7.2 Command Injection ≈ Packet Storm](https://packetstormsecurity.com/files/171746/pdfkit-0.8.7.2-Command-Injection.html)

I ran it with IP and port and I got access as user ruby

To get the parameter used for collecting IP

simply check source code

![2023-05-20_10-32.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-32.png)

![2023-05-20_10-21.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-21.png)

![2023-05-20_10-21_1.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-21_1.png)

## Gaining Access

I generated ssh-keys since I’m user ruby and logged in using ssh

![2023-05-20_10-25.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-25.png)

There are two users on the system Henry and ruby, trying to become user Henry I tried checking for any of Henry’s file for password 😆 but got nothing

I traced my step back to ruby home directory and saw a config file in .bundle

## bash-5.1$ cd .bundle/
-bash-5.1$ ls
config
-bash-5.1$ cat config

BUNDLE_HTTPS://RUBYGEMS__ORG/: "henry:Q3c1AqGHtoI0aXAYFH"
-bash-5.1$

I used the password to ssh as user henry and got user flag

![2023-05-20_10-31.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-31.png)

## Privilege Escalation

I checked for sudo privileges and found

![2023-05-20_10-37.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-37.png)

totally new to that, but as IDAN  we move

i ran the script with sudo permissions to get a hang of it and an error came up

![2023-05-20_10-40.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-40.png)

i knew from ther a file dependencies.yml is needed

i proceeded to google and search for **ruby update dependencies**

I found and used this exploit [Ruby exploit](https://exploit-notes.hdks.org/exploit/linux/privilege-escalation/ruby-privilege-escalation/)

i edited it to give bash suid permissions

![2023-05-20_10-46.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-46.png)

i saved and ran the sudo privilege again and boom root

![2023-05-20_10-48.png](Hack%20The%20Box%20Precious%20fec6cf67dcae43dfb0f8276daf44ef77/2023-05-20_10-48.png)