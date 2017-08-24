# docker-quantlib
Dockerized development environment with QuantLib C++ library based on Alpine Linux.

The image contains Boost and QuantLib library binaries only. All build tools are removed.

## Build Info

Compiles shared libraries.

Boost:

- All except Boost.Python.

QuantLib:

- All except examples and benchmark.