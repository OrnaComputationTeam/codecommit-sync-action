#!/bin/bash
set -ue

echo "DEBUG: Starting codecommit-sync-action"
echo "DEBUG: INPUT_REPOSITORY_NAME=${INPUT_REPOSITORY_NAME}"
echo "DEBUG: INPUT_AWS_REGION=${INPUT_AWS_REGION}"

RepositoryName="${INPUT_REPOSITORY_NAME}"
AwsRegion="${INPUT_AWS_REGION}"
CodeCommitUrl="https://git-codecommit.${AwsRegion}.amazonaws.com/v1/repos/${RepositoryName}"

echo "DEBUG: CodeCommitUrl=${CodeCommitUrl}"

git config --global --add safe.directory /github/workspace
git config --global credential.'https://git-codecommit.*.amazonaws.com'.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true

echo "DEBUG: Git config set"

git remote add sync ${CodeCommitUrl}

echo "DEBUG: Remote 'sync' added"
echo "DEBUG: Git remotes:"
git remote -v

echo "DEBUG: Attempting git push"
git push sync --mirror

echo "DEBUG: Push completed"
