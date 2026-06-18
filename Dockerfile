FROM node

WORKDIR /app/learndocker

COPY . ./build/

WORKDIR /app/learndocker/build
RUN npm install

CMD [ "node", "index.js" ]