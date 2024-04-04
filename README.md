# StreamPod VMS CE
 
[![GitHub license](https://img.shields.io/badge/License-MIT%20v3-blue.svg)](https://raw.githubusercontent.com/blowleaf/streampodvms/main/LICENSE)

StreamPod VMS is a modern, fully featured open core video management system. It is developed to meet the needs of modern web platforms for viewing and sharing media. It can be used to build a small to medium video and media portal within minutes. 

## Features

- **Complete control over your data**: Self-Host. 
- **Support for multiple publishing workflows**: public, private, unlisted and custom
- **Modern technologies**: Django/Python/Celery, React.
- **Multiple media types support**: video, audio,  image, pdf
- **Multiple media classification options**: categories, tags and custom
- **Multiple media sharing options**: social media share, videos embed code generation
- **Easy media searching**: enriched with live search functionality
- **Playlists for audio and video content**: create playlists, add and reorder content
- **Responsive design**: including light and dark themes
- **Advanced users management**: allow self registration, invite only, closed.
- **Configurable actions**: allow download, add comments, add likes, dislikes, report media
- **Configuration options**: change logos, fonts, styling, add more pages
- **Enhanced video player**: customized video.js player with multiple resolution and playback speed options
- **Multiple transcoding profiles**: Defaults for multiple dimensions (240p, 360p, 480p, 720p, 1080p) and multiple profiles (h264, h265, vp9)
- **Adaptive video streaming**: possible through HLS protocol
- **Subtitles/CC**: support for multilingual subtitle files
- **Scalable transcoding**: transcoding through priorities. Experimental support for remote workers
- **Chunked file uploads**: for pausable/resumable upload of content
- **REST API**: Documented through Swagger
- **Plugins**: Extended usecases with the ability to plugin solutions provided on StreamPod EE.

## Installation / Maintanance

The recommended way to run a local instance of StreamPod VMS is through Docker Compose, a simple ```docker compose up``` command should deploy the stack. There are other methods available through installing it on a server via an automation script that installs and configures all needed services but due to the demanding nature of video streaming, containers and orchestration are more suitable deplyoment targets. 

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


