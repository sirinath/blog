#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

cd public

if [ -n "$GITHUB_AUTH_SECRET" ]
then
    touch ~/.git-credentials
    chmod 0600 ~/.git-credentials
    echo $GITHUB_AUTH_SECRET > ~/.git-credentials

    git config credential.helper store
    git config user.email "sirinath-bot@users.noreply.github.com"
    git config user.name "sirinath-bot"
fi

git add .

msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

git push --force --recurse-submodules=check origin HEAD:master