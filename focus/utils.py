import os

def get_focusfile():
    "Return the path for the current users .focus file"
    return os.path.join(os.environ["HOME"], ".focus")

def get_focus_urls():
    return [url.strip() for url in get_file_lines(get_focusfile())]

def get_file_lines(filename):
    "Return all lines from a file"
    with open(filename) as file:
        return (line for line in file.readlines())
