module Stylix.Output ( makeOutputTable ) where

import Data.Colour ( RGB(RGB) )
import qualified Data.Vector as V
import Data.Word ( Word8 )
import Text.JSON ( JSObject, toJSObject )
import Text.Printf ( printf )

toWord8 :: (RealFrac a) => RGB a -> RGB Word8
toWord8 (RGB r g b) = RGB (truncate r) (truncate g) (truncate b)

toHex :: RGB Word8 -> String
toHex (RGB r g b) = printf "%02x%02x%02x" r g b

makeOutputTable :: (RealFrac a) => V.Vector (RGB a) -> JSObject String
makeOutputTable
  = toJSObject
  . V.toList
  . V.imap (\i c -> (printf "base%02X" i, c))
  . V.map (toHex . toWord8)