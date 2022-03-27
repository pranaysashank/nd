{-# LANGUAGE OverloadedStrings #-}

module Main where

import Codec.Compression.Zlib (compress, decompress)
import Prelude ((.), print)

main = print (slowId "Hello from rules_haskell!")

slowId = decompress . compress
