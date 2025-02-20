ARG NODE_VERSION=22
ARG DEBIAN_VERSION=bookworm
ARG APP_NAME=todo-backend


FROM node:${NODE_VERSION}-${DEBIAN_VERSION} AS builder
ARG APP_NAME

WORKDIR /srv/${APP_NAME}

COPY package.json package-lock.json ./

RUN --mount=type=cache,target=/root/.npm \
	set -eux; \
	npm ci

COPY src ./src
COPY tsconfig.json ./

ENV NODE_ENV=production

RUN set -eux; \
	npm run build


FROM debian:${DEBIAN_VERSION}-slim AS runner
ARG APP_NAME

WORKDIR /srv/${APP_NAME}

RUN set -eux; \
	groupadd --gid 1000 node; \
	useradd --uid 1000 --gid node --shell /bin/bash --create-home node; \
	chown node:node ./

COPY --from=builder /usr/local/bin/node /usr/local/bin/

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
	ca-certificates \
	libstdc++6 \
	; \
	rm -rf /var/lib/apt/lists/*

USER node

COPY --from=builder --chown=node:node /srv/${APP_NAME}/dist ./dist
COPY --from=builder --chown=node:node /srv/${APP_NAME}/node_modules ./node_modules
COPY --chown=node:node public ./public
COPY --chown=node:node package.json package-lock.json ./

ENV NODE_ENV=production
ENV PORT=3000

COPY --from=builder /usr/local/bin/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["node", "dist/server"]


FROM builder AS dev
