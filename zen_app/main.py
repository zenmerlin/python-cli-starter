import click

import os


cmd_dir = os.path.join(os.path.dirname(__file__), 'commands')
cmd_prefix = 'cmd_'

class CLI(click.MultiCommand):

    def list_commands(self, ctx):
        """
        Get sorted list of available commands.

        :param ctx: Click context object (dict)
        :return: List of sorted commands
        """
        commands = []

        for filename in os.listdir(cmd_dir):
            if filename.endswith('.py') and filename.startswith(cmd_prefix):
                commands.append(filename[4:-3])

        commands.sort()
        return commands


    def get_command(self, ctx, name):
        """
        Get command by module name.

        :param ctx: Click context object (dict)
        :param name: Name of command to get
        :return: Module's cli function
        """
        ns = {}
        filename = os.path.join(cmd_dir, f'{cmd_prefix}{name}.py')

        with open(filename) as file:
            code = compile(file.read(), filename, 'exec')
            eval(code, ns, ns)

        return ns['cli']



@click.command(cls=CLI)
def cli():
    """Multi-Command Entry Point"""
    pass
