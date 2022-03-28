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

# How is this made?

This is made using [foliage](https://github.com/andreabedini/foliage).

At each push event, a GitHub Actions workflow builds a repository
out of the packages listed in `_sources`.

The format of the input files is explained [here](https://github.com/andreabedini/foliage/blob/main/README.md#example).

# How do I publish a package to this repo?

You could make a pull request, but I am using this repository only for personal testing, so I won't accept it.

Better idea would be making your own repository [using this as a template](https://github.com/andreabedini/byo-hackage/generate).

# This is all wrong, you have no idea what you are doing

Yes, that is correct, I have no idea what I am doing. I like playing with things.

# Author

- Andrea Bedini (andrea@andreabedini.com)
