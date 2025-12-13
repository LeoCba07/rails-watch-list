require 'open-uri'
puts "Cleaning the DB...."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "Creating movies.... \n"
(1..5).to_a.each do |num|
  url = "http://tmdb.lewagon.com/movie/top_rated?page=#{num}"
  response = JSON.parse(URI.open(url).read)

  response['results'].each do |movie_hash|
    puts "...creating the movie #{movie_hash['title']}..."
    puts
    Movie.create!(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash['poster_path'],
      rating: movie_hash['vote_average'],
      title: movie_hash['title'],
      overview: movie_hash['overview']
    )
  end
end

puts "Creating lists...."
lists_data = [
  { name: "Binge Watchables", image: "binge.jpg" },
  { name: "Best on Netflix", image: "netflix.jpg" },
  { name: "Classics I Should've Watched", image: "classics.jpg" },
  { name: "Before the 90's", image: "90s.jpg" },
]

lists_data.each do |list_data|
  puts "...creating list #{list_data[:name]}..."
  list = List.create!(name: list_data[:name])

  image_path = Rails.root.join("db/images/#{list_data[:image]}")
  if File.exist?(image_path)
    list.photo.attach(io: File.open(image_path), filename: list_data[:image])
    puts "...attached image #{list_data[:image]}..."
  end

  comments = ["Amazing film!", "Must watch this", "Loved every scene", "Highly recommend", "A true masterpiece", "So underrated"]
  Movie.order("RANDOM()").limit(rand(4..6)).each do |movie|
    Bookmark.create!(list: list, movie: movie, comment: comments.sample)
  end
end

puts "... created #{Movie.count} movies."
puts "... created #{List.count} lists."
puts "... created #{Bookmark.count} bookmarks."
puts "Seeding completed!"
