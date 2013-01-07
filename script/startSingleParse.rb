#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'parse/SingleElimBracketParser.rb'

parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('mlgspringobwseeds', 'data/mlgspringobwseeds.txt')
parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('se8bracket', 'data/8sebracket.txt')
