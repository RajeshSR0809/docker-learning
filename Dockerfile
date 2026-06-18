

# =========================================================
# STAGE 1: The Builder 
# =========================================================
FROM node:24-alpine as builder

WORKDIR /usr/src/app

COPY package*.json .

RUN npm ci

COPY . .

RUN ls -l

#some build step for TS based node application
RUN npm prune --omit=dev



# =========================================================
# STAGE 2: The Runner 
# =========================================================
FROM node:24-alpine as runner

ENV NODE_ENV=PRODUCTION
WORKDIR /usr/src/app

COPY package*.json .
COPY --from=builder /usr/src/app/node_modules ./node_modules
# may need to copy the build or dist folder for TS based node project
COPY --from=builder /usr/src/app/src ./src 


RUN ls -l

USER node
EXPOSE 3000

CMD [ "node", "src/index.js" ]



# this approach reduce the image size from 1.27GB to 168.96MB