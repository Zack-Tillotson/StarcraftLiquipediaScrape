require 'upload/Set'
require 'upload/SetUploader'
require 'parse/BracketParser'
require 'parse/GroupParser'

module StarcraftLiquipediaScrape
  class LiquipediaParser

    def initialize(event, filename)

      @event = event
      @filename = filename

      @parsers = Array.new
      @parsers.push StarcraftLiquipediaScrape::BracketParser.new
      @parsers.push StarcraftLiquipediaScrape::GroupParser.new

      @games = Hash.new

      parse()
      save()

    end

    def attempt_parsing(lines)
      @parsers.each do |p|
        games = p.parse(lines)
        puts "#{p.class}, #{games.length}"
        @games = merge_games(games)
      end
    end

    def merge_games(games)
      
      @games = @games.merge(games)

    end

    def parse()

      item_lines = Array.new
      inside_parse_item = false

      f = File.open(@filename)
      f.each do |line|

        line = line.gsub(/ +/, " ")
        line = line.gsub(/^ */, "")
        line = line.gsub(/ *$/, "")
        line = line.gsub(/ *\|/, "|")
        line = line.gsub(/\| */, "|")

        item_lines.push line

      end

      attempt_parsing item_lines
      
    end

    def save()

      #puts "Save!"

      # Save the game objects
      uploader = StarcraftLiquipediaScrape::SetUploader.new()
      @games.each_pair do |key, game|
        game.event = Event.new @event
        uploader.upload(game)
      end
      uploader.done()

    end

  end
end
