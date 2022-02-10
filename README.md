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

[These ones](https://github.com/andreabedini/byo-hackage/blob/main/packages.tsv). It's a simple list of GitHub repositories, hashes and subdirectories.

At each push event, a [script](https://github.com/andreabedini/byo-hackage/blob/main/build.sh) downloads those repositories, runs `cabal sdist` on each of them, and updates the package repository using the [`hackage-repo-tool`](https://hackage.haskell.org/package/hackage-repo-tool).

# How do I publish a package to this repo?

You could make a pull request, but I am using this repository only for personal testing, so I won't accept it.

Better idea would be making your own repository, just [click here](https://github.com/andreabedini/byo-hackage/generate).

# This is all wrong, you have no idea what you are doing

Yes, that is correct, I have no idea what I am doing. I am playing with things.

# Author

- Andrea Bedini (andrea@andreabedini.com)
