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

info "Cleaning up the old ref(s);"

# we use a feature of 'tg delete' described in the README:
# 
#     The '-f' option is also useful to force removal of a branch's
#     base, if you used `git branch -D B` to remove branch B, and then
#     certain TopGit commands complain, because the base of branch B
#     is still there.

info "the warning is OK because it's been renamed already:"
$tg delete -f "$OLD"

#   - for BRANCH in (all branches that depend on OLD,
#   		   i.e. reference OLD in .topdeps); do
#       git checkout BRANCH
#       sed -i 's%^OLD$%NEW$' .topdeps
#       git commit -m 'OLD -> NEW' .topdeps
#     done
#   - tg summary
#   - tg update as appropriate

