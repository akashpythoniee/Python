#!/usr/bin/env bash

# Python Auto-Linter using 'black'

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
echo "Linting Python Files with 'black'"
echo ""
black .
echo ""
LAST_COMMIT="$(git log --pretty=format:'%s' -1)"
LAST_COMMIT_SHA="$(git rev-parse HEAD)"
LAST_COMMIT_LINK="https://github.com/crazyuploader/Python/commit/${LAST_COMMIT_SHA}"
DATE="$(date +%m/%d/%y)"
if [[ -z $(git status --porcelain) ]]; then
    echo "${GREEN}Nothing to lint & push${NC}"
else
    git config user.email "49350241+crazyuploader@users.noreply.github.com"
    git config user.name "crazyuploader"
    git add .
    git commit -m "Travis CI -- Auto Linter"              \
               -m ""                                       \
               -m "  Linting Date: ${DATE}"                 \
               -m ""                                         \
               -m "  Original Commit: ${LAST_COMMIT}"         \
               -m ""                                           \
               -m "  Original Commit Link: ${LAST_COMMIT_LINK}"
    git push https://crazyuploader:"${GITHUB_TOKEN}"@"${GH_REF}" HEAD:linted --force
    echo ""
    echo -e "${YELLOW}Linted Python code pushed to branch 'linted' at https://github.com/crazyuploader/Python/tree/linted${NC}"
    echo ""
fi
