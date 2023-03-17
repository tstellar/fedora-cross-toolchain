set -ex

for arch in aarch64 ppc64le; do
    os_name=fedora
    os_version=37
    host_container=quay.io/fedora/fedora:37-x86_64
    target_container=quay.io/fedora/fedora:37-$arch
    container_name=$os_name/$arch-redhat-linux-clang:$os_version
    podman build --build-arg HOST_CONTAINER=$host_container \
                 --build-arg TARGET_CONTAINER=$target_container \
                 -f Dockerfile.cross -t $container_name
    podman build --build-arg TARGET_CONTAINER=$target_container \
                 --build-arg HOST_CONTAINER=$container_name \
                 --build-arg TARGET_ARCH=$arch \
                  -f Dockerfile.test
done
