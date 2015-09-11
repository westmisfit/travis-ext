import sys
import yaml
import argparse

def detect_language(dir):
    if dir:
        path = dir + "/.travis.yml"
    else:
        path = ".travis.yml"

    with open(path, 'r') as stream:
        config = yaml.load(stream)

    return config['language']

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--dir', dest='dir', help='set dir path of the .travis.yml file')

    args = parser.parse_args()
    try:
        lang = detect_language(args.dir)
        print lang
    except Exception, err:
        sys.stderr.write('ERROR: %s\n' % str(err))
        exit(1)
