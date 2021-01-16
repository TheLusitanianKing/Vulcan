-- |
-- Module      : Alias
-- Description : Handle some aliases
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module Alias where

import Data.Text (Text)
import qualified Data.Text as T

(+-+) :: Text -> Text -> Text
(+-+) = T.append