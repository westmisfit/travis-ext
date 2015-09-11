#!/usr/bin/env python

from __future__ import print_function

try:
    from setuptools import setup
    extra = dict(test_suite="tests.test.suite", include_package_data=True)
except ImportError:
    from distutils.core import setup
    extra = {}

import sys

from travis_ext import __version__

if sys.version_info <= (2, 7, 3):
    error = "ERROR: travis_ext requires Python Version 2.7.3 or above...exiting."
    print(error, file=sys.stderr)
    sys.exit(1)

def readme():
    with open("README.txt") as f:
        return f.read()

def requirements():
    with open("requirements.txt") as f:
        return f.readlines()

setup(name = "travis_ext",
      version = __version__,
      install_requires=requirements(),
      description = "travis_ext",
      long_description = readme(),
      author = "West Wang",
      author_email = "west@misfit.com",
      scripts = ["bin/travis-ext"],
      url = "https://github.com/westmisfit/travis-ext",
      packages = ["travis_ext"],
      package_data = {
        'travis_ext': ['*.*', '**/*.*', '**/.travis.yml', '**/vars'],
      },
      license = "MIT",
      platforms = "Posix; MacOS X; Windows",
      classifiers = ["Development Status :: 5 - Production/Stable",
                     "Intended Audience :: Developers",
                     "License :: OSI Approved :: MIT License",
                     "Operating System :: OS Independent",
                     "Topic :: Internet",
                     "Programming Language :: Python :: 2",
                     "Programming Language :: Python :: 2.6",
                     "Programming Language :: Python :: 2.7",
                     "Programming Language :: Python :: 3",
                     "Programming Language :: Python :: 3.3",
                     "Programming Language :: Python :: 3.4"],
      **extra
      )
