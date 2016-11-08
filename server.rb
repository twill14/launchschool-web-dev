require "socket"

server = TCPServer.new("localhost", 3003)

def parse_request(request_line)
  http_method, path_and_param, http = request_line.split(" ")
  path, params = path_and_param.split("?")

  params = params.split("&").each_with_object({}) do |pair, hash|
    key, val = pair.split("=")
    hash[key] = val
  end

  [http_method, path, params]
end

loop  do

  client = server.accept

  request_line = client.gets
  puts request_line

  next if !request_line || request_line =~ /favicon/
  http_method, path, params = parse_request(request_line)

  client.puts "HTTP/1.0 200 OK"
  client.puts "ContentType: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  client.puts "<pre>"
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"
  
  # client.puts "<h1> Rolls!</h1>"
  # rolls = params["roll"].to_i
  # sides = params["sides"].to_i

  # rolls.times do
  #   roll = rand(sides) + 1
  #   client.puts "<p>" , roll , "</p>"
  # end

  number = params["number"].to_i

  client.puts "<h1> Counter </h1>"
  client.puts "<p> The current number is  #{number}. </p>"
  
  client.puts "<a href='?number=#{number + 1}'>Add one</a>"
  client.puts "<a href='?number=#{number - 1}'>Subtract one</a>"
  client.puts "</body>"
  client.puts "</html>"

  client.close
end