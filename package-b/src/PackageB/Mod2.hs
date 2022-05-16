module PackageB.Mod2 where

import Data.List
import qualified PackageA.Mod2

mod2Func :: [String]
mod2Func = ["I am mod1Func"] ++ PackageA.Mod2.mod2Func