FROM node:16-alpine
WORKDIR /app
COPY ./emulator/package*.json ./
RUN npm install
COPY ./emulator .
CMD ["node", "index.js"]