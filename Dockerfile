# Use a multi-stage build for smaller final image
FROM node:17-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json .
RUN npm install

# Copy application code and build
COPY . .
RUN npm run build

# Generate SSH keys
RUN apk update && \
    apk add --no-cache openssh && \
    ssh-keygen -A && \
    mkdir /app/ssh-keys && \
    mv /etc/ssh/ssh_host_rsa_key /app/ssh-keys/ && \
    mv /etc/ssh/ssh_host_dsa_key /app/ssh-keys/ && \
    mv /etc/ssh/ssh_host_ecdsa_key /app/ssh-keys/ && \
    mv /etc/ssh/ssh_host_ed25519_key /app/ssh-keys/

# Use a new stage for the final image
FROM nginx:1.19.0-alpine

# Set working directory
WORKDIR /usr/share/nginx/html

# Remove existing files
RUN rm -rf ./*

# Copy built files from the builder stage
COPY --from=builder /app/build .

# Copy SSH keys from the builder stage
COPY --from=builder /app/ssh-keys/* /etc/ssh/

# Install necessary packages
RUN apk update && \
    apk add --no-cache openssh && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    echo 'root:15963' | chpasswd && \
    rm -rf /var/cache/apk/*

# Expose port 22 for SSH
EXPOSE 22

# Start SSH service and Nginx separately
CMD service ssh start && nginx -g 'daemon off;'
