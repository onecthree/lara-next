# Stage 2: Production image
FROM node:20-alpine

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

WORKDIR /web

# Set environment
ENV NODE_ENV=production

# Expose default Next.js port
#EXPOSE 3000

# Start the Next.js app
CMD ["npm", "start"]
