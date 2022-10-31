#!/bin/bash
set -euf -o pipefail

# Docker Compose doesn't automatically rebuild a container if its source 'Dockerfile' changes.
#
make refresh-dc > /dev/null

npm --prefix functions -s install --omit=optional

#---
# Create the state
#
install -d .state/configstore && \
  touch .state/.captured.sdkconfig && \
  ([ -f .state/.firebaserc ] || echo '{}' > .state/.firebaserc) && \
  docker compose run --rm --service-ports deploy-auth

if [[ ! -f .state/.captured.sdkconfig ]]; then
  >&2 echo "ERROR: Did not get '.state/.captured.sdkconfig'"
  false
fi

#---
# Backend deploy
#
[[ -d .state/configstore && -f .state/.firebaserc ]] || ( >&2 echo "INTERNAL ERROR: Missing '.state'"; false )

touch firebase-debug.log &&
  docker compose run --rm deploy-backend

#---
# Wipe clean
#rm -rf .state
