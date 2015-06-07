class Game
  attr_accessor :word

  def initialize
    @word = find_word
    @hidden_word = hidden_word
    @player = create_player
    start_game
  end 

  def find_letter_index(guess)
  	letter_index = []
  	@word.each_with_index {|letter,i| letter_index << i if guess == letter}
  	letter_index
  end

  def create_player
  	puts "Enter your name"
    player_name = gets.chomp
    Player.new(player_name)
  end

  def guess_letter
  	puts "Guess the letter:"
  	gets.chomp
  end

  def start_game
  	while true do
      return game_over if @player.guesses_left == 0
      return player_wins if @word == @hidden_word
      guess = guess_letter

  	  if @word.include?(guess)
  	  	puts "Correct!"
  	  	letters_index = find_letter_index(guess)
  	  	change_hidden_word(guess, letters_index)
  	  	show_hidden_word
  	  else
  	  	@player.guesses_left -= 1
  	  	puts "Wrong, try again"
  	  	puts "Lives remaining: #{@player.guesses_left}"
  	  end
    end
  end

  def hidden_word
    Array.new(@word.length, '_')
  end

  def change_hidden_word(guess, letters_index)
  	@hidden_word = @hidden_word.each_with_index.map do |hidden_letter, i| 
  		letters_index.include?(i) ? guess : hidden_letter 
  	end
  end

  def show_hidden_word
  	print @hidden_word.join
  	puts ''
  end

  def game_over
  	puts 'You lose!'
  	puts "The word was: #{@word}"
  	@player.guesses_left = 0
  end

  def player_wins
  	puts "You win."
  end

  def find_word
    lines = File.readlines("words.txt").select do |x| 
      (6..12).include?(x.chomp.length)
    end
    lines[rand(lines.length-1)].chomp.chars
  end
end
 
class Player
  attr_accessor :name, :guesses_left

  def initialize(name)
	@name = name
	@guesses_left = 20
  end
end

game = Game.new 


