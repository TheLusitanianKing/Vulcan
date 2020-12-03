# Vulcan Raven
Our assistant for GitLab merge requests

## Who is Vulcan Raven?
Vulcan Raven is our support assistant for automatic Git actions and guidelines.

## What can he do?
From a GitLab merge request URI, he can :
- Check if the merge request have some commits behind the target branch and it therefore needs a manual action
- If the merge request contains a single commit forwarding Git submodules, it verifies the commit name contains "[FORWARD]" as it is a convention and check for each forward that the target commit is the last of the target branch.

If it's not a merge request URI, from a target branch name, he can :
- List the X last commits of all configured submodules (hash, name, author)

If the merge request needs manual validation, Vulcan Raven won't do anything, he will let you know.

## Configuration
TODO

## How does it work?
```
> ./vulcan https://git.something.com/project/subproject/merge_requests/199

The merge request has 2 commits behind: update your branch.
```

```
> ./vulcan https://git.something.com/project/subproject/merge_requests/6409

The merge request contains forward commit(s) to the `branch_name` branch:
    api-front:      to @f1242efw8327jf389f3 (last known commit in branch `branch_name`)
        new commits:
            - b934872 - Commit A
            - g2jd94j - Commit B
    api-back:       to @3umf3gm932gidsd9g30 (last known commit in branch `branch_name`)
        new commits:
            - 3ujf390 - Commit C
The forward(s) are pointing to the right commits.
```

```
> ./vulcan https://git.something.com/project/subproject/merge_requests/323

The merge request has forward commit(s) but do not target the last commit of the `branch_name` target branch:
    api-front:      to @skjig203ud382du3208
                    should be @532fjig322d382du30987 (last known commit in branch `branch_name`)
The merge request needs manual validation.
```

OR

```
> ./vulcan us_283532_statistics

The following submodules have a branch `us_283532_statistics`, here are their last X commits :
    api-front:
        - @b934872 - Commit A (last known commit in the target branch)
        - @g2jd94j - Commit B
        - @jgoer39 - Commit C
    api-back:
        - @3ujf390 - Commit F
```

## Progress
Work in progress... 5%

## Disclaimer
TODO