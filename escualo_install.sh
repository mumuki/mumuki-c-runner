#/bin/bash
REV=$1

echo "[Escualo::CSpecServer] Fetching GIT revision"
echo -n $REV > version

echo "[Escualo::CSpecServer] Pulling docker image"
docker pull mumuki/mumuki-cspec-worker