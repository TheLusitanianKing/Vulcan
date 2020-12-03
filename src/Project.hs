module Project where

data Project = Project {
    projectId   :: Int,
    projectName :: String
} deriving (Eq, Show)


fromRaw :: (String, Int) -> Project
fromRaw (s, i) = Project i s

-- TODO
retrieveProjectsFromConfiguration :: FilePath -> IO (Maybe [Project])
retrieveProjectsFromConfiguration = undefined

-- TODO: get this from configuration, not from here
projectsRaw :: [(String, Int)]
projectsRaw = [
        ("something", 39),
        ("something/else", 72)
    ]

projects :: [Project]
projects = map fromRaw projectsRaw