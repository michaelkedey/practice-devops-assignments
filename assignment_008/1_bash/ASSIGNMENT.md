# Assignment Instructions
## Create a Simple Logging Script

- Create a simple script called **logs.sh** that generates a log entry with the current date and time, in a file called logs.txt inside your home directory. 

### Inside your script, include :

1. Declare a variable in your script and assign it the value of the path to where the log will be written. eg. **log_file="$HOME/logs.txt"**

2. Declare another variable and assign it the value of the current timestamp. 
eg  **$(date +"%Y-%m-%d %H:%M:%S")** 

3. Declare another variable which will have the log message 
eg. **"Log entry at ${current_datetime}"** 
  or 
**"This log  was generated at ${current_datetime}"**

4. Add the new log to the logs.txt file (don't overwrite existing logs)

5. Print a message to the terminal indicating the log entry is added successfully.

6. Set up a cronjob to run the script every 1 minute.

7. Create aliases for the following commands ls, cd , and cp.


- **HAPPY LEARNING**