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
