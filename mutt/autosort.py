#!/usr/bin/env python3
import email
import email.policy
import notmuch
from notmuch import Query, Database
import sys

db = Database('/home/kai/Maildir', create=False)
folder = "/home/kai/Maildir/hdm/Inbox/"
cutoff = len(folder)

with open("/home/kai/fwdtest", "rb") as fp:
    msg = email.message_from_binary_file(fp, policy=email.policy.default)
    mid = msg["Message-Id"]
    msgs = list(Query(db, f'id:{mid[1:-1]}').search_messages())
    if len(msgs) > 0:
        m = msgs[0]
        tags = list(m.get_tags())
        # for t in ["draft", "flagged", "passed", "replied", "unread", "attachment", "signed", "encrypted"]:
        #    if t in tags:
        #        tags.remove(t)
        for t in tags:
            if t.startswith("?"):
                print(f"save-hook . '={t[1:]}'")
                sys.exit(0)
        print(f"save-hook . '='")

