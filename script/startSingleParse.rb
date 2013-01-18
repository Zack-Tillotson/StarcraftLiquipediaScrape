#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'parse/LiquipediaParser.rb'

parser = StarcraftLiquipediaScrape::LiquipediaParser.new('hsc6-playoffs', 'data/hsc6-playoffs.txt')
