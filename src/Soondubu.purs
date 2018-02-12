module Soondubu where

import Control.Monad.Eff (Eff)
import Graphics.Canvas (Context2D)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ChartInstance :: Type
foreign import data BarData :: Type
foreign import data BarDataset :: Type

foreign import makeBarChart_ :: forall barChartSpec e
   . barChartSpec -> Context2D -> Eff e ChartInstance

makeBarChart
  :: forall e options spec spec'
   . Union spec spec' (BarSpec options)
  => Record spec
  -> Context2D
  -> Eff e ChartInstance
makeBarChart = makeBarChart_

makeBarData
  :: forall data_ data_'
   . Union data_ data_' BarSpecData
  => Record data_
  -> BarData
makeBarData = unsafeCoerce

makeBarDataset
  :: forall dataset dataset'
   . Union dataset dataset' BarSpecDataset
  => Record dataset
  -> BarDataset
makeBarDataset = unsafeCoerce

type ChartSpec data_ options =
  ( "data" :: data_
  , options :: options
  )

type BarSpec options =
  ChartSpec BarData (Record options)

type BarSpecData =
  ( labels :: Array String
  , datasets :: Array BarDataset
  )

type BarSpecDataset =
  ( label :: String
  , "data" :: Array Number
  , backgroundColor :: Array String
  , borderColor :: Array String
  , borderWidth :: Int
  )
