# container-vlc

[VLC Media Player](https://www.videolan.org/vlc/) in a Container Image.

Container Image available from:

* [Quay.io](https://quay.io/repository/galexrt/vlc)
* [GHCR.io](https://github.com/users/galexrt/packages/container/package/vlc)
* [**DEPRECATED** Docker Hub](https://hub.docker.com/r/galexrt/vlc)
  * Docker Hub has been deprecated as of **06.09.2021**!

Container Image Tags:

* `main` - Latest build of the `main` branch.
* `YYYYmmdd-HHMMSS-NNN` - Latest build of the application with date of the build.

## Usage

### Running the image

```console
docker \
    run \
    --detach \
    --volume "$(pwd)":/data \
    --user $(id -u):$(id -g) \
    quay.io/galexrt/vlc:latest \
    YOUR_VLC_FLAGS
```

The `--volume "$(pwd)":/data` will mount your current working directory to `/data` inside the container for shorter paths, though this might lead to confusion. Make sure to mount the right path into the container and then use the right path for your flags.

**NOTE**: If you point to a different directory inside the container than `/data` you need to add `-e HOME=__YOUR_DIRECTORY__` to the `docker run` command.

For some simple examples, checkout the [VLC Examples](#vlc-examples) section below.

### Pulling the image

From Quay.io:

```console
docker pull quay.io/galexrt/vlc:latest
```

Or from GHCR.io:

```console
docker pull ghcr.io/galexrt/vlc:latest
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
docker \
    run \
    --detach \
    --volume "$(pwd)":/data \
    --user $(id -u):$(id -g) \
    --publish 8554:8554/udp \
    quay.io/galexrt/vlc:latest \
    file:///data/your-video-file.mp4 --sout '#transcode{scodec=none}:rtp{sdp=rtsp://:8554/}'
```

### VLC `sout` References

It is worth to checkout the following VideoLAN wiki pages for more information on the structure and possibilities of the `sout` argument:

* https://wiki.videolan.org/Documentation:Streaming_HowTo/
* https://wiki.videolan.org/Documentation:Streaming_HowTo/Advanced_streaming_with_samples,_multiple_files_streaming,_using_multicast_in_streaming/
