#4 Holes, 6 Colors, 12 Tries

class Code
	attr_reader :code, :color_code
	attr_writer :guess, :code
	def initialize
		@code = []
		@guess = []
		@@color_code = {1 => :Blue, 2 => :Red, 3 => :Yellow, 
			4 => :Green, 5 => :Purple}
	end
	
	def generate_code(number=4)
		while @code.length < number
			@code << rand(1...5)
		end
		return @code
	end

	def input_code(arr)
		@code = arr

	end
	def exact?(guess) 
		codeclone = @code.clone
		response = []
		exact = 0
		removeforclose = @code & guess
		#codeclone = codeclone - removeforclose
		guess.each_with_index do |i, index|
			if i == @code[index]
				exact += 1
				response << i
				#codeclone.delete_at(index)

			elsif removeforclose.include? i 
				response << "c"
				#codeclone.delete_at(index)
			else
				response << "."
			end
		end
		return exact,response
	end

	def fixclose(response, original, code, codeclone)
		response.each_with_index do |i, index|
			if i == "c"
			end
		end
	end


	def check(arr)
		exact, response = exact?(arr)
		puts "Your guess result is #{response}"
		return exact, response
	end
end

class HumanPlayer
	attr_reader :arr
	def initialize
		@arr = []
	end

	def guess
		@arr = []
		while @arr.count < 4
			puts "input number from 1 - 5"
			input = gets.chomp.to_i
			clean = checkparams(input)
			@arr << clean
		end
		p "your input is #{@arr}"
		return @arr
	end
	def checkparams(number)
		while number > 5 || number == 0
			puts "#{number} is not between 1 and 5. Please try again"
			number = gets.chomp.to_i
		end
		return number
	end
end

class ComputerPlayer < Code
	
	def firstguess
		guess = generate_code
		puts "guess is #{guess}"
		return guess
	end

	def guess(response)
		guess = []
		close = []
		response.each do |i|
			if i.is_a? Integer
				guess << i
			else 
				guess << rand(1...5)
			end
		end
		puts "the computer guesses #{guess}"
		return guess
	end
end


class NewGame
	def initialize
		@@arr = 0
		@@newcode = 0
		@@player1 = 0
	end
	def begintypeone
		@@newcode = Code.new
		@@player1 = HumanPlayer.new
		start_code = @@newcode.generate_code
	end
	def begintypetwo
		@@newcode = Code.new
		@@player1 = HumanPlayer.new
		create_code = @@player1.guess
		start_code = @@newcode.input_code(create_code)
		@@computer = ComputerPlayer.new


	end
	def humanguesser
		exact = 0
		tries = 0
		response = []
		until exact == 4 || tries == 12
			@@arr = @@player1.guess
			exact,response = @@newcode.check(@@arr)
			tries += 1
		end
		if exact == 4
			puts "You win!! The answer was #{@@arr}"
		else
			puts "Sorry, you didn't win. The answer was #{@@arr}"
		end
	end
	def computerguesser
		exact = 0
		tries = 0
		until exact == 4 || tries == 12
			if tries == 0
				guess = @@computer.firstguess
				exact, response = @@newcode.check(guess)
				
			else
				guess = @@computer.guess(response)
				exact, response = @@newcode.check(guess)
				
			end 
			tries += 1
		end
		if exact == 4
			puts "The computer wins!! it took #{tries} tries!"
		else
			puts "The computer lost!"
		end
	end
end

class SetupGame
	def setup
		puts "Would you like to guess the code or create it? Type 1 to guess, 2 to create"
		choice = gets.chomp.to_i
		if choice == 1
			start = NewGame.new
			start.begintypeone
			start.humanguesser
		elsif choice == 2
			start = NewGame.new
			start.begintypetwo
			start.computerguesser
		else
			puts "Sorry, you didn't choose 1 or 2"
		end
	end
end
newgame = SetupGame.new
newgame.setup

