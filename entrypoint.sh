#!/bin/sh
set -ue

# Get the repository name from the Git context
RepositoryName=$(echo "$GITHUB_REPOSITORY" | cut -d'/' -f2)
AwsRegion="${INPUT_AWS_REGION}"
CodeCommitUrl="https://git-codecommit.${AwsRegion}.amazonaws.com/v1/repos/${RepositoryName}"

git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${CodeCommitUrl}
git push sync --mirror
