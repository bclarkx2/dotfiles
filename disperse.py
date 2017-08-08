
###############################################################################
# Imports                                                                     #
###############################################################################

import shutil
import json
import argparse


###############################################################################
# Constants                                                                   #
###############################################################################

default_disperse_filepath = "disperse.json"


###############################################################################
# Class definitions                                                           #
###############################################################################

class Target(object):
    """update target"""

    def __init__(self, attr_dict):
        super(Target, self).__init__()
        self.__dict__.update(attr_dict)

    def disperse(self):
        raise NotImplementedError("subclass must define dispersal")

    def force_disperse(self):
        raise NotImplementedError("subclass must define dispersal")

    @staticmethod
    def of(attr_dict):
        target_type = attr_dict.get("type", "dir")
        if target_type == "dir":
            return DirTarget(attr_dict)
        else:
            return DirTarget(attr_dict)


class DirTarget(Target):

    def __init__(self, attr_dict):
        super(Target, self).__init__()

    def disperse(self):
        

###############################################################################
# Enum types                                                                  #
###############################################################################



###############################################################################
# Helper functions                                                            #
###############################################################################

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-f", "--disperse-filepath")
    return parser.parse_args()


def read_json_file(filepath):
    with open(filepath, 'r') as json_file:
        return json.load(json_file)


###############################################################################
# Main script                                                                 #
###############################################################################

def main():
    args = get_args()

    if args.disperse_filepath:
        disperse_filepath = args.disperse_filepath
    else:
        disperse_filepath = default_disperse_filepath

    disperse_info = read_json_file(disperse_filepath)

    # get enabled targets
    targets = [Target.of(target_json) for target_json in disperse_info if target_json['enabled']]



if __name__ == '__main__':
    main()
