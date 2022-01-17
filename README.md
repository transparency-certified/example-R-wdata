# README

## Data

Data is public-use, but requires login at ICPSR. Data can be downloaded from https://doi.org/10.3886/ICPSR13568.v1. 

**It must be downloaded manually (no API), then unzipped.**

Target directory structure:

```
data/
   ICPSR_13568/
      DS0001/
      DS0002/
         13568-0002-Data.txt
         13568-0002-Documentation.txt
      DS0003/
      ...
      DS0072/
```

Assuming you downloaded the file `ICPSR_13568-V1.zip` from ICPSR, the following will recreate the directory structure:

```{bash}
cd data
unzip $PATH/ICPSR_13568-V1.zip
```

## Requirements

Runtime: approximatly 1.6s on 2021 vintage Linux workstation.

Software:
- R 4.1
- `tidyverse` and `rprojroot` already installed.
- Ideally: Docker and access to internet

## Code

There are 5 R program files:

In *programs/*:

- `master.R` : will run all programs in the right sequence
- `01_dataclean.R`: reads in downloaded data, saves person and household files, and creates a clean merged dataset, for Alaska only
- `02_table1.R`: Creates Table 1
- `config.R`: sets up the environment. Called by `master.R` and all other programs.

In *root* directory:

- `setup.R`: installs all R packages. Must be run prior to `master.R` in same R session. Is used to build Docker image.

## Running code

### Running locally (no Docker)

- open R
- source `setup.R` to install packages (assuming `tidyverse` and `rprojroot` already installed)
- source `master.R` to run code and generate table.

### Running locally (Docker)

- Optional: 
  - Adjust `./build.sh` to write image with your Docker Hub ID. You will then need to 
  - Run `./build.sh`  to build Docker image
- Run `./run_locally.sh` to run all R code.
- Optional:
  - Run `./start_rstudio.sh` to interactively run Rstudio in your browser.

### Running remotely (Docker)

The following should work, **if data are available**:

- `docker pull larsvilhuber/example-r-nodata:2022-01-16`
- `./run_locally.sh`

## Tables

All table output is in folder `tables`:

| Table | Programs | 
|-------|----------|
| Table 1 | 02_table1.R | 

Output:

```
tables/freq_specific_ak.tex
```


