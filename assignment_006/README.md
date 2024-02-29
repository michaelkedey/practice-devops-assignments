### The goal of this assignment is to give you hands-on practice with creating SSH keys, managing users, managing files, and  Linux system navigation, and using elevated commands.


- PART I
1. **Provision a new EC2 instance with the following features.**
OS: Ubuntu
Storage: 8gb gp2
SSH access
Public ip address
Instance type: t2-micro (any free tier eligible instance)
Name: SSHServer.
New or existing keypair

- PART II
2. **User management**
NB. Unless otherwise stated, use the su username command to switch users, not exit.
SSH into the instance as user ubuntu using the keypair associated with the user
On success, assign a password to the user ubuntu eg sudo passwd ubuntu
Assign a password to the root user too
Create 2 new users named user1 and "your_name" using the adduser command.
Fill in the subsequent details
Use the id command to display the user IDs and groups for the users you created.
Check the /etc/passwd file to confirm the user details. eg cat /etc/passwd | tail
What does the tail command do?
Use the chage -l command to verify the password aging information for both user1 and "your_name"
Configure password aging for user1 to expire in 60 days. eg sudo chage -M 60 user1
Configure password aging for "your_name" to expire in 90 days.
Verify the new password ageing for both users
Switch user and login as "your_name" su "your_name"
Move to "your_name" home directory
Use the visudo command to add "your_name" to the sudoers file, to enable them run sudo commands.
What error message did you get?
Switch user and login as ubuntu
Use the visudo command to add "your_name" to the sudoers file, to enable them run sudo commands.
In the sudoers files, locate the section where users and their permissions are defined, usually starting with  %sudo ALL=(ALL:ALL) ALL.
 Add a new line beneath the section in step 18  to enable sudo acces for "your_name" eg  "your_name" ALL=(ALL:ALL) ALL
Save and exit.
Switch user and login as "your_name" again
Try editing the sudoers file again.
Did it work this time around? If yes, why? If no, correct steps 17-20
Switch  user and login as  "your_name"
Force user1 to change their password at the next login using the passwd -e command.
If you get a permission denied error, modify the command and try again.
Switch user and login as user1
Switch to user ubuntu, if it fails, modify the command and switch with sudo privileges.
Logout  out of the remote server by running the exit command repeatedly until you're out of the remote server.

- PART III
3. **SSH ACCESS - A**
Back on your local desktop and terminal, move to your home directory by using the cd command
List the contents of your home directory and look for the .ssh directory. eg ls -lah | grep .ssh  be sure to run this command in your home directory.
If the .ssh directory exists in your home directory, move into it
If it does not exist, create it and move into it. eg mkdir .ssh && cd .ssh 
Inside the .ssh directory, generate SSH keys for your local user. eg ssh-keygen -t rsa 
Leave all other settings at default, including the name.
On success list the contents of the .ssh directory
Notice the ssh key pair files created
What is the difference between id_rsa and id_rsa.pub ?
Start the ssh agent to manage your keys. eg  eval "$(ssh-agent -s)"
Use the ssh-add command to add the private key to the ssh agent. eg  ssh-add ~/.ssh/id_rsa
Open and copy the contents of the public key, using the answer from step 9.

- PART IV
4. **SSH ACCESS - B**
 login into the remote server as user ubuntu using the initial keypair file you downloaded
Switch user to "your_name" and navigate to your home directory using the cd command
Navigate to the .ssh directory in your home directory. Create and navigate into it If it doesn't exist.
List the contents of the .ssh directory and look for the file authorized_keys.
Create it if it doesn't exist. eg touch authorized_keys
Using an editor of your choice, edit  the authorized_keys file and paste in the contents of the public key you copied earlier.
Set rwx permissions on the .ssh directory for the owner only.
Set rw permissions on the authorized_keys file for the owner only
Switch back to user Ubuntu
 Logout of the remote server.

- PART V
5. **SSH ACCESS - C**
Back on your local desktop and terminal, ssh into the remote server now as "your_name" eg. ssh "your_name"@remote_ip_address
On success, congrats! You have configured Remote access via SSH on your instance.
On failure, don't be discouraged, go through the steps again.

- PART VI
6. **File management Ownership and Advanced Permissions, Archiving.**
Still logged in as "your_name";
Create a directory named shared_data in the home directory of user1. eg mkdir /home/user1/shared_date
How do you solve the permission denied error? Modify the command to solve the error.
Create a directory named private_data in the home directory of  "your_name"
Change the permissions of the shared_data directory to allow rw access for both user1 and "your_name" only
Use the ls -l command to verify the permissions of the home directories and subdirectories for both users.
Create a file named shared_file.txt inside the shared_data directory.
Change the ownership of shared_file.txt to user1. eg chown user1 /home/user1/shared_date/shared_file.txt
Grant user1 only rw permissions on the private_data directory.
Try navigating to the shared_data directory as user "your_username". Did it work?
Grant rw permissions to "your_username" too
Archive the entire private_data directory into a compressed file named private_data.tar.gz. eg tar -cvzf private_data.tar.gz private_data/
Extract the contents of private_data.tar.gz into a new directory named restored_files.
Remember, Linux commands like mkdir, touch, chmod, chown, tar, etc., will be useful for these assignments.


- HAPPY LEARNING
