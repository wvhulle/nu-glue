#!/usr/bin/env nu

let zip_file = "novel-corona-virus-2019-dataset.zip"
# Download and save the file
http get https://www.kaggle.com/api/v1/datasets/download/sudalairajkumar/novel-corona-virus-2019-dataset
| save -f $zip_file

# Extract the archive
^unzip -o $zip_file -d data
rm $zip_file
