#!/usr/bin/env nu

# Setup topiary configuration for nushell formatting support
def main [
  topiary_nu_module: path # Path to the topiary-nushell module
  --config-source: path = "languages.ncl" # Path to the source Nickel config file
]: nothing -> nothing {
  let topiary_dir = ".topiary"
  let languages_dir = $"($topiary_dir)/languages"
  let config_file = $"($topiary_dir)/languages.ncl"
  let query_file = $"($languages_dir)/nu.scm"
  let source_query = $"($topiary_nu_module)/languages/nu.scm"

  mkdir $languages_dir

  # Copy the nushell query file if it doesn't exist or is different
  if not ($query_file | path exists) or (open $source_query | hash md5) != (open $query_file | hash md5) {
    cp $source_query $query_file
    chmod 644 $query_file
  }

  # Copy the Nickel config if it doesn't exist or is different
  if not ($config_file | path exists) or (open $config_source | hash md5) != (open $config_file | hash md5) {
    cp $config_source $config_file
    chmod 644 $config_file
  }
}
