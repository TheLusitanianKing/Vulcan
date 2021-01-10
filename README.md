# Vulcan
GitLab merge requests assistant

## Who is Vulcan?
Vulcan is a support assistant for automatic Git actions and guidelines.

## Context
Teams working with Git submodules need to forward them. Usually, if we updated a submodule on a particular branch, we will want to the main project to update the target commit of this submodule. Therefore, we often need to check manually if the submodule commit is the right one.

## What will he be able to do?
From a GitLab merge request URI, he will be able to :
- Check if the merge request have some commits behind the target branch and it therefore needs a manual action like rebasing.
- If the merge request contains only commits forwarding Git submodules, it verifies that the commit name contains "[FORWARD]" as it is a convention and check for each forward that the target commit is the last of the target branch.

If you pass it a branch name, he will :
- List the X last commits of all configured submodules (hash, name, author) of that branch (if it exists)

If the merge request needs manual validation, Vulcan won't do anything, he will let you know.

## Configuration
There are 2 configuration files, one for Vulcan's main configuration and another one for projects listing.

### Vulcan's configuration
Vulcan's configuration is mainly about how to access GitLab from the script (GitLab's URL, your token, etc.).
```bash
cp vulcan.conf.default vulcan.conf
vim vulcan.conf # edit the file with your configuration
```

### Projects' configuration
This configuration is about listing all the submodules you are using and their GitLab's ID.
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