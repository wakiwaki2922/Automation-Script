#!/bin/bash

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
    echo "Please run the script as root"
    exit 1
fi

# Error handling function
handle_error() {
    echo "Error: $1"
    exit 1
}

# Function to execute command with error handling
execute_command() {
    echo "Executing: $1"
    if ! eval "$1"; then
        handle_error "Failed to execute command: $1"
    fi
    sleep 2  # 2-second delay between commands
}

# Add Docker GPG key and repository
execute_command "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg"
execute_command 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null'

# Update package index
execute_command "apt update"

# Install Docker
execute_command "apt install docker-ce docker-ce-cli containerd.io -y"

# Verify Docker installation
if ! docker --version; then
    handle_error "Unable to verify Docker version. Installation may have failed."
fi

# Create volume for Portainer
execute_command "docker volume create portainer_data"

# Run Portainer
execute_command "docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce"

echo "Docker and Portainer installation complete."
echo "You can access Portainer at http://localhost:9000 or http://[server-ip]:9000"
