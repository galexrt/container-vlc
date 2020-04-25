# docker-vlc

[![](https://images.microbadger.com/badges/image/galexrt/vlc.svg)](https://microbadger.com/images/galexrt/vlc "Get your own image badge on microbadger.com")

[![Docker Repository on Quay.io](https://quay.io/repository/galexrt/vlc/status "Docker Repository on Quay.io")](https://quay.io/repository/galexrt/vlc)

Image available from:

* [**Quay.io**](https://quay.io/repository/galexrt/vlc)
* [**Docker Hub**](https://hub.docker.com/r/galexrt/vlc)

VLC Media Player in a Docker container.

## Usage

### Running the image

```console
docker run -d -v "$(pwd)":/data quay.io/galexrt/vlc:latest YOUR_VLC_FLAGS
```

For some simple examples, checkout the [VLC Examples](#vlc-examples) section below.

### Pulling the image

From Quay.io:

```console
docker pull quay.io/galexrt/vlc:latest
```

Or From Docker Hub:

```console
docker pull galexrt/vlc:latest
```

## VLC Examples

### HTTP based video stream (TCP)

This will start a HTTP based video stream on port `8080/tcp`.

```console
docker run -d -v "$(pwd)":/data -p 8080:8080 quay.io/galexrt/vlc:latest file:///data/your-video-file.mp4 --sout '#transcode{scodec=none}:http{mux=ffmpeg{mux=flv},dst=:8080/}'
```

Using VLC to connect to the stream on the container / server IP on port `8080/tcp` will show the video stream.

#### RTSP stream (UDP)

This will start a RTSP stream on port `8554/udp`.

```console
docker run -d -v "$(pwd)":/data -p 8554:8554/udp quay.io/galexrt/vlc:latest file:///data/your-video-file.mp4 --sout '#transcode{scodec=none}:rtp{sdp=rtsp://:8554/}'
```

### VLC `sout` References

It is worth to checkout the following VideoLAN wiki pages for more information on the structure and possibilities of the `sout` argument:

* https://wiki.videolan.org/Documentation:Streaming_HowTo/
* https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_streaming_with_samples,_multiple_files_streaming,_using_multicast_in_streaming/
