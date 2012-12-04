#!/cygdrive/c/pf/Ruby187/bin/ruby

txt = File.read("mlgspringobwseeds.txt")

txt = txt.gsub(/\n|\r/, '')
txt = txt.gsub(/\{\{ *[^ \<]* */, '')
txt = txt.gsub(/\}\} */, '')
txt = txt.gsub(/\<!--.*?--\>/, '')
txt = txt.gsub(/\| *?/, '|').gsub(/ *?\|/, '|')
puts txt + "\n\n"

hash = Hash.new 
txt.split("|").collect { |v|
  puts v
  v =~ /=/
  hash[$`] = $'
}
