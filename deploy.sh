#!/bin/bash

# Log the start of the script
echo "Starting deployment process..."

# Update the system
echo "Updating system packages..."
sudo apt update

# Install NVM and Node.js
echo "Installing NVM and Node.js..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install v20.10.0

# Install PM2 and TypeScript globally
echo "Installing PM2 and TypeScript..."
npm install -g pm2
npm install -g typescript

# Clone the repositories
echo "Cloning repositories..."
git clone https://github.com/Discord-Activity-Planify/project-service.git
git clone https://github.com/Discord-Activity-Planify/file-service.git
git clone https://github.com/Discord-Activity-Planify/discord-auth-service.git

# Navigate to the file-service directory and install dependencies
echo "Navigating to file-service directory and installing dependencies..."
cd file-service/
npm i
cd ../project-service/

# Install project dependencies and Compile TypeScript code
echo "Installing project dependencies..."
npm i
tsc
cd ../discord-auth-service/

# Navigate to the file-service directory and install dependencies
echo "Installing discord-auth-service dependencies..."
npm i
tsc

# Go back to the root
cd ..

# Set up PM2 configuration
echo "Setting up PM2 configuration..."
vim pm2.config.js

# Set up UFW firewall rules
echo "Configuring UFW firewall..."
sudo ufw status
sudo ufw enable
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw reload
sudo ufw status

# Install PostgreSQL and start it
echo "Installing PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib
echo "Starting PostgreSQL..."
sudo systemctl start postgresql
sudo systemctl enable postgresql
echo "Switching to postgres user..."
sudo -i -u postgres

# Alter PostgreSQL password and create the project database
echo "Altering PostgreSQL password and creating project database..."
psql -c "ALTER USER postgres PASSWORD 'NEW_PASSWORD';"
psql -c "CREATE DATABASE project;"
psql -c "GRANT ALL PRIVILEGES ON DATABASE project TO postgres;"

# Start PM2 applications
echo "Starting PM2 applications..."
pm2 start pm2.config.js

# Save the PM2 process list
echo "Saving PM2 process list..."
pm2 save

# Set up PM2 to start on boot
echo "Setting up PM2 to start on boot..."
pm2 startup

# Check the status of PostgreSQL
echo "Checking PostgreSQL status..."
sudo systemctl status postgresql

# Log the completion of the deployment process
echo "Deployment process completed successfully!"
