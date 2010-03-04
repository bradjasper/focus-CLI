from setuptools import setup, find_packages

setup(
    name='focus',
    version="0.1b",
    description="Focus",
    author="Brad Jasper",
    author_email="bjasper@gmail.com",
    url="http://bradjasper.com",
    platforms=["linux"],
    license="BSD",
    packages=find_packages(),
    scripts=["bin/focus", "bin/unfocus"],
    #    entry_points={
    #    'console_scripts': [
    #        'celeryd = celery.bin.celeryd:main',
    #        'celeryinit = celery.bin.celeryinit:main',
    #        'celerybeat = celery.bin.celerybeat:main'
    #        ]
    #},
)
