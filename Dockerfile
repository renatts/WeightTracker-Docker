# ===================================> Build image
FROM node:14-alpine
COPY . /bootcamp-app
WORKDIR /bootcamp-app
# ARG port=8080
# ENV port=$port
EXPOSE 8080

RUN npm install

CMD npm run initdb
CMD npm run dev
