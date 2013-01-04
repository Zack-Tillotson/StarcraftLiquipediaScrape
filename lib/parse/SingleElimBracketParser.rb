require 'upload/Set'

module StarcraftLiquipediaScrape
  class SingleElimBracketParser

    def initialize(eventid, filename)

      @eventid = eventid
      @filename = filename
      parse()

    end

    def parse()

      # Get and clean up the data string
      txt = File.read(@filename)

      txt = txt.gsub(/\n|\r/, '')
      txt = txt.gsub(/\{\{ *[^ \<]* */, '')
      txt = txt.gsub(/\}\} */, '')
      txt = txt.gsub(/\<!--.*?--\>/, '')
      txt = txt.gsub(/\| *?/, '|').gsub(/ *?\|/, '|')

      # Split the data string into a collection of attributes
      attrlist = Hash.new 
      txt.split('|').collect { |v|
        v =~ /=/
        attrlist[$`] = $' if $` != nil
      }

      # Roll the attributes into game objects
      games = Hash.new
      attrlist.each_pair do |k,v|

        k.scan(/(R[0-9]+W)([0-9]+)(.*)/) do |gid, gnum, attr|
          gid = "#{gid}#{Integer(gnum) / 2}"
          attr = "name" if attr == nil or attr.length() == 0

          games[gid] = StarcraftLiquipediaScrape::Set.new(@eventid, gid) if !games.has_key?(gid) 
          games[gid].set_attr(1- Integer(gnum) % 2, attr, v)

        end
      end 

      # Save the game objects
      
    end

  end
end
