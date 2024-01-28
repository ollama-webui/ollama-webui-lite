# Use a Node.js base image
FROM node:lts-alpine3.19

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm ci

# Copy the rest of the application files to the working directory
COPY . .

# Expose the port on which your application will run (if different from 3000)
EXPOSE 3000

# Start the application in development mode
CMD ["npm", "run", "dev"]

