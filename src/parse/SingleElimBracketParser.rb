class SingleElimBracketParser

  def initialize(filename)

    @filename = filename
    parse()

  end

  def parse()

    # Get and clean up the data string
    txt = File.read(@filename)

    txt = txt.gsub(/\n|\r/, '')
    txt = txt.gsub(/\{\{ *[^ \<]* */, '')
    txt = txt.gsub(/\}\} */, '')
    txt = txt.gsub(/\<!--.*?--\>/, '')
    txt = txt.gsub(/\| *?/, '|').gsub(/ *?\|/, '|')

    # Split the data string into a collection of attributes
    hash = Hash.new 
    txt.split("|").collect { |v|
      v =~ /=/
      hash[$`] = $'
    }

    # Roll the attributes into game objects
    puts hash

    # Save the game objects
  end

end
