#!/usr/bin/env python3

import os

with open(os.path.expanduser("~/.mailboxes"), "r") as mbfile:
    print(" ".join(["+{}".format(m.rstrip("\n")) for m in mbfile]))
