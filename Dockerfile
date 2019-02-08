FROM node:9.11.2-alpine AS BUILD
ADD . dapx-core-react-demo/
RUN npm config set unsafe-perm true
WORKDIR dapx-core-react-demo
RUN npm install -g npm@6.2.0
RUN npm install -g yarn@1.7.0
RUN npm install gulp@3.9.1 -g

RUN yarn install
RUN pwd
RUN ls -lsa
RUN ls -lsa dapx-demo
WORKDIR dapx-demo/dapx-demo
#CMD ["sleep", "9000000"]
RUN export PUBLIC_URL=https://api.ci.bluegrizzly.ie
RUN yarn build-semantic
RUN yarn build

FROM nginx
COPY --from=BUILD /dapx-core-react-demo/dapx-demo/dapx-demo/build /usr/share/nginx/html
EXPOSE 80
