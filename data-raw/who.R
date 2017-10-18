library(tidyverse)
library(glue)

# bc who column names are weird
parse_percentile <- function(x){
  x <- str_replace( x, "^P", "" )
  case_when(
    x == "01"  ~ .1,
    x == "999" ~ 99.9,
    TRUE       ~ as.numeric(x)
  )
}

parse_who <- function(url, sex, variable ){
  variable <- ensym(variable)

  read_delim(url,
      delim = "\t", col_types = list( .default = col_double() )
    ) %>%
    select( -(L:S) ) %>%
    gather( percentile, !!variable, starts_with("P")) %>%
    mutate(
      percentile = parse_percentile(percentile),
      sex = !!sex
    )
}

w <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/wfa_girls_p_exp.txt", "F", weight ),
  parse_who( "http://www.who.int/childgrowth/standards/wfa_boys_p_exp.txt", "M", weight )
)
h <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/lhfa_girls_p_exp.txt", "F", height ),
  parse_who( "http://www.who.int/childgrowth/standards/lhfa_boys_p_exp.txt", "M", height )
) %>% rename( Age = Day)


