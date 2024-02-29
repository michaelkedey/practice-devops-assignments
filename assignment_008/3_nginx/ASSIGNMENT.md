# Assignment Instructions

1. Provision an **EC2** instance on AWS, with **ssh access** and **public ip** enabled.

2. **SSH** into your instance and change the ssh port from **default(22)** to **2024** by modifying the **/etc/ssh/sshd_config** file

3. Modify the firewall rules and allow inbound traffic on port **2024** using the **ufw** command. **Enable and reload** the firewall.

4. Exit the remote instance

5. SSH into the instance again and notice the error message. 

6. What is the error message, why the error message and how do you resolve the error?

7. SSH into the instance again using the right port. Does it work?

8. On the **AWS console**, navigate to the instances page.

9. Select your instance, view the details and scroll to the **security tab**.

10. Select the **security group** your instance is associated with, under the **inbound rules**, **add** the new ssh port (2024) as a custom tcp rule, and allow traffic from everywhere (0.0.0.0/0). 

11. **Remove** the old ssh rule, and save.

12. On your terminal ssh into the instance again via the new port. Did it work?

13. Install **Nginx** on your remote instance.

14. Enable and start the nginx service by using the **systemctl** or **service** commands

15. Verify that nginx is working. Which command do you use?

16. Set up **reverse proxy** on your nginx server by modifying the **/etc/nginx/nginx.conf** file and adding your configuration inside the **http code block**.

17. The server should listen on port **9090**, and the backend configured to port **80**.

18. Use **ufw** to allow inbound traffic on port 9090, reload the firewall.

19. In your web browser try accessing the server without specifying the port.

20. Did it work? If no, try again and specify the port. eg **http://serverIp:port**

21. Did it work? If no why do you think so?

22. Back to your AWS console, modify the security group by allowing traffic on the new port you configured for your nginx server to listen on.

23. Restart the Nginx service and try accessing the server from the web again. Did it work? Remember to specify the port

24. Modify the contents of the webserver by copying the contents  of the **assignment_resource** sub-folder and pasting it into the Nginx web file at /var/www/html/index.html. Be sure to overwrite the existing code in **/var/www/html/index.html**

25. Modify the contents of the webpage as you please.

- **HAPPY LEARNING**