# Use Node.js 20.18.0-bullseye as the base image
FROM node:20.18.0-bullseye

# Install pnpm globally
RUN npm install -g pnpm

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and pnpm-lock.yaml (if available) to the container
COPY package.json pnpm-lock.yaml* ./

# Install dependencies using pnpm
RUN pnpm install

# Copy the rest of the project files to the container
COPY . .

# Make sure to install bash if it's not available
RUN apt-get update && apt-get install -y bash

RUN chmod +x /usr/src/app/custom-script.sh

RUN pnpm run build


# CMD to run your script
CMD ["bash", "-c", "/usr/src/app/custom-script.sh && pnpm start"  ]

# Expose the port if needed for future applications (optional)
EXPOSE 37069
