#                                           Casimira Schmeler MD
#------------------------------------------------------------------------------#
class Menu

    def pause                                                                                                        
        print "press any key to continue"                                                                                                    
        STDIN.getch                                                                                                              
        print "      \r" # extra space to overwrite in case next sentence is short                                                                                                              
    end    

    
    def login                            ########## BEGIN LOGIN MENU ###########
        system("clear")
        puts "\nWelcome to the Login Menu!"
        puts "\nPlease enter your valid name, 'new' to sign up, or 'exit' to leave."
        print "\n: "
        result = gets.chomp

        if Climber.find_by(name: result)
            user = Climber.find_by(name: result)
            return user
        elsif result.downcase == "new"
            puts "You are a new user?"
            pause
            return "new"
        else result.downcase == "exit"
            result = nil
            return result
        end
    end                                  #############   END LOGIN MENU ##############

    def new_user                ###########  BEGIN NEW USER SIGNUP ############
        system("clear")
        puts "\nWelcome to the System.  Please enter your name!\n"
        print "\n: "
        name = gets.chomp
        
        pause

        system("clear")
        puts "\nHello #{name}!  Please tell us your age.\n"
        print "\n: "
        age = gets.chomp

        pause

        skill = nil
        system("clear")
        puts "\nThank you #{name}, it's good to know you're #{age}."
        puts "On a scale of 1 to 5, five being the best, how good are you?\n"
        print "\n: "
        skill = STDIN.getch
        while skill.to_i < 1 || skill.to_i > 5 do
            if skill.to_i < 1
                system("clear")
                puts "\nThere's no way you're THAT bad.  Please RE-ENTER your so-called"
                puts "'skill level'"
                print "\n: "
                while skill.to_i < 1 || skill.to_i > 5 do
                    skill = STDIN.getch
                end
            else skill.to_i > 5
                system("clear")
                puts "\nThere's no way you're THAT good.  Please RE-ENTER you're skill level"
                print "\n: "
                while skill.to_i < 1 || skill.to_i > 5 do
                    skill = STDIN.getch
                end
            end
        end

        pause 

        system("clear")
        puts "\n\nWOW #{name}, you're #{age} years old and a #{skill}?  That's great!  Last but "
        puts "not least, please select your location from the list below."
        puts "\n1 - Bay Area                    2 - Yosemite                          3 - SoCal"
        puts "             4 - New York                       5 - International"
        print ": "
        location = STDIN.getch
        location_options = ["1", "2", "3", "4", "5"]
        while !location_options.include?(location) do
            location = STDIN.getch 
        end

        pause

        system("clear")
        puts "\nFantastic!!!"
        puts "\nJust to be clear, let's make sure this is correct.  Youre name is #{name},"
        puts "you're #{age} years old.  You'd consider your skill level a #{skill}, & you're"
        puts "located in (or near) #{location}."
        print "\nCorrect? (Y/N): "
        answer = STDIN.getch.downcase

        while answer != "y" || answer != "n"
            if answer == "y"
                user = Climber.create(name: name, age: age, location: location,  skill_level: skill)
                return user
            elsif answer == "n"
                puts "\nThat's ok, we can start over again."
                pause
                self.new_user
            else
                puts "\nIt was either a yes or a no.\n"
                print "\n: "
                answer = STDIN.getch.downcase
            end
        end
    end                             ##########  END NEW USER SIGNUP  ###############



    def main(user)                            #####  BEGIN MAIN MENU ########
        system("clear")
        puts "\nWelcome #{user.name}!"
        puts "\n1 - View your climbs                  2 - Delete a climb"
        puts "3 - Find climb by name                4 - Find climb by area"
        puts "5 - List available routes             6 - List climbers who've climbed a route"
        puts "7 - Add a climb                       8 - List routes by rating"
        puts "9 - Update a climb                    X - Exit"
        print "\nMenu: "
        choice = STDIN.getch.to_s.downcase
        if choice == "x"
            return nil
        else
            return choice
        end
    end                               ##########  END MAIN MENU #############

    def view_user_climbs                    # MAIN MENU OPTION 1
        puts "\n\nVIEW YOUR CLIMBS"
        pause
    end

    def delete_climb(user)                  # MAIN MENU OPTION 2
        puts "\n\nTo delete a climb, select your climb below. Note-this action cannot be reversed."
        puts user.retrieve_climbs.each_with_index.map { |climb, i| "#{i + 1}. #{climb}\n" }
        puts "\n\n: "
        binding.pry
        user_input = STDIN.getch
        user.delete_climb(user_input)
        pause
    end

    def find_climb_by_name                  # MAIN MENU OPTION 3
        puts "\n\nFIND CLIMB BY NAME"       
        pause
    end

    def list_climbs_by_area                 # MAIN MENU OPTION 4
        puts "\n\nPlease select from the following locations\n\n"
        puts "1 - Bay Area                      2 - Yosemite                        3 - SoCal"
        puts "              4 - New York                        5 - International"
        print "\n: "
        choice = STDIN.getch
        choices = ["1", "2", "3", "4", "5"]
        while choices.all? { |c| c != choice } do
            print "\nI'm sorry but '#{choice}' is not a valid.  \nPlease try again (1-5): \n"
            choice = STDIN.getch
        end
        if choice == "1"
            puts
            results = Route.find_by_location("Bay Area")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
            puts
            pause
        elsif choice == "2"
            puts
            results = Route.find_by_location("Yosemite")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
            puts
            pause
        elsif choice == "3"
            puts
            results = Route.find_by_location("SoCal")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
            puts
            pause
        elsif choice == "4"
            puts
            results = Route.find_by_location("New York")
            results.each { |result| 
                puts "#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
            pause
        else choice == "5"
            results = Route.find_by_location("International")
            results.each { |result| 
                puts "\n\n#{result.name}, Difficulty: #{result.difficulty}, Type: #{result.style}"
            }
            puts
            pause
        end  
    end                                     # END OPETION -4, LIST CLIMBS BY LOCATION

    def list_available_routes               # MAIN MENU OPTION 5
        puts "\n\nCurrent Routes\n\n"
        allclimbs = Route.all
        allclimbs.each { |climb| puts "#{climb.name}, Location: #{climb.location}, Type: #{climb.style}" }
        puts
        pause
    end

    def list_accomplished_climbers          # MAIN MENU OPTION 6
        puts "\n\nLIST CLIMERS WHO'VE CLIMBED A ROUTE"
        pause
    end

    def add_climb                           # MAIN MENU OPTION 7
        puts "\n\nADD A CLIMB"
        pause
    end

    def list_routes_by_rating               # MAIN MENU OPTION 8
        puts "\n\nCurrent routes, listed by rating \n\n"
        #     results =  Route.all_routes_rated
        #     i = 0
        #     results.each { |result|
        #         binding.pry
        #         puts "#{i+1}. #{result} located in #{result.location}"
        #         i += 1   
        #     }
        pause
    end

    def update_climb                        # MAIN MENU OPTION 9
        puts "\n\nUPDATE A CLIMB\n"
        pause
    end
end
