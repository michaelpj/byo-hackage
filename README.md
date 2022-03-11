# BYO Hackage

Just an experiment around Haskell packaging.

Inspired by https://github.com/input-output-hk/hackage-overlay-ghcjs

# How do I use it?

Add the following lines to your `cabal.project` or `~/.cabal/config`:

```
repository andreabedini-byo-hackage
  url: https://andreabedini.github.io/byo-hackage
  secure: True
```

# What packages are available?

The ones listed in [`config.toml`](https://github.com/andreabedini/byo-hackage/blob/main/config.toml).
It's a simple list of tarballs and subdirectories. GitHub provides a
tarball for every commit hash so that's convenient!

At each push event, a GitHub Actions workflow uses the
[foliage](https://github.com/andreabedini/foliage) to build a repository
out of the packages listed in `config.toml`.

# How do I publish a package to this repo?

You could make a pull request, but I am using this repository only for personal testing, so I won't accept it.

Better idea would be making your own repository [using this as a template](https://github.com/andreabedini/byo-hackage/generate).

# This is all wrong, you have no idea what you are doing

Yes, that is correct, I have no idea what I am doing. I like playing with things.

# Author

- Andrea Bedini (andrea@andreabedini.com)
