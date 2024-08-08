#!/bin/sh
set -ue

RepositoryName="from-github-$GITHUB_REPOSITORY_OWNER-$GITHUB_REPOSITORY_NAME"
AwsRegion="${INPUT_AWS_REGION}"
CodeCommitUrl="https://git-codecommit.${AwsRegion}.amazonaws.com/v1/repos/${RepositoryName}"

git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git remote add sync ${CodeCommitUrl}
git push sync --mirror
