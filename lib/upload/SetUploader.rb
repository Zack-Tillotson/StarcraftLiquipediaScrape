module StarcraftLiquipediaScrape
  require 'mysql'

  class SetUploader
    def initialize()
      dbInfo = get_db_info()
      @con = Mysql.new dbInfo['host'], dbInfo['user'], dbInfo['pass'], dbInfo['database']
    end

    def upload(set)

      for i in 0...set.p1.score
        save_game set.game_id, i, set.event.id, "", set.map, set.p1.name, set.p1.race, 1, set.p1.flag, set.p2.name, set.p2.race, 0, set.p2.flag
      end

      for i in 0...set.p2.score
        save_game set.game_id, set.p1.score + i, set.event.id, "", set.map, set.p2.name, set.p2.race, 1, set.p2.flag, set.p1.name, set.p1.race, 0, set.p1.flag
      end
    end

    def save_game(game_id, game_index, event_id, map_id, game_date, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country)
        begin
          rs = @con.prepare 'select count(*) cnt from games where id = ? and series_index = ? and event_id = ?'
          rs.execute game_id, game_index, event_id
          
          if rs.fetch()[0] == 0
            rs = @con.prepare 'insert into games(id, series_index, event_id, play_date, map, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
            rs.execute game_id, game_index, event_id, game_date, map_id, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country
            #puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Success"
          else 
            #puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Repeat"
          end
        rescue StandardError => e
          puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Failed"
          puts e
        end
    end

    def done()
      @con.close if @con
    end

    def get_db_info()
      input = IO.read("db.txt")
      return Hash[*input.split(/\s*[\n=]\s*/)]
    end

  end
end
