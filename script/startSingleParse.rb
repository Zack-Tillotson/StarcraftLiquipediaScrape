#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'parse/SingleElimBracketParser.rb'

parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('mlgspringobwseeds', 'data/mlgspringobwseeds.txt')
