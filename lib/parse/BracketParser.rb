require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class BracketParser

    def initialize
      @games = Hash.new
    end

    def can_parse_list
      ["[0-9]*SEBracket", "[0-9]*DEBracket", "IPL5FinalBracket", "MLGSummerBracket\"Groups", "MLGSummerBracket", "MLGSpringOWBSeeds"]
    end

    def parse(lines)

      inside_parsable_item = false
      parseable_items = Array.new

      lines.each do |line|

        found = false
        can_parse_list.each() do |name|
          if /^ *\{\{#{name}/.match(line)
            found = true
          end
        end
        if found
          inside_parseable_item = true
          parseable_items = Array.new
          next
        end

        if not inside_parseable_item
          next
        end

        if /(.*)\{\{(.*)\}\}(.*)/.match(line)
          line = $1+$2+$3
        end

        if /(.*)\}\}/.match(line)
          if not $1.empty?()
            parseable_items.push $1
          end
          parse_item(parseable_items)
          inside_parseable_item = false
          parseable_items = Array.new
          next
        end

        parseable_items.push line

      end

      @games

    end

    def parse_item(lines)

      game_line_no = 0

      lines.each do |line|

        if !/R[0-9]+[A-Z][0-9]+/.match(line)
          next
        end

        puts line

        # Every two lines should be a new game
        gameno = game_line_no / 2
        playerno = game_line_no % 2 == 0

        @games[gameno] = StarcraftLiquipediaScrape::Set.new("#{gameno}") if !@games.has_key?(gameno) 

        # Each line will have attibutes separated by bars
        line.split("|").each do |pev|
          pev.scan(/^R[0-9]+[A-Z][0-9]+(.*)=(.*)$/) do |attr, val|

            attr = "name" if attr == nil or attr.length() == 0
            val = val.gsub("'", "")

            @games[gameno].set_attr(playerno, attr, val)

          end
        end 

        game_line_no = game_line_no + 1

      end

    end

  end
end
