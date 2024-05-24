#!/bin/bash

echo "Logging in to $HARBOR_HOST ..."
helm registry login \
  --username $HARBOR_USERNAME \
  --password $HARBOR_TOKEN \
  $HARBOR_HOST


RELEASE_NAME="$PROJECT_NAME"
CHART_PATH="oci://$HARBOR_HOST/royfuwei/$PROJECT_NAME"

if helm status "$RELEASE_NAME" > /dev/null 2>&1; then
  echo "Release $RELEASE_NAME exists. Upgrading..."
  helm uninstall "$RELEASE_NAME"
fi

echo "Release $RELEASE_NAME Installing..."
helm install "$RELEASE_NAME" "$CHART_PATH"