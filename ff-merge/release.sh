#!/usr/bin/env bash
set -euxo pipefail

BRANCH="${BRANCH:-master}"
ORG="${ORG:-aws4embeddedlinux}"
# For Linux and MacOS compat, avoid the -t option with mktemp!
WORKDIR=$(mktemp -d "${TMPDIR:-/tmp}/release.XXXXXXXXX")

function cleanup() {
    rm -fr $WORKDIR
}
trap cleanup EXIT

git clone https://github.com/${ORG}/meta-aws -b $BRANCH $WORKDIR

git -C $WORKDIR merge --ff-only origin/${BRANCH}-next
git -C $WORKDIR push -u origin $BRANCH
