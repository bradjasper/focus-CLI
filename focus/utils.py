import os

def get_focusfile():
    "Return the path for the current users .focus file"
    return os.path.join(os.environ["HOME"], ".focus")

def get_file_lines(filename):
    "Return all lines from a file"
    with open(filename) as file:
        return (line.strip() for line in file.readlines())
