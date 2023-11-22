# Containerd shims:
# - https://github.com/containerd/runwasi
# - https://github.com/deislabs/containerd-wasm-shims

# FROM ghcr.io/webassembly/wasi-sdk as build
# WORKDIR /build
# COPY hello.c .
# RUN clang-15 hello.c -o hello.wasm

# FROM scratch
# COPY --from=build /build/hello.wasm /opt/hello.wasm
# ENTRYPOINT [ "/opt/hello.wasm" ]

FROM scratch
COPY hello.wasm /opt/hello.wasm
ENTRYPOINT [ "/opt/hello.wasm" ]
