
<!-- README.md is generated from README.Rmd. Please edit that file -->

# iramuteqlike <a href='https://gipso.github.io/iramuteqlike/'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/gipso/iramuteqlike/workflows/R-CMD-check/badge.svg)](https://github.com/gipso/iramuteqlike/actions)
[![Codecov test
coverage](https://codecov.io/gh/gipso/iramuteqlike/branch/main/graph/badge.svg)](https://app.codecov.io/gh/gipso/iramuteqlike?branch=main)
[![License:
MIT](https://img.shields.io/badge/license-MIT-green)](https://choosealicense.com/licenses/mit/)
[![Contributor
Covenant](https://img.shields.io/badge/Contributor%20Covenant-v2.0%20adopted-ff69b4.svg)](https://gipso.github.io/iramuteqlike/CODE_OF_CONDUCT.html)
[![Buy Me A Coffee donate
button](https://img.shields.io/badge/buy%20me%20a%20coffee-donate-yellow.svg)](https://ko-fi.com/danielvartan)
<!-- badges: end -->

## Overview

`iramuteqlike` is an R package with tools to reproduce the
[IRaMuTeQ](http://www.iramuteq.org/) software analyses in R. The aim of
`iramuteqlike` is to facilitate text analyses, in addition to
contributing to research reproducibility.

The package use different methods to compute some analyses, hence, the
results can differ from the [IRaMuTeQ](http://www.iramuteq.org/)
software.

Please note that `iramuteqlike` is not related in any way with the
[IRaMuTeQ](http://www.iramuteq.org/) developer team.

## Prerequisites

You only need to have some familiarity with the [R programming
language](https://www.r-project.org/) to use the `iramuteqlike` main
functions.

In case you don’t feel comfortable with R, we strongly recommend
checking Hadley Wickham and Garrett Grolemund’s free and online book [R
for Data Science](https://r4ds.had.co.nz/) and the Coursera course from
the John Hopkins University [Data Science: Foundations using
R](https://www.coursera.org/specializations/data-science-foundations-r)
(free for audit students).

## Installation

You can install `iramuteqlike` from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("gipso/iramuteqlike")
```

## Citation

If you use `iramuteqlike` in your research, please consider citing it.
We put a lot of work to build and maintain a free and open-source R
package. You can find the `iramuteqlike` citation below.

``` r
citation("iramuteqlike")
#> 
#> To cite {iramuteqlike} in publications use:
#> 
#>   Vartanian, D., Souza, A. A., & Pedrazzoli, M. (2021). {iramuteqlike}:
#>   an R package with tools to reproduce the IRaMuTeQ software analyses
#>   in R. https://gipso.github.io/iramuteqlike/
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Unpublished{,
#>     title = {{iramuteqlike}: an R package with tools to reproduce the IRaMuTeQ software analyses in R},
#>     author = {Daniel Vartanian and Alesandra Araujo {de Souza} and Mario Pedrazzoli},
#>     year = {2021},
#>     url = {https://gipso.github.io/iramuteqlike/},
#>     note = {Lifecycle: experimental},
#>   }
```

## Contributing

We welcome contributions, including bug reports. Take a moment to review
our [Guidelines for
Contributing](https://gipso.github.io/iramuteqlike/CONTRIBUTING.html).

Please note that `iramuteqlike` is released with a [Contributor Code of
Conduct](https://gipso.github.io/iramuteqlike/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
