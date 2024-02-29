### The goal of this assignment is to give you hands-on practice with creating SSH keys, managing users, managing files, and  Linux system navigation, and using elevated commands.


- PART I
1. **Provision a new EC2 instance with the following features.**
- OS: Ubuntu
- Storage: 8gb gp2
- SSH access
- Public ip address
- Instance type: t2-micro (any free tier eligible - instance)
- Name: SSHServer.
- New or existing keypair

- PART II
2. **User management**
**NB. Unless otherwise stated, use the su username command to switch users, not exit.**
1.SSH into the instance as user ubuntu using the keypair associated with the user

2. On success, assign a password to the user ubuntu eg sudo passwd ubuntu

3. Assign a password to the root user too

4. Create 2 new users named user1 and "your_name" using the adduser command.

5. Fill in the subsequent details

6. Use the id command to display the user IDs and groups for the users you created.

7. Check the /etc/passwd file to confirm the user details. eg cat /etc/passwd | tail

8. What does the tail command do?

9. Use the chage -l command to verify the password aging information for both user1 and "your_name"

10. Configure password aging for user1 to expire in 60 days. eg sudo chage -M 60 user1

11. Configure password aging for "your_name" to expire in 90 days.

12. Verify the new password ageing for both users

13. Switch user and login as "your_name" su "your_name"

14. Move to "your_name" home directory

15. Use the visudo command to add "your_name" to the sudoers file, to enable them run sudo commands.

16. What error message did you get?

17. Switch user and login as ubuntu

18. Use the visudo command to add "your_name" to the sudoers file, to enable them run sudo commands.

19. In the sudoers files, locate the section where users and their permissions are defined, usually starting with  %sudo ALL=(ALL:ALL) ALL.
 Add a new line beneath the section in step 18  to enable sudo acces for "your_name" eg  "your_name" ALL=(ALL:ALL) ALL

19. Save and exit.

20. Switch user and login as "your_name" again

21. Try editing the sudoers file again.

22. Did it work this time around? If yes, why? If no, correct steps 17-20

23. Switch  user and login as  "your_name"

24. Force user1 to change their password at the next login using the passwd -e command.

25. If you get a permission denied error, modify the command and try again.

26. Switch user and login as user1

27. Switch to user ubuntu, if it fails, modify the command and switch with sudo privileges.

28. Logout  out of the remote server by running the exit command repeatedly until you're out of the remote server.

- PART III
3. **SSH ACCESS - A**
**Back on your local desktop and terminal, move to your home directory by using the cd command**
1. List the contents of your home directory and look for the .ssh directory. eg ls -lah | grep .ssh  be sure to run this command in your home directory.

2. If the .ssh directory exists in your home directory, move into it

3. If it does not exist, create it and move into it. eg mkdir .ssh && cd .ssh 

4. Inside the .ssh directory, generate SSH keys for your local user. eg ssh-keygen -t rsa 
Leave all other settings at default, including the name.

5. On success list the contents of the .ssh directory

6. Notice the ssh key pair files created

7. What is the difference between id_rsa and id_rsa.pub ?

8. Start the ssh agent to manage your keys. eg  eval "$(ssh-agent -s)"

9. Use the ssh-add command to add the private key to the ssh agent. eg  ssh-add ~/.ssh/id_rsa

10. Open and copy the contents of the public key, using the answer from step 9.

- PART IV
4. **SSH ACCESS - B**

1. login into the remote server as user ubuntu using the initial keypair file you downloaded

2. Switch user to "your_name" and navigate to your home directory using the cd command

3. Navigate to the .ssh directory in your home directory. Create and navigate into it If it doesn't exist.

4. List the contents of the .ssh directory and look for the file authorized_keys.

5. Create it if it doesn't exist. eg touch authorized_keys

6. Using an editor of your choice, edit  the authorized_keys file and paste in the contents of the public key you copied earlier.

7. Set rwx permissions on the .ssh directory for the owner only.

8. Set rw permissions on the authorized_keys file for the owner only

9. Switch back to user Ubuntu

10. Logout of the remote server.

- PART V
5. **SSH ACCESS - C**
1. Back on your local desktop and terminal, ssh into the remote server now as "your_name" eg. ssh "your_name"@remote_ip_address

2. On success, congrats! You have configured Remote access via SSH on your instance.

3. On failure, don't be discouraged, go through the steps again.

- PART VI
6. **File management Ownership and Advanced Permissions, Archiving.**
**Still logged in as "your_name";**
1. Create a directory named shared_data in the home directory of user1. eg mkdir /home/user1/shared_date

2. How do you solve the permission denied error? Modify the command to solve the error.

3. Create a directory named private_data in the home directory of  "your_name"

4. Change the permissions of the shared_data directory to allow rw access for both user1 and "your_name" only

5. Use the ls -l command to verify the permissions of the home directories and subdirectories for both users.

6. Create a file named shared_file.txt inside the shared_data directory.

7. Change the ownership of shared_file.txt to user1. eg chown user1 /home/user1/shared_date/shared_file.txt

8. Grant user1 only rw permissions on the private_data directory.

9. Try navigating to the shared_data directory as user "your_username". Did it work?

10. Grant rw permissions to "your_username" too

11. Archive the entire private_data directory into a compressed file named private_data.tar.gz. eg tar -cvzf private_data.tar.gz private_data/

12. Extract the contents of private_data.tar.gz into a new directory named restored_files.

**Remember, Linux commands like mkdir, touch, chmod, chown, tar, etc., will be useful for these assignments.**


- HAPPY LEARNING
