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
There are 2 configuration files, one for Vulcan's main configuration and another one for listing the submodules.

### Vulcan's configuration
This configuration file is mainly about how to access your VCS from the script (URL, your token, etc.).
```bash
cp vulcan.conf.default vulcan.conf
vim vulcan.conf # edit the file with your configuration
```

### Projects' listing
This configuration is about listing all the submodules you are using and their ID.
As there is no simple way to retrieve this list and Vulcan needs it, you have to write them all.
```bash
cp submodules.conf.default submodules.conf
vim submodules.conf # edit the file with your submodules
```

## How does it work?
Just pass it a merge request URL

```bash
> ./vulcan https://git.something.com/namespace/project/merge_requests/199
```

OR a branch name

```bash
> ./vulcan us_283532_statistics
```

## License
see [LICENSE](LICENSE) file