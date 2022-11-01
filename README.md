[![Create Table](https://github.com/labordynamicsinstitute/example-R-wdata/actions/workflows/compute.yml/badge.svg)](https://github.com/labordynamicsinstitute/example-R-wdata/actions/workflows/compute.yml)

# README

This is the same content as [labordynamicsinstitute/example-R-nodata](https://github.com/labordynamicsinstitute/example-R-nodata), with one key exception: The necessary data is included.

## Data

Data is public-use, but normally requires login at ICPSR. Data can be downloaded from https://doi.org/10.3886/ICPSR13568.v1. 

**However, because the data can be redistributed, and in this particular case is small, it is included in the repository!**

### Data acquisition


We downloaded the file `ICPSR_13568-V1.zip` from ICPSR, then

```{bash}
cd data
unzip $PATH/ICPSR_13568-V1.zip
```
Directory structure:

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

We only kept the files in directory `DS0002`.

The remainder of the methods of running this are unmodified here, see [labordynamicsinstitute/example-R-nodata](https://github.com/labordynamicsinstitute/example-R-nodata) for details.

NOTE: This will run as-is in the cloud.
