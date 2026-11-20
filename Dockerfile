FROM node:22.23.5-alpine3.24 AS builder
WORKDIR /usr
RUN npm install -g npm@11.21.3 && npm cache clean --force
COPY ./package.json ./package-lock.json /usr/
RUN npm ci --silent
COPY . /usr
RUN npm run-script update-version --release_version=$(cat release-version.txt)

FROM node:22.23.5-alpine3.24
WORKDIR /usr
RUN npm install -g npm@11.21.3 && npm cache clean --force
COPY --from=builder /usr /usr

EXPOSE 9005
ENTRYPOINT ["npm", "run"]
CMD ["start"]
