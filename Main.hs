import Control.Concurrent
import Control.Monad (forever)
import System.Process

main = do
  _ <- forkIO $ f 1 $ echo "frequent process"
  _ <- forkIO $ f 3 $ echo "less frequent..."
  _ <- forkIO $ f 10 $ ls
  forever $ threadDelay 1000
    where
      ls = runProcess "ls" [] Nothing Nothing Nothing Nothing Nothing
      echo msg = runProcess "echo" [msg] Nothing Nothing Nothing Nothing Nothing
      f :: Int -> (IO a) -> IO ()
      f t msg = forever $ do
            threadDelay $ t * 1000 * 1000
            _ <- msg -- 
            return ()
