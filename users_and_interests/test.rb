my_hash = {:jamy=>{:email=>"jamy.rustenburg@gmail.com", :interests=>["woodworking", "cooking", "reading"]}, :nora=>{:email=>"nora.alnes@yahoo.com", :interests=>["cycling", "basketball", "economics"]}, :hiroko=>{:email=>"hiroko.ohara@hotmail.com", :interests=>["politics", "history", "birding"]}}

p my_hash[:jamy]

string = my_hash[:jamy][:interests]

p string