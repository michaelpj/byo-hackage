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
  echo "Processing $repo/tree/$hash subdirs:$subdirs"

  name=$(basename $repo)
  tmpdir=$(mktemp -d -p $PWD $name.XXXXXXXXXX)

  echo "Fetching $repo/tarball/$hash into $tmpdir"
  curl -L $repo/tarball/$hash | tar xz --strip-components=1 -C $tmpdir

  echo "Running cabal sdist"
  cd $tmpdir

  echo "Remove cabal.project*"
  rm -v cabal.project*
  cabal sdist --ignore-project $subdirs

  echo "Moving sdist inside repository"
  mv -v dist-newstyle/sdist/*.tar.gz $repodir/package/
  cd ..

  echo "Deleting $tmpdir"
  rm -rf $tmpdir
done

# Create package repository

echo "Bootstapping hackage repository"
hackage-repo-tool bootstrap --keys ./keys --repo $repodir

echo "Hackage repository built in $repodir"

