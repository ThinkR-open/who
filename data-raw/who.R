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

hc <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/second_set/hcfa_girls_p_exp.txt", "F", head_circumference ),
  parse_who( "http://www.who.int/childgrowth/standards/second_set/hcfa_boys_p_exp.txt", "M", head_circumference )
)

ac <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/second_set/acfa_girls_p_exp.txt", "F", arm_circumference ),
  parse_who( "http://www.who.int/childgrowth/standards/second_set/acfa_boys_p_exp.txt", "M", arm_circumference )
)

ss <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/second_set/ssfa_girls_p_exp.txt", "F", subscapular_skinfold ),
  parse_who( "http://www.who.int/childgrowth/standards/second_set/ssfa_boys_p_exp.txt", "M", subscapular_skinfold )
)

ts <- bind_rows(
  parse_who( "http://www.who.int/childgrowth/standards/second_set/tsfa_girls_p_exp.txt", "F", triceps_skinfold ),
  parse_who( "http://www.who.int/childgrowth/standards/second_set/tsfa_boys_p_exp.txt", "M", triceps_skinfold )
)

datasets <- list(w,h,hc,ac,ss,ts)
who <- reduce(datasets, full_join, by = c("Age", "percentile", "sex")) %>%
  select( Age, sex, percentile, everything() )


