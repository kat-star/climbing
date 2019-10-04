###Comment your code (one line above method)

def main_menu                                     ########## BEGIN STARTUP LOGIN ###########
    system('clear')
    puts 
    puts '*' * 60
    puts '                  Welcome to Climb Finder!'
    puts '*' * 60
    puts 
    puts "If you're new to our site, enter 'new' to get started."
    puts 'For returning members, enter your name.'
    puts
    print 'BEGIN: '
    
    input = gets.chomp
   
    if climber = Climber.find_by(name: input)
        user_menu(climber)
    elsif input == 'new'
        signup_menu
    elsif input == 'exit'
        puts 'Stop by again soon!'
        puts
        pause 
        return
    else
        puts 'That was not a valid menu selection.'
        puts
        pause
        main_menu
    end
end                                                  ##########  END STARTUP LOGIN #############

def pause                                                                                           
    print 'press any key to continue'
    STDIN.getch                     
    print "            \r"  #extra space to overwrite in case next sentence is short                
end    

def location_prompt
    puts 
    puts "1 - Bay Area      2 - Yosemite        3 - SoCal"
    puts "      4 - New York    5 - International"
    puts
end

def user_menu(user)                                           #####  BEGIN MAIN MENU ########
    user.reload
    system('clear')
    puts "Welcome #{user.name}!"
    puts
    puts "                   My Climbs"
    puts '-' *60
    puts "1 - View My Climbs            2 - Add a New Climb"
    puts "3 - Update a Climb Record     4 - Delete a Climb Record"
    puts
    puts
    puts "              Find Climbing Routes"
    puts '-' *60
    puts "5 - List All Routes           6 - Find Routes By Location"
    puts "7 - Find Climb Route by Name  8 - Find Climbers By Location"
    puts "9 - List Routes By Rating     0 - Add a New Route"
    puts 
    puts 'X - Exit'
    puts 
    print 'Menu Selection: '

    choice = STDIN.getch
    puts 
    if choice == '1'
        puts
        puts 'Here is a list your climbs:'
        puts '-' *60
        if user.climbs.empty?
            puts 'You have no climbs. Start climbing!'
        else
            puts user.retrieve_climbs
        end
        puts
        pause
        user_menu(user)
    elsif choice == '2'
        puts 
        puts 'To add a climb, please enter the following climb details:'
        print 'Route name: '
        route_input = gets.chomp
        route_id = Route.find_by_route_name(route_input).id
        print "How would you rate the route? Choose 1-5: "
        rating_input = STDIN.getch
        puts
        print "Date climbed (mm/dd/yyyy): "
        date_input = gets.chomp
        Climb.create(route_id: route_id, climber_id: user.id, rating: rating_input, date_climbed: date_input)
        puts 
        puts "Your new climb has been added."
        puts
        pause
        user_menu(user)
    elsif choice == "3"
        puts
        puts 'To update a climb, select your climb below.'
        puts '-' * 60
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i  + 1}. #{climb}" }
        print ': '
        user_input = STDIN.getch
        puts
        puts 'You can update your climb rating. What is the new rating (1-5)?'
        climb_rating =  STDIN.getch
        user.update_climb(user_input, climb_rating)
        puts
        pause
        user_menu(user)
    elsif choice == '4'
        puts
        puts 'To delete a climb, select your climb below. Note-this action cannot be reversed.'
        puts '-' * 40
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i + 1}. #{climb}"}
        user_input = STDIN.getch
        user.delete_climb(user_input)
        puts
        puts "Climb number #{user_input} has been deleted."
        puts
        pause
        user_menu(user)
    elsif choice == '5'
        puts
        puts 'All available routes:'
        puts '-' * 60
        puts Route.all.map { |a_route| "#{a_route.name} - Location: #{a_route.location}, Difficulty: #{a_route.difficulty}, Type: #{a_route.style}" }.sort
        puts
        pause
        user_menu(user)
    elsif choice == '6'
        puts
        puts 'What routes would you like to see for a location?'
        puts location_prompt

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
            puts 'Invalid location. Please try again.'
        end
        puts
        pause 
        user_menu(user)
    elsif choice == '7'
        puts
        print 'What is the name of the route you would like to view: '
        user_input = gets.chomp

        if !Route.find_by_route_name(user_input)
            puts 'That is not a valid location. Please try again.'
        else
            route = Route.find_by_route_name(user_input)
            puts '-' * 60
            puts "#{route.name} - Difficulty: #{route.difficulty}, Location: #{route.location}, Style: #{route.style}"
        end
        puts
        pause
        user_menu(user)
    elsif choice == '8'
        puts
        puts 'What location would you like to see a list of climbers?'
        puts location_prompt
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
            puts 'Invalid location. Please try again.'
        end
        puts
        pause
        user_menu(user)
    elsif choice == '9'
        puts
        puts 'Highest-rated routes'
        puts '-' * 60
        puts Route.highest_rated
        puts
        pause
        user_menu(user)
    elsif choice == '0'
        puts
        puts 'To add a new route, please enter the following route details:'
        puts
        print 'Route name: '
        route_input = gets.chomp
        puts
        print "What is the difficulty level? Choose 1-5: "
        difficulty_input = STDIN.getch.to_i
        puts
        puts
        puts 'Choose the location from the following:' 
        print 'Bay Area, Yosemite, SoCal, New York, or International: '
        location_input = gets.chomp
        puts
        print 'What is the climb style? '
        style_input = gets.chomp
        puts
        Route.create(name: route_input, difficulty: difficulty_input, location: location_input, style: style_input)
        puts 
        puts "Thanks for contributing to our routes database! The new route has been added."
        puts
        pause
        user_menu(user)    
    elsif choice == 'x' || choice == 'X'
        puts "Goodbye #{user.name}!"
        return
    else
        puts 'That is not a valid selection. Please try again.'
        puts
        pause
        user_menu(user)
    end
