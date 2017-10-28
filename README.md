
<!-- README.md is generated from README.Rmd. Please edit that file -->
gammabuster
===========

The gammabuster package contains two functions that translate judgemental estimates about a random variable into the gamma distrribution parameters consistent with that judgement. This is helpful because the parameters of a gamma distribution--the shape and scale parameters--don't have a real-world interpretation. It's hard to make elicit judgemental estimates of a gamma distribution via its parameters directly. However, it's relatively straightforward to elicit judgemnts about the likely upper and lower bounds of the distribution or about the mean and range of the distribution. The gammabuster package converts these judgments into needed paramater estimates.

Installation
------------

You can install gammabuster from github with:

``` r
# install.packages("devtools")
devtools::install_github("JohnsonBrent/gammabuster")
```

Example
-------

Here's one example. Suppose one has elicited judgments that the range of a random variable lies between 0 and 5. Assuming the random variable is strictly positive and continuous within this space, a gamma might be the appropriate distribution. If so, the following function generates the gamma parameters consistent with the judgement:

``` r
GbusterMinMax(0, 5)
```

There are more examples and a deeper explanation in the vignette.
