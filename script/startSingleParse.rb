#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'parse/SingleElimBracketParser.rb'

parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('mlgspringobwseeds', 'data/mlgspringobwseeds.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('se8bracket', 'data/8sebracket.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('nasl4', 'data/nasl4.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('homestory6', 'data/homestorycup6.txt')
