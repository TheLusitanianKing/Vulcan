# Vulcan
Merge requests validation helper

## Who is Vulcan?
Vulcan is an assistant for automatic VCS actions around merge requests and submodules.

## Context
Teams working with Git submodules need to forward them. Usually, when updating a submodule, we will want the main project to update the target commit of this submodule. Therefore, we often need to check manually if the targeted commit is the right one.

## Supports
- GitLab :white_check_mark: (using `gitlab-haskell` library)
- GitHub :x:
- BitBucket :x:
- ...

## Configuration
There are 2 configuration files, one for Vulcan's configuration and preferences and another one for listing the submodules.

### Vulcan's configuration
This configuration file is mainly about how to access your VCS from the script (default URL, your token and some other preferences).
```bash
cp vulcan.conf.default vulcan.conf
vim vulcan.conf # edit the file with your configuration
```

### Listing submodules
This configuration is about listing all the submodules you are using and their ID (you can usually find their ID in their main page).
As there is no simple way to retrieve this list for now, and since Vulcan needs it, you have to write them all.
```bash
cp submodules.conf.default submodules.conf
vim submodules.conf # edit the file with your submodules
```

## What can this script do?
From a merge request URL, it will:
- Retrieve the target branch and then list the 5 last commits of all configured submodules on that branch.

If you pass it a branch name, it will:
- List the 5 last commits of all configured submodules (hash, name, author) of that branch (if it exists)

## How does it work?
Just pass it a merge request URL

```bash
> ./vulcan https://git.something.com/namespace/project/merge_requests/199
```

OR directly a branch name

```bash
> ./vulcan us_283532_statistics
```

# Future features / TO DO list
- Find a way to retrieve the submodule projects without having to list them all in the submodule configuration file.
- Check if the merge request have some commits behind the target branch and it therefore needs a manual action like rebasing.
- Check if the merge request contains only commits forwarding Git submodules, check for each forward that the target commit is the last of the target branch.
- ...

## License
see [LICENSE](LICENSE) file