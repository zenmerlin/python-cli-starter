from pathlib import Path
from setuptools import setup, find_packages


VERSION_PATH = Path(__file__).parents[0] / "{{ cookiecutter.root_package }}" / "VERSION"
with open(VERSION_PATH, "r") as file:
    __version__ = file.read().strip()

with open(file="README.md", mode="r") as file:
    long_description = file.read()

setup(
    name="{{ cookiecutter.project_name }}",
    author="{{ cookiecutter.author }}",
    author_email="{{ cookiecutter.author_email }}",
    version=__version__,
    description="", # TODO: add short description here
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="{{ cookiecutter.repo_baseurl }}/{{ cookiecutter.project_name }}",
    packages=find_packages(),
    include_package_data=True,
    # TODO: add package data here as required
    install_requires=[
        "click==8.0.1",
    ],
    entry_points={
        "console_scripts": ["{{ cookiecutter.command }}={{ cookiecutter.root_package }}.cli:cli"]
    }
    # TODO: add keywords and classifiers
)
