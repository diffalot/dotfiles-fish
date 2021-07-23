#!/usr/bin/env fish

# # Basic Workflow
#
# Each computer where the synced folder might be accessed should trigger a run
# of `chronofiler-git push`, folders should not be shared among people, this
# system relies on one person not moving as quickly as the files do.
#
# Some suggestions:
# 1. Trigger a push when a file is saved in the directory from either your
#    editor or a directory watcher like inotify or fsevents (wait a little bit,
#    maybe 30 seconds to 3 minutes, in case there are multiple files about to
#    be saved).
# 2. Trigger a pull when you log in or open up your editor
#
# # Git Workflow
#
# Each computer will create branches based on their hostname and the date.
# these branches will only be pushed to origin with and error log as the commit
# message if there has been a problem.
#
# ## Push or Pull - (For any error, crash hard)
#
# Since we are counting on these branches remaining separate from main, and
# committing before trying to update main, data loss should be very rare, and
# collisions on main will not result in loss of data unless the individual
# branches have suffered catastrophic failure.

function cronofiler -a directory
    echo directory: $directory
    echo \$args:     $args
    
    # use local times, but make it explicit that it's zoned
    # 1. Check that todays branch exists;  if not, create it.
    set -l todays_branch (date "+%Y-%m-%d-%Z-$hostname")
    if not contains $todays_branch (git -C $directory branch --list --format='%(refname:short)')
        git -C $directory checkout -b $todays_branch main
    end

    # 2. Check that you are on the appropriate branch (yy-mm-dd-hostname), if not, create it and check
    #    it out.
    if test (git -C $directory branch --show-current) != "$todays_branch"
        # TODO log warning, because we should not have left this branch
        git -C $directory checkout $todays_branch
    end

    # 3. if `git status` --porcelain has any output, there have been changes, add
    #    to the current branch with `git add . && git commit -m "MM/DD hh:mm:ss (hostname)"`
    set -l commit_message (date "+%m/%d %H:%M:%S %Z ($hostname)")
    if test -n "(git -C $directory status--porcelain)"
        git -C $directory add .
        git -C $directory commit -m $commit_message
    end

    # 4. update the main branch without checking it out with
    git -C $directory fetch origin main:main

    # 5. rebase onto main with
    git -C $directory rebase main

    # 6. have main fast forward main to your branch head with
    git -C $directory fetch . $todays_branch:main

    # 7. push main to origin with
    git -C $directory push origin main:main

    # 8. for any error, push the current branch upstream with the last 1000 lines of
    #    the log attached as the commit message
    set -l
end
