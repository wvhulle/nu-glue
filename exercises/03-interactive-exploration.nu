#!/usr/bin/env nu

def challenge-data-detective [] {
    # TODO: Use explore to answer these questions about COVID data:
    # 1. Which country has the highest Deaths/Confirmed ratio?
    # 2. Find countries where Deaths > Confirmed (data anomalies)
    # 3. Identify the top 3 countries by total confirmed cases
    # Return your findings as a structured record, don't just print them
}

def challenge-interactive-cleaning [] {
    # TODO: Create an interactive data cleaning pipeline:
    # 1. Load COVID data and explore to find data quality issues
    # 2. Filter out records where any numeric field is null or negative
    # 3. Use explore to verify your cleaning worked
    # 4. Return cleaned dataset with summary statistics
}

def challenge-custom-explorer [column_name: string] {
    # TODO: Create a function that:
    # 1. Groups COVID data by the specified column
    # 2. Shows group sizes and lets user explore interactively
    # 3. After exploration, returns the group with highest average deaths
    # 4. Handle invalid column names gracefully
}

def challenge-performance-explorer [] {
    # TODO: Create an exploration workflow that:
    # 1. Loads COVID data and adds computed columns:
    #    - mortality_rate: Deaths / Confirmed
    #    - cases_per_million: Confirmed / Population (assume 1M if missing)
    # 2. Use explore to identify outliers interactively
    # 3. Return countries that are outliers in both metrics
}

def challenge-debug-exploration [] {
    # This function has bugs - fix them:
    # let data = open ../data/covid_19_data.csv
    # let filtered = $data | where Confirmed > 1000
    # let grouped = $filtered | group-by Country/Region
    # $grouped | items {|country, records|
    #     let total = $records | get Confirmed | math sum
    #     {country: $country, total: total}
    # } | sort-by total --reverse | explore

    # TODO: Fix syntax errors and logic issues
}

def challenge-advanced-patterns [] {
    # TODO: Combine multiple exploration techniques:
    # 1. Load COVID data and create pivot-like view (countries vs metrics)
    # 2. Use explore with custom transformations during exploration (:try mode)
    # 3. Build an interactive "drill-down" experience:
    #    - Start with country summary
    #    - Let user select a country to see detailed records
    #    - Provide comparison with regional averages
}

def challenge-memory-efficient [] {
    # TODO: Handle large dataset exploration efficiently:
    # 1. Create streaming approach for COVID data (process in chunks)
    # 2. Use explore --peek strategically to avoid loading everything
    # 3. Implement progressive loading based on user selections
    # 4. Compare memory usage of different approaches
}

def main [] {
    # Test your solutions (comment/uncomment as needed):
    # challenge-data-detective
    # challenge-interactive-cleaning
    # challenge-custom-explorer "Country/Region"
    # challenge-performance-explorer
    # challenge-debug-exploration
    # challenge-advanced-patterns
    # challenge-memory-efficient
}
