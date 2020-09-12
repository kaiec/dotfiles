#!/usr/bin/env python3
import email
import email.policy
import notmuch
from notmuch import Query, Database
from joblib import dump, load
import pandas as pd
import numpy as np
import sys

db = Database('/home/kai/Maildir', create=False, mode=Database.MODE.READ_WRITE)
folder = "/home/kai/Maildir/hdm/Inbox/"
cutoff = len(folder)

msgs = list(Query(db, f'tag:/^\?.*/').search_messages())
for m in msgs:
    for t in m.get_tags():
        if t.startswith("?"):
            m.remove_tag(t)
            if len(sys.argv) > 1:
                print(f"Removed: {t} from {m}")

msgs = list(Query(db, f'folder:hdm/Inbox').search_messages())
for m in msgs:
    with open(m.get_filename(), "rb") as fp:
        msg = email.message_from_binary_file(fp, policy=email.policy.default)
        replyto = msg["In-Reply-To"]
        if replyto:
            rmsgs = list(Query(db, f'id:{replyto[1:-1]}').search_messages())
            if len(rmsgs) > 0:
                rmsg = rmsgs[0]
                path = rmsg.get_filename()[cutoff:]
                path = path[:path.index('/')]
                m.add_tag(f"?{path}")
                if len(sys.argv) > 1:
                    print(f"Tagged ?{path} for {m}")
        else:
            cdict = load('/home/kai/dotfiles/mutt/mail-classifier.joblib')
            classifier = cdict["classifier"]
            data_dict = cdict["empty"]
            froms = msg.get_all('from', [])
            tos = msg.get_all('to', [])
            ccs = msg.get_all('cc', [])
            addresses = email.utils.getaddresses(froms + tos + ccs)
            addresses = [a[1].lower() for a in addresses]
            for a in addresses:
                if a in data_dict:
                    data_dict[a] = True
            df = pd.DataFrame([data_dict])
            res = classifier.predict(df)
            if len(res)==1:
                m.add_tag(f"?{res[0]}")
                if len(sys.argv) > 1:
                    print(f"Tagged ?{res[0]} for {m}")
