import Csvprocessor
import DownloadImage
import SummaryCsv
import Data.Maybe
import System.Directory
import Data.Time.Clock
import Data.Time.LocalTime
import System.Environment
import Data.String
import Data.List
import Data.List.Split

getPath = (intercalate "/") . init . (splitOn "/")

getResources :: Int -> [[String]] -> [String]
getResources col csv = mapMaybe (dataAt col) csv

dataAt :: Int -> [a] -> Maybe a
dataAt _ [] = Nothing
dataAt y (x:xs)  | y <= 0 = Just x
                 | otherwise = dataAt (y-1) xs

currentTime = do
                 now <- getCurrentTime
                 timezone <- getCurrentTimeZone
                 return (utcToLocalTime timezone now)

createFolderAndProcess path col csv = do
                           ct <- currentTime
                           let folderName = path ++ "/" ++ show ct ++"/"
                           createDirectoryIfMissing True folderName
                           (mapM_(downloadImages folderName) . getResources(col)) csv
                           writeFile (folderName ++ "data.csv") (generateSummaryCsv col csv)
                           print "Finished"

process path col fileName = do
            contents <- readFile fileName
            case parseCSV contents of
                Left e -> do putStrLn "Error parsing input:"
                             print e
                Right r -> createFolderAndProcess path col r

getCsvName     [] = "data.csv"
getCsvName (x:xs) = x

getCol :: [String] -> Int
getCol     [] = 6
getCol (x:xs) = getSecCol(xs)

getSecCol :: [String] -> Int
getSecCol     [] = 6
getSecCol (x:xs) = read x::Int

main = do
        args <- getArgs
        currentDir <- getExecutablePath
        let path = getPath currentDir
        process path (getCol args)  (path ++ "/" ++ getCsvName args)