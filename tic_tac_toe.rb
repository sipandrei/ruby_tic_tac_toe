# Joc x si y in Ruby
# Jucatorul jocului
class Player
  attr_reader :name, :letter

  def initialize(name, letter)
    @name = name
    if letter[0] != '.'
      @letter = letter[0]
    else
      puts 'Please enter another letter, besides "."'
      @letter = gets.chomp
    end
    @won = false
  end
end

# Tabla de joc
class Board
  def initialize
    @board = Array.new(3, ['.', '.', '.'])
  end

  def display_board
    @board.each_with_index do |row, row_index|
      puts '-----' if row_index != 0

      row.each_with_index do |element, index|
        print element
        print '|' if index != 2
      end
      print "\n"
    end
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

game_board = Board.new
