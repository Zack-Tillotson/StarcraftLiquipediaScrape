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

    def flag
      if @flag then @flag else "" end
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
