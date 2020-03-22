# hardening (Ansible role)
-----------------------

This role keeps a baseline of linux hardening options.

## Description

The role is devided into different parts:

- Configuration of PAM (Pluggable Authentication Model)
- Configuration of `login.defs`
- Set some good Kernel limits
- Configure sudo
- Creating an administrativ user and group

## Caution

!This role does not update your OS.!

## Variables

### Systemwide

| Name                       | Default | Description                                                                    |
| :------------------------- | :-----: | ------------------------------------------------------------------------------ |
| `hardenings_system_umask`  |  0077   | Used by different tasks to set the umask. E.g. PAMs pam_umask.so or login.defs |
| `hardening_system_timeout` |  1800   | Default timeout for system SHELL if no input is given in seconds.              |

### PAM

| Name                                 | Default  | Description                                                      |
| :----------------------------------- | :------: | ---------------------------------------------------------------- |
| `hardening_enable_pam_configuration` |   true   | Enables/Disables PAM hardening.                                  |
| `hardening_pam_failed_logins`        |    4     | Faild login tries before user account gets locked.               |
| `hardening_pam_unlock_time`          |    60    | Seconds how long user account will be locked after n tries.      |
| `hardening_pam_fail_delay`           | 10000000 | Milliseconds how long the delay is after failing authentication. |

### Login defs

| Name                                   |          Default          | Description                                                             |
| :------------------------------------- | :-----------------------: | ----------------------------------------------------------------------- |
| `hardening_enable_login_configuration` |           true            | Enables/Disables login.defs configurations.                             |
| `hardening_login_mail_dir`             |       __/var/mail__       | Directory to store user mails.                                          |
| `hardening_login_create_home`          |            yes            | Create by default ,home directory if it doesn't exist.                  |
| `hardening_login_default_home`         |            no             | Allow login if no home directory for user exist.                        |
| `hardening_login_umask`                | `hardenings_system_umask` | Sets umask for home directory creation.                                 |
| `hardening_login_env_paths`            |            []             | Extend PATH environment variable with extra paths.                      |
| `hardening_login_uid_min`              |           10000           | UID minimum while creating new users.                                   |
| `hardening_login_gid_min`              |           10000           | GID minimum while creating new groups.                                  |
| `hardening_login_sys_uid_min`          |           1000            | UID minimum while creating new system users.                            |
| `hardening_login_sys_gid_min`          |           1000            | GID minimum while creating new system groups.                           |
| `hardening_login_log_ok_logins`        |            yes            | Enables/Disables logging of successful logins.                          |
| `hardening_login_pass_min_days`        |             7             | Minimum days to keep password after changing.                           |
| `hardening_login_pass_max_days`        |            180            | Maximum age for user password in days.                                  |
| `hardening_login_pass_warn_age`        |            14             | Number of days before password will be expired to print a warn message. |
| `hardening_login_sulog_file`           |  __/var/log/sulog.log__   | Logfile location to log `su` command executions to.                     |
| `hardening_login_extra`                |            {}             | Dictionary to use for extra arguments to setup `login.defs`.            |

### Limits

| Name                                    | Default | Description                                                         |
| :-------------------------------------- | :-----: | ------------------------------------------------------------------- |
| `hardening_enable_limits_configuration` |  true   | Enables/Disables kernel limits configuration.                       |
| `hardening_limits_maxlogins_count_hard` |    5    | Sets the __hard__ limit for concurrent users and sessions per user. |
| `hardening_limits_process_count_soft`   |   100   | Sets the __soft__ limit for per user process creation count.        |
| `hardening_limits_process_count_hard`   |   500   | Sets the __hard__ limit for per user process creation count.        |

### File permissions

| Name                                        | Default | Description                                                                    |
| :------------------------------------------ | :-----: | ------------------------------------------------------------------------------ |
| `hardening_enable_file_perms_configuration` |  true   | Enables/Disables setting and ensuring now write for group and others on files. |

### Deactivate old and and vulnerable filesystems

| Name                                              | Default | Description                                                          |
| :------------------------------------------------ | :-----: | -------------------------------------------------------------------- |
| `hardening_enable_filesytem_module_configuration` |  true   | Enables/Disables blacklisting of old and vulnerable filesystems.     |
| `hardening_filesystem_package`                    |  kmod   | Package to install to be able to configure blacklist of filesystems. |
| `hardening_filesystem_whitelist`                  |   []    | List of filesystems you want to exclude from the blacklist list.     |

### Cryptop policies (only RedHat)

This playbook will set the systemwide crypto policy.
:exclamation: This module only runs on RedHat based distributions.

| Name                                                  | Default | Description                                   |
| :---------------------------------------------------- | :-----: | --------------------------------------------- |
| `hardening_enable_crypto_policy_module_configuration` |  true   | Enables/Disables crypto policy configuration. |
| `hardening_crypto_policy`                             | DEFAULT | Set by default the crypto policy.             |

### Services

| Name                                      | Default | Description                              |
| :---------------------------------------- | :-----: | ---------------------------------------- |
| `hardening_enable_services_configuration` |  true   | Enables/Disables services configuration. |
| `hardening_whitelist_services`            |   []    | List of services to whitelist.           |

### User

| Name                                                  | Default | Description                                                                         |
| :---------------------------------------------------- | :-----: | ----------------------------------------------------------------------------------- |
| `hardening_enable_user_configuration`                 |  true   | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_user`                           |  admin  | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_group`                          | admins  | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_user_ssh_pub_keys` __required__ |   []    | List of public SSH keys to place into administrativ account.                        |

### Reboot

The system will be rebooted if anything has changed

## Tags

| Name                         | Description                              |
| ---------------------------- | ---------------------------------------- |
| `hardening_pam`              | Includes pam configuration.              |
| `hardening_login`            | Includes `login.defs` configuration.     |
| `hardening_limits`           | Includes kernel limits configuration.    |
| `hardening_file_permissions` | Includes file permissions configuration. |
| `hardening_user`             | Creation of administrativ user.          |

## Dependencies
---------------

**None**

## Example Playbook
-------------------

```yaml
- name: All
  hosts: all
  debugger: on_failed
  roles:
    - role: ansible-role-hardening
```

## License

MIT License

## Contributors

Daniel von Eßen
