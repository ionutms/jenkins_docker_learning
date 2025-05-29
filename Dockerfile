# Use the official Jenkins LTS image with JDK 21 as the base image
FROM jenkins/jenkins:2.504.2-lts-jdk21

# Switch to root user to install system packages
USER root

# Update package lists and install lsb-release (for OS version detection) and python3-pip
RUN apt-get update && apt-get install -y lsb-release python3-pip

# Download Docker's official GPG key and save it to the keyring directory
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Add Docker's official repository to the system's package sources
# This creates a new apt source list file for Docker packages
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Update package lists again (now including Docker repo) and install Docker CLI
# Note: Only installs the CLI, not the Docker daemon (for Docker-in-Docker scenarios)
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to the jenkins user for security best practices
USER jenkins

# Install Jenkins plugins: BlueOcean (modern UI) and Docker Workflow (Docker pipeline support)
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"