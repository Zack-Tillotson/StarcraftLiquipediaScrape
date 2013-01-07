module StarcraftLiquipediaScrape
  class SetPlayer
    def initialize()
    end

    def race
      @race
    end

    def name
      @name
    end
    def score
      @score
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
      "SetPlayer #{@name} #{@race} #{@score} #{@flag}"
    end
  end
end
