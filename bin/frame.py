#!/usr/bin/env python3
import fileinput
elements = """\
╭─╮
│ │
╰─╯
""".splitlines()

def reflow(lines, max_length):
    result = []
    remaining = []
    right_lines = []
    for line in lines:
        if not line.startswith(" "):
            remaining.extend(line.rstrip().split(" "))
        else:
            right_lines.append(line[-max_length:])

    while len(remaining) > 0:
        line = []
        length = 0
        tmp = remaining.copy()
        remaining.clear()
        full=False
        for word in tmp:
            if not full and length + len(word) < max_length:
                line.append(word)
                length += len(word) + 1
            else:
                full=True
                remaining.append(word)
        result.append(" ".join(line))
    result.extend(right_lines)
    return result



def get_frame(lines, xpadding=1, ypadding=0, limit=100):
    lines = reflow(lines, limit)
    max_length = 0
    for line in lines:
        max_length = len(line) if len(line)>max_length else max_length 
    result = []
    result.append(f"{elements[0][0]}{elements[0][1]*(max_length+2*xpadding)}{elements[0][2]}")
    for _ in range(ypadding):
        result.append(f"{elements[1][0]}{' '*(max_length+2*xpadding)}{elements[1][2]}")
    for line in lines:
        space = " " * (max_length - len(line))
        result.append(f"{elements[1][0]}{' '*xpadding}{line}{space}{' '*xpadding}{elements[1][2]}")
    for _ in range(ypadding):
        result.append(f"{elements[1][0]}{' '*(max_length+2*xpadding)}{elements[1][2]}")
    result.append(f"{elements[2][0]}{elements[2][1]*(max_length+2*xpadding)}{elements[2][2]}")
    return result

if __name__=="__main__":
    lines = []
    for line in fileinput.input():
        line = line.strip("\n").replace("\t", "    ")
        lines.append(line)

    for line in get_frame(lines, limit=40):
        print(line)
