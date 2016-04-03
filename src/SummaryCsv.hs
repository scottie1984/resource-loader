module SummaryCsv ( generateSummaryCsv  ) where

import Csvprocessor
import Data.List.Split

changeNthElement :: Int -> (a -> a) -> [a] -> [a]
changeNthElement idx transform list
    | idx < 0   = list
    | otherwise = case splitAt idx list of
                    (front, element:back) -> front ++ transform element : back
                    _ -> list    -- if the list doesn't have an element at index idx

getFileName = (++ ".jpg") . last . (splitOn "/")
replaceImageLocations col = map (changeNthElement col getFileName)

generateSummaryCsv col = (genCSV . (replaceImageLocations col))