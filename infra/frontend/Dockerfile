FROM node:20.17.0

WORKDIR /usr/src/app

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN yarn install

COPY . /usr/src/app

CMD ["yarn", "dev", "-p", "4000"]
