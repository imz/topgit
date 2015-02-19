#!/bin/bash

# tg rebase
# 
# is like: 
# 
#     git rebase tg-BASE
# 
# and is allowed only for leaves (not to break dependents).

# Plan:
# 
# * Find new-BASE (merging all dependencies into old-BASE).
#   - Note that old-BASE is a point whose history must not be rewritten.
# * Rebase old-BASE..HEAD onto new-BASE.
#   - BTW, "git rebase new-BASE" would automatically discover old-BASE.
#     as the common ancestor of new-BASE and HEAD.
# * Remove the ref for old-BASE.
#   - Well, actually, there is no need for keeping a ref like old-BASE
#     because "git rebase new-BASE" automatically discovers old-BASE.
# 
# This must be very similar to the operation of "tg update",
# with the difference that "tg update" merges new-BASE into HEAD.

# I think a working solution would be to simply substitute
# "git rebase --preserve-merges" for "git merge" in "tg update".
# It might even work for recursive updates.
# -- https://github.com/greenrd/topgit/issues/40#issuecomment-74869975
# 
# A hack is to pass it as an environment variable (instead of an option),
# which would also allow to satisfy another wish:
# specifying special strategies (like -s ours) when updating special branches.
# -- https://github.com/greenrd/topgit/issues/42
