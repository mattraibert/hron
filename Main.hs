import Control.Concurrent
import Control.Monad
import System.Process

main :: IO b
main = do
  void $ forkIO $ schedule 1 $ echo "frequent process"
  void $ forkIO $ schedule 3 $ slow "less frequent..."
  void $ forkIO $ schedule 10 ls
  forever $ threadDelay 1000
    where
      runp x y = runProcess x y Nothing Nothing Nothing Nothing Nothing >>= waitForProcess
      ls = runp "ls" []
      echo msg = runp "echo" [msg]
      slow msg = do
        void $ runp "echo" ["start", msg]
        void $ runp "sleep" ["10"]
        void $ runp "echo" ["finish", msg]
      schedule :: Int -> IO a -> IO ()
      schedule t fcn = forever $ do
            threadDelay $ t * 1000 * 1000
            void fcn
