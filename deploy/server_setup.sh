#!/usr/bin/env bash

set -euo pipefail  # Exit on error, undefined variable, or failed pipe command

# Variables
PROJECT_GIT_URL='https://github.com/prathmeshpandya1414/profiles-rest-api.git'
PROJECT_BASE_PATH='/usr/local/apps/profiles-rest-api'
VIRTUALENV_BASE_PATH='/usr/local/apps/virtualenvs'
REQUIREMENTS_FILE='requiremnet.txt'

# Ensure running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Use sudo."
    exit 1
fi

# Set Ubuntu Language
echo "Setting up locale..."
locale-gen en_GB.UTF-8 > /dev/null 2>&1

# Install Python, SQLite, pip, and other dependencies
echo "Installing dependencies..."
apt-get update -y > /dev/null
<<<<<<< HEAD
apt-get install -y python3-dev python3-venv sqlite3 python3-pip supervisor nginx git \
    build-essential libpcre3-dev libssl-dev zlib1g-dev > /dev/null
=======
apt-get install -y python3-dev python3-venv sqlite3 python3-pip supervisor nginx git > /dev/null
>>>>>>> b07a3b2f66ec5733aa277c599b64757c449286c3

# Create necessary directories
echo "Setting up directories..."
mkdir -p $PROJECT_BASE_PATH
mkdir -p $VIRTUALENV_BASE_PATH

# Clone the project repository (handle existing directories)
if [ -d "$PROJECT_BASE_PATH/.git" ]; then
    echo "Repository already exists. Pulling latest changes..."
    git -C $PROJECT_BASE_PATH pull
else
    echo "Cloning repository..."
    git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH
fi

# Set up virtual environment
echo "Setting up virtual environment..."
if [ ! -d "$VIRTUALENV_BASE_PATH/profiles_api" ]; then
    python3 -m venv $VIRTUALENV_BASE_PATH/profiles_api
fi

<<<<<<< HEAD
# Upgrade pip, setuptools, and wheel (ensure dependencies are correctly installed)
echo "Upgrading pip, setuptools, and wheel..."
$VIRTUALENV_BASE_PATH/profiles_api/bin/pip install --upgrade pip setuptools wheel > /dev/null

# Install dependencies from requirements.txt
echo "Installing Python dependencies..."
if [ -f "$PROJECT_BASE_PATH/$REQUIREMENTS_FILE" ]; then
    $VIRTUALENV_BASE_PATH/profiles_api/bin/pip install -r $PROJECT_BASE_PATH/$REQUIREMENTS_FILE > /dev/null
else
    echo "Error: $REQUIREMENTS_FILE file not found!"
    exit 1
fi

# Run database migrations
echo "Running database migrations..."
cd $PROJECT_BASE_PATH/src
$VIRTUALENV_BASE_PATH/profiles_api/bin/python manage.py migrate

=======
# Install Python dependencies
echo "Installing Python dependencies..."
if [ -f "$PROJECT_BASE_PATH/$REQUIREMENTS_FILE" ]; then
    $VIRTUALENV_BASE_PATH/profiles_api/bin/pip install --upgrade pip > /dev/null
    $VIRTUALENV_BASE_PATH/profiles_api/bin/pip install -r $PROJECT_BASE_PATH/$REQUIREMENTS_FILE > /dev/null
else
    echo "Error: $REQUIREMENTS_FILE file not found!"
    exit 1
fi

# Run database migrations
echo "Running database migrations..."
cd $PROJECT_BASE_PATH/src
$VIRTUALENV_BASE_PATH/profiles_api/bin/python manage.py migrate

>>>>>>> b07a3b2f66ec5733aa277c599b64757c449286c3
# Configure Supervisor
SUPERVISOR_CONF="/etc/supervisor/conf.d/profiles_api.conf"
echo "Configuring Supervisor..."
if [ -f "$PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf" ]; then
    cp $PROJECT_BASE_PATH/deploy/supervisor_profiles_api.conf $SUPERVISOR_CONF
    supervisorctl reread
    supervisorctl update
    supervisorctl restart profiles_api
else
    echo "Error: Supervisor configuration file not found!"
    exit 1
fi

# Configure Nginx
NGINX_CONF="/etc/nginx/sites-available/profiles_api.conf"
echo "Configuring Nginx..."
if [ -f "$PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf" ]; then
    cp $PROJECT_BASE_PATH/deploy/nginx_profiles_api.conf $NGINX_CONF
    ln -sf $NGINX_CONF /etc/nginx/sites-enabled/
    rm -f /etc/nginx/sites-enabled/default
    systemctl restart nginx
else
    echo "Error: Nginx configuration file not found!"
    exit 1
fi

# Final message
<<<<<<< HEAD
echo "Setup completed successfully! :)"
=======
echo "Done :)"
>>>>>>> b07a3b2f66ec5733aa277c599b64757c449286c3
