FROM node:14
RUN mkdir -p /usr
WORKDIR /usr
RUN apt-get update && apt-get install -y zip
COPY ./package.json /usr
RUN npm install --silent
COPY . /usr
RUN npm run-script update-version --release_version=$(cat release-version.txt)
RUN mkdir -p /app/build
RUN zip -r /app/build/iep-peerexplorer-ui.zip ./dist
COPY --from=builder /app/build /build
#RUN npm run lint
#EXPOSE 9006
ENTRYPOINT ["npm", "run"]
CMD ["start"]