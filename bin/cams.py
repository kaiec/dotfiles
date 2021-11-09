#!/usr/bin/env python3
import subprocess

ffmpeg2v4l = {}


def out(command):
    result = subprocess.run(command.split(" "), stdout=subprocess.PIPE)
    return result.stdout.decode("utf-8")

def err(command):
    result = subprocess.run(command.split(" "), stderr=subprocess.PIPE)
    return result.stderr.decode("utf-8")

def get_cameras():
    output = out("v4l2-ctl --list-devices")
    cameras = []
    camera = None
    for line in output.split("\n"):
        if not line.startswith("\t"):
            if not line.strip():
                continue
            name = line[:-1]
            if name:
                cameras.append(name)
    return cameras

def get_devices(camera):
    output = out("v4l2-ctl --list-devices")
    devices = []
    line_camera = None
    for line in output.split("\n"):
        if not line.startswith("\t"):
            if not line.strip():
                continue
            name = line[:-1]
            line_camera = name
        elif "/dev/video" in line:
            if line_camera == camera:
                device = line.strip()
                devices.append(device)
    return devices

def get_codecs(device):    
    output = err(f"ffmpeg -f v4l2 -list_formats all -i {device}")
    codecs = []
    for line in output.split("\n"):
        if not "Compressed" in line:
            continue
        parts = line.split(":")
        codec = parts[1].strip()
        codec_v4l = parts[2].strip()
        ffmpeg2v4l[codec] = codec_v4l
        codecs.append(codec)
    return codecs

def get_max_resolution(device, codec):
    output = err(f"ffmpeg -f v4l2 -list_formats all -i {device}")
    codecs = {}
    max_w = 0
    max_h = 0
    for line in output.split("\n"):
        if not "Compressed" in line:
            continue
        parts = line.split(":")
        line_codec = parts[1].strip()
        if line_codec == codec: 
            resolutions = parts[-1].strip()
            for res in resolutions.split(" "):
                w, h = res.strip().split("x")
                w = int(w)
                h = int(h)
                if w > max_w:
                    max_w = w
                    max_h = h
    return max_w, max_h



def get_max_framerate(device, codec, width, height):
    try:
        v4l_codec = ffmpeg2v4l[codec]
    except:
        print("Codec not found:", codec, device)
        return 0
    output = out(f"v4l2-ctl --list-formats-ext -d {device}")
    line_codec = None
    line_width = None
    line_height = None
    max_fps = 0
    for line in output.split("\n"):
        if "[" in line:
            line_codec = line.split("(")[1].split(",")[0].split(")")[0]
        elif "Size" in line:
            line_width, line_height = line.strip().split(" ")[-1].split("x")
            line_width = int(line_width)
            line_height = int(line_height)
        elif "fps" in line:
            if v4l_codec == line_codec and width == line_width:
                fps = int(line.split("(")[1].split(".")[0].strip())
                if fps > max_fps:
                    max_fps = fps

    return max_fps

def get_best_device_and_codec(camera):
    h264 = None
    mjpeg = None
    for dev in get_devices(camera):
        for codec in get_codecs(dev):
            if codec == "h264":
                h264 = dev
            elif codec == "mjpeg":
                mjpeg = dev
    if h264:
        return h264, "h264"
    else:
        return mjpeg, "mjpeg"

for cam in get_cameras():
    dev, codec = get_best_device_and_codec(cam)
    if dev==None:
        continue
    res = get_max_resolution(dev, codec)
    fps = get_max_framerate(dev, codec, *res)
    print(dev, codec, "{}x{}".format(*res), fps)
