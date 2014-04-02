{-# LANGUAGE OverloadedStrings #-}
import Control.Monad.IO.Class
import Data.Monoid
import Data.Time.Clock.POSIX
import Hakyll

main :: IO ()
main = do
  ts <- liftIO getPOSIXTime
  hakyll $ do
    let ts' = show ts -- Do this once so miliseconds don't ever change.

    match "images/**" $ do
      route   idRoute
      compile copyFileCompiler

    match "css/*.less" $ do
      route $ setExtension (ts' ++ ".less")
      compile compressCssCompiler

    match "css/*.css" $ do
      route $ setExtension (ts' ++ ".css")
      compile compressCssCompiler

    match "templates/*" $ compile templateCompiler

    match "*.html" $ do
      route $ setExtension "html"
      compile $ do
        let ctx = mconcat [ constField "ts" ts'
                          , defaultContext
                          ]

        getResourceBody
          >>= loadAndApplyTemplate "templates/default.html" ctx
          >>= relativizeUrls

    match "robots.txt" $ do
      route idRoute
      compile copyFileCompiler
