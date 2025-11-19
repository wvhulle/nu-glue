#! /usr/bin/env nu

# For this workshop it is necessary to download the COVID-19 dataset from Kaggle.
# Use the `fetch-data.nu` script to download and extract the data.

def demo [] {
  # Listing files
  ls -l file.txt

  # The information runs off the screen
  ls -l file.txt | transpose

  # We are only interested in accessed and modified times
  ls -l file.txt | select name modified accessed
}

def single-values [] {
  # What is today's date?
  date now
  # What is the output exactly?
  date now | describe
  # All values in Nu have a type (also Any)
  # What is the date within 7 days?
  (date now) + 7day
  # Write this using a pipeline
  date now | $in + 7day
  # An easier way to calculate dates
  "in 2 minutes" | date from-human
}

def table-operations [] {
  # List the files in the "data" directory
  ls data/

  # Show unique all unique dates on which files in data where modified
  ls data/ | select modified | uniq

  # TODO: Shows all files modified today in the "data" directory,
  ls -l data | where modified >= (date now) - 1day
}

def row-conditions [] {
  # Show all files created more than 1 year ago
  ls -l data | where ($it.created - (date now)) > 1year
  # A year is not a fixed number of days, because of leap years.
  ls -l data | where ($it.created - (date now)) > 51wk
  # TODO: You just learned to filter files. Now, write it as a closure.
}

def csv-exploration [] {
  open data/covid_19_data.csv
  # This shows too much data at once, explore interactively
  open data/covid_19_data.csv | describe
  open data/covid_19_data.csv | explore
  # Get all unique countries/regions in the dataset`
  open data/covid_19_data.csv | get `Country/Region` | uniq | sort
}

def interactive-commands [] {
  open data/covid_19_data.csv | explore
  # Type :help for help about explore
  # For example: t for transpose, q for quit

  # Use :try for imperative manipulation
  
  # Search for patterns with `where country =~ "It"`
  # Drop a column with reject Confirmed

  # You zoom into the data and copy selected value on `q`
  # explore --peek

  # TODO: try sorting by Deaths descending
  open data/covid_19_data.csv | sort-by Deaths --reverse | explore
}

# Compute the total amount of deaths per country/region
def compute-deaths-per-country [] {
  # Group rows by country (returns a RECORD, not a table!)
  # Keys = country names, Values = tables of rows for that country
  open data/covid_19_data.csv | group-by `Country/Region`

  # Convert the record to a table with 2 columns: country and rows
  # This makes it easier to work with in a pipeline
  open data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows

  # For each group, calculate the sum of deaths
  # The closure parameter |group| gives us access to each row
  # $group.country = the country name
  # $group.rows = table of all rows for that country
  open data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows
  | each {|group| $group.rows | get Deaths | math sum}

  # Create a structured record with country name and total
  # This gives us a nice table with named columns
  open data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows
  | each {|group|
      {country: $group.country, total_deaths: ($group.rows | get Deaths | math sum)}
    }

  # Sort by total deaths (highest first)
  open data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows
  | each {|group|
      {country: $group.country, total_deaths: ($group.rows | get Deaths | math sum)}
    }
  | sort-by total_deaths --reverse

  # Alternative: Using items (more idiomatic for records)
  # items iterates over key-value pairs directly without needing transpose
  open data/covid_19_data.csv
  | group-by `Country/Region`
  | items {|country, rows|
      {country: $country, total_deaths: ($rows | get Deaths | math sum)}
    }
  | sort-by total_deaths --reverse
}

def reflection-examples [] {
  # Show the structure of a Nu expression
  ast 'let a = 3 + 4'
  # This is too much at once, explore interactively
  ast 'let a = 3 + 4' | get block | describe
  # It is just a string. We need to output in JSON and parse
  # Use enter, arrows and escape
  ast --json 'let a = 3 + 4' | get block | from json | explore
}

def main [] {
  single-values
  table-operations
  row-conditions
  csv-exploration
  interactive-commands
  compute-deaths-per-country
  reflection-examples
}
