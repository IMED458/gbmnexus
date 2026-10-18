#!/usr/bin/env bash
# Rebuild index.html from the source parts.
#   ./build.sh
set -euo pipefail
cd "$(dirname "$0")"
cat src/part1.html src/part2.html src/part3.html src/part4.html src/part5.html \
    src/part6.html src/part7.html src/part9.html src/part10.html src/part8.html > .index.raw.html
python3 - <<'PY'
b64 = open('assets/gbmn-mark.b64').read().strip()
src = open('.index.raw.html').read().replace('__LOGO__', b64)
open('index.html', 'w').write(src)
print('index.html %d bytes' % len(src))
PY
rm -f .index.raw.html
