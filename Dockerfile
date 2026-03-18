# Stage 1: Build Vite React App
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Nginx Server
FROM nginx:alpine

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Add custom config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build files
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
