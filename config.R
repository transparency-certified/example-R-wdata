# config.R
# Suggested by Lars Vilhuber 
# Create a reproducible R sequence by calling this program from every other program in your sequence 

   


# paths 

basepath <- rprojroot::find_root(rprojroot::has_file("config.R"))

# Main directories

icpsrpath <- file.path(basepath,"data","ICPSR_13568","DS0002")  # local relative path 
inputdata <- file.path(basepath,"data","inputdata")  # this is where you would read data acquired elsewhere
outputdata <- file.path(basepath,"data","outputdata") # this is where you would write the data you create in this project
results <- file.path(basepath,"tables")       # All tables for inclusion in your paper go here
programs <- file.path(basepath,"programs")    # All programs (which you might <- file.path(include") are to be found here


for ( dir in list(icpsrpath,inputdata,outputdata,results)){
	if (file.exists(dir)){
	} else {
	dir.create(file.path(dir))
	}
}

dtam  <- file.path(outputdata,"pumsak.Rds")  # Stata PUMS merged data 


