set -ex

arch=$1
base_container=$2
out_container=$3

host_container=$base_container-x86_64
target_container=$base_container-$arch

podman build --build-arg HOST_CONTAINER=$host_container \
             --build-arg TARGET_CONTAINER=$target_container \
             -f Dockerfile.cross -t $out_container
