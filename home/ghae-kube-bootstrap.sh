#!/usr/bin/env bash

set -euo pipefail

unset GITHUB_TOKEN

gh auth logout

gh auth login

az login
