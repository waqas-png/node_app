FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy application source code
COPY . .

# Stage 2: Create a lightweight runtime image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app /app

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]