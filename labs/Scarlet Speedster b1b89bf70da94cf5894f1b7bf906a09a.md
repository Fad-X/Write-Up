# Scarlet Speedster

This is an easy box for beginner’s I created Myself

The machine is named Scarlet Speedster because I’m a very big fan of The Flash 

## Recon

As always we’ll always start with an nmap scan to know what we have open and accessible.

![2023-06-16_01-40.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-16_01-40.png)

From the abvove screenshot we have 3 ports open

Since we have Http and https open, I copied the IP and paste in my browser 

![2023-06-16_01-41.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-16_01-41.png)

We have wordpress installed
Lets fire up wpscan and scan aggresively for plugins

## GAINING ACCESS

Searching for wp-filemanger exploit I got a bash script [https://github.com/mansoorr123/wp-file-manager-CVE-2020-25213](https://github.com/mansoorr123/wp-file-manager-CVE-2020-25213)

I downloaded it 

![2023-06-16_01-54.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-16_01-54.png)

The exploit said its vulnerable 
the next step is to upload my reverse shell using the same exploit

I copied the reverse shell located in /usr/share/webshells/php/php-reverse-shell.php and edited the IP and port to mine then boom we have a shell

PLEASE NOTE to actually get a shell, you’ll need a public IP, here I use ngrok for that

![2023-06-18_13-44.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_13-44.png)

![2023-06-18_13-43.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_13-43.png)

For every wordpress, there’s always a config file for its database connection

I located it, cat out it’s content then login to mysql using the creds obtained

![2023-06-18_13-48.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_13-48.png)

I got a username and password hash from the database,

I also got a flag from the database

![2023-06-18_15-05.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_15-05.png)

Using the Password from  mysql, i tried switching user to ubuntu, whic failed and then tried harrison-wells and boom success

![2023-06-18_14-11.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_14-11.png)

## PRIVESC

I tried checking for sudo privileges and we can edit a file as root using VI

I checked gtfobin 

[vi
            
            |
            
            GTFOBins](https://gtfobins.github.io/gtfobins/vi/#file-write)

I followed the steps and boom root

![2023-06-18_14-57.png](Scarlet%20Speedster%20b1b89bf70da94cf5894f1b7bf906a09a/2023-06-18_14-57.png)