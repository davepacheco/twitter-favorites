#!/bin/bash

#
# favorites.sh: emit CSV file of Twitter favorites
#
set -o pipefail

arg0="favorites.sh"
MAXFAVS=10000

function fail
{
	echo "$arg0: $@" >&2
	exit 1
}

function main
{
	if [[ ! -n "$TWITTER_CONSUMER_KEY" ]]; then
		fail "TWITTER_CONSUMER_KEY must be set in the environment"
	fi

	if [[ ! -n "$TWITTER_CONSUMER_SECRET" ]]; then
		fail "TWITTER_CONSUMER_SECRET must be set in the environment"
	fi

	echo "Authorizing the app to access your Twitter account." >&2
	echo "Follow the instructions below." >&2

	if ! twurl authorize \
	    --consumer-key "$TWITTER_CONSUMER_KEY" \
	    --consumer-secret "$TWITTER_CONSUMER_SECRET"; then
		fail "failed to authorize; aborting"
	fi

	cp ~/.twurlrc ~/.trc || fail "failed to copy auth file"
	t favorites -n "$MAXFAVS" -c
}

main "$@"
