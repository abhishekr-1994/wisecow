FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y netcat-openbsd fortune cowsay 

ENV PATH="/usr/games:${PATH}"
# Copy script into the container
COPY wisecow.sh /wisecow.sh

RUN chmod +x /wisecow.sh

# Expose the service port
EXPOSE 4499

# Start the server
CMD ["/wisecow.sh"]
