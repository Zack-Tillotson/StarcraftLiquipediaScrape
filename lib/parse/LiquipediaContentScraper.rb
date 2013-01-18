module StarcraftLiquipediaScrape
  class LiquipediaContentScraper

    require 'mysql'
    require 'open-uri'
    require 'nokogiri'
    require 'parse/LiquipediaParser.rb'

    def initialize()

      dbInfo = get_db_info()
      @con = Mysql.new dbInfo['host'], dbInfo['user'], dbInfo['pass'], dbInfo['database']
      endpoints = downloadEndpointsList()
      scrapeEndpoints(endpoints)
      startParses(endpoints)

    end

    def downloadEndpointsList()
      endpoints = Hash.new

      rs = @con.query("select id, url from endpoints where active = 1")

      rs.each_hash do |row|
        endpoints[row['id']] = row['url']
      end

      return endpoints
    end

    def scrapeEndpoints(endpoints)
      endpoints.each_pair do |id, url|
        puts "Endpoint #{id} #{url}"
        doc = Nokogiri::HTML(open(url))
        txt = doc.xpath("//textarea/text()").first().to_s 
        aFile = File.open("data/#{id}.txt", 'w')
        begin 
          aFile.syswrite(txt)
        ensure
          aFile.close
        end
            
      end
    end

    def startParses(endpoints)
      endpoints.each_pair do |id, url|
        puts "Starting parse #{id}"
        StarcraftLiquipediaScrape::LiquipediaParser.new(id, "data/#{id}.txt")
      end
    end

    def get_db_info()
      input = IO.read("db.txt")
      return Hash[*input.split(/\s*[\n=]\s*/)]
    end


  end
end
