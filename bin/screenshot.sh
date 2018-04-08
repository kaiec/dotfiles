#!/bin/bash
# Source: https://askubuntu.com/questions/759651/how-to-copy-an-image-to-the-clipboard-from-a-file-using-command-line
TMP=/tmp/screenshot.png
function screenshotfail {
  notify-send -u low -i image "Screenshot failed."
  exit
}
# Take screenshot
notify-send -u low -i image "Select area to copy to clipboard."
scrot -s -z $TMP || screenshotfail
# Ensure it's max 600px wide
# mogrify -resize '>600x' "$TMP" || screenshotfail
# optimise the png if optipng is installed.
which optipng >/dev/null && optipng "$TMP"

# Copy to clipboard.
#
# This is what does not work for Thunderbird:
xclip -selection clipboard -t image/png <"$TMP" || screenshotfail
# But this does:
# echo "<img src='data:image/png;base64,"$(base64 -w0 "$TMP")"' />" | \
#          xclip -selection clipboard -t text/html || screenshotfail

# Remove the temp file.
rm -f "$TMP"

# Notify user.
notify-send -u low -i image "Screenshot copied to clipboard"