end                                                         ##########  END MAIN MENU #############

def skill_menu(name, age)                       ########## BEGIN SKILL MENU - NEW USER SIGNUP ###########
    system('clear')
    puts 
    puts "Thank you #{name}, it's good to know you're #{age}."
    puts 'On a scale of 1 to 5, five being the best, how good are your climbing skills?'
    puts 
    print ": "
    skill = STDIN.getch.to_i
    if skill.between?(1,5)
        skill
    else
        puts 'Your choice is invalid.  Please try again.'
        puts
        pause
        skill_menu(name, age)
    end
end                             ############  END SKILL MENU - NEW USER SIGNUP ##########

def location_menu(name, age, skill)         ###### BEGIN LOCATION MENU - NEW USER SIGNUP ##########
    system('clear')
    puts 
    puts "WOW #{name}, you're #{age} years old and a #{skill}?  That's great!"
    puts location_prompt
    print ': '
    location = case STDIN.getch
   
    when '1'
        'Bay Area'
    when  '2'
        'Yosemite'
    when '3'
        "SoCal"
    when '4'
        "New York"
    when '5'
        "International"
    end

    if location
        location
    else
        puts 
        puts "That's an invalid selection. Please try again."
        puts
        pause
        location_menu(name, age, skill)
    end
end                                     ###########  END LOCATION - NEW USER SIGNUP ##########

def confirmation_menu(name, age, skill, location) #######  BEGIN CONFIRMATION - NEW USER SIGNUP ###
    system('clear')
    puts 
    puts 'Fantastic!!!'
    puts 
    puts "Just to be clear, let's make sure this is correct."
    puts "Your name is #{name}, you're #{age} years old."
    puts "You'd consider your skill level a #{skill}, "
    puts "and you're located in (or near) #{location}."
    print 'Correct? (y/n): '
    answer = STDIN.getch
    puts 
    if answer == 'y' || answer == 'Y'
        puts 'Wonderful!'
        answer
    elsif answer == 'n' || answer == 'N'
        puts "That's alright, we can start over!"
        puts
        pause
        signup_menu
    else
        puts "Answer 'y' or 'n'. Please try again."
        puts
        pause
        confirmation_menu(name, age, skill, location)
    end
end                                  ###########   END CONFIRMATION - NEW USER SIGNUP ##########

def signup_menu                              #######  BEGIN NEWUSER SIGNUP###########
    system('clear')
    puts 
    puts 'Welcome to the System.  Please enter your name!'
    puts 
    print ': '
    name = gets.chomp
    
    system('clear')
    puts 
    puts "Hello #{name}!  Please tell us your age."
    puts 
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
        puts 'Please try again.'
        puts
        pause
    end
end                                          ############  END NEW USER SIGNUP ############

def add_new_route

end