import Control.Concurrent
import Control.Monad (forever)
import System.Process

main = do
  _ <- forkIO $ g 1 "frequent process"
  _ <- forkIO $ g 3 "less frequent..."
  _ <- forkIO $ g 10 "big slow process.."
  forever $ threadDelay 1000
    where
      g t msg = mapM_ (f t msg) (repeat 1)
      f :: Int -> String -> Int -> IO ()
      f t msg _ = do
            threadDelay $ t * 1000 * 1000
            -- _ <- runProcess "echo" [msg] Nothing Nothing Nothing Nothing Nothing
            print msg
            return ()
