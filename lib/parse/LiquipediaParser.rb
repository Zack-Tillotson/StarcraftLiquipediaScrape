require 'upload/Set'
require 'upload/SetUploader'
require 'parse/BracketParser'

module StarcraftLiquipediaScrape
  class LiquipediaParser

    def initialize(eventid, filename)

      @eventid = eventid
      @filename = filename
      @games = Hash.new

      @parsers = Array.new
      @parsers.push StarcraftLiquipediaScrape::BracketParser.new

      parse()
      save()

    end

    def attempt_parsing(name, lines)
      @parsers.each do |p|
        if p.can_parse_list().include?(name)
          puts "Parser says it can parse"
          gs = p.parse(lines)
          #TODO Merge with currently parsed games
          @games = gs
        end
      end
    end

    def parse()

      item_lines = Array.new
      item_name = ""
      inside_parse_item = false

      f = File.open(@filename)
      f.each do |line|

        line = line.gsub(/ */, '')

        puts "   #{line}"

        # An item starts with "{{<name>"
        if /\{\{(.*)$/.match(line)
          inside_parse_item = true
          item_name = $1
          puts "Inside parse item #{item_name}"
        end 

        # Make sure to save the last line if needed
        if /([^\}]+)\}\}/.match(line)
          item_lines.push $1
        end
        
        # An item ends with "...}}"
        if /\}\}/.match(line)
          inside_parse_item = false
          puts "Outside parse item"
        end

        # If done with the item send it to a parser and end
        if !inside_parse_item and item_lines.length > 0
          puts "Sending to parsers!"
          attempt_parsing(item_name, item_lines) 
          item_lines = Array.new
        end

        # Skip some lines we don't care about
        if /\{\{/.match(line) or /<!--/.match(line) or /^ *$/.match(line)
          puts "Skipping this line"
          next
        end

        # Add this line to the end of the array
        if inside_parse_item
          puts "Adding to item_lines"
          item_lines.push line
        end

      end
      
    end

    def save()

      puts "Save!"
      puts @games

      # Save the game objects
      uploader = StarcraftLiquipediaScrape::SetUploader.new()
      @games.each_pair do |key, game|
        game.event = Event.new @eventid
        uploader.upload(game)
      end
      uploader.done()

    end

  end
end
