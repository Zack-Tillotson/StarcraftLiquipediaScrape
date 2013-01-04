require 'upload/SetPlayer'
require 'upload/Event'

module StarcraftLiquipediaScrape
  class Set

    def initialize(eventid, gameid)
      @event = Event.new(eventid)
      @gameid = gameid
      @p1 = SetPlayer.new
      @p2 = SetPlayer.new
    end 
    
    def set_attr(player, attr, value)
      puts "#{@event}-#{@gameid} - Setting #{attr} to #{value}"
      p = 
        if player == 0
          @p1
        else
          @p2
        end
      case attr
        when "name"
          p.name = value
        when "race"
          p.race = value
        when "score"
          p.score = value
        when "flag"
          p.flag = value
      end
    end

  end
end
