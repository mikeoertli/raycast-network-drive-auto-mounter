# Raycast Network Drive Auto-Mount Utility

<p align="center">
<img width="192" alt="Light/Dark Mode Icon" src="images/drive-icon.png"/>
</p>

This script command verifies network drives are mounted, and if not found, mounts them via finder (allowing for credential
storage in keychain).

## Configuration

There is required configuration, specifically a config file like the [example](./auto_smb_mounts.txt) (shown below) located at
the default path of `$HOME/.config/raycast/auto_smb_mounts.txt`.

```
smb://mynas/share1
smb://my-other-nas/storage_share
smb://mynas/share2
#smb://mynas/ignored_share

```

(Note the newline after the last entry.)

### Commented Entries

The `txt` file now supports commented lines. Any line that begins (after trimming whitespace) with a non-alphanumeric character is
treated as a commented line and ignored. This means that common comment prefixes like `#`, `--` and `//` are all supported.

### Add Custom Script Directory

Once cloned, make sure to add a custom script directory in Raycast. To do this, the information from the
[Raycast Script Commands](https://github.com/raycast/script-commands) repo applies here too.

## More Info

Read more about Raycast Script Commands [here](https://github.com/raycast/script-commands).
