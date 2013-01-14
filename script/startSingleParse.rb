#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'parse/LiquipediaParser.rb'

#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('mlgspringobwseeds', 'data/mlgspringobwseeds.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('se8bracket', 'data/8sebracket.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('nasl4', 'data/nasl4.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('homestory6', 'data/homestorycup6.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012gslblizzardcup', 'data/2012gslblizzardcup.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('ironsquid2', 'data/ironsquid2.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('ipl5final', 'data/ipl5final.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012dreamhackopen', 'data/2012dreamhackopen.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('iemvii', 'data/iemvii.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012blizzardnet', 'data/2012blizzardnet.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012mlgch', 'data/2012mlgch.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('eswc2012', 'data/eswc2012.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012dhbuch', 'data/2012dhbuch.txt')
#parser = StarcraftLiquipediaScrape::SingleElimBracketParser.new('2012wcsasia', 'data/2012wcsasia.txt')
parser = StarcraftLiquipediaScrape::LiquipediaParser.new('2012wcsasia', 'data/2012wcsasia.txt')
