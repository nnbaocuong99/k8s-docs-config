#!/bin/bash
echo "=============================================="
echo "Checking Helm chart version and tag version..."

CHART_VER=$(docker run --rm -v "${PWD}":/workspace -w /workspace mikefarah/yq eval .version Chart.yaml)

if [ "$CHART_VER" = "$1" ]; then
  echo "Chart version check OK. Continue..."
  echo "=============================================="
  exit 0
else
  echo "Chart version and tag version mismatch. Please correct it and try again."
  echo "=============================================="
  exit 1
fi
