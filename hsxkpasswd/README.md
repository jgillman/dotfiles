# Passwords

I like using [HSXKPasswd](https://github.com/bbusschots/hsxkpasswd) for my
password generation. They give a good amount of entropy but are still easy for
humans to type if they need to.

The default config I have here only chooses symbols that are available on the
"first page" on the English iOS symbols keyboard.

Despite publicly posting my password pattern this config is still strong:

- **Blind Entropy:** 157 to 236 bits
- **Full knowledge:** 82 bits

For most people's usage 82 bits of entropy should be totally fine.


## Install

```shell
cpan Crypt::HSXKPasswd
```

Don't use `sudo` unless you want to install it for multiple users. It's a pain
in the ass and doing a local install is much easier since everything is
installed into `~/perl5`.

If you're previously used `sudo` with `cpan` you'll probably have a `~/.cpan`
folder owned by root. You're on your own fixing that one, but if you can `rm
-rf ~/.cpan` that's the easiest (*if* you can afford to loose that folder).

## Usage

Either use it directly with `hsxkpasswd` or use the script in `bin` with `passwords`:

```shell
$ passwords
--69;HELP;color;toward;57--
??74@SKIN@ETCHING@fire@54??
((83;DAILY;cook;english;04((
''47'force'farmers'RING'90''
@@44:neither:woman:meet:02@@
```
