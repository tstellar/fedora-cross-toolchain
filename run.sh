set -ex

for arch in aarch64 ppc64le; do
    podman build --build-arg TARGET_ARCH=$arch --build-arg HOST_ARCH=x86_64 -f Dockerfile.cross -t $arch-redhat-linux-clang:37
    podman build --build-arg TARGET_ARCH=$arch -f Dockerfile.test
done
