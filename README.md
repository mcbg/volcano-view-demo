
This repository has the code for a [demo](https://storage.googleapis.com/volcano-view-demo/index.html) of [volcano.view](https://github.com/mcbg/volcano.view). The demo is based on a study looking at proteomic differences after receiving gastric bypass.


```r
source('dashboards.R') # generate dashboard files
volcano.view::serve_static('demo') # run dashboard locally
```

