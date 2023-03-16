set -ex

# Setup container images.  Create separate

# Create builder containers
for arch in ppc64le s390x; do #ppc64le s390x aarch64; do
    mkdir -p tree/$arch/
    podman build --arch $arch -f Dockerfile -t cross-toolchain-$arch-builder:f37
done

podman pull --arch amd64 registry.fedoraproject.org/fedora:37

podman build  -f Dockerfile.x86_64 -t cross-toolchain:f37

podman build -f Dockerfile.test -t cross-toolchain-test:f37
