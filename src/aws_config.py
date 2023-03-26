#!/usr/bin/env python

"""
AWS Auth
"""

try: 
    from dotenv import load_dotenv
    #Add as as many imports as you would like to check for.
except ModuleNotFoundError as e:
    print("-E- Failed to import prerequisite {}. Please install prior to running this script.".format(e.name))
    exit(1)