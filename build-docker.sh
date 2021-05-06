#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

docker build -t decentage/iep-node-api:latest .