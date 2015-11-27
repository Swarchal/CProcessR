[![build status](https://travis-ci.org/Swarchal/CProcessR.svg?branch=master)](https://travis-ci.org/Swarchal/CProcessR)

CProcessR
============

Note: am biologist, no idea what I'm doing.

Package for the semi-automated processing of CellProfiler data in R. Aim to to get raw CellProfiler output into a simple useable dataframe. No effort should be made to write code for analysis or visualisation of the data - this is just for processing!

- Two families of functions:
	- Those for dealing with .csv files
	- Those for reading from an SQL database

- Want the ability to chain together modular functions with magrittr pipes (%>%) to quickly build a pipeline (think how well dplyr works...)

- Might be easier if initial settings (cell-lines, objects, etc) are stored in a structured .txt file which is imported into the package. This should make actual use much easier once set up, as the functions can read any required arguments from the setup file rather than repeating arguments.
	- Create function to initialise a skeleton setup.txt file in the working directory, then everything should be in the correct format to be read by the package.
	- One option to to use a .csv file since we're in R and will make extracting values from it much easier.

- (pipedream) Can produce a markdown file detailing the processing steps used and any summary statistics (such as which outlier images were removed) and save in the working directory.

- Ideally should be working with databases (SQLite) rather than .csv files.

## Principal functions

### CSV family:

- Load multiple .csv files produced by CP into an SQLite database
- Sort out column names so consistent with the to_database output of CP

### SQL family:

- Process tables and column names to a sensible default

### Universal:
CSV or SQL should produce dataframes in the same format that can then be passed to universal functions

- Summarise object data into well or image averages
- Identify outlier images
	- Show image
	- Make it easy to remove data from outliers from further analysis
	- Want ability to run this in a fully automated fashion, and also in a semi-automated fashion that requires user input.
- Normalise
	- against negative control values for each variable per plate
	- other normalisation methods (which?)
