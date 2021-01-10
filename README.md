# Vulcan
Merge requests validation helper

## Who is Vulcan?
Vulcan is an assistant for automatic VCS actions around merge requests.

## Context
Teams working with Git submodules need to forward them. Usually, when updating a submodule, we will want the main project to update the target commit of this submodule. Therefore, we often need to check manually if the targeted commit is the right one in a merge request.

## Supports
- GitLab :white_check_mark:
- GitHub :x:
- BitBucket :x:
- ...

## What is it able to do?
From a merge request URI, it can :
- Check if the merge request have some commits behind the target branch and it therefore needs a manual action like rebasing.
- If the merge request contains only commits forwarding Git submodules, it verifies that the commit name contains "[FORWARD]" as it is a convention and check for each forward that the target commit is the last of the target branch.

If you pass it a branch name, it will :
- List the X last commits of all configured submodules (hash, name, author) of that branch (if it exists)

If the merge request needs manual validation, it will let you know.

## Configuration
There are 2 configuration files, one for Vulcan's main configuration and another one for projects listing.

### Vulcan's configuration
This configuration file is mainly about how to access your VCS from the script (URL, your token, etc.).
```bash
cp vulcan.conf.default vulcan.conf
vim vulcan.conf # edit the file with your configuration
```

### Projects' configuration
This configuration is about listing all the submodules you are using and their ID.
```bash
cp projects.conf.default projects.conf
vim projects.conf # edit the file with your submodules
```

## How does it work?
```
> ./vulcan https://git.something.com/namespace/project/merge_requests/199

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

## License
TODO