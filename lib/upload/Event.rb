module StarcraftLiquipediaScrape
  class Event
    def initialize(id)
      @id = id
    end

    def id
      @id
    end

    def to_s()
      "Event #{@id}"
    end
  end
end
