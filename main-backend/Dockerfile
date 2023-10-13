FROM node:16-alpine
WORKDIR /app
ENV NODE_ENV=production
COPY ./main-backend/package*.json ./
RUN npm install
COPY ./main-backend .
EXPOSE 8080
RUN npm run build
CMD ["node", "dist/main.js"]