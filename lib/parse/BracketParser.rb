require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class BracketParser

    def initialize
    end

    def can_parse_list
          ["4SEBracket", "6SEBracket", "8SEBracket", "12SEBracket", "16SEBracket", "32SEBracket", "64SEBracket", "32DEBracket", "MatchSummary|bestof=3", "MatchSummary|bestof=5", "MatchSummary|bestof=7", "MatchSummary|bestof=9", "IPL5FinalBracket", "MLGSummerBracket/Groups", "MLGSummerBracket", "MLGSpringOWBSeeds"]
    end

    def parse(lines)

      games = Hash.new
      game_line_no = 0

      lines.each do |line|

        puts "     #{line}"

        if !/R[0-9]+[A-Z][0-9]+/.match(line)
          puts "Ignoring line"
          next
        end

        # Every two lines should be a new game
        gameno = game_line_no / 2
        playerno = game_line_no % 2 == 0

        games[gameno] = StarcraftLiquipediaScrape::Set.new("#{gameno}") if !games.has_key?(gameno) 

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

      return games

    end

  end
end
