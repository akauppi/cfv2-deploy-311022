#
# Makefile
#
#   Docker Compose does not automatically rebuild images if the underlying Dockerfile changes.
#	This Makefile avoids surprises.
#
all:
	false

_DC=docker compose

# Stamps for building Docker images, if their recipes change.
#
_FIREBASE_TOOLS_DC=tmp/.stamp.firebase-tools

# A building is needed for all the _final_ DC targets that depend on the external Dockerfile.
$(_FIREBASE_TOOLS_DC): _needs_dc ./dc.firebase-tools/Dockerfile
	$(_DC) build deploy-auth deploy-backend
	touch $@

refresh-dc: $(_FIREBASE_TOOLS_DC)

_needs_dc:
	@docker --version > /dev/null || ( >&2 echo "PROBLEM: 🐋 Not seeing Docker around, please launch it.\n"; false )

#---
echo:
	@echo A

.PHONY: all \
  refresh-dc \
  _needs_dc \
  echo
