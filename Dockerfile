# ==========================================
# STAGE 1: Build & Test Stage
# ==========================================
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package manifests and lockfiles
COPY package*.json yarn.lock ./

# Install ALL dependencies (including devDependencies needed for Jest/ESLint)
RUN if [ -f yarn.lock ]; then yarn install --frozen-lockfile; else npm ci; fi

# Copy source code
COPY . .

# Run linter and tests before building final image
RUN npm test

# Prune devDependencies to keep production node_modules clean
RUN if [ -f yarn.lock ]; then yarn install --production --ignore-scripts --prefer-offline; else npm prune --production; fi

# ==========================================
# STAGE 2: Production Runtime Stage
# ==========================================
FROM node:18-alpine AS runner

WORKDIR /app

# Set production environment
ENV NODE_ENV=production

# Create non-root user for security
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs

# Copy pruned dependencies and application files from builder stage
COPY --chown=nodejs:nodejs --from=builder /app/node_modules ./node_modules
COPY --chown=nodejs:nodejs --from=builder /app/package*.json ./
COPY --chown=nodejs:nodejs --from=builder /app/src ./src

# Switch to non-root user
USER nodejs

EXPOSE 3000

CMD ["node", "src/index.js"]