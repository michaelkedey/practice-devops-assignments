###The goal of this assignment is to give you hands-on practice with launching an instance, connecting via SSH, installing web server, controlling instance state, and using public IPs

- PART I
1. Sign in to the AWS console with your IAM user account and go to the EC2 dashboard.

2. Launch an EC2 instance using the Ubuntu AMI.

3. Number of instances is 1

4. Instance type is t2micro

5. Instance name is webServer

6. Create a new keypair named webServer  or use an existing one

7. Use default network configurations

8. Select Create security group, and allow SSH, HTTP, HTTPS access from 0.0.0.0/0 (everywhere)
9. Use 8GB gp2 storage

10. Confirm the instance summary and click on Launch instance.

- PART II (Web-Server)
1. Notice the public IP address of the new instance

2. From your terminal, ssh into the new instance using the keypair and public IP address. eg ssh -i path-to-your-ky-pair ubuntu@your-instance-public-ip

3. On success, install Apache webserver on the instance eg. sudo apt-get install apache2 -y

4. On success, start the apache server eg. sudo systemctl start apache2

5. On success, copy and paste your public ip address into your internet browser

6. Can you see the default Apache webpage (if yes, congratulations, you've installed your first webserver)

7. On your terminal, switch to a root user. eg sudo -i

8. Modify the content of the webpage by adding your name and a congratulatory message. eg echo "my name is michael, and this is my first web server, congrats to me" > /var/www/html/index.html

9. On success, paste your public IP into an internet browser again.

10. Has the content of the webpage changed from Apache to what you echoed?

- PART III
1. Share your public ip with colleagues to verify your web server configurations

2. On your console, terminate the instance (webServer) you created

3. Remember not to exceed your free tier usage, by monitoring how long your instances run

- HAPPY LEARNING.