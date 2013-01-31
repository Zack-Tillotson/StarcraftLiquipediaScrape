module StarcraftLiquipediaScrape
  require 'mysql'

  class SetUploader
    def initialize()
      dbInfo = get_db_info()
      @con = Mysql.new dbInfo['host'], dbInfo['user'], dbInfo['pass'], dbInfo['database']
    end

    def upload(set)

      set = filter(set)

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
            puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Success"
          else 
            puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Repeat"
          end
        rescue StandardError => e
          puts "Uploading #{game_id}, #{game_index}, #{event_id}, #{p1_name}, #{p2_name} - Failed"
          puts e
        end
    end

    def done()
      if @con
        begin
          rs = @con.prepare "delete from games where p2_name = 'BYE'"
          rs.execute
        rescue StandardError => e
          puts "Deleting BYE games failed"
          puts e
        end
        @con.close
      end
    end

    def get_db_info()
      input = IO.read("db.txt")
      return Hash[*input.split(/\s*[\n=]\s*/)]
    end

    def filter(set)

      # Race values
      if set.p1.race.strip == 'b' then set.p1.race = '' end
      if set.p2.race.strip == 'b' then set.p2.race = '' end

      # Country
      if set.p1.flag == 'china' then set.p1.flag = 'cn' end
      if set.p1.flag == 'serbia' then set.p1.flag = 'se' end
      if set.p1.flag == 'switzerland' then set.p1.flag = 'ch' end
      if set.p1.flag == 'belarus' then set.p1.flag = 'by' end
      if set.p1.flag == 'spain' then set.p1.flag = 'es' end
      if set.p1.flag == 'sweden' then set.p1.flag = 'se' end
      if set.p1.flag == 'poland' then set.p1.flag = 'pl' end
      if set.p1.flag == 'ukraine' then set.p1.flag = 'uk' end
      if set.p1.flag == 'peru' then set.p1.flag = 'pe' end
      if set.p1.flag == 'canada' then set.p1.flag = 'ca' end
      if set.p1.flag == 'finland' then set.p1.flag = 'fi' end
      if set.p1.flag == 'taiwan' then set.p1.flag = 'tw' end
      if set.p2.flag == 'china' then set.p2.flag = 'cn' end
      if set.p2.flag == 'serbia' then set.p2.flag = 'se' end
      if set.p2.flag == 'switzerland' then set.p2.flag = 'ch' end
      if set.p2.flag == 'belarus' then set.p2.flag = 'by' end
      if set.p2.flag == 'spain' then set.p2.flag = 'es' end
      if set.p2.flag == 'sweden' then set.p2.flag = 'se' end
      if set.p2.flag == 'poland' then set.p2.flag = 'pl' end
      if set.p2.flag == 'ukraine' then set.p2.flag = 'uk' end
      if set.p2.flag == 'peru' then set.p2.flag = 'pe' end
      if set.p2.flag == 'canada' then set.p2.flag = 'ca' end
      if set.p2.flag == 'finland' then set.p2.flag = 'fi' end
      if set.p2.flag == 'taiwan' then set.p2.flag = 'tw' end

      set

    end

  end
end
