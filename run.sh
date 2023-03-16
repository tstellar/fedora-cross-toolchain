set -ex

# Setup container images.  Create separate

# Create builder containers
for arch in ppc64le s390x; do #ppc64le s390x aarch64; do
    mkdir -p tree/$arch/
    podman build --arch $arch -f Dockerfile -t cross-toolchain-$arch-builder:f37
done

# Podman seems to ignore the platform option in FROM files in some cases and defaults to
# the arch of the last pull, so we need to pull the amd64 version here, since
# want to use an amd64 version of the image for our container build.
podman pull --arch amd64 registry.fedoraproject.org/fedora:37

podman build  -f Dockerfile.x86_64 -t cross-toolchain:f37

podman build -f Dockerfile.test -t cross-toolchain-test:f37
