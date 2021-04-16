# Joc x si 0 in Ruby

# Jucatorul jocului
class Player
  attr_reader :name, :letter, :position

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
    while  @board[player.position / 3][player.position % 3] != '.'
      puts 'You chose a taken position'
      player.next_move
    end
    @board[player.position / 3][player.position % 3] = player.letter
    display_board
  end

  def end_game(player)
    if won_diag?(player.letter) || won_col?(player) || won_row?(player)
      @game_over = true
      puts "#{player.name} won the game!"
    end
  end

  def draw_end
    if draw?
      @game_over = true
      puts "It's a draw!"
    end
  end

  private

  def draw?
    true unless @board.flatten.include?('.')
  end

  def won_diag?(character)
    num = 0
    @board.each_with_index do |row, index|
      num += 1 if character == row[index]
    end
    return true if num == 3

    num = 0
    @board.each_with_index do |row, index|
      num += 1 if character == row[2 - index]
    end
    true if num == 3
  end

  def won_row?(player)
    row = @board[player.position / 3]
    true if row.uniq.length == 1 && row.uniq[0] == player.letter
  end

  def won_col?(player)
    col = player.position % 3
    won = true
    @board.each do |row|
      won = false if row[col] != player.letter
    end
    won
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

puts "\n---------Game Started--------\n"

game_board = Board.new
game_board.display_board
print "\n"

until game_board.game_over == true
  player1.next_move
  game_board.update_board(player1)
  game_board.end_game(player1)
  game_board.draw_end

  break if game_board.game_over

  player2.next_move
  game_board.update_board(player2)
  game_board.end_game(player2)
  game_board.draw_end
end
