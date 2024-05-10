FROM node:21
WORKDIR /app
COPY package.json .
RUN npm install
COPY . . 
ENTRYPOINT npx vite --host 0.0.0.0