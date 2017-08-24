FROM auivanov/boost:latest
LABEL maintainer="me@antonivanov.net"
LABEL description="An environment with QuantLib based on Alpine Linux."

ARG QUANTLIB_VERSION=1.10
ENV QUANTLIB_VERSION ${QUANTLIB_VERSION}

# Use openssl package for wget ssl_helper issue
RUN apk add --no-cache --virtual .build-dependencies \
    openssl \
    linux-headers \
    build-base \
    automake \
    autoconf \
    libtool \
    && wget http://downloads.sourceforge.net/project/quantlib/QuantLib/${QUANTLIB_VERSION}/QuantLib-${QUANTLIB_VERSION}.tar.gz \
    && tar xfz QuantLib-${QUANTLIB_VERSION}.tar.gz \
    && rm QuantLib-${QUANTLIB_VERSION}.tar.gz \
    && cd QuantLib-${QUANTLIB_VERSION} \
    && sh autogen.sh \
    && ./configure --prefix=/usr --disable-static --disable-examples --disable-benchmark CXXFLAGS=-O3 \
    && make -j 4 && make install && ldconfig ./ \
    && cd .. && rm -rf QuantLib-${QUANTLIB_VERSION} \
    && apk del .build-dependencies

CMD sh