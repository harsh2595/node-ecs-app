# Use Node.js LTS version
FROM node:18

# Set working directory inside container
WORKDIR /app

# Copy only package.json & package-lock.json first (to cache deps layer)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the source code
COPY . .

# Expose app port
EXPOSE 3000

# Command to run app
CMD ["npm", "start"]
