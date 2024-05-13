# fqdn-valdiator

This very simple CLI program checks if the given input argument is a valid FQDN.

## Usage

```sh
Usage: fqdn-validator [OPTIONS] <INPUT>

Arguments:
  <INPUT>  Input string to check

Options:
  -s, --silent   If set, suppresses text output
  -h, --help     Print help
  -V, --version  Print version
```

Returns exit code 0 if `<INPUT>` is a valid FQDN, otherwise returns exit code 1.
