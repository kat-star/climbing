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