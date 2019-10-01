def pause                                                                                                        
    print "press any key to continue"                                                                                                    
    STDIN.getch                                                                                                              
    print "            \r" # extra space to overwrite in case next sentence is short                                                                                                              
end    

def new_user
    system("clear")
    puts " " * 3 + "*" * 70                                     # solid row line
    3.times { puts " " * 3 + "*" * 2 + " " * 66 + "*" * 2 }     # spacer
    puts " " * 3 + "*" * 2 + " " * 26 + "WELCOME HUMAN!" + " " * 26 + "*" * 2
    4.times { puts " " * 3 + "*" * 2 + " " * 66 + "*" * 2 }     # spacer
    puts " " * 3 + "*" * 70                                     # solid row line
    input = STDIN.getch
    puts input
    pause
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
        puts "You entered your name!"
    elsif input == "new"
        new_user
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