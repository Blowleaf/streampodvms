# StreamPod VMS CE
 
[![GitHub license](https://img.shields.io/badge/License-MIT%20v3-blue.svg)](https://raw.githubusercontent.com/blowleaf/streampodvms/main/LICENSE)

StreamPod VMS CE is a modern, fully-featured open-core video management system. It is developed to meet the needs of modern web platforms for viewing and sharing media. It can be used to build a small to medium video and media portal within minutes.

## Features

- **Complete control over your data**: Self-Hosting capabilities.
- **Support for multiple publishing workflows**: Public, private, unlisted, and custom options.
- **Modern technologies**: Leveraging Django/Python/Celery and React.
- **Multiple media types support**: Video, audio, image, and PDF.
- **Multiple media classification options**: Categories, tags, and custom classifications.
- **Multiple media sharing options**: Social media sharing and video embed code generation.
- **Easy media searching**: Enriched with live search functionality.
- **Playlists for audio and video content**: Create playlists, add and reorder content.
- **Responsive design**: Including light and dark themes.
- **Advanced user management**: Allow self-registration, invite-only, or closed access.
- **Configurable actions**: Enable download, add comments, likes, dislikes, and report media.
- **Configuration options**: Change logos, fonts, styling, and add more pages.
- **Enhanced video player**: Customized video.js player with multiple resolution and playback speed options.
- **Multiple transcoding profiles**: Defaults for various dimensions (240p, 360p, 480p, 720p, 1080p) and multiple profiles (h264, h265, vp9).
- **Adaptive video streaming**: Possible through HLS protocol.
- **Subtitles/CC**: Support for multilingual subtitle files.
- **Scalable transcoding**: Transcoding through priorities. Experimental support for remote workers.
- **Chunked file uploads**: For pausable/resumable upload of content.
- **REST API**: Documented through Swagger.
- **Plugins**: Extended use cases with the ability to integrate solutions provided on StreamPod EE.

## Installation / Maintenance

The recommended way to run a local instance of StreamPod VMS is through Docker Compose. A simple `docker compose up` command should deploy the stack. There are other methods available through installing it on a server via an automation script that installs and configures all needed services. However, due to the demanding nature of video streaming, containers and orchestration are more suitable deployment targets.

Find the related pages:

* [Single Server](docs/admins_docs.md#2-server-installation) page
* [Docker Compose](docs/admins_docs.md#3-docker-installation) page

## Configuration

Visit [Configuration](docs/admins_docs.md#5-configuration) page.


## Documentation

* [Users documentation](docs/user_docs.md) page
* [Administrators documentation](docs/admins_docs.md) page
* [Developers documentation](docs/developers_docs.md) page

## Credits

Forked from Original GitHub repo by Markos Gogoulos and Yiannis Stergiou; https://github.com/mediacms-io/mediacms


