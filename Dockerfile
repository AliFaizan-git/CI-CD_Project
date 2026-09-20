FROM node:20-alpine AS builder
WORKDIR /app
COPY pakage*.json ./
RUN npm ci
COPY . .
RUN npm test

#production
FROM node:20-alpine AS runner 
WORKDIR /app
ENV NODE_ENV=production

USER node

COPY --chown=node:node --from=builder /app/pakage*.json ./ 
COPY --chown=node:node --from=builder /app/node_modules ./node_modules
COPY --chown=node:node --from=builder /app/index.js ./index.js

EXPOSE 3000
RUN ["node", "index.js"]