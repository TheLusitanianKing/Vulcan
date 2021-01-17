# Vulcan
Merge requests validation helper.

<img src="https://static.wikia.nocookie.net/metalgear/images/2/22/Vulcan_Raven.jpg/revision/latest?cb=20060802225437" alt="vulcan-raven" width="150"/>

## Context
Teams working with Git submodules need to forward them. Usually, when updating a submodule, we will want the main project to update the target commit of this submodule. Therefore, we often need to check manually if the targeted commit is the right one.

## Features
From a merge request URL, it will:
- Retrieve the target branch and then list the last 5 commits (hash, name, author) of all configured submodules on that branch.

If you pass it a branch name, it will:
- List the last X commits (hash, name, author) of all configured submodules of that branch (if it exists)

## Configuration
There are 2 configuration files, one for Vulcan's main configuration and preferences and another one for listing the submodules.

### Main configuration
This configuration file is mainly about how to access your VCS from the script (default URL, your token and some other preferences).
```bash
cp conf/vulcan.conf.default conf/vulcan.conf
vim conf/vulcan.conf # edit the file with your configuration
```

### Listing submodules
This configuration is about listing all the submodules you are using and their ID (you can usually find their ID in their main page).
As there is no simple way to retrieve this list for now, and since Vulcan needs it, you have to write them all.
```bash
cp conf/submodules.conf.default conf/submodules.conf
vim conf/submodules.conf # edit the file with your submodules
```

## Usage
Just pass it a merge request URL

```bash
cabal run :vulcan https://git.something.com/namespace/project/merge_requests/199
```

OR directly a branch name

```bash
cabal run :vulcan us_283532_statistics
```

You can build it first, to run it faster as it won't have to build it before running with: `cabal build`

## Future features / TO DO list
See [Issues tagged with enhancement](https://github.com/TheLusitanianKing/Vulcan/labels/enhancement)

## Supports
- :white_check_mark: GitLab (using `gitlab-haskell` library)
- :x: GitHub
- :x: BitBucket
- ...

## License
see [LICENSE](LICENSE) file