require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class GroupParser

    def initialize
      @status = "outside_all"
      @games = Hash.new
    end

    def parse(lines)

      lines.each do |line|

        puts "     #{line}"

        if @status == "outside_all"

          if not /\{\{GroupTableStart/.match(line)
            puts "Ignoring line"
            next
          else
            @status = "inside_group_table"
          end

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
