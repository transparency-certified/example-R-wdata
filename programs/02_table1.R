# This file creates Table 1 in the paper.  
# Author: Lars Vilhuber 


source(file.path(rprojroot::find_root(rprojroot::has_file("config.R")),"config.R"))

library(dplyr)
library(knitr)

  # table with appropriate weights 
  # tab specific_ak [fweight=pweight_num]
  # label define spec 0  "Not identified" 1 "Identified with one of the four tribes"
  # label value specific_ak spec

readRDS(dtam) %>%
    count(specific_ak, wt = pweight_num) %>%
    mutate(Tribes = factor(specific_ak,
                                labels = c("Not identified",
                                           "Identified with one of the four tribes"))
    ) %>%
    select(Tribes,n) -> table
  
  # output the table to latex 
  # latab specific_ak [fweight=pweight_num],  tf("$results/freq_specific_ak") replace dec(2)

sink(file=file.path(results,"freq_specific_ak.tex"))
table %>% kable(format="latex")
sink()
