module Paths_ResourceDownloader (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/stephenscott/.cabal/bin"
libdir     = "/Users/stephenscott/.cabal/lib/x86_64-osx-ghc-7.10.3/ResourceDownloader-0.1-CCP9YT55yR2LQHwiyFsqD0"
datadir    = "/Users/stephenscott/.cabal/share/x86_64-osx-ghc-7.10.3/ResourceDownloader-0.1"
libexecdir = "/Users/stephenscott/.cabal/libexec"
sysconfdir = "/Users/stephenscott/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "ResourceDownloader_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "ResourceDownloader_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "ResourceDownloader_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "ResourceDownloader_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "ResourceDownloader_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
