module StarcraftLiquipediaScrape
  require 'mysql'

  class SetUploader
    def initialize()
      @con = Mysql.new 'mysql.laowaigonewild.com', 'sclp', '', ''
      puts @con.get_server_info
    end

    def upload(set)
      puts set
      #rs = @con.prepare 'insert into games(id, event_id, date, map'
      #puts rs.fetch_row
    end

    def done()
      @con.close if @con
    end

  end
end
