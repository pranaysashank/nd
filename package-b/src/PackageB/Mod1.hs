module PackageB.Mod1 where

import Data.List
import qualified PackageA.Mod1
import PackageB.Mod2

mod1Func :: [String]
mod1Func = ["I am mod1Func"] ++ PackageA.Mod1.mod1Func ++ mod2Func