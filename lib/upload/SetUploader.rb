module StarcraftLiquipediaScrape
  require 'mysql'

  class SetUploader
    def initialize()
      @con = Mysql.new 
    end

    def upload(set)
      puts "Uploading #{set}"

      for i in 0...set.p1.score
        puts "rs.execute set.game_id}, #{ i}, #{ set.event.id}, #{ ''}, #{ ''}, #{ set.p1.name}, #{ set.p1.race}, #{ true}, #{ set.p1.flag}, #{ set.p2.name}, #{ set.p2.race}, #{ false}, #{ set.p2.flag"
        rs = @con.prepare 'insert into games(id, series_index, event_id, play_date, map, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
        puts rs.execute set.game_id, i, set.event.id, "", "", set.p1.name, set.p1.race, true, set.p1.flag, set.p2.name, set.p2.race, false, set.p2.flag
      end
      for i in 0...set.p2.score
        rs = @con.prepare 'insert into games(id, series_index, event_id, play_date, map, p1_name, p1_race, p1_winner, p1_country, p2_name, p2_race, p2_winner, p2_country) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)'
        puts rs.execute set.game_id, i + set.p1.score, set.event.id, nil, nil, set.p1.name, set.p1.race, false, set.p1.flag, set.p2.name, set.p2.race, true, set.p2.flag
      end
    end

    def done()
      @con.close if @con
    end

  end
end
