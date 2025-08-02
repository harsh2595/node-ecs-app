# ----------- Build Stage -----------
FROM node:18 AS builder

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install all dependencies
RUN npm install

# Copy application source code
COPY . .

# ----------- Production Stage -----------
FROM node:18-slim

# Set working directory
WORKDIR /app

# Copy everything from builder stage
COPY --from=builder /app /app

# Install only production dependencies
RUN npm prune --production

# Expose port (match app.js PORT)
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
