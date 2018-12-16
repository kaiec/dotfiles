#!/usr/bin/env python3

"""
Message forward script for mutt.

This script implements a message forward as it is for example implemented in
Thunderbird. This means that a new message is created that contains the
original message text inline, between markers. All attachments of the original
mail are attached to the new mail.

The script expects the full message to be forwarded as parameter. The new
message is created in a temporary directory and mutt is called with -H to
compose a new message using the generated message as draft.

The script can be called seamlessly from within Mutt, for example put this in
your muttrc to replace the default forward behaviour:

# ------
macro index f ":set wait_key=no<enter><pipe-message>cat > ~/tmpfwd<enter>!forward-mail.py -d ~/tmpfwd<enter>:set wait_key=yes<enter>"
# ------

Note that the script deletes the file that is handed over, when called with the
-d parameter.

WARNING: The script starts a second mutt instance that stores the forwarded
mail in your Sent mailbox. Be careful, if you use a mailbox format that does
not work with parallel access to a mailbox. With Maildir, so far there haven't
been any problems.

Copyright (c) 2018 Kai Eckert

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"""

import sys
import os
import email
import email.policy
import subprocess
import tempfile

msgfile = None
delete = False
if len(sys.argv) == 2:
    if not os.path.isfile(sys.argv[1]):
        print("File does not exist: {}".format(sys.argv[1]))
        sys.exit(9)
    else:
        msgfile = sys.argv[1]
elif len(sys.argv) == 3:
    if sys.argv[1] != "-d":
        print("First argument must be -d.")
        sys.exit(9)
    else:
        delete = True
        if not os.path.isfile(sys.argv[2]):
            print("File does not exist: {}".format(sys.argv[2]))
            sys.exit(9)
        else:
            msgfile = sys.argv[2]


with open(msgfile, "r") as fp:
    orig_msg = fp.read()

if delete:
    os.remove(msgfile)

old_msg = email.message_from_string(orig_msg, policy=email.policy.default)

new_msg = email.message.EmailMessage()


def add_fwd_header(text, msg, header):
    if header not in msg:
        return text
    text += "{}:{}{}\n".format(header, " " * (10 - len(header)), msg[header])
    return text


body = old_msg.get_body(["plain"])
if body:
    content = body.get_content()
else:
    body = old_msg.get_body(["html"])
    content = body.get_content()
    # TODO: Maybe extract plain text?

text = """\



-------- Forwarded Message --------
"""

for header in ["Subject", "Date", "From", "Reply-To", "To", "Cc"]:
    text = add_fwd_header(text, old_msg, header)
text += """\

{text}

------ End Forwarded Message ------
""".format(text=content)


new_msg["Subject"] = "Fwd: {}".format(old_msg["Subject"])
new_msg.set_content(text)
new_msg.make_mixed()
for part in old_msg.iter_attachments():
    new_msg.attach(part)

with tempfile.TemporaryDirectory() as tmpdir:
    filename = os.path.join(tmpdir, "mail")
    with open(filename, "wb") as fp:
        fp.write(new_msg.as_bytes())
    print("Running mutt with draft: {}".format(filename))
    # import time
    # time.sleep(60)
    subprocess.run(["mutt", "-H", filename], stdin=sys.stdin)
