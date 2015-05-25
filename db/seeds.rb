require 'open-uri'

puts Dir.pwd
Cast.delete_all
Railscast.delete_all
open("db/rcasts.txt") do |casts|
  casts.read.each_line do |item|
    episode, title = item.chomp.split("|")
    Cast.create!(:episode => episode, :title => title)
  end
end
    
  
