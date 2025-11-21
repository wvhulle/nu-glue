#!/usr/bin/env nu

def solution-modified-today [] {
    ls -l ../data | where modified >= (date now) - 1day
}

def bonus-variations [] {
    print "Files modified in the last hour:"
    ls -l ../data | where modified >= (date now) - 1hr

    print "\nFiles modified in the last week:"
    ls -l ../data | where modified >= (date now) - 1wk

    print "\nFiles created today:"
    ls -l ../data | where created >= (date now) - 1day

    print "\nLarge files (>1MB) modified recently:"
    ls -l ../data | where modified >= (date now) - 1day and size > 1mb
}