require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class SingleElimBracketParser

    def initialize(eventid, filename)

      @eventid = eventid
      @filename = filename
      parse()

    end

    def can_parse_list
          ["4SEBracket", "6SEBracket", "8SEBracket", "MLGSpringOWBSeeds", "16SEBracket", "32SEBracket", "64SEBracket", "MatchSummary|bestof=3", "MatchSummary|bestof=5", "MatchSummary|bestof=7", "MatchSummary|bestof=9", "IPL5FinalBracket", "12SEBracket", "MLGSummerBracket/Groups", "MLGSummerBracket", "32DEBracket"]
    end

    def parse()

      games = Hash.new
      game_line_no = 0
      can_parse = false

      f = File.open(@filename)
      f.each do |line|

        line = line.gsub(/ */, '')

        # Ignore comments and lines we don't care about
        if / *\{\{(.*)$/.match(line)
          inside_parse_item = true
          can_parse = (can_parse_list().include? $1)
          if !can_parse
            puts "Can't parse #{$1}"
          end
        end 

        if / *\}\}/.match(line)
          inside_parse_item = false
        end

        if / *\{\{(.*)^/.match(line) or /^ *<!--/.match(line) or /^ *\}\}/.match(line) or !/R[0-9]+[A-Z][0-9]+/.match(line) or !can_parse
          next
        end

        # Every two lines should be a new game
        gameno = game_line_no / 2
        playerno = game_line_no % 2 == 0

        games[gameno] = StarcraftLiquipediaScrape::Set.new(@eventid, "#{gameno}") if !games.has_key?(gameno) 

        # Each line will have attibutes separated by bars
        line.split("|").each do |pev|
          pev.scan(/^R[0-9]+[A-Z][0-9]+(.*)=(.*)$/) do |attr, val|

            attr = "name" if attr == nil or attr.length() == 0
            val = val.gsub("'", "")

            games[gameno].set_attr(playerno, attr, val)

          end
        end 

        game_line_no = game_line_no + 1

      end
      
      # Save the game objects
      uploader = StarcraftLiquipediaScrape::SetUploader.new()
      games.each_pair do |key, game|
        uploader.upload(game)
      end
      uploader.done()

    end

  end
end
