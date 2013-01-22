require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class BracketParser

    def initialize
      @games = Hash.new
      @game_line_no = 0
    end

    def can_parse_list
      ["[0-9]*SEBracket", "[0-9]*DEBracket", "IPL5FinalBracket", "MLGSummerBracket\"Groups", "MLGSummerBracket", "MLGSpringOWBSeeds", "CodeABracket"]
    end

    def parse(lines)

      inside_parsable_item = false
      parsable_items = Array.new

      lines.each do |line|

        found = false
        can_parse_list.each() do |name|
          if /^ *\{\{#{name}/.match(line)
            found = true
          end
        end
        if found
          inside_parsable_item = true
          parsable_items = Array.new
          next
        end

        if not inside_parsable_item
          next
        end
  
        line = line.gsub(/\{\{([^\}]*)\}\}/, '\1')

        if /(.*)\}\}/.match(line)
          if not $1.empty?()
            parsable_items.push $1
          end
          parse_item(parsable_items)
          inside_parsable_item = false
          parsable_items = Array.new
          next
        end

        parsable_items.push line

      end

      @games

    end

    def parse_item(lines)

      lines.each do |line|

        if !/R[0-9]+[A-Z][0-9]+/.match(line)
          next
        end

        # Every two lines should be a new game
        gameno = @game_line_no / 2
        playerno = @game_line_no % 2 == 0

        puts "#{gameno}, #{playerno} = #{line}"

        @games[gameno] = StarcraftLiquipediaScrape::Set.new("#{gameno}") if !@games.has_key?(gameno) 

        # Each line will have attibutes separated by bars
        line.split("|").each do |pev|
          pev.scan(/^R[0-9]+[A-Z][0-9]+(.*)=(.*)$/) do |attr, val|

            attr = "name" if attr == nil or attr.length() == 0
            val = val.gsub(/' .*/, "'").gsub("'", "")

            @games[gameno].set_attr(playerno, attr, val)

          end
        end 

        @game_line_no = @game_line_no + 1

      end

    end

  end
end
