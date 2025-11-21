#!/usr/bin/env nu

def challenge-nested-closures [] {
    # TODO: Use nested closures to:
    # 1. Filter COVID data for countries with >10000 deaths
    # 2. Group by first letter of country name
    # 3. For each group, find the country with max confirmed cases
    # Expected: record with letter -> country name mapping
}

def challenge-debug-closures [] {
    # Fix these broken closure expressions:

    # Broken 1: ls -l ../data | where {|f| f.size > 1MB}
    # Broken 2: ls -l ../data | each {|file| file.name | str upcase | get name}
    # Broken 3: open ../data/covid_19_data.csv | where {|row| $row.Deaths > 1000 and Confirmed > 5000}

    # TODO: Identify syntax errors and fix them
}

def challenge-compose-operations [] {
    # TODO: Chain multiple closure operations:
    # 1. Load COVID data
    # 2. Filter countries where Deaths/Confirmed ratio > 0.05 (high mortality rate)
    # 3. Transform: add a 'severity' field calculated as Deaths * 2 + Confirmed
    # 4. Group by first 3 letters of country name
    # 5. Return top country by severity in each group
}

def challenge-performance-test [] {
    # TODO: Compare performance of different filtering approaches:
    # Method 1: Multiple separate where clauses
    # Method 2: Single complex closure with &&
    # Method 3: Filter -> Filter chain
    # Use 'timeit' to measure and return the fastest approach
}

def challenge-custom-aggregation [] {
    # TODO: Create a closure that:
    # 1. Takes COVID data grouped by country
    # 2. For each country, calculates a "risk score":
    #    (Deaths * 1.5 + Confirmed * 0.1) / number_of_records
    # 3. Returns countries sorted by risk score
    # Hint: You'll need items or each with complex inner logic
}

def challenge-fix-complex-function [threshold: int] {
    # This function should find countries where the difference between
    # max and min deaths across all records exceeds the threshold
    # But it has several errors - fix them:

    # open ../data/covid_19_data.csv
    # | group-by `Country/Region`
    # | items {|country, records|
    #     let max_deaths = ($records | get Deaths | math max)
    #     let min_deaths = ($records | get Deaths | math min)
    #     if ($max_deaths - $min_deaths) > threshold {
    #         {country: country, death_range: ($max_deaths - $min_deaths)}
    #     }
    # }

    # TODO: Fix syntax and logic errors
}

def main [] {
    # Test your solutions:
    # challenge-nested-closures
    # challenge-debug-closures
    # challenge-compose-operations
    # challenge-performance-test
    # challenge-custom-aggregation
    # challenge-fix-complex-function 100
}
