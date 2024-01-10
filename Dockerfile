# syntax=docker/dockerfile:1

FROM node:alpine as build

ARG OLLAMA_API_BASE_URL='/ollama/api'
RUN echo $OLLAMA_API_BASE_URL

ENV PUBLIC_API_BASE_URL $OLLAMA_API_BASE_URL
RUN echo $PUBLIC_API_BASE_URL

WORKDIR /app

COPY package.json package-lock.json ./ 
RUN npm ci

COPY . .
RUN npm run build

CMD [ "npm", "run", "dev"]
