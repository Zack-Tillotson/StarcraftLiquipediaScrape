module StarcraftLiquipediaScrape
  require 'mysql'

  class SetUploader
    def initialize()
      @con = Mysql.new 
    end

    def upload(set)
      puts "Uploading #{set}"

      for i in 0...set.p1.score
        save_game set.game_id, i, set.event.id, "", "", set.p1.name, set.p1.race, 1, set.p1.flag, set.p2.name, set.p2.race, 0, set.p2.flag
      end

      for i in 0...set.p2.score
        save_game set.game_id, set.p1.score + i, set.event.id, "", "", set.p2.name, set.p2.race, 1, set.p2.flag, set.p1.name, set.p1.race, 0, set.p1.flag
      end
    end

    def save_game(game_id, game_index, event_id, map_id, game_date, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country)
        begin
          rs = @con.prepare 'select count(*) cnt from games where id = ? and series_index = ? and event_id = ?'
          rs.execute game_id, game_index, event_id
          
          if rs.fetch()[0] == 0
            rs = @con.prepare 'insert into games(id, series_index, event_id, play_date, map, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            rs.execute game_id, game_index, event_id, game_date, map_id, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country
            puts "  Success"
          else 
            puts "  Repeat"
          end
        rescue StandardError => e
          puts e
          puts "  Failed"
        end
    end

    def done()
      @con.close if @con
    end

  end
end
