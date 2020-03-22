# {{ ansible_managed }}

# Setting umask for all users
umask {{ hardening_system_umask }}

# Setting timeout if no input is given to shell
TMOUT={{ hardening_system_timeout }}
