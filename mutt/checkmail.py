#!/usr/bin/env python3
# vim: set fileencoding=utf-8 sw=4 expandtab ts=4 :

# -----------------------------------------------------------------------------
#
# Perform various checks on mail.
# Kai Eckert <http://github.com/kaiec>
#
# Based on the script "Check for attachments in mail"
# by Florian Pose <florian ät pose.nrw>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software Foundation,
# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA
#
# -----------------------------------------------------------------------------

import sys
import email
import re
import subprocess


orig_msg = sys.stdin.read()
msg = email.message_from_string(orig_msg)


def rofi_ask(question, answers):
    out = subprocess.run(["rofi", "-dmenu", "-p", question], stdout=subprocess.PIPE, input="\n".join(answers).encode("utf-8"))
    return out.stdout.decode("utf-8").strip()


def count_attachments(msg):
    """
    Counts all attachments besides the first plain text (content) and pgp signatures.
    """
    attach_count = 0
    text_found = False
    for part in msg.walk():
        if part.is_multipart():
            continue  # dive deeper
        if part.get_content_type() == 'text/plain':
            if text_found:
                attach_count += 1
            else:
                text_found = True
        elif part.get_content_type() != 'application/pgp-signature':
            attach_count += 1
    return attach_count


def check_text(msg, regex):
    """
    Checks if given regex can be found in one of the text parts of the mail.
    """
    for part in msg.walk():
        if part.is_multipart():
            continue  # dive deeper
        if part.get_content_type() == 'text/plain':
            content = part.get_payload(decode=True)
            charset = part.get_param('charset')
            if charset:
                content = content.decode(charset)
            else:
                content = content.decode("utf-8")
            if regex.search(content):
                return True


def has_no_attachment_header(msg):
    """
    Checks, if the X-Attached header is set, as proposed for an override here:
    https://gitlab.com/muttmua/mutt/wikis/ConfigTricks/CheckAttach
    """
    hdr = 'X-Attached'
    return hdr in msg and msg[hdr].lower() == 'none'


def is_recipient(recipient, msg):
    """
    Checks, if the given recipient is a recipient of this mail.
    """
    return recipient in msg["To"] or recipient in msg["Cc"] or recipient in msg["Bcc"]


#
# Check for forgotten attachments
#
trigger = u'attach|anhang|anh\.|anhänge|anbei|hängt|haeng'
regex = re.compile(trigger, re.IGNORECASE)

if not has_no_attachment_header(msg) and check_text(msg, regex) and count_attachments(msg) == 0:
    cont = rofi_ask("Attachment vergessen?", ["ja", "nein"])
    if cont == "ja":
        sys.exit(9)


#
# Check for "dangerous" recipients
#
lists = [
            "hdm-alle@hdm-stuttgart.de",
            "hdm-professoren@hdm-stuttgart.de",
            "hdm-beschaeftigte@hdm-stuttgart.de",
            "f3-professoren@hdm-stuttgart.de",
        ]

for recipient in lists:
    if is_recipient(recipient, msg):
        cont = rofi_ask("Wirklich an {} senden?".format(recipient), ["ja", "nein"])
        if cont == "nein":
            sys.exit(9)



sendmail = subprocess.Popen(sys.argv[1:], stdin=subprocess.PIPE)
sendmail.communicate(input=orig_msg.encode("utf-8"))
sys.exit(sendmail.returncode)

# ----------------------------------------------------------------------------
