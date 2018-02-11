A wrapping for Chart.js like [dotorimuk](https://github.com/justinwoo/purescript-dotorimuk), but using the approach like in [React-Basic](https://github.com/lumihq/purescript-react-basic) and choosing to allow the spec to be defined by using Unions to allow for defining a subset of fields in the concretely typed records passed in.

tl;dr `Union spec trash AllAllowedFields`

## Example

```hs
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
```

Looks like this:
![](https://i.imgur.com/ApUHKOj.png)
