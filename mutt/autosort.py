#!/usr/bin/env python3
import email
import email.policy
import notmuch
from notmuch import Query, Database

db = Database('/home/kai/Maildir', create=False)
folder = "/home/kai/Maildir/hdm/Inbox/"
cutoff = len(folder)

with open("/home/kai/fwdtest", "rb") as fp:
    msg = email.message_from_binary_file(fp, policy=email.policy.default)
    replyto = msg["In-Reply-To"]
    if replyto:
        rmsgs = list(Query(db, f'id:{replyto[1:-1]}').search_messages())
        if len(rmsgs) > 0:
            rmsg = rmsgs[0]
            path = rmsg.get_filename()[cutoff:]
            path = path[:path.index('/')]
            print(f"save-hook . '={path}'")
            exit(0)
    else:
        print(f"save-hook . '='")
