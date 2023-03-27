#!/bin/bash

cd charts/services/charts || exit

TOTAL_CHART=0
SUCCESS_CHART=0

if [[ $# -eq 1 ]]; then
  echo "==> Start update subcharts common library to version: $1"
fi

for d in */; do
  if [[ -d "$d" && -f "$d/Chart.yaml" ]]; then
    cd "$d" || exit
    TOTAL_CHART=$((TOTAL_CHART + 1))
    echo "=================================================="
    echo "* update Chart dependency"
    if [[ $# -eq 1 ]]; then
      docker run --rm -e TAG="$1" -v "${PWD}":/workspace -w /workspace mikefarah/yq eval '.dependencies[0].version = strenv(TAG)' -i Chart.yaml || exit
    fi
    helm dep update || exit
    SUCCESS_CHART=$((SUCCESS_CHART + 1))
    echo "* update DONE"
    cd ..
  fi
done

echo "==> Total Chart: $TOTAL_CHART"
echo "    Success    : $SUCCESS_CHART"

