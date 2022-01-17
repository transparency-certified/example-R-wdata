# This file reads in Alaska PUMS data 
# SRC: http://doi.org/10.3886/ICPSR13568.v1 
# Source program:  "ICPSR_13568/13568-Setup.do" was used
#   as a template, but that program cannot
#   be run as-is 
# Download data files to ICPSR_13568 
# Author: Lars Vilhuber 


source(file.path(rprojroot::find_root(rprojroot::has_file("config.R")),"config.R"))

  # Define macros, filenames and locations 
  datpums <- file.path(icpsrpath,"13568-0002-Data.txt")   # PUMS Data 
  dtahu   <- file.path(outputdata,"housing.Rds")  # Stata Housing Unit data 
  dcthu   <- file.path(programs,"housing.dct")  # Stata Housing Unit dictionary 
  schmahu <- paste0(dcthu,".csv")               # converted to schema
  dtap    <- file.path(outputdata,"person.Rds")   # Stata Person data 
  dctp    <- file.path(programs,"person.dct")   # Stata Person dictionary 
  schmap  <- paste0(dctp,".csv")               # converted to schema
  
  # global macros are defined in config.do 

# See setup.R for install instructions
#install.packages("remotes")
#remotes::install_github("mrdwab/StataDCTutils")
library(StataDCTutils)
library(dplyr)
library(readr)

# original Stata code
  # clear
  # infile using `dcthu' if rectype=="H", using ("`datpums'")
  # sort serialno   # sort data by Serial Number 
  # save `dtahu', replace  # save housing unit data 

dct.parser(dcthu, preview = TRUE)
dcthu_dict <- dct.parser(dcthu, 
                          includes = c("StartPos", "StorageType", "ColName", "ColWidth", "VarLabel"))
csvkit.schema(dcthu_dict)
# this always writes to the pwd
if (file.exists("housing.dct.csv")) {
  file.copy("housing.dct.csv",schmahu)
  file.remove("housing.dct.csv")
}
csvkit.fwf2csv(datpums, schmahu, file.path(outputdata,"housing.csv"))
# because this runs asynchronously, but should be fast, we wait for 10 secs
Sys.sleep(10)     
hu <- read_csv(file.path(outputdata,"housing.csv"))
saveRDS(hu,dtahu)

  # clear
  # infile using `dctp' if rectype=="P", using ("`datpums'")
  # sort serialno   # sort data by Serial Number 
  # save `dtap', replace # save person data 

dct.parser(dctp, preview = TRUE)
dctp_dict <- dct.parser(dctp, 
                         includes = c("StartPos", "StorageType", "ColName", "ColWidth", "VarLabel"))
csvkit.schema(dctp_dict)
# this always writes to the pwd
if (file.exists("person.dct.csv")) {
  file.copy("person.dct.csv",schmap)
  file.remove("person.dct.csv")
}
csvkit.fwf2csv(datpums, schmap, file.path(outputdata,"person.csv"))
# because this runs asynchronously, but should be fast, we wait for 10 secs
Sys.sleep(10)     
p <- read_csv(file.path(outputdata,"person.csv"))
saveRDS(p,dtap)

  # merge serialno using `dtahu' # merge person and housing unit data 
  # drop _merge
  # # keep only relevant information 
  # keep pweight race2 race1 numrace
  # # code a dummy to the four tribes 
  # gen specific_ak=(race2 == "31" | race2 == "32" | race2 == "33" | race2 == "34")
  # # convert weights 
  # destring pweight, gen(pweight_num)

merged <- left_join(p,hu,by="serialno") %>% 
        select(pweight,race2,race1,numrace) %>%
        mutate(specific_ak=(race2 == "31" | race2 == "32" | race2 == "33" | race2 == "34"),
               pweight_num=as.numeric(pweight))

  # # label variables 
  # label variable specific_ak "Identifying with one of the four tribes"
  # label variable pweight_num "Person weight"
  # saveold "dtam", replace  # save merged data 

saveRDS(merged,dtam)
  