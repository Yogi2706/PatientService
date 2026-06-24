# syntax=docker/dockerfile:1
FROM node:18-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN npm install --production=false

COPY . .
RUN npm run build || true

FROM node:18-alpine
WORKDIR /app

COPY --from=builder /app .
RUN npm prune --production

EXPOSE 3000
CMD ["npm", "start"]
