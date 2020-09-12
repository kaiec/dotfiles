#!/usr/bin/env python3
# ---
# jupyter:
#   jupytext:
#     formats: py:percent,ipynb
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.5.1
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %%
from notmuch import Database, Query
import email
import email.utils
from collections import Counter

# %%
db = Database('/home/kai/Maildir/', create=False)
msgs = list(Query(db, 'date:2019-08-01..').search_messages())

print(f"Anzahl Nachrichten: {len(msgs)}")

# %%
data = []
for msg in msgs:
    filename = msg.get_filename()
    path_elements = filename.split('/')
    mailbox = path_elements[4]
    folder = path_elements[6]
    if folder in ['cur', 'tmp', 'new']:
        folder = 'inbox'
    if mailbox != 'hdm':
        continue
    if folder in ['inbox', 'trash', 'scifoo', 'inetbib', 'hdm-alle', 'moodle', 'Trash', 'bahn', 'foerderung']:
        continue
    with open(filename, 'rb') as fp:
        emsg = email.message_from_binary_file(fp)
        froms = emsg.get_all('from', [])
        tos = emsg.get_all('to', [])
        ccs = emsg.get_all('cc', [])
        addresses = email.utils.getaddresses(froms + tos + ccs)
        addresses = [a[1].lower() for a in addresses]
        addresses = list(set(addresses))
        addresses.sort()
        data.append((addresses, folder))

# %%
addresses = Counter()
for d in data:
    for a in d[0]:
        addresses[a] += 1

# %%
print(len(data))

# %%
print(len(addresses))

# %%
addresses_filtered = [a[0] for a in addresses.items() if a[1] > 9]

# %%
print(len(addresses_filtered))

# %%
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# %%
data_dicts = []
for d in data:
    data_dict = {}
    for a in addresses_filtered:
        data_dict[a] = a in d[0]
    data_dict['folder'] = d[1]
    data_dicts.append(data_dict)

# %%
df = pd.DataFrame(data_dicts)

# %%
df

# %%
X = df.drop('folder', axis=1)
y = df['folder']
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.20)

# %%
from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier()
classifier.fit(X_train, y_train)

# %%
y_pred = classifier.predict(X_test)
from sklearn.metrics import classification_report, confusion_matrix
print(confusion_matrix(y_test, y_pred))
print(classification_report(y_test, y_pred))

# %%
from sklearn import tree
# fig=plt.figure(figsize=(20,20), dpi= 100, facecolor='w', edgecolor='k')
# tree.plot_tree(classifier, max_depth=7, class_names=classifier.classes_, feature_names=X.columns)
# pass
print(tree.export_text(classifier, feature_names=addresses_filtered))

# %%
X.columns


# %%
from joblib import dump, load
emptydict = {}
for c in X.columns:
    emptydict[c] = False
dump({"classifier": classifier, "empty": emptydict}, 'mail-classifier.joblib') 

# See foldertagger.py for the application of the model
# %%
