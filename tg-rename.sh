#!/bin/sh

# tg rename -- renames a branch (works only for leaves now)

set -e # exit on any error immediately!

OLD="$1"
NEW="$2"

children=($($tg next "$OLD"))

if [[ "${children[@]}" ]]; then # non-empty
    die "Correct work not implemented for non-leaves, but $OLD has dependents: ${children[@]}."
fi

# Thomas Schwinge in <https://groups.google.com/forum/#!topic/git-version-control/AG9AIk3DMBM>:
# 
# There is no such command yet, but here's a receipe what ``tg rename OLD
# NEW'' would do:
# 
#   - Have a clean state before beginning.
#   - Assert NEW doesn't already exist.

git branch -m "$OLD" "$NEW"
git update-ref refs/top-bases/"$NEW" refs/top-bases/"$OLD" ''

#   - for BRANCH in (all branches that depend on OLD,
#   		   i.e. reference OLD in .topdeps); do
#       git checkout BRANCH
#       sed -i 's%^OLD$%NEW$' .topdeps
#       git commit -m 'OLD -> NEW' .topdeps
#     done
#   - tg summary
#   - tg update as appropriate

