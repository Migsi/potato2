
#docker build -t potato .

docker buildx build \
  --platform linux/amd64 \
  -f Dockerfile.amd64 \
  -t rkugler/potato:amd64 \
  . \
  --load # use local registry instead of push to Dockerhub

docker buildx build \
  --platform linux/i386 \
  -f Dockerfile.i386 \
  -t rkugler/potato:i386 \
  . \
  --load # use local registry instead of push to Dockerhub
