require 'upload/Player'
require 'upload/Event'

module StarcraftLiquipediaScrape
  class Game

    def initialize(eventid, gameid, p1id, p1race, p2id, p2race, result, map, date)
      @gameid = gameid
      @p1 = Player.new(p1id.strip, p1race.strip)
      @p2 = Player.new(p2id.strip, p2race.strip)
      @result = result
      @map = map
      @date = date
      @event = Event.new(eventid)
    end

    def p1()
      @p1
    end

    def p2()
      @p2
    end

  end
end
