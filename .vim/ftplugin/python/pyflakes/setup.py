#!/usr/bin/python
# (c) 2005-2009 Divmod, Inc.  See LICENSE file for details

from setuptools import setup

setup(
    name="pyflakes",
    license="MIT",
    version="0.3.0",
    description="passive checker of Python programs",
    author="Phil Frost",
    maintainer="Moe Aboulkheir",
    maintainer_email="moe@divmod.com",
    url="http://www.divmod.org/trac/wiki/DivmodPyflakes",
    packages=["pyflakes", "pyflakes.scripts", "pyflakes.test"],
    scripts=["bin/pyflakes"],
    long_description="""Pyflakes is program to analyze Python programs and detect various errors. It
works by parsing the source file, not importing it, so it is safe to use on
modules with side effects. It's also much faster.""")
