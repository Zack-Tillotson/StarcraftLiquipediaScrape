require 'upload/Set'
require 'upload/SetUploader'

module StarcraftLiquipediaScrape
  class GroupParser

    def initialize
      @status = "outside_all"
      @players = Hash.new
      @games = Hash.new
      clearVars()
    end

    def parse(lines)

      lines.each do |line|

        line = line.gsub(/ *\|/, "|").gsub(/\| */, "|").gsub(/&amp;nbsp;/, "")

        #puts "     #{@status} #{line}"

        if @status == "outside_all"

          if not /\{\{GroupTableStart/.match(line)
            next
          else
            @status = "inside_group_table"
            puts "inside group table"
            next
          end

        end

        if @status == "inside_group_table"

          if /\{\{GroupTableSlot/.match(line)
              country = ""
              race = ""
              name = ""
            if /\{\{player\|flag=([^\|]*)\|race=([^\|]*)\|([^\}]*)\}\}/.match(line)
              country = $1
              race = $2
              name = $3
            elsif /\{\{player\|race=([^\|]*)\|flag=([^\|]*)\|([^\}]*)\}\}/.match(line)
              race = $1
              country = $2
              name = $3
            else
              puts "Error getting players"
              next
            end

              name = name.gsub(/\|.*$/, "")

              puts "save player #{name}, #{country}, #{race}"
              savePlayer(name, country, race)
            next
          elsif /\{\{MatchListStart/.match(line)
            @status = "inside_compact_matches"
            puts "inside match compact list"
            next
          elsif /\{\{MatchList\|/.match(line) or /\{\{MatchList *$/.match(line)
            @status = "inside_matches"
            puts "inside match list"
            next
          elsif /\{\{GameSet/.match(line)
            puts "inside GameSet"
            if /\{\{GameSet\|\{\{.*\|([^\|]+)\}\}\|\{\{.*\|([^\|]+)\}\}\|map=([^\|]+)\|win=([0-9]+)/.match(line)
              @player1 = $1
              @player2 = $2
              @map = $3
              @winner = $4
              makeGame()
              next
            else
              puts "Not a real game"
            end
          end

        end
            
        if @status == "inside_compact_matches"
          if /\{\{MatchListSlot(.*)/.match(line)
            line = $1.gsub(/[^A-Za-z 0-9 \.,\?'""!@#\$%\^&\*\(\)-_=\+;:<>\/\\\|\}\{\[\]`~]*/, "").gsub(/\{\{[^\}]*\}\}/, "").gsub(/ /, "")
            /\|([^\|]+)\|([^\|]+)\|games1=([^\|]+)\|games2=([^\|]+)\|/.match(line)
            @player1 = $1
            @player2 = $2
            @score1 = $3
            @score2 = $4
            makeGame()
          end
        end

        if @status == "inside_compact_matches" and /\{\{MatchListEnd/.match(line)
          @status = "outside_all"
          next
        end

        if @status == "inside_matches"

          if /|GroupTableSlot/.match(line)
            @status = "inside_a_match"
            puts "inside a match"
          elsif /\}\}/.match(line)
            @status = "outside_all"
          end

          #next

        end

        if @status == "inside_a_match"

          if /\|player([0-9]+)=([^|]+)\|(.*)/.match(line)
            if $1 == "1"
              @player1 = $2
            else
              @player2 = $2
            end
            if /\|player([0-9]+)=([^|]+)\|(.*)/.match($3)
              if $1 == "1"
                @player1 = $2
              else
                @player2 = $2
              end
            end
          elsif /\|map[0-9]+win=([0-9]+)\|map[0-9]+=([^|]+)\|?/.match(line)
            @winner = $1
            @map = $2
            @map = @map.gsub(/\n/, "")
            @map = @map.gsub(/\}/, "")
            makeGame()
          elsif /\|winner=([0-9]+)\|map=([^|]+)\|?/.match(line)
            @winner = $1
            @map = $2
            @map = @map.gsub(/\n/, "")
            @map = @map.gsub(/\}/, "")
            makeGame()
          elsif /\{\{[bB]ox\|/.match(line)
            @status = "outside_all"
            puts "outside_all"
          end

          next

        end

      end

      @games

    end

    def savePlayer(name, flag, race)
      player = StarcraftLiquipediaScrape::SetPlayer.new
      player.name = name
      player.race = race
      player.flag = flag
      @players[name] = player
      @players[name.downcase] = player
    end

    def clearVars()
      @player1 = nil
      @player2 = nil
      @winner = nil
      @score1 = nil
      @score2 = nil
      @map = nil
    end

    def makeGame()

      if @player1 == nil or @player2 == nil 
        puts "Player1 or Player2 nil, can't go forward"
        return 
      end

      p1 = if @players[@player1] != nil then @players[@player1] else @players[@player1.downcase] end
      p2 = if @players[@player2] != nil then @players[@player2] else @players[@player2.downcase] end

      if p1 == nil or p2== nil 
        puts "Unable to lookup player. #{@player1}, #{p1}, #{@player2}, #{p2}. Can't go forward"
        return 
      end

      if @winner != nil
        if @winner == 1 
          p1.score = 1
          p2.score = 0
        else
          p1.score = 0
          p2.score = 1
        end
      else
        begin
          p1.score = @score1
          p2.score = @score2
        rescue
          puts "Unable to parse scores!"
          return
        end
      end

      if @map == nil then @map = "" end

      game = StarcraftLiquipediaScrape::Set.new("#{@games.length}")
      game.set_all_attrs(@map, p1, p2)

      @games[@games.length] = game

    end

  end
end
