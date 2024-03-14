FROM ghcr.io/cirruslabs/flutter:3.19.3 as build

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter doctor
RUN flutter build web

FROM nginx:1.25
COPY --from=build /app/build/web /usr/share/nginx/html