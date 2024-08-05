# Use a specific Node.js version
FROM node:18 AS build

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY app/package*.json ./
RUN npm install

# Bundle app source
COPY app/ ./

# Optionally build or compile the app if needed (e.g., if using TypeScript or Babel)
# RUN npm run build

# Start from a fresh image to reduce the final image size
FROM node:18-slim

# Create app directory
WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app /usr/src/app

# Expose the port the app runs on
EXPOSE 3000

# Command to run the app
CMD [ "node", "app.js" ]
