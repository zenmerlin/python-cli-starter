from setuptools import setup, find_packages

setup(
    name="python-cli-starter",
    version="0.0.1",
    py_modules=["cli"],
    install_requires=[
        "Click==7.0",
    ],
    entry_points="""
        [console_scripts]
        cmd=cli:cli
    """,
)
