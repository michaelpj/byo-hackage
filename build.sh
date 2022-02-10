#!/usr/bin/env bash

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

# Downloading packages

mkdir -p $repodir/package

cat packages.tsv | while read repo hash subdirs; do
  echo "processing $repo@$hash subdirs:$subdirs"

  name=$(basename $repo)
  tmpdir=$(mktemp -d -p $PWD $name.XXXXXXXXXX)

  cd $tmpdir
  curl -L $repo/tarball/$hash | tar xz --strip-components=1
  cabal sdist --ignore-project $subdirs
  mv -v dist-newstyle/sdist/*.tar.gz $repodir/package/
  cd ..

  rm -rf $tmpdir
done

# Bootstrap or update

if [ ! -f $repodir/root.json ]; then
  echo "Bootstapping hackage repository"
  hackage-repo-tool bootstrap --keys ./keys --repo $repodir
else
  echo "Updating hackage repository"
  hackage-repo-tool update --keys ./keys --repo $repodir
fi

echo "Hackage repository built in $repodir"

