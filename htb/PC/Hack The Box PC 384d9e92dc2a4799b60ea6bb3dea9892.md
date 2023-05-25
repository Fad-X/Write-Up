# Hack The Box PC

Hi This is a very interesting and fun box… Well it always starting with enumeration

I added it to /etc/hosts with the domain name

## Enumeration

I use threader3000 for my scans , only 2 ports are open.

![2023-05-25_18-35.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_18-35.png)

Well we are very familiar with port 22 (ssh), but whats with port 50051

I googled what runs on it and i have, GRPC and guess what.? Its a Remote Procedure Call released by Google 
Ok researched on how to connect or use it, then i found a tool, grpcui

[https://github.com/fullstorydev/grpcui](https://github.com/fullstorydev/grpcui)

# Gaining Access

I intalled and connected to it 

![2023-05-25_18-41.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_18-41.png)

![2023-05-25_18-43_1.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_18-43_1.png)

The WEB UI has 3 functions 

LoginUser, RegisterUser, GetInfo

I registered a user, then logged in
when i logged in I was given an ID and a token

![2023-05-25_18-46.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_18-46.png)

I copied the token with the id and paste in the getInfo function

![2023-05-25_18-49.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_18-49.png)

I got a response

{
"message": "Will update soon."
}

I then tried injecting the **“id”** parameter with **“ ‘ “**

and I have an error message different message

I took the request through burp intercepted and saved the request then used sqlmap to inject it

![2023-05-25_19-00.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-00.png)

![2023-05-25_19-01.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-01.png)

I got the SSH password for user sau

I logged in as sau 

![2023-05-25_19-04.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-04.png)

# Priviledge Escalation

I checked first with sudo -l

sau@pc:~$ sudo -l
[sudo] password for sau:
Sorry, user sau may not run sudo on localhost.
sau@pc:~$

I checked for SUID “ find / -perm -u=s -type f 2>/dev/null”

and got nothing interesting
I brought big bro linpeas, still empty

I then checked for running services and found an interesting service running on port 80

![2023-05-25_19-08.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-08.png)

I copied chisel to the VM for tunnelling 

On the Vm

![2023-05-25_19-12.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-12.png)

On my attack box]

![2023-05-25_19-10.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-10.png)

We have a web service running

![2023-05-25_19-13_1.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-13_1.png)

I tried default creds “admin:admin” I did a little research and got to its documentation , trie its default login “pykload:pyload” still nothing 

I searched for it exploit and found Metasploit has something for us

```
msf > use exploit/linux/http/pyload_js2py_exec
msf exploit(pyload_js2py_exec) > show targets
    ...targets...
msf exploit(pyload_js2py_exec) > set TARGET < target-id >
msf exploit(pyload_js2py_exec) > show options
    ...show and set options...
msf exploit(pyload_js2py_exec) > exploit
```

![2023-05-25_19-18.png](Hack%20The%20Box%20PC%20384d9e92dc2a4799b60ea6bb3dea9892/2023-05-25_19-18.png)