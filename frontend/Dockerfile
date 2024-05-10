FROM node:21
WORKDIR /app
COPY package.json .
RUN npm install
COPY . . 
ENTRYPOINT npm run dev