# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Movie.create!(
  name: "The Shawshank Redemption",
  description: "Over the course of several years, two convicts form a friendship, seeking consolation and, eventually, redemption through basic compassion.",
)

Movie.create!(
  name: "The Godfather",
  description: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
)

Movie.create!(
  name: "The Dark Knight",
  description: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.",
)

Movie.create!(
  name: "The Lord of the Rings: The Return of the King",
  description: "Gandalf and Aragorn lead the World of Men against Sauron's army to draw his gaze from Frodo and Sam as they approach Mount Doom with the One Ring.",
)

Movie.create!(
  name: "Schindler's List",
  description: "In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution by the Nazis.",
)

Movie.create!(
  name: "12 Angry Men",
  description: "The jury in a New York City murder trial is frustrated by a single member whose skeptical caution forces them to more carefully consider the evidence before jumping to a hasty verdict.",
)

Movie.create!(
  name: "The Godfather Part II",
  description: "The early life and career of Vito Corleone in 1920s New York City is portrayed, while his son, Michael, expands and tightens his grip on the family crime syndicate.",
)

Movie.create!(
  name: "The Lord of the Rings: The Fellowship of the Ring",
  description: "A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.",
)

Movie.create!(
  name: "Pulp Fiction",
  description: "The lives of two mob hitmen, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.",
)

Movie.create!(
  name: "12th Fail",
  description: "The real-life story of IPS Officer Manoj Kumar Sharma and IRS Officer Shraddha Joshi.",
)

Movie.all.each do |movie|
  rand(1..20).times do
    Review.categories.each do |category, _category_index|
      Review.create!(
        score: rand(Review::MIN_SCORE..Review::MAX_SCORE),
        category: category, movie: movie
      )
    end
  end
end
