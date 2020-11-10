FROM ubuntu:14.04
LABEL maintainer "Dave Larson <delarson@wustl.edu>"

# Build dependencies
RUN MANTA_VERSION=1.6.0 \
    && buildDeps=' \
        gcc \
        g++ \
        make \
        python \
        bzip2 \
        zlib1g-dev \
        curl \
        ca-certificates \
        ' \
    && runDeps=' \
        python \
        zlib1g \
        ' \
    && apt-get update -qq \
    && apt-get -y install \
        --no-install-recommends \
        $buildDeps \
    && curl -O -L https://github.com/Illumina/manta/releases/download/v$MANTA_VERSION/manta-$MANTA_VERSION.release_src.tar.bz2 \
    && tar -xjf manta-$MANTA_VERSION.release_src.tar.bz2 \
    && rm -rf manta-$MANTA_VERSION.release_src.tar.bz2 \
    && mkdir build \
    && cd build \
    && mkdir -p /usr/bin/manta \
    && ../manta-$MANTA_VERSION.release_src/configure --jobs=4 --prefix=/usr/bin/manta \
    && make -j 4 install \
    && cd .. \
    && rm -rf build manta-$MANTA_VERSION.release_src \
    && AUTO_ADDED_PACKAGES=`apt-mark showauto` \
    && apt-get purge -y --auto-remove $buildDeps $AUTO_ADDED_PACKAGES \
    && apt-get install -y $runDeps \
    && rm -rf /var/lib/apt/lists/*
COPY manta_helper.py /usr/bin/manta_helper.py
