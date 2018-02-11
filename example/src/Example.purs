module Example where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Maybe (Maybe(..))
import Data.Traversable (traverse)
import Graphics.Canvas (CANVAS, getCanvasElementById, getContext2D)
import Soondubu (makeBarChart)

main :: forall e
   . Eff
       ( console :: CONSOLE
       , canvas :: CANVAS
       | e
       )
     Unit
main = do
  context <- traverse getContext2D =<< getCanvasElementById "myChart"
  case context of
    Nothing -> log "couldn't find chart context..."
    Just ctx ->  do
      chart <- makeBarChart spec ctx
      log "made bar chart"
  where
    spec =
      { "data":
          { labels: [ "Red" , "Blue" , "Yellow" , "Green" , "Purple" , "Orange"]
          , datasets:
              [ { label: "# of Votes"
                , "data": [12.0, 19.0, 3.0, 5.0, 2.0, 3.0]
                , backgroundColor:
                  [ "rgba(255, 99, 132, 0.2)"
                  , "rgba(54, 162, 235, 0.2)"
                  , "rgba(255, 206, 86, 0.2)"
                  , "rgba(75, 192, 192, 0.2)"
                  , "rgba(153, 102, 255, 0.2)"
                  , "rgba(255, 159, 64, 0.2)"
                  ]
                , borderColor:
                  [ "rgba(255,99,132,1)"
                  , "rgba(54, 162, 235, 1)"
                  , "rgba(255, 206, 86, 1)"
                  , "rgba(75, 192, 192, 1)"
                  , "rgba(153, 102, 255, 1)"
                  , "rgba(255, 159, 64, 1)"
                  ]
                , borderWidth: 1
                }
              ]
          }
      , options: {scales:{yAxes:[{ticks:{beginAtZero: true}}]}}
      }
