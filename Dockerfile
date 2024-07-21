# Use an Ubuntu base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && apt-get install -y cowsay fortune bash socat

# Copy the script into the container
COPY wisecow.sh /app/wisecow.sh

# Set the working directory
WORKDIR /app

# Make the script executable
RUN chmod +x /app/wisecow.sh

# Expose the port
EXPOSE 4499

# Run the wisecow script
CMD ["/app/wisecow.sh"]