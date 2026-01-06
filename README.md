# Raycast Network Drive Auto-Mount Utility

<p align="center">
<img width="192" alt="Light/Dark Mode Icon" src="images/drive-icon.png"/>
</p>

This script command verifies network drives are mounted, and if not found, mounts them via finder (allowing for credential
storage in keychain).

## Configuration

There is required configuration, specifically a config file like the [example](./auto_smb_mounts.txt) (shown below) located at
the default path of `$HOME/.config/raycast/auto_smb_mounts.txt`.

```txt
smb://mynas/share1 # main NAS
smb://my-other-nas/storage_share
smb://mynas/share2
#smb://mynas/ignored_share # Temporarily offline
```

Previously, it was required to include a trailing newline after the last entry. This is no longer the case.

### Commented Entries

The `txt` file now supports commented lines. Any line that begins (after trimming whitespace) with a non-alphanumeric character is
treated as a commented line and ignored. This means that common comment prefixes like `#`, `--` and `//` are all supported.

### Comments on Entries

Entries can be commented by adding 1+ space followed by a pound sign (`#`) after the network mount path. This is supported for
entries that are commented out and those that are not.

For example:

```txt
smb://mynas/share1 # main NAS
```

### Add Custom Script Directory

Once cloned, make sure to add a custom script directory in Raycast. To do this, the information from the
[Raycast Script Commands](https://github.com/raycast/script-commands) repo applies here too.

## More Info

Read more about [Raycast Script Commands here](https://github.com/raycast/script-commands).
