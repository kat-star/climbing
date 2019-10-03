def pause                                                                                                        
    print "press any key to continue"                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r" # extra space to overwrite in case next sentence is short                                                                                                              
end    

def user_menu(user)                                           #####  BEGIN MAIN MENU ########
    system("clear")
    puts "Welcome #{user.name}!"
    puts "1 - View your climbs          2 - Delete a climb"
    puts "3 - Find climb by name        4 - Find climb by area"
    puts "5 - List available routes     6 - List climbers who've climbed a route"
    puts "7 - List top climbers         8 - List routes by rating"
    puts "9 - Edit a climb              X - Exit"
    puts " "
    print "Menu: "
    choice = STDIN.getch.to_s
    puts " "
    if choice == "1"
        puts "Here is a list your climbs:"
        puts "-----"
        puts user.retrieve_climbs
        pause
        user_menu(user)
    elsif choice == "2"
        puts "To delete a climb, select your climb below. Note-this action cannot be reversed."
        puts "-----"
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i + 1}. #{climb}" }
        user_input = STDIN.getch
        user.delete_climb(user_input)
        pause
        user_menu(user)
    elsif choice == "3"
        puts "What is the name of the route you would like to view?"
        user_input = gets.chomp
        route = Route.find_by_route_name(user_input)
        puts "-----"
        puts "Route Name: #{route.name}"
        puts "Difficulty: #{route.difficulty}"
        puts "Location: #{route.location}"
        puts "Style: #{route.style}"
        pause
        user_menu(user)
    elsif choice == "4"
        puts "THESE ARE CLIMBS LISTED BY AREA"
        pause
        user_menu(user)
    elsif choice == "5"
        puts "THESE ARE ALL AVAILABLE ROUTES"
        pause
        user_menu(user)
    elsif choice == "6"
        puts "What location would you like to see a list of climbers?"
        puts 
        puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
        puts "      4 - New York    5 - International"
      
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
        pause
        user_menu(user)
    elsif choice == "7"
        puts "THESE ARE THE TOP CLIMBERS"
        pause
        user_menu(user)
    elsif choice == "8"
        puts "Highest-rated routes"
        puts "-----"
        puts Route.highest_rated
        pause
        puts
        user_menu(user)
    elsif choice == '9'
        puts 'To update a climb, select your climb below.'
        puts "-----"
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i  + 1}. #{climb}" }
        user_input = STDIN.getch
        user.update_climb(user_input)
        pause
        user_menu(user)
    elsif choice == "x" || choice == "X"
        puts "Goodbye #{user.name}!"
        return
    else
        puts "YOU TYPED SOMETHING I DON'T UNDERSTAND, HUMAN!!!"
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
    skill = gets.chomp 
    if skill
        puts "YESSS!"
        pause
    else
        puts "NOOOOO"
        pause
    end
    return skill
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
        pause
        location_menu(name, age, skill)
    end
end                                                     ###########  END LOCATION - NEW USER SIGNUP ##########

def signup_menu                                                #######  BEGIN NEWUSER SIGNUP###########
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

    system("clear")
    puts " "
    puts "Fantastic!!!"
    puts " "
    puts "Just to be clear, let's make sure this is correct."
    puts "Youre name is #{name}, you're #{age} years old."
    puts "You'd consider your skill level a #{skill}, &"
    puts "you're located in (or near) #{location}."
    print "Correct? (Y/N): "
    answer = STDIN.getch
    puts " "
    puts answer
    pause
end                                                             ############  END NEW USER SIGNUP ############

def main_menu                                               ########## BEGIN STARTUP LOGIN ###########
    system("clear")
    puts " " * 30
    puts "Welcome to the Main Menu!"
    puts " " * 36
    puts "Please enter your name, 'new' to sign up, or 'exit' to leave."
    print "BEGIN: "
    
    input = gets.chomp
    #binding.pry   # possible solution = "Casimira Schmeler MD"
   
    if climber = Climber.find_by(name: input)
        user_menu(climber)
    elsif input == "new"
        signup_menu

    elsif input == "exit" 
        puts "YOU'RE GOING TO WISH YOU STAYED!"
        pause 
        return
    else
        puts "That was not a valid menu selection"
        pause
        main_menu
    end
end                                                  ##########  END STARTUP LOGIN ##############