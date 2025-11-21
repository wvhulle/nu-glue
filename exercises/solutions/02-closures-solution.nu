#!/usr/bin/env nu

def solution-closure-filter [] {
  ls -l ../data | where {|item| ($item.created - (date now)) > 1year }
}

def solution-complex-filter [] {
  # Files larger than 100KB AND created in last 30 days
  ls -l ../data | where {|f| $f.size > 100kb and ($f.created - (date now)) < 30day }
}

def solution-custom-logic [] {
  # Files that are either very large (>1MB) OR very recently modified (last hour)
  ls -l ../data | where {|f| $f.size > 1mb or ($f.modified - (date now)) > -1hr }
}

# Alternative approaches
def alternative-solutions [] {
  # Using $it syntax (shorter for simple conditions)
  print "Using $it syntax:"
  ls -l ../data | where $it.size > 100kb

  # Combining with other operations
  print "\nCombined with sorting:"
  ls -l ../data
  | where {|f| $f.size > 100kb }
  | sort-by modified --reverse
}
