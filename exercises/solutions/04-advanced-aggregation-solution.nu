#!/usr/bin/env nu

def solution-step-by-step [] {
  print "Step 1: Basic grouping (creates a record)"
  open ../data/covid_19_data.csv | group-by `Country/Region`

  print "\nStep 2: Convert to table with transpose"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows

  print "\nStep 3: Calculate totals for each group"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows
  | each {|group| $group.rows | get Deaths | math sum }

  print "\nStep 4: Create structured output"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | transpose country rows
  | each {|group|
    {country: $group.country total_deaths: ($group.rows | get Deaths | math sum)}
  }
  | sort-by total_deaths --reverse
}

def solution-alternative-methods [] {
  # Method 1: Using 'items' (more idiomatic for records)
  print "Using items method:"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | items {|country rows|
    {country: $country total_deaths: ($rows | get Deaths | math sum)}
  }
  | sort-by total_deaths --reverse

  # Method 2: Direct approach with reduce
  print "\nUsing reduce approach:"
  open ../data/covid_19_data.csv
  | reduce --fold {} {|row acc|
    let country = $row.`Country/Region`
    let deaths = $row.Deaths
    $acc | upsert $country {|current|
      if ($current | get $country | is-empty) {
        $deaths
      } else {
        ($current | get $country) + $deaths
      }
    }
  }
}

def solution-bonus-exercises [] {
  print "1. Countries with highest average deaths per record:"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | items {|country rows|
    {country: $country avg_deaths: ($rows | get Deaths | math avg)}
  }
  | sort-by avg_deaths --reverse

  print "\n2. Top 5 countries by total deaths:"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | items {|country rows|
    {country: $country total_deaths: ($rows | get Deaths | math sum)}
  }
  | sort-by total_deaths --reverse
  | first 5

  print "\n3. Global statistics:"
  let data = (open ../data/covid_19_data.csv)
  {
    total_deaths: ($data | get Deaths | math sum)
    total_confirmed: ($data | get Confirmed | math sum)
    countries_count: ($data | get `Country/Region` | uniq | length)
    max_single_death_count: ($data | get Deaths | math max)
  }
}
