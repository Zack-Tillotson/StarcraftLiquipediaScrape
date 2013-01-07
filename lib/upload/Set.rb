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
    
    def set_attr(is_player_one, attr, value)
      player = 
        if is_player_one
          @p1
        else
          @p2
        end
      case attr
        when "name"
          player.name = value
        when "race"
          player.race = value
        when "score"
          player.score = value
        when "flag"
          player.flag = value
      end
    end

    def to_s()
      "#{@event}, #{@gameid}, P1 #{@p1}, P2 #{@p2}"
    end

  end
end
