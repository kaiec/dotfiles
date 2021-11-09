#!/usr/bin/env python3
import subprocess
import re
import argparse

MULTI_SPACE = re.compile("[ ]+")

def execute(command):
    process = subprocess.Popen(command.split(" "), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()
    if stderr and stderr.strip():
        print(stderr)
    stdout = stdout.decode("UTF-8")
    return stdout



class WindowManager():
    def __init__(self):
        self.windows = self._get_windows()
        self.active = self._get_active_window()

    def _get_active_window(self):
        output = execute("xdotool getactivewindow")
        dec_id = int(output.strip())
        return self.windows[dec_id]

    def _get_windows(self):
        output = execute("wmctrl -l -G -x -p")
        output = MULTI_SPACE.sub(" ", output)
        windows = {}
        for line in output.split("\n"):
            elements = line.split(" ")
            if not len(elements) >= 9:
                continue
            window = Window(self,
                    int(elements[0], 16),   # ID 
                    int(elements[1]),       # Desktop
                    int(elements[2]),       # PID
                    int(elements[3]),       # x-offset
                    int(elements[4]),       # y-offset
                    int(elements[5]),       # width
                    int(elements[6]),       # height
                    elements[7],            # wm class
                    elements[8],            # client
                    " ".join(elements[9:])  # name
                    )
            windows[window.id] = window
        return windows



class Vector2():
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __sub__(self, other):
        return Vector2(self.x - other.x, self.y - other.y)

    def __add__(self, other):
        return Vector2(self.x + other.x, self.y + other.y)

    def squared_distance_to(self, other):
        d = other - self
        return d.x * d.x + d.y * d.y
        


class Window():
    def __init__(self, window_manager, id, desktop, pid, x_offset, y_offset, width, height, wm_class, client, name):
        self.window_manager = window_manager
        self.id = id
        self.desktop = desktop
        self.pid = pid
        self.left = x_offset
        self.top = y_offset
        self.width = width
        self.height = height
        self.wm_class = wm_class
        self.client = client
        self.name = name

    @property
    def centerx(self):
        return self.left + self.width//2

    @property
    def centery(self):
        return self.top + self.height//2

    @property
    def right(self):
        return self.left + self.width

    @property
    def bottom(self):
        return self.top + self.height

    @property
    def centertop(self):
        return Vector2(self.centerx, self.top)

    @property
    def centerbottom(self):
        return Vector2(self.centerx, self.bottom)

    @property
    def centerleft(self):
        return Vector2(self.left, self.centery)

    @property
    def centerright(self):
        return Vector2(self.right, self.centery)

    def x_within(self, other):
        return other.left < self.centerx < other.right
        
    def is_above(self, other):
        return other.top > self.top

    def is_below(self, other):
        return other.top < self.top

    def is_left_of(self, other):
        return other.left > self.left

    def is_right_of(self, other):
        return other.right < self.right

    def y_distance(self, other):
        return other.centery - self.centery
        
    def activate(self):
        execute(f"wmctrl -i -a {self.id}")
        self.window_manager.active = self

    def next_window(self, anchor_attrib, point_attribs, check_method):
        closest = None
        closest_distance = 9999999
        for window in self.window_manager.windows.values():
            if window == self:
                continue
            if window.desktop != self.desktop:
                continue
            if not getattr(window, check_method)(self):
                continue
            for point_attrib in point_attribs:
                distance = getattr(window, point_attrib).squared_distance_to(getattr(self, anchor_attrib))
                if distance < closest_distance:
                    closest = window
                    closest_distance = distance
        return closest

    def next_up(self):
        window = self.next_window("centertop", ["centerbottom", "centertop"], "is_above")
        return window

    def next_down(self):
        window = self.next_window("centerbottom", ["centerbottom", "centertop"], "is_below")
        return window

    def next_left(self):
        window = self.next_window("centerleft", ["centerleft", "centerright"], "is_left_of")
        return window

    def next_right(self):
        window = self.next_window("centerright", ["centerleft", "centerright"], "is_right_of")
        return window

            
wm = WindowManager()
parser = argparse.ArgumentParser()
parser.add_argument("--focus-up", action="store_true", help="Focus the window above the current active window.")
parser.add_argument("--focus-down", action="store_true", help="Focus the window below the current active window.")
parser.add_argument("--focus-left", action="store_true", help="Focus the window left of the current active window.")
parser.add_argument("--focus-right", action="store_true", help="Focus the window right of the current active window.")
args = parser.parse_args()
if args.focus_up:
    wm.active.next_up().activate()
if args.focus_down:
    wm.active.next_down().activate()
if args.focus_left:
    wm.active.next_left().activate()
if args.focus_right:
    wm.active.next_right().activate()
