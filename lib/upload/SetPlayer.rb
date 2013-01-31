module StarcraftLiquipediaScrape
  class SetPlayer
    def initialize()
    end

    def race
      if @race then @race.downcase else "" end
    end

    def name
      @name
    end

    def flag
      if @flag then @flag.downcase else "" end
    end

    def score
      begin
        val = Integer(@score)
      rescue
        val =
          if @score == "W"
            1
          else
            0
          end
      end
      val
    end

    def race=(v)
      @race = v.strip
    end

    def name=(v)
      @name= v.strip
    end

    def score=(v)
      @score= v
    end

    def flag=(v)
      @flag= v.strip
    end

    def to_s()
      "SetPlayer #{@name} #{@race} #{@score} #{@flag}"
    end
  end
end
