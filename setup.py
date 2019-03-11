from setuptools import setup, find_packages

setup(
    name='zen',
    version='0.0.1',
    package=find_packages(),
    include_package_data=True,
    install_requires=[
        'Click==7.0',
    ],
    entry_points='''
        [console_scripts]
        zen=zen_app.main:cli
    ''',
)
