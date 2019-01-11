import subprocess
import sys
import tempfile

def main(args):
    text = sys.stdin.read()
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpfile = "{}/temp-kitty".format(tmpdir)
        with open(tmpfile, "w", encoding="utf-8") as f:
            for line in text.split("\n"):
                line = line.rstrip()
                if line != "":
                    f.write("{}\n".format(line))
        subprocess.call(["vim", "+normal G", tmpfile])

def handle_result(args, answer, target_window_id, boss):
    pass

handle_result.type_of_input = 'history'
