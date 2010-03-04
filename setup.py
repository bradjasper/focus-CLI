from setuptools import setup, find_packages

setup(
    name='focus',
    version="0.1",
    description="Focus",
    author="Brad Jasper",
    author_email="bjasper@gmail.com",
    url="http://bradjasper.com",
    platforms=["linux"],
    license="BSD",
    packages=find_packages(),
    scripts=["bin/focus", "bin/unfocus"]
)
