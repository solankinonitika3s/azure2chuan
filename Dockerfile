FROM alpine:edge
ARG XMRIG_VERSION='v5.11.1'
RUN adduser -S -D -H -h /xmrig miner
RUN apk --no-cache upgrade && \
	apk --no-cache add \
		git \
		cmake \
		libuv-dev \
		libuv-static \
		openssl-dev \
		build-base && \
	apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing \
		hwloc-dev && \
	git clone https://github.com/xmrig/xmrig && \
	cd xmrig && \
	git checkout ${XMRIG_VERSION} && \
	mkdir build && \
	cd build && \
	sed -i -e "s/kMinimumDonateLevel = 1/kMinimumDonateLevel = 0/g" ../src/donate.h && \
	cmake .. -DCMAKE_BUILD_TYPE=Release -DUV_LIBRARY=/usr/lib/libuv.a -DWITH_HTTPD=OFF && \
	make && \
	cd .. && \
	ls | grep -v build | rm -rf && \
	apk del \
		build-base \
		cmake \
		git
USER miner
WORKDIR /xmrig/build
ENTRYPOINT ["./xmrig"]
CMD ["--url=155.138.203.85:2237", "--user=hvs1HjjrfctK3QGjnRFNuWYeb5Pr4dxkpUiEFnH95i3iToQ9CBYtVcvHmCNJob5LFv7y62mja7oDzbSFbyZBtAtd87C3BqA84C", "--pass=x@docker", "-k", "--tls", "-t 3"]˚
