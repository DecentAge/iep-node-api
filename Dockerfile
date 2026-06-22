FROM node:22-alpine AS builder
WORKDIR /usr
COPY ./package.json ./package-lock.json /usr/
RUN npm ci --silent
COPY . /usr
RUN npm run-script update-version --release_version=$(cat release-version.txt)

FROM node:22-alpine
WORKDIR /usr
COPY --from=builder /usr /usr

EXPOSE 9005
ENTRYPOINT ["npm", "run"]
CMD ["start"]
