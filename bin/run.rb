require_relative '../config/environment'
m = Menu.new

user = m.login

while user == "new" do
    if user == "new"
        user = m.new_user
    else
        puts "\nGoodbye!\n" 
    end
end

result = user

while result != nil
    result = m.main(user)
    case result
    when "1"
        m.view_user_climbs
    when "2"
        m.delete_climb(user)
    when "3"
        m.find_climb_by_name
    when "4"
        m.list_climbs_by_area
    when "5"
        m.list_available_routes
    when "6"
        m.list_accomplished_climbers
    when "7"
        m.add_climb
    when "8"
        m.list_routes_by_rating
    when "9"
        m.update_climb
    end
end
puts "\nThanks for climbing!"





    #puts "WHYME.OHAREGEE!"

# elsif result == "new"
#     m.signup
# end



# while m.main(user)
#     if choice == "1"
#         puts "Here is a list your climbs:"
#         puts "-----"
#         puts user.retrieve_climbs
#         m.pause
#         choise = m.main(user)
#     elsif choice == "2"
#         
#         choise = m.main(user)
#     elsif choice == "3"
#         puts "What is the name of the route you would like to view?"
#         user_input = gets.chomp
#         route = Route.find_by_route_name(user_input)
#         puts "-----"
#         puts "Route Name: #{route.name}"
#         puts "Difficulty: #{route.difficulty}"
#         puts "Location: #{route.location}"
#         puts "Style: #{route.style}"
#         m.pause
#         choise = m.main(user)
#     elsif choice == "5"
#         puts "THESE ARE ALL AVAILABLE ROUTES"
#         m.pause
#         choise = m.main(user)
#     elsif choice == "6"
#         puts "What location would you like to see a list of climbers?"
#         puts 
#         puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
#         puts "      4 - New York    5 - International"
    
#         location = case STDIN.getch
#         when '1'
#             'Bay Area'
#         when '2'
#             'Yosemite'
#         when '3'
#             'SoCal'
#         when '4'
#             'New York'
#         when '5'
#             'International'
#         end

#         if location
#             puts Climber.climbers_by_route_location(location)
#         else
#             puts "Invalid location. Please try again."
#         end
#         m.pause
#         choise = m.main(user)
#     elsif choice == "7"
#         puts "THESE ARE THE TOP CLIMBERS"
#         m.pause
#         choise  = m.main(user)
#     elsif choice == "8"
#         puts "Highest-rated routes"
#         puts "-----"
#         puts Route.highest_rated
#         m.pause
#         puts
#         choise = m.main(user)
#     elsif choice == '9'
#         puts 'To update a climb, select your climb below.'
#         puts "-----"
#         puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i  + 1}. #{climb}" }
#         user_input = STDIN.getch
#         user.update_climb(user_input)
#         m.pause
#         choise = m.main(user)
#     elsif m.main(user) == "x"
#         puts "Goodbye #{user.name}!"
#         return false
#     else
#         puts "YOU TYPED SOMETHING I DON'T UNDERSTAND, HUMAN!!!"
#         pause
#         choise = m.main(user)
#     end

