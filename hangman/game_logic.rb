require 'yaml'

class Game
  attr_accessor :word, :guesses_left

  def initialize
    @guesses_left =  10
    @word         =  random_word
    @hidden_word  =  hidden_word
  end 

  def find_letter_index(guess)
  	letter_index = []
  	@word.each_with_index {|letter,i| letter_index << i if guess == letter}
  	letter_index
  end

  def guess_letter
  	puts "Guess the letter:"
  	gets.chomp
  end

  def start_game
  	loop do
      return game_over if guesses_left == 0
      return player_wins if @word == @hidden_word
      guess = guess_letter
     
      if guess == 'save'
        save 
      elsif @word.include?(guess)
  	  	puts "Correct!"
  	  	letters_index = find_letter_index(guess)
  	  	change_hidden_word(guess, letters_index)
  	  	show_hidden_word
  	  else
  	  	@guesses_left -= 1
  	  	puts "Wrong, try again"
  	  	puts "Lives remaining: #{@guesses_left}"
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
  	puts "The word was: #{@word.join}"
  end

  def player_wins
  	puts "You win."
  end

  def random_word
    lines = File.foreach("words.txt").select do |x| 
      (6..12).include?(x.chomp.length) && x.downcase == x
    end
    lines[rand(lines.length-1)].chomp.chars
  end

  def load
    content = File.read('games/saved.yaml')
    YAML.load(content)  
  end

  def save
    Dir.mkdir('games') unless Dir.exist? 'games'
    filename = 'games/saved.yaml'
    File.open(filename, 'w') {|file| YAML.dump(self, file)}
  end
end

