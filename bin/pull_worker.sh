#!/bin/bash

TAG=$(grep -e 'mumuki/mumuki-cspec-worker:[0-9]*\.[0-9]*' ./lib/c_runner.rb -o | tail -n 1)

echo "Pulling $TAG..."
docker pull $TAG
