FROM node:12-alpine as builder
RUN mkdir -p /usr
WORKDIR /usr
COPY ./package.json /usr
RUN npm install --silent
COPY . /usr
RUN npm run-script update-version --release_version=$(cat release-version.txt)

FROM node:12-alpine
WORKDIR /usr
COPY --from=builder /usr /usr

#RUN npm run lint
#EXPOSE 9006
ENTRYPOINT ["npm", "run"]
CMD ["start"]