def pause                                                                                            
    print "press any key to continue"                         
    STDIN.getch                     
    print "            \r"  #extra space to overwrite in case next sentence is short                
end    

def user_menu(user)                                           #####  BEGIN MAIN MENU ########
    system("clear")
    puts "Welcome #{user.name}!"
    puts
    puts "              My Climbs"
    puts "1 - View My Climbs            2 - Add a New Climb"
    puts "3 - Update a Climb Record     4 - Delete a Climb Record"
    puts
    puts "              Find Climbing Routes"
    puts "5 - List All Routes           6 - Find Routes By Location"
    puts "7 - Find Climb Route by Name  8 - Find Climbers By Location"
    puts "9 - List Routes By Rating     X - Exit"
    puts " "
    print "Menu Selection: "


    choice = STDIN.getch.to_s
    puts " "
    if choice == "1"
        puts
        puts "Here is a list your climbs:"
        puts "-" *36
        puts user.retrieve_climbs
        pause
        user_menu(user)
    elsif choice == "2"
        puts 
        puts "To add a climb, please enter the following climb details:"
        print "Route name: "
        route_input = gets.chomp
        route_id = Route.find_by_route_name(route_input).id
        print "Rating (1-5): "
        rating_input = STDIN.getch
        puts
        print "Date climbed (mm/dd/yyyy): "
        date_input = gets.chomp
        Climb.create(route_id: route_id, climber_id: user.id, rating: rating_input, date_climbed: date_input)
        pause
        user_menu(user)
    elsif choice == "3"
        puts
        puts 'To update a climb, select your climb below.'
        puts "-" * 36
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i  + 1}. #{climb}" }
        user_input = STDIN.getch
        user.update_climb(user_input)
        pause
        user_menu(user)
    elsif choice == "4"
        puts
        puts "To delete a climb, select your climb below. Note-this action cannot be reversed."
        puts "-" * 36
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i + 1}. #{climb}"}
        user_input = STDIN.getch
        user.delete_climb(user_input)
        pause
        user_menu(user)
    elsif choice == "5"
        puts
        puts "All available routes:"
        puts "-" * 36
        puts Route.all.map { |a_route| "#{a_route.name} - Location: #{a_route.location}, Difficulty: #{a_route.difficulty}, Type: #{a_route.style}" }
        pause
        user_menu(user)
    elsif choice == "6"
        puts
        puts "What routes would you like to see for a location?"
        puts 
        puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
        puts "      4 - New York    5 - International"
        puts
        location = case STDIN.getch
        when '1'
            'Bay Area'
        when '2'
            'Yosemite'
        when '3'
            'SoCal'
        when '4'
            'New York'
        when '5'
            'International'
        end

        if location
            puts Route.find_by_location(location)
        else
            puts "Invalid location. Please try again."
        end
        puts
        pause 
        user_menu(user)
    elsif choice == "7"
        puts
        print "What is the name of the route you would like to view: "
        user_input = gets.chomp
        route = Route.find_by_route_name(user_input)
        puts "-" * 36
        puts "#{route.name} - Difficulty: #{route.difficulty}, Location: #{route.location}, Style: #{route.style}"
        puts
        pause
        user_menu(user)
    elsif choice == "8"
        puts
        puts "What location would you like to see a list of climbers?"
        puts 
        puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
        puts "      4 - New York    5 - International"
        puts
        location = case STDIN.getch
        when '1'
            'Bay Area'
        when '2'
            'Yosemite'
        when '3'
            'SoCal'
        when '4'
            'New York'
        when '5'
            'International'
        end

        if location
            puts Climber.climbers_by_route_location(location)
        else
            puts "Invalid location. Please try again."
        end
        puts
        pause
        user_menu(user)
    elsif choice == '9'
        puts
        puts "Highest-rated routes"
        puts "-" * 36
        puts Route.highest_rated
        puts
        pause
        user_menu(user)
    elsif choice == "x" || choice == "X"
        puts "Goodbye #{user.name}!"
        return
    else
        puts "That is not a valid selection. Please try again."
        puts
        pause
        user_menu(user)
    end
