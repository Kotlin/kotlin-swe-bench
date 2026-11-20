#!/bin/bash
set -euo pipefail
git apply --whitespace=nowarn /solution/fix.patch
