#!/usr/bin/env nu

def solution-interactive-sorting [] {
  open ../data/covid_19_data.csv | sort-by Deaths --reverse | explore
}

def solution-explore-patterns [] {
  print "1. Countries containing 'United':"
  open ../data/covid_19_data.csv | where (`Country/Region` =~ "United") | explore

  print "2. High-death countries sorted by confirmed cases:"
  open ../data/covid_19_data.csv
  | where Deaths > 1000
  | sort-by Confirmed --reverse
  | explore

  print "3. Focused view with selected columns:"
  open ../data/covid_19_data.csv
  | select `Country/Region` Confirmed Deaths
  | explore
}

def solution-peek-explore [] {
  # Peek mode for quick data inspection
  open ../data/covid_19_data.csv | explore --peek
}

# Advanced exploration patterns
def advanced-exploration [] {
  print "Explore system information:"
  sys | explore

  print "Explore file system with size information:"
  ls -l ../data | sort-by size --reverse | explore

  print "Explore grouped data:"
  open ../data/covid_19_data.csv
  | group-by `Country/Region`
  | explore
}
