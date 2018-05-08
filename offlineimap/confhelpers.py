import subprocess


def mailpasswd(account):
    path = "/home/kai/.kak/%s.gpg" % account
    return subprocess.check_output(["gpg", "--quiet", "--batch",
                                    "-d", path]).strip()
