require 'upload/Player'
require 'upload/Event'

module StarcraftLiquipediaScrape
  class Game

    def initialize(eventid, gameid, p1id, p1race, p2id, p2race, result, map, date)
      @gameid = gameid
      @p1 = Player.new(p1id, p1race)
      @p2 = Player.new(p2id, p2race)
      @result = result
      @map = map
      @date = date
      @event = Event.new(eventid)
    end

  end
end
