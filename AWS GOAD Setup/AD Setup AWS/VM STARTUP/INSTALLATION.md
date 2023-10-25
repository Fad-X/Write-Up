MOVE TO THE LOAD DIRECTORY
- **pwd
/opt/LOAD  # place yourself in the LOAD folder (where you cloned the project)
cd terraform # start with AWS configuration

YOU can edit few things like :
- REGION
- MANAGEMENT_IPS

- **cd LOAD #TO generate acess key
ssh-keygen -t rsa -N "" -b 2048 -C "TerraformKey" -f ./terraform/keys/TerraformKey


### RUN
- ***terraform init
- ***terraform validate
- ***terraform apply
- Check your aws console, and confirm the instances are up and running
- 
![[instances 1.png]]


### CONNECTION
**CONNECTION WITHOUT VPN

- On your aws console Select all Instances and 