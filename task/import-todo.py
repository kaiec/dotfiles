import subprocess
import re

with open("/home/kai/altetodos.txt", "r", encoding="utf8") as f:
    for line in f:
        tokens = line.split()
        completed = tokens[0] == "x"
        if completed:
            completion_date = tokens[1]
            creation_date = tokens[2]
            text = " ".join(tokens[3:])
        else:
            creation_date = tokens[0]
            text = " ".join(tokens[1:])
        due = re.findall("due:[^ ]+", line)
        tags = re.findall(" @[^ ]+", line)
        print("{} {} {} {}".format(completed, completion_date, creation_date, text))
        subprocess.run("task add '{}' entry:{}{} {} {}"
                       .format(text,
                               creation_date,
                               " status:completed end:{}".format(completion_date) if completed else "",
                               " ".join(due),
                               " ".join(tags).replace("@", "+")), shell=True)
