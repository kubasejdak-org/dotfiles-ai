#!/bin/bash
#
# Safe to re-run.

set -e

. ./install.sh

cd
git clone git@github.com:kubasejdak-org/trumpf-ai.git || true
