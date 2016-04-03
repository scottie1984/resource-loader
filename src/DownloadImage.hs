module DownloadImage ( downloadImages  ) where

import Network.HTTP.Conduit
import Data.List.Split
import qualified Data.ByteString.Lazy as LB

getFileName loc = (loc ++ ) . (++ ".jpg") . last . (splitOn "/")

downloadImages loc file = simpleHttp file
                             >>= (LB.writeFile . getFileName(loc)) file