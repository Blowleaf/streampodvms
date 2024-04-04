# User Documentation

## Table of Contents
- [Uploading Media](#uploading-media)
- [Downloading Media](#downloading-media)
- [Adding Captions/Subtitles](#adding-captionssubtitles)
- [Using Timestamps for Sharing](#using-timestamps-for-sharing)
- [Mentioning Users in Comments](#mentioning-users-in-comments)
- [Showing Comments in the Timebar](#showing-comments-in-the-timebar)
- [Searching Media](#searching-media)
- [Sharing Media](#sharing-media)
- [Embedding Media](#embedding-media)
- [Customizing Profile Options](#customizing-profile-options)

## Uploading Media

Uploading media is straightforward. Click the "Upload Media" button, wait for the media to upload, and then click the media to add metadata (title, description, etc.) by filling out a form.

To upload media:
1. Click the "Upload Media" button at the top-right of the screen.
2. You'll be redirected to the upload page (e.g., https://demo.StreamPod.io/upload).
3. Click the "Browse your files" button or drag and drop a file from your desktop.
4. Select the media file you want to upload and click "Open."
5. Wait for the file to finish uploading. You can pause or continue the upload if needed.
6. Wait for the media file to finish processing.
7. Click the "View media" button to open the media page.
8. Click the "EDIT MEDIA" button to add metadata and configure the poster image.
9. Fill in all the required fields and as many non-required fields as possible.

## Downloading Media

StreamPod offers a configurable option for users to make their media files available for download. Downloads are available for transcoded files and the original file.

To enable downloads:
1. Visit the media view page and choose the "EDIT MEDIA" button.
2. Select the checkbox for "Allow Downloads."

To download media:
1. Visit the media view page and click the "DOWNLOAD" button below the video player.
2. Choose the version you wish to download - a transcoded file or the original file.
3. Click "Save File" and then "OK."

## Adding Captions/Subtitles

In StreamPod, you can add subtitles/captions to your video by uploading a subtitle file in the popular .vtt format.

To add captions/subtitles:
1. Visit the "single media page" for the media you wish to add subtitles/captions to and click the "EDIT SUBTITLES" button.
2. Click the Language menu to select the correct language for your subtitles/captions file.
3. Click "Browse" to find a subtitles/captions file on your computer (if your file is not in the .vtt format, you may need to convert it).
4. Choose a .vtt subtitles/captions file from your computer.
5. Click the "Add" button to add the file to your media.

You can now watch the captions/subtitles play back in the video player and toggle display on/off by clicking the "CC" button.

## Using Timestamps for Sharing

You can use timestamps to start the video at a specific time when sharing.

To use a timestamp in the URL:
- Add the GET parameter 't' with the starting time in seconds to the video URL (e.g., https://example.com/video?t=120).
- Alternatively, use the share button to generate a URL with the timestamp at the current second the video is playing.

To use a timestamp in comments:
- Include timestamps in the format HH:MM:SS or MM:SS when posting a comment.
- Timestamps will be automatically detected and displayed as hyperlinks in the comment.

## Mentioning Users in Comments

In comments, you can mention other users by tagging them with '@'. This will open a suggestion box showing usernames, and the selection will refine as you continue typing.

Comments with mentions will contain a link to the user's page, and can be set up to send an email to the mentioned user.

## Showing Comments in the Timebar

When enabled, comments including a timestamp will be displayed in the current video's timebar as a colorful dot. You can preview the comment by hovering over the dot, and it will be displayed on top of the video when reaching the correct time.

Only comments with the correct timestamp formats (HH:MM:SS or MM:SS) will appear in the timebar.
