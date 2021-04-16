# Joc x si 0 in Ruby

# Jucatorul jocului
class Player
  attr_reader :name, :letter, :position, :won

  @@player_letters = []
  def initialize(name, letter)
    @name = name
    until letter[0] != '.' && !@@player_letters.include?(letter[0])
      puts "Please enter another character, besides \"#{letter[0]}\""
      letter = gets.chomp
      @letter = letter
    end
    @letter = letter[0]
    @@player_letters << @letter
    @won = false
  end

  def next_move
    puts "Give a number between 1 and 9, #{@name}."
    @position = gets.chomp.to_i - 1
    next_move if (@position + 1).between?(1, 9) == false
  end
end

# Tabla de joc
class Board
  attr_reader :game_over

  def initialize
    @board = Array.new(3) { ['.', '.', '.'] }
    @game_over = false
  end

  def display_board
    print "\n"
    @board.each_with_index do |row, row_index|
      puts '-+-+-' if row_index != 0

      row.each_with_index do |element, index|
        print element
        print '|' if index != 2
      end
      print "\n"
    end
    print "\n"
  end

  def update_board(player)
    index = player.position

    while  @board[index / 3][index % 3] != '.'
      puts 'You chose a taken position'
      player.next_move
      index = player.position
    end
    @board[index / 3][index % 3] = player.letter
    display_board
  end
end

puts 'What is the name of player 1?'
name = gets.chomp
puts "What letter do you want to see on the board, #{name}?"
letter = gets.chomp
player1 = Player.new(name, letter)

puts 'What is the name of player 2?'
name = gets.chomp
puts "What letter do you want to see on the board, #{name}?"
letter = gets.chomp
player2 = Player.new(name, letter)

puts "\n-------The game is starting------\n"

game_board = Board.new
game_board.display_board
print "\n"

until game_board.game_over == true
  player1.next_move
  game_board.update_board(player1)
  # Check if he won

  player2.next_move
  game_board.update_board(player2)
  # Check if he won
end
