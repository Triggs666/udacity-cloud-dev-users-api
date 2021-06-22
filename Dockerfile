# Use NodeJS base image
FROM node:13

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Define typescript config by copying ts*.json
COPY ts*.json ./

# Define environment variables
# secure variables in file
COPY set_env_prod.sh ./

# secret variables as argument
ARG POSTGRES_USERNAME=default_value
ENV POSTGRES_USERNAME=${POSTGRES_USERNAME}
ARG POSTGRES_PASSWORD=default_value
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ARG POSTGRES_DB=default_value
ENV POSTGRES_DB=${POSTGRES_DB}
ARG JWT_SECRET=default_value
ENV JWT_SECRET=${JWT_SECRET}

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Bind the port that the image will run on
EXPOSE 8082

# Define the Docker image's behavior at runtime
CMD ["npm", "run", "prod"]
