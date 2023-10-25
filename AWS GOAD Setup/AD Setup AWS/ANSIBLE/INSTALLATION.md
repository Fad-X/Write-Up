## I prefer host installation here

***sudo apt install git
git clone https://github.com/0xBallpoint/LOAD.git
cd LOAD/ansible
sudo apt install python3-venv
python3 -m virtualenv .venv
source .venv/bin/activate

## Proceed to Installing Ansible
### LINUX
- **python3 -m pip install --user ansible
- **pipx inject ansible argcomplete
- **pipx install --include-deps ansible
- 