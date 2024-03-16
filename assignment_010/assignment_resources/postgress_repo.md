## Why install/add the official PostgreSQL repository to your system's list of package sources and also add the repository's GPG key for package verification?

**Adding the official Debian package PostgreSQL repository** `deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main`  (specifically tailored for your Ubuntu distribution identified by $(lsb_release -cs))

**and adding the GPG key** `https://www.postgresql.org/media/keys/ACCC4CF8.asc`

**to your system provides access to the latest version, security updates, and additional features, of PostgreSQL amd also ensures that the packages you install from this repository are authentic and have not been tampered with, making it a preferred choice for many users, especially in production environments. Overall, this process ensures a secure and reliable installation of PostgreSQL on your system.**


**Running `sudo apt install postgresql`  is a quick and convenient way to install PostgreSQL from the default Ubuntu repository. While this is a straightforward way to install PostgreSQL, it may not always provide the latest version of PostgreSQL or the most up-to-date features and bug fixes.**

- **Here's why using the official PostgreSQL repository and adding the GPG key is preferred in many cases:**

1. **Latest Version: The official PostgreSQL repository often provides the latest stable version of PostgreSQL If you need specific features or bug fixes that are only available in newer versions, installing from the official repository ensures you have access to them.**

2. **Security Updates: The official repository ensures that you receive security updates and patches promptly. These updates are important for maintaining the security and integrity of your database server.**

3. **Packaged with Ubuntu: The version of PostgreSQL available in the default Ubuntu repository might be slightly outdated compared to the version available in the official PostgreSQL repository. This is because Ubuntu packages are frozen at a certain version to ensure stability throughout the release cycle.**

4. **Dependency Management: When you install PostgreSQL from the official repository, APT (the package manager) handles dependencies automatically. This ensures that all required libraries and packages are installed correctly, reducing the risk of compatibility issues.**


**When you install a package using the apt package manager on Ubuntu, it will install the package from the repository with the highest priority that contains the package you're trying to install. The priority of repositories is determined by the configuration files located in the `/etc/apt/sources.list` directory and the `/etc/apt/sources.list.d/` directory.**

**In this case, after adding the PostgreSQL repository to your system, running `sudo apt install postgresql` will install PostgreSQL from the PostgreSQL repository because the repository was added to your system and it contains the postgresql package.**

**The reason it installs from the PostgreSQL repository and not the default Ubuntu repository is because the PostgreSQL repository was added to your system after you ran `sudo apt update`, which updates the local package lists. As a result, apt is aware of the PostgreSQL repository and its contents, and it prioritizes packages from that repository when installing PostgreSQL.**

**In general, when you have multiple repositories configured on your system, apt will choose the repository with the highest priority that contains the package you're trying to install. You can adjust the priorities of repositories by modifying their configuration files in the `/etc/apt/sources.list` directory and the `/etc/apt/sources.list.d/` directory.**


### The installation of PostgreSQL before installing SonarQube is often required because SonarQube relies on a database to store its data, and PostgreSQL is one of the supported databases for SonarQube.


## Command breakdown (Why you can't just sudo 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' `without using sh -c`)


    - The `sh -c` command allows you to execute a string as a shell command which is why you can't use `sudo echo` directly. The `-c` flag specifies that you want to run a command provided as an argument to `sh`. It tells `sh` to interpret the following argument as a command to execute. If you try to run this command directly with sudo, (`sudo echo ... >> /etc/apt/sources.list.d/pgdg.list'`) you might encounter a permission denied error. This is because of how redirection (>>) works in the shell.

    - When you use sudo echo "...", the echo command is executed with elevated privileges (as root) due to sudo. However, the redirection (>>) is performed by the shell before sudo is executed. Therefore, the shell, which is running with your user's permissions, tries to append the output to the file /etc/apt/sources.list.d/pgdg.list. Since your user doesn't have permission to write to this file, you'll get a permission denied error.

    - By using sh -c, you're running the entire command (echo ... >> /etc/apt/sources.list.d/pgdg.list) within a new shell instance, which is executed with elevated privileges (sudo). This allows the shell to perform the redirection as root, and you avoid the permission denied error.

    - However if you switch to the `root` user before running the command, you won't need to use `sudo` to execute the command, and you can use `echo` directly without the need for `sh -c`.



