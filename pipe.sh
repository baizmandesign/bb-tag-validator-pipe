#!/usr/bin/env bash
#
# Required globals:
#   TARGET_BRANCH
#

set -e

GIT=$(which git)
git_bin=${GIT:?Git not found}
# https://confluence.atlassian.com/bbkb/git-command-returns-fatal-error-about-the-repository-being-owned-by-someone-else-1167744132.html
${git_bin} config --global --add safe.directory ${BITBUCKET_CLONE_DIR}
target_commit="HEAD"
tag_name=$(git tag --points-at ${target_commit})
branch_name=${BITBUCKET_BRANCH:?Could not identify branch name.}
target_branch=${TARGET_BRANCH:?Missing TARGET_BRANCH variable in pipeline definition.}
#target_tag=
#target_tag_comparison=


if [[ "${branch_name}" != "${target_branch}" ]]
then
	echo "The branch \"${branch_name}\" is not the target branch (\"${target_branch}\"). Aborting."
	echo
	exit 1
else
	echo "The branch \"${branch_name}\" is the target branch. Continuing execution."
	echo
fi

if [[ "${tag_name}" == "" ]]
then
	echo "The ${target_commit} commit does not contain a tag. Aborting."
	echo
	exit 1
else
	echo "The ${target_commit} commit contains a tag (\"${tag_name}\"). Continuing execution."
	echo
fi