end                                                         ##########  END MAIN MENU #############

def skill_menu(name, age)                       ########## BEGIN SKILL MENU - NEW USER SIGNUP ###########
    system("clear")
    puts " "
    puts "Thank you #{name}, it's good to know you're #{age}."
    puts "On a scale of 1 to 5, five being the best, how good are you?"
    puts " "
    print ": "
    skill = STDIN.getch
    skill = skill.to_i
    if skill.between?(1,5)
        return skill
    else
        puts "Your choice is invalid.  Please try again."
        puts
        pause
        skill_menu(name, age)
    end
end                                         ############  END SKILL MENU - NEW USER SIGNUP ##########

def location_menu(name, age, skill)             ###### BEGIN LOCATION MENU - NEW USER SIGNUP ##############
    system("clear")
    puts " "
    puts "WOW #{name}, you're #{age} years old and a #{skill}?  That's great!"
    puts "Last but not least, please select your location from the list below."
    puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
    puts "      4 - New York    5 - International"
    print ": "
    location = STDIN.getch
    #binding.pry
    
    if location == "1"
        return "Bay Area"
    elsif location == "2"
        return "Yosemite"
    elsif location == "3"
        return "SoCal"
    elsif location == "4"
        return "New York"
    elsif location == "5"
        return "International"
    else
        puts " "
        puts "YOU WASTE MY TIME, HUMAN!  NOW START OVER!"
        puts
        pause
        location_menu(name, age, skill)
    end
end                                     ###########  END LOCATION - NEW USER SIGNUP ##########

def confirmation_menu(name, age, skill, location) #######  BEGIN CONFIRMATION - NEW USER SIGNUP ###
    system("clear")
    puts " "
    puts "Fantastic!!!"
    puts " "
    puts "Just to be clear, let's make sure this is correct."
    puts "Your name is #{name}, you're #{age} years old."
    puts "You'd consider your skill level a #{skill}, &"
    puts "you're located in (or near) #{location}."
    print "Correct? (Y/N): "
    answer = STDIN.getch
    puts " "
    if answer == "y"
        puts "Wonderful!  We can continue!"
        return answer
    elsif answer == "n"
        puts "That's alright, we can start over!"
        pause
        signup_menu
    else
        puts "You answer wan't 'y' or 'n', please try again."
        puts
        pause
        confirmation_menu(name, age, skill, location)
    end
end                                  ###########   END CONFIRMATION - NEW USER SIGNUP ##########


def signup_menu                              #######  BEGIN NEWUSER SIGNUP###########
    system("clear")
    puts " "
    puts "Welcome to the System.  Please enter your name!"
    puts " "
    print ": "
    name = gets.chomp
    
    system("clear")
    puts " "
    puts "Hello #{name}!  Please tell us your age."
    puts " "
    print ": "
    age = gets.chomp

    skill = skill_menu(name, age)
    location = location_menu(name, age, skill)
    confirmation = confirmation_menu(name, age, skill, location)
    
    if confirmation
        new_user = Climber.create(name: name, age: age, location: location,  skill_level: skill)
        puts "Welcome #{new_user.name}!  We're glad to have you!"
        puts
        pause
        user_menu(new_user)
    else
        puts "Please try again."
        puts
        pause
    end
end                                          ############  END NEW USER SIGNUP ############

def main_menu                                     ########## BEGIN STARTUP LOGIN ###########
    system("clear")
    puts " " * 36
    puts "*" * 36
    puts "    Welcome to Climb Finder!"
    puts "*" * 36
    puts "" * 36
    puts "Please enter your name, 'new' to sign up, or 'exit' to leave."
    print "BEGIN: "
    
    input = gets.chomp
    #binding.pry   # possible solution = "Casimira Schmeler MD"
   
    if climber = Climber.find_by(name: input)
        user_menu(climber)
    elsif input == "new"
        signup_menu
    elsif input == "exit" 
        puts "Stop by again soon!"
        puts
        pause 
        return
    else
        puts "That was not a valid menu selection"
        puts
        pause
        main_menu
    end
end                                                  ##########  END STARTUP LOGIN #############