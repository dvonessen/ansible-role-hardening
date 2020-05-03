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

### Special

| Name                     | Default | Description                                 |
| :----------------------- | :-----: | ------------------------------------------- |
| `hardening_allow_reboot` |  true   | Allows execution of `reboot system` handler |

### PAM

| Name                          | Default  | Description                                                      |
| :---------------------------- | :------: | ---------------------------------------------------------------- |
| `hardening_pam`               |   true   | Enables/Disables PAM hardening.                                  |
| `hardening_pam_failed_logins` |    4     | Faild login tries before user account gets locked.               |
| `hardening_pam_unlock_time`   |    60    | Seconds how long user account will be locked after n tries.      |
| `hardening_pam_fail_delay`    | 10000000 | Milliseconds how long the delay is after failing authentication. |

### Login

| Name                                    |                               Default                                | Description                                                                           |
| :-------------------------------------- | :------------------------------------------------------------------: | ------------------------------------------------------------------------------------- |
| `hardening_login`                       |                                 true                                 | Enables/Disables login.defs configurations.                                           |
| `hardening_login_umask`                 |                                 0077                                 | Used by different tasks to set the umask. E.g. PAMs pam_umask.so or login.defs        |
| `hardening_login_timeout`               |                                 1800                                 | Default timeout for system SHELL if no input is given in seconds.                     |
| `hardening_login_motd`                  |  Banner message. See [templates/etc/motd.j2](templates/etc/motd.j2)  | Fulltext message for `/etc/motd`.                                                     |
| `hardening_login_issue`                 | Banner message. See [templates/etc/issue.j2](templates/etc/issue.j2) | Fulltext message for `/etc/issue`.                                                    |
| `hardening_login_defs_mail_dir`         |                            __/var/mail__                             | Directory to store user mails.                                                        |
| `hardening_login_defs_create_home`      |                                 yes                                  | Create by default ,home directory if it doesn't exist.                                |
| `hardening_login_defs_default_home`     |                                  no                                  | Allow login if no home directory for user exist.                                      |
| `hardening_login_defs_umask`            |                       `hardening_login_umask`                        | Sets umask for home directory creation.                                               |
| `hardening_login_defs_env_paths`        |                                  []                                  | Extend PATH environment variable with extra paths.                                    |
| `hardening_login_defs_uid_min`          |                                10000                                 | UID minimum while creating new users.                                                 |
| `hardening_login_defs_gid_min`          |                                10000                                 | GID minimum while creating new groups.                                                |
| `hardening_login_defs_sys_uid_min`      |                                 1000                                 | UID minimum while creating new system users.                                          |
| `hardening_login_defs_sys_gid_min`      |                                 1000                                 | GID minimum while creating new system groups.                                         |
| `hardening_login_defs_log_ok_logins`    |                                 yes                                  | Enables/Disables logging of successful logins.                                        |
| `hardening_login_defs_pass_min_days`    |                                  7                                   | Minimum days to keep password after changing.                                         |
| `hardening_login_defs_pass_max_days`    |                                 180                                  | Maximum age for user password in days.                                                |
| `hardening_login_defs_pass_warn_age`    |                                  14                                  | Number of days before password will be expired to print a warn message.               |
| `hardening_login_defs_pass_min_length`  |                                  32                                  | Minumin length of password.                                                           |
| `hardening_logi<n_defs_sulog_file`      |                        __/var/log/sulog.log__                        | Logfile location to log `su` command executions to.                                   |
| `hardening_login_defs_extra`            |                                  {}                                  | Dictionary to use for extra arguments to setup `login.defs`.                          |
| `hardening_login_useradd_default_shell` |                              /bin/bash                               | The SHELL variable specifies the default login shell on your system.                  |
| `hardening_login_useradd_set_inactive`  |                                  30                                  | The number of days after a password expires until the account is permanently disabled |
| `hardening_login_useradd_extras`        |                                  {}                                  | Dictionary to use for extra arguments to setup `useradd`. See `man 8 useradd`         |

### Limits

| Name                                    | Default | Description                                                         |
| :-------------------------------------- | :-----: | ------------------------------------------------------------------- |
| `hardening_limits`                      |  true   | Enables/Disables kernel limits configuration.                       |
| `hardening_limits_maxlogins_count_hard` |    5    | Sets the __hard__ limit for concurrent users and sessions per user. |
| `hardening_limits_process_count_soft`   |   100   | Sets the __soft__ limit for per user process creation count.        |
| `hardening_limits_process_count_hard`   |   500   | Sets the __hard__ limit for per user process creation count.        |

### File permissions

| Name                   | Default | Description                                                                    |
| :--------------------- | :-----: | ------------------------------------------------------------------------------ |
| `hardening_file_perms` |  true   | Enables/Disables setting and ensuring now write for group and others on files. |

### Deactivate old and and vulnerable filesystems

| Name                             | Default | Description                                                          |
| :------------------------------- | :-----: | -------------------------------------------------------------------- |
| `hardening_filesytem_module`     |  true   | Enables/Disables blacklisting of old and vulnerable filesystems.     |
| `hardening_filesystem_package`   |  kmod   | Package to install to be able to configure blacklist of filesystems. |
| `hardening_filesystem_whitelist` |   []    | List of filesystems you want to exclude from the blacklist list.     |

### Cryptop policies (only RedHat)

This playbook will set the systemwide crypto policy.
:exclamation: This module only runs on RedHat based distributions.

| Name                             | Default | Description                                   |
| :------------------------------- | :-----: | --------------------------------------------- |
| `hardening_crypto_policy_module` |  true   | Enables/Disables crypto policy configuration. |
| `hardening_crypto_policy`        | DEFAULT | Set by default the crypto policy.             |

### Services

| Name                           | Default | Description                              |
| :----------------------------- | :-----: | ---------------------------------------- |
| `hardening_services`           |  true   | Enables/Disables services configuration. |
| `hardening_whitelist_services` |   []    | List of services to whitelist.           |

### Network

| Name                                 | Default | Description                                           |
| :----------------------------------- | :-----: | ----------------------------------------------------- |
| `hardening_network`                  |  true   | Enables/Disables network configuration.               |
| `hardening_network_dns_servers`      |   []    | List of DNS server IP addresses in `/etc/resolv.conf` |
| `hardening_network_dns_search_bases` |   []    | List of DNS search base entries in `/etc/resolv.conf` |

### User

| Name                                                  | Default | Description                                                                         |
| :---------------------------------------------------- | :-----: | ----------------------------------------------------------------------------------- |
| `hardening_user`                                      |  true   | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_user`                           |  admin  | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_group`                          | admins  | Enables/Disables administrativ user and group creation. Adds user to sudoers group. |
| `hardening_user_admin_user_ssh_pub_keys` __required__ |   []    | List of public SSH keys to place into administrativ account.                        |

## Tags

| Name                         | Description                              |
| ---------------------------- | ---------------------------------------- |
| `hardening_pam`              | Includes pam configuration.              |
| `hardening_login`            | Includes `login.defs` configuration.     |
| `hardening_limits`           | Includes kernel limits configuration.    |
| `hardening_file_permissions` | Includes file permissions configuration. |
| `hardening_network`          | Includes network configuration.          |
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
