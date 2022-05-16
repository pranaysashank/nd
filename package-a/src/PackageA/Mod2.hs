module PackageA.Mod2 where

import Data.List
import PackageA.Mod1

mod2Func :: [String]
mod2Func = ["I am mod1Func"] ++ mod1Func