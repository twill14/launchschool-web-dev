require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  allfiles = File.join("**", "*.{*}")
  array = Dir.glob(allfiles)
  new_array = []
  array.each do |x|
     new_array << File.basename(x)
  end 
  @title = "Coding Challenge"
  @filelist = new_array
  @filelist.reverse! if params[:sort] == "desc"
  erb :list
end