import sys, subprocess

config_command = ['/usr/bin/python', '/usr/local/bin/configManta.py']
config_command.extend(sys.argv[1:])
subprocess.check_call(config_command)

run_command = ['/usr/bin/python', 'runWorkflow.py', '-m', 'local']
subprocess.check_call(run_command)
