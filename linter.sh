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
if [[ -z $(git status --porcelain) ]]; then
    echo "${GREEN}Nothing to lint & push${NC}"
else
    echo git add .
    git commit -m "Travis CI -- Auto Linter Date: $(date +%m/%d/%y)"
    git push https://crazyuploader:"${GITLAB_TOKEN}"@"${GL_REF}" HEAD:linted
    echo ""
    echo "${YELLOW}Linted Python code pushed to branch 'linted'"
fi
