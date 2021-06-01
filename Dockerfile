FROM node:14
RUN mkdir -p /usr
WORKDIR /usr
RUN apt-get update && apt-get install -y zip
COPY ./package.json /usr
RUN npm install --silent
COPY . /usr
RUN npm run-script update-version --release_version=$(cat release-version.txt)
RUN mkdir -p /ust/build
RUN zip -r /usr/build/iep-node-api-ui.zip ./dist
COPY --from=builder /usr/build /build
#RUN npm run lint
#EXPOSE 9006
ENTRYPOINT ["npm", "run"]
CMD ["start"]