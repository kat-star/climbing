def pause                                                                                                        
    print "press any key to continue"                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r" # extra space to overwrite in case next sentence is short                                                                                                              
end    

def user_menu(input)
    system("clear")
    puts "Welcome #{input.capitalize}!"
    puts "1 - See your climbs       2 - Find climbs in your area"
    choise = STDIN.getch.to_s
    #binding.pry
    if choise == "1"
        puts "HERE ARE YOUR CLIMBS"
        pause
        user_menu(input)
    elsif choise == "2"
        puts "THESE ARE CLIMBS IN YOUR AREA"
        pause
        user_menu(input)
    else
        return
    end
end


def main
    system("clear")
    puts " " * 30
    puts "Welcome to the Main Menu!"
    puts " " * 36
    puts "Please enter your name, 'new' to sign up, or 'exit' to leave."
    print "BEGIN: "
    input = gets.chomp
    input.downcase!

    if input == "name"
        system("clear")
        user_menu(input)
        
        
    elsif input == "new"
        pause
        return
    elsif input == "exit" 
        puts "YOU'RE GOING TO WISH YOU STAYED!"
        pause 
        return
    else
        puts "That was not a valid menu selection"
        pause
        main
    end
end