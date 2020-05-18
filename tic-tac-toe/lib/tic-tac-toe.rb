class Players
    attr_accessor :name, :symbol
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end
end

class Game
    
    attr_accessor :board, :count

    @@board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    @@count = 0
    WIN_COMBINATIONS = [ 
        [0,1,2], # top_row 
        [3,4,5], # middle_row 
        [6,7,8], # bottom_row 
        [0,3,6], # left_column 
        [1,4,7], # center_column 
        [2,5,8], # right_column 
        [0,4,8], # left_diagonal 
        [6,4,2] # right_diagonal 
        ]

    def initialize
        puts "Tic Tac Toe!"
        @board = @@board
    end

    def display_board
        puts "  #{@@board[0]}  |  #{@@board[1]}  |  #{@@board[2]}"
        puts seperator = "-----+-----+-----"
        puts "  #{@@board[3]}  |  #{@@board[4]}  |  #{@@board[5]}"
        puts seperator
        puts "  #{@@board[6]}  |  #{@@board[7]}  |  #{@@board[8]}"
        puts "\n"
    end

    def game_start
        puts "Time for some Tic Tac Toe! Enter your name player 1: \n"
        player1 = gets.chomp
        puts "Would you like to be X or O #{player1}?"
        symbol1 = gets.chomp.upcase
        player_one = Players.new(player1, symbol1)
        puts "And a name for player 2: \n"
        player2 = gets.chomp
        symbol2 = player_one.symbol == "X" ? "O" : "X"
        player_two = Players.new(player2, symbol2)
        puts "\n"
        puts "Okay #{player_one.name}, you're up. Make a move. \n "
        display_board
        play_game(player_one, player_two)
    end

    def play_game(player_one, player_two)

            until @@count == 9
            puts "Pick a number from the grid above #{player_one.name}"
            move = gets.chomp.to_i - 1
            if valid_move?(move, player_one, player_two) == true
                move = gets.chomp.to_i - 1
            end
            @@board[move] = player_one.symbol
            @@count += 1
            display_board
            break if check_winner?(player_one, player_two)

            puts "Pick a number from the grid above #{player_two.name}"
            move = gets.chomp.to_i - 1
            if valid_move?(move, player_one, player_two) == true
                move = gets.chomp.to_i - 1
            end
            @@board[move] = player_two.symbol
            @@count += 1
            display_board
            break if check_winner?(player_one, player_two)
        end
        game_over
    end

    def valid_move?(move, player_one, player_two)
        if @@board[move] == "#{player_one.symbol}" || @@board[move] == "#{player_two.symbol}"
            puts "That number is taken, pick another!"
            return true
        else 
            return false
        end
    end

    def check_winner?(player_one, player_two)
        if WIN_COMBINATIONS.any? {|line| line.all? { |square| @@board[square] == "#{player_one.symbol}" } }
            puts "#{player_one.name} won!"
            return true
        elsif WIN_COMBINATIONS.any? {|line| line.all? { |square| @@board[square] == "#{player_two.symbol}" } }
            puts "#{player_two.name} won!"
            return true
        elsif @@count == 9
            puts "It's a tie!"
            return true
        else
            return false
        end
    end

    def game_over
        puts "Game Over!"
        puts "\n"
        reset_game
    end

    def reset_game
        puts "Would you like to play again? Y/N "
        input = gets.chomp.upcase
        if input == "Y"
            refresh_board
            game_start
        elsif input == "N"
            puts "Good game! Thanks for playing!"
            exit!
        end
    end

    def refresh_board
        @@board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        @@count = 0
    end

end

#game = Game.new
#game.game_start