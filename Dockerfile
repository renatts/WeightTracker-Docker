# ===================================> Build image
FROM node:14-alpine
COPY . /bootcamp-app
WORKDIR /bootcamp-app
ARG port=8080

# Run-time variables
ENV port=$port

# Expose the application
EXPOSE $port

# Install dependencies
RUN npm install

CMD npm run initdb && npm run dev
