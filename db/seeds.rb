##creating other climbers

locations = ['Bay Area', 'Yosemite', 'SoCal', 'New York', 'International']

30.times do 
  Climber.find_or_create_by(
    name: Faker::Name.name,
    age: Faker::Number.between(from: 15, to: 86),
    location: locations.sample,
    skill_level: Faker::Number.between(from: 1, to: 5)
  )
end


45.times do
  Climb.find_or_create_by(
    climber_id: Faker::Number.between(from: 1, to: 30),
    route_id: Faker::Number.between(from: 1, to: 24),
    rating: Faker::Number.between(from: 1, to: 5),
    date_climbed: (Time.now - rand(15552000)).strftime('%m/%d/%Y')
  )
end

Route.destroy_all

Route.create(name: "Beaver St. Wall", difficulty: 4, location: "Bay Area", style: "Free")
Route.create(name: "The Unnatural Act", difficulty: 6, location: "Bay Area", style: "Free")
Route.create(name: "Mechanic's Crack", difficulty: 5, location: "Bay Area", style: "Free")
Route.create(name: "Rimshot", difficulty: 5, location: "Bay Area", style: "Free")

Route.create(name: "Northwest Books", difficulty: 5, location: "Yosemite", style: "Free")
Route.create(name: "Sunnyside Bench", difficulty: 2, location: "Yosemite", style: "Free")
Route.create(name: "Snake Dike", difficulty: 4, location: "Yosemite", style: "Free")
Route.create(name: "Sea of Dreams", difficulty: 8, location: "Yosemite", style: "Aid")
Route.create(name: "The Nose", difficulty: 9, location: "Yosemite", style: "Aid")

Route.create(name: "Tiers for Fears", difficulty: 7, location: "SoCal", style: "Free")
Route.create(name: "Cosmic Trigger", difficulty: 6, location: "SoCal", style: "Free")
Route.create(name: "I Have The Touch", difficulty: 7, location: "SoCal", style: "Free")
Route.create(name: "Goof Proof Roof", difficulty: 5, location: "SoCal", style: "Aid")
Route.create(name: "Jesus Saw You Take It", difficulty: 6, location: "SoCal", style: "Aid")

Route.create(name: "Wandering Stars Jude 13", difficulty: 8, location: "New York", style: "Aid")
Route.create(name: "Swing Time", difficulty: 7, location: "New York", style: "Aid")
Route.create(name: "Yellow Belly", difficulty: 7, location: "New York", style: "Free")
Route.create(name: "Criss Cross Direct", difficulty: 6, location: "New York", style: "Free")
Route.create(name: "Requiem", difficulty: 8, location: "New York", style: "Free")
Route.create(name: "Easy Rider", difficulty: 6, location: "New York", style: "Free")

Route.create(name: "Everest: South Col", difficulty: 10, location: "International", style: "Aid")
Route.create(name: "Everest: North Col", difficulty: 10, location: "International", style: "Aid")
Route.create(name: "Annapurna Massif", difficulty: 10, location: "International", style: "Aid")
Route.create(name: "K2", difficulty: 10, location: "International", style: "Aid")
