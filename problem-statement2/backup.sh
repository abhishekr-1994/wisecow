#!/bin/bash

# Configuration variables
SOURCE_DIR="/root/wisecow/"
DESTINATION_HOST="ubuntu@ec2-13-233-229-162.ap-south-1.compute.amazonaws.com"  # Replace with your remote host URL or IP address
DESTINATION_DIR="/home/ubuntu/"  # Destination directory on the remote host
BACKUP_TYPE="remote"  # Set to 'local' or 'remote'

# Function to perform local or remote backup using rsync
perform_backup() {
    SOURCE=$1
    DESTINATION=$2

    rsync -avz --delete $SOURCE $DESTINATION

    # Check the rsync exit status
    if [ $? -eq 0 ]; then
        echo "Backup completed successfully."
        return 0
    else
        echo "Backup failed."
        return 1
    fi
}

# Main function for backup
main() {
    echo "Starting backup at $(date)"
    perform_backup $SOURCE_DIR $DESTINATION_HOST:$DESTINATION_DIR

    # Capture the return code of perform_backup function
    if [ $? -eq 0 ]; then
        echo "Backup operation successful."
    else
        echo "Backup operation failed."
    fi
}

# Call main function
main
