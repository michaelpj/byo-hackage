#!/usr/bin/env bash

set -e

# Initialisation

repodir=${repodir:-$PWD/repo}

if [ -d ./keys ]; then
  echo "Using existing keys"
else
  if [ -z "$KEYS" ]; then
    echo "Creating new set of keys in ./keys"
    hackage-repo-tool create-keys --keys ./keys
  else
    echo "Using keys from environment"
    echo "$KEYS" | base64 -d | tar xz
  fi
fi

# Download packages

mkdir -p $repodir/package

cat packages.tsv | while read repo hash subdirs; do
  echo "Processing $repo/tree/$hash subdirs $subdirs"

  name=$(basename $repo)
  tmpdir=$(mktemp -d -p $PWD $name.XXXXXXXXXX)

  echo "Fetching $repo/tarball/$hash into $tmpdir"
  curl -L $repo/tarball/$hash | tar xz --strip-components=1 -C $tmpdir

  pushd $tmpdir

  echo "Removing cabal.project files (if present)"
  rm -fv cabal.project*

  if [ -z "$subdirs" ]; then
    echo "Running cabal sdist at top level"
    cabal sdist
    echo "Moving sdists inside repository"
    mv -v dist-newstyle/sdist/*.tar.gz $repodir/package/
  else
    for subdir in $subdirs; do
      pushd $subdir
      echo "Running cabal sdist inside $subdir"
      cabal sdist
      echo "Moving sdists inside repository"
      mv -v dist-newstyle/sdist/*.tar.gz $repodir/package/
      popd
    done
  fi
  popd

  echo "Deleting $tmpdir"
  rm -rf $tmpdir
done

# Create package repository

echo "Bootstapping hackage repository"
hackage-repo-tool bootstrap --keys ./keys --repo $repodir

echo "Hackage repository built in $repodir"

