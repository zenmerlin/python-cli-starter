import click


@click.command()
@click.option("--goodbye", "-g", is_flag=True,
              help="Says goodbye to {NAME}")
@click.argument("name")
@click.argument("quality_of_day")
def cli(goodbye, name, quality_of_day):
    """Say hello or goodbye to {NAME} and wish them {QUALITY_OF_DAY}"""
    greet = "Goodbye" if goodbye else "Hello"
    click.echo(f"{greet}, {name}. Have a {quality_of_day} day!")
