require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

before do
  @chapters = File.readlines("data/toc.txt")
end

get "/" do
  @title = "Sherlock Homes and The Game Designer From The Void"
  
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @chapters[number - 1]
  @title = "Chapter #{number}- #{chapter_name}"

  @chapter = File.read("data/chp#{params[:number]}.txt")
  @chapterNumber = " Chapter #{params[:number]}"
  erb :chapter
end


not_found do
  redirect "/"
end

def each_chapter(&block)
  @chapters.each_with_index do |name, index|
    number = index + 1
    contents = File.read("data/chp#{number}.txt")
    yield number, name, contents
  end
end


helpers do
  def in_paragraphs(text)
    text.split("\n\n").each_with_index.map do |line, index|
      "<p id=paragraph#{index}>#{line}</p>"
    end.join
  end
end


def chapters_matching(query)
  results = []

  return results unless query

  each_chapter do |number, name, contents|
    matches = {}
    contents.split("\n\n").each_with_index do |paragraph, index|
      matches[index] = paragraph if paragraph.include?(query)
    end
    results << {number: number, name: name, paragraphs: matches} if matches.any?
  end

  results
end

get "/search" do
  @results = chapters_matching(params[:query])
  erb :search
end


helpers do 
  def highlight(text, term)
    text.gsub(term, %(<strong>#{term}</strong>))
  end
end





# <% if params[:query] %>
#   <% if @results.empty? %>
#     <p>Sorry, no matches were found.</p>
#   <% else %>
#     <h2 class="content-subhead">Results for '<%= params[:query]%>'</h2>

#     <ul>
#       <% @results.each do |result| %>
#         <li><a href="/chapters/<%= result[:number] %>"><%= result[:name] %></a></li>
#       <% end %>
#     </ul>
#   <% end %>
# <% end %>