# Vulcan
Merge requests validation helper.

## Context
Teams working with Git submodules need to forward them. Usually, when updating a submodule, we will want the main project to update the target commit of this submodule. Therefore, we often need to check manually if the targeted commit is the right one.

## Features
From a merge request URL, it will:
- Retrieve the target branch and then list the last 5 commits (hash, name, author) of all configured submodules on that branch.

If you pass it a branch name, it will:
- List the last 5 commits (hash, name, author) of all configured submodules of that branch (if it exists)

## Configuration
There are 2 configuration files, one for Vulcan's main configuration and preferences and another one for listing the submodules.

### Main configuration
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

## Usage
Just pass it a merge request URL

```bash
> cabal v2-run :vulcan https://git.something.com/namespace/project/merge_requests/199
```

OR directly a branch name

```bash
> cabal v2-run :vulcan us_283532_statistics
```

## Future features / TO DO list
- Read number of commits to display for each submodule from the preferences.
- Find a way to retrieve the submodule projects without having to list them all in the submodule configuration file.
- Check if the merge request have some commits behind the target branch and it therefore needs a manual action like rebasing.
- Check if the merge request contains only commits forwarding Git submodules, check for each forward that the target commit is the last of the target branch.
- Add some tests.
- Support other VCS such as GitHub or Bitbucket.
- ...

## Supports
- :white_check_mark: GitLab (using `gitlab-haskell` library)
- :x: GitHub
- :x: BitBucket
- ...

## License
see [LICENSE](LICENSE) file