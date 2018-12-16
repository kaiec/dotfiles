#!/usr/bin/env python3

import sys
import os
import email
import email.policy
import subprocess
import tempfile

with open(sys.argv[1], "r") as fp:
    orig_msg = fp.read()

os.remove(sys.argv[1])

old_msg = email.message_from_string(orig_msg, policy=email.policy.default)

new_msg = email.message.EmailMessage()


def add_fwd_header(text, msg, header):
    if header not in msg:
        return text
    text += "{}:{}{}\n".format(header, " " * (10 - len(header)), msg[header])
    return text


text = """\



-------- Forwarded Message --------
"""

for header in ["Subject", "Date", "From", "Reply-To", "To", "Cc"]:
    text = add_fwd_header(text, old_msg, header)
text += """\

{text}

------ End Forwarded Message ------
""".format(text=old_msg.get_body(["plain"]).get_content())


new_msg["Subject"] = "Fwd: {}".format(old_msg["Subject"])
new_msg.set_content(text)
for part in old_msg.iter_attachments():
    new_msg.add_attachment(part)

with tempfile.TemporaryDirectory() as tmpdir:
    filename = os.path.join(tmpdir, "mail")
    with open(filename, "wb") as fp:
        fp.write(new_msg.as_bytes())
    print("Running mutt with draft: {}".format(filename))
    # import time
    # time.sleep(60)
    subprocess.run(["mutt", "-H", filename], stdin=sys.stdin)
