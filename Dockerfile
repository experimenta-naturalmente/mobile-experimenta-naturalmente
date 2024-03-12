FROM dart:stable AS build
WORKDIR /app
COPY . .
RUN flutter pub get
RUN flutter build web

FROM node:alpine
RUN npm install -g http-server
COPY --from=build /app/build/web /web
EXPOSE 8080

CMD ["http-server", "/web"]