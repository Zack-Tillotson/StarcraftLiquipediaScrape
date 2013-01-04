module StarcraftLiquipediaScrape
  class SetPlayer
    def initialize()
    end

    def race=(v)
      @race = v
    end

    def name=(v)
      @name= v
    end

    def score=(v)
      @score= v
    end

    def flag=(v)
      @flag= v
    end

    def to_s()
      "#Player #{@id} #{@race}"
    end
  end
end
