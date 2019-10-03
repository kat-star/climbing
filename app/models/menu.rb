#                                           Casimira Schmeler MD

class Menu
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

    def pause                                                                                                        
        print "press any key to continue"                                                                                                    
        STDIN.getch                                                                                                              
        print "            \r" # extra space to overwrite in case next sentence is short                                                                                                              
    end    


    def skill_menu(name, age)                       ########## BEGIN SKILL MENU - NEW USER SIGNUP ###########
        skill = nil
        system("clear")
        puts " "
        puts "Thank you #{name}, it's good to know you're #{age}."
        puts "On a scale of 1 to 5, five being the best, how good are you?"
        puts " "
        print ": "

        skill = STDIN.getch
        skill = skill.to_i
        
        if skill.between?(1,5)
            puts "YESSS!"
            return skill
        else
            puts "Your choise in invalid.  Please try again."
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
            puts "I'm sorry but that was not a valid entry.  Please try again."
            pause
            location_menu(name, age, skill)
        end
    end                                                     ###########  END LOCATION - NEW USER SIGNUP ##########

    def confirmation_menu(name, age, skill, location)       ######## BEGIN CONFIRMATION - NEW USER SIGNUP ######
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
        if answer == "y"
            puts "Wonderful!  We can continue!"
            return answer
        elsif answer == "n"
            puts "That's alright, we can start over!"
            pause
            signup_menu
        else 
            puts "You answer wan't 'y' or 'n', please try again."
            pause
            confirmation_menu(name, age, skill, location)
        end
    end                                                     ############  END CONFIRMATION - NEWUSER ###########

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

        skill_level = skill_menu(name, age)
        location = location_menu(name, age, skill_level)
        confirmation = confirmation_menu(name, age, skill_level, location)
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

        if confirmation
            new_user = Climber.create(name: name, age: age, location: location,  skill_level: skill_level)
            puts "Welcome #{new_user.name}!  We're glad to have you!"
            pause
            user_menu(new_user)
        else
            puts "Something is terribly wrong, human."
            pause
        end
    end                                                             ############  END NEW USER SIGNUP ############

    def user_menu(user)                                           #####  BEGIN USER MENU ########
        system("clear")
        puts "Welcome #{user.name}!"
        puts " "
        puts "1 - See your climbs           2 - Delete a climb"
        puts "3 - Find climb by name        4 - Find climb by area"
        puts "5 - List available routes     6 - List climbers who've climbed route"
        puts "7 - List most popular route   8 - List routes by rating"
        puts "X - Exit"
        puts " "
        print "Menu: "
        choise = STDIN.getch.to_s
        puts " "
        if choise == "1"
            puts "HERE ARE YOUR CLIMBS"
            pause
            user_menu(user)
        elsif choise == "2"
            puts "DON'T FORGET THE PAST, HUMAN!"
            pause
            user_menu(user)
        elsif choise == "3"
            puts "THESE ARE CLIMBS LISTED BY NAME"
            pause
            user_menu(user)
        elsif choise == "4"
            climb_by_area_menu(user)
        elsif choise == "5"
            allclimbs = Route.all
            puts " "
            allclimbs.each { |climb|
                puts "#{climb.name}, Location: #{climb.location}, Type: #{climb.style}"
            }
            pause
            user_menu(user)
        elsif choise == "6"
            puts "THESE ARE ALL THE CLIMBERS FOR A ROUTE"
            pause
            user_menu(user)
        elsif choise == "7"
            result = Route.most_popular
            puts "The most popular route is #{result.name} located in #{result.location}" 
            pause
            user_menu(user)
        elsif choise == "8"
            puts "THESE ARE THE CLIMBS BY RATING"
            results =  Route.all_routes_rated
            i = 0
            results.each { |result|
                puts "#{i+1}. #{result.name} located in #{result.location}"
                i += 1   
            }
            pause
            user_menu(user)
        elsif choise == "x" || choise == "X"
            puts "Goodbye #{user.name}!"
            return
        else
            puts "YOU TYPED SOMEHTING I DON'T UNDERSTAND, HUMAN!!!"
            pause
            user_menu(user)
        end
    end                                                         ##########  END USER MENU #############

    def main_menu                                               ########## BEGIN STARTUP LOGIN ###########
        system("clear")
        puts " "
        puts "Welcome to the Main Menu!"
        puts " "
        puts "Please enter your name, 'new' to sign up, or 'exit' to leave."
        print "BEGIN: "
        
        input = gets.chomp
                                                                # possible solution = "Casimira Schmeler MD"
        
        if Climber.helper.include?(input) 
            user = Climber.find { |info| info.name == input }
            user_menu(user)
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


    def climb_by_area_menu(user)
        system("clear")
        puts " "
        puts "Please select from the following locations"
        puts " "
        puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
        puts "      4 - New York    5 - International"
        puts " "
        print ": "
        choise = STDIN.getch
        
        if choise == "1"
            puts " "
            results = Route.find_by_location("Bay Area")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
        elsif choise == "2"
            puts " "
            results = Route.find_by_location("Yosemite")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
        elsif choise == "3"
            puts " "
            results = Route.find_by_location("SoCal")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
        elsif choise == "4"
            puts " "
            results = Route.find_by_location("New York")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
        elsif choise == "5"
            puts " "
            results = Route.find_by_location("International")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
        else
            puts " "
            puts "I'm sorry but that was not a valid entry.  Please try again."
            pause
            climb_by_area_menu(user)
        end  
        puts " "
        pause
        user_menu(user)
    end
end