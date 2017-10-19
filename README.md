
who
===

Data from the World Health Organisation

Installation
------------

You can install who from github with:

``` r
# install.packages("devtools")
devtools::install_github("ThinkR-open/who")
```

Example
-------

``` r
glimpse( who::standards )
#> Observations: 55,710
#> Variables: 9
#> $ Age                  <dbl> 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12,...
#> $ sex                  <chr> "F", "F", "F", "F", "F", "F", "F", "F", "...
#> $ percentile           <dbl> 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0...
#> $ weight               <dbl> 2.002, 1.963, 1.972, 1.986, 2.004, 2.023,...
#> $ height               <dbl> 43.392, 43.551, 43.711, 43.869, 44.029, 4...
#> $ head_circumference   <dbl> 30.219, 30.322, 30.427, 30.531, 30.636, 3...
#> $ arm_circumference    <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
#> $ subscapular_skinfold <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
#> $ triceps_skinfold     <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
```
