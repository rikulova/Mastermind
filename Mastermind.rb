#4 Holes, 6 Colors, 12 Tries

class ComputerCode
	attr_reader :code, :color_code
	def initialize
		@code = [1,2,3,4]
		@@color_code = {0 => :White, 1 => :Blue, 2 => :Red, 3 => :Yellow, 
			4 => :Green, 5 => :Purple}
	end
	
	def generate_code
		while @code.length < 4
			@code << rand(5)
		end
	end
end

class Player
end


try = ComputerCode.new
