module Soondubu where

import Control.Monad.Eff (Eff)
import Graphics.Canvas (Context2D)

foreign import data ChartInstance :: Type

foreign import makeBarChart_ :: forall barChartSpec e
   . barChartSpec -> Context2D -> Eff e ChartInstance

makeBarChart
  :: forall e options
       spec spec'
       data_ data_'
       dataset dataset'
   . Union spec spec' (BarSpec data_ options)
  => Union data_ data_' (BarSpecData dataset)
  => Union dataset dataset' BarSpecDataset
  => Record spec
  -> Context2D
  -> Eff e ChartInstance
makeBarChart = makeBarChart_

type ChartSpec data_ options =
  ( "data" :: Record data_
  , options :: Record options
  )

type BarSpec data_ options =
  ChartSpec data_ options

type BarSpecData dataset =
  ( labels :: Array String
  , datasets :: Array (Record dataset)
  )

type BarSpecDataset =
  ( label :: String
  , "data" :: Array Number
  , backgroundColor :: Array String
  , borderColor :: Array String
  , borderWidth :: Int
  )
