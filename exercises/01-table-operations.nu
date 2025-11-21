#!/usr/bin/env nu

def challenge-multi-criteria [] {
    # TODO: Find files that are:
    # - Larger than 500KB
    # - Modified within the last 2 days
    # - Have "covid" in the filename (case insensitive)
    # Sort by size (largest first), show only name, size, and modified
}

def challenge-date-ranges [] {
    # TODO: Group files by modification week and count them
    # Hint: You'll need to manipulate the date format first
    # Expected output: table with week and file count
}

def challenge-debug-filter [] {
    # This command has multiple errors - fix them:
    # ls -l ../data | where size > 1MB && modified > (date now - 1week) | select name size
    #
    # TODO: Identify and fix at least 3 syntax issues
}

def challenge-size-stats [] {
    # TODO: Calculate statistics about file sizes in the data directory:
    # - Total size of all files
    # - Average file size
    # - Number of files larger than the median size
    # Return as a structured record
}

def find-recent-large-files [min_size: filesize, days_back: duration] {
    # TODO: Create a reusable function that finds files:
    # - Larger than min_size parameter
    # - Modified within days_back from now
    # - Returns sorted by modification date (newest first)
}

def main [] {
    # Test your solutions here
    # challenge-multi-criteria
    # challenge-date-ranges
    # challenge-debug-filter
    # challenge-size-stats
    # find-recent-large-files 1MB 3day
}