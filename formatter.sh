#!/usr/bin/env bash

# Python Auto Code Formatter using 'black'

# Colors
NC="\033[0m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"

# Getting 'master' branch of https://github.com/crazyuploader/Python.git
echo ""
echo "Cloning Python Repository"
echo ""
git clone https://"${GH_REF}" -b master python
cd python || exit
echo ""
echo "Formatting Python Files with 'black'"
echo ""
black .
echo ""
LAST_COMMIT="$(git log --pretty=format:'%s' -1)"
LAST_COMMIT_SHA="$(git rev-parse HEAD)"
LAST_COMMIT_LINK="https://github.com/crazyuploader/Python/commit/${LAST_COMMIT_SHA}"
DATE="$(date +%m/%d/%y)"
if [[ -z $(git status --porcelain) ]]; then
    echo "${GREEN}Nothing to format & push${NC}"
else
    git config user.email "49350241+crazyuploader@users.noreply.github.com"
    git config user.name "crazyuploader"
    git add .
    git commit -m "Travis CI -- Auto Formatter"           \
               -m ""                                       \
               -m "  Formatting Date: ${DATE}"              \
               -m ""                                         \
               -m "  Original Commit - '${LAST_COMMIT}'"      \
               -m ""                                           \
               -m "  Original Commit Link: ${LAST_COMMIT_LINK}"
    git push https://crazyuploader:"${GITHUB_TOKEN}"@"${GH_REF}" HEAD:formatted --force
    echo ""
    echo -e "${YELLOW}Formatter Python code pushed to branch 'formatted' at https://github.com/crazyuploader/Python/tree/formatted${NC}"
    echo ""
fi
