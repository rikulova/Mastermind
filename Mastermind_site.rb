require 'sinatra'
require 'sinatra/reloader' 
require './Mastermind.rb'
enable :sessions

codeClass = Code.new

player1 = HumanPlayer.new
color_code = {"1" => "Blue", "2" => "Red", "3" => "Purple", "4" => "Green", "5" => "Yellow"}
guesses = Array.new

exact = 0
tries = 1

post '/guess' do 
	code = session[:answer]
	if params["onePlayer"]
			erb :game,:locals => {:code => session[:answer], :one => false}
	elsif params["twoPlayers"]
		erb :setCode#,:locals => {:code => session[:answer], :twoPlayers => false}
	# elsif params[""]
	else

		if params["guesses"]
			guesses << color_code[params["0"]]
			guesses << color_code[params["1"]]
			guesses << color_code[params["2"]]
			guesses << color_code[params["3"]]

			tries = guesses.length / 4
		else
			tries = 1
			guesses = [color_code[params["0"]], color_code[params["1"]], color_code[params["2"]], color_code[params["3"]]]
		end
		guess = Array.new
		guess << params["0"].to_i
		guess << params["1"].to_i
		guess << params["2"].to_i
		guess << params["3"].to_i

		if params["newCode"]
			session.delete(:answer)
			codeClass = Code.new
			code = codeClass.input_code(guess)
			session[:answer] = code
			erb :game,:locals => {:code => session[:answer], :one => false}
		# end
		else
			exact, response = codeClass.exact?(guess)
			wordResponse = Array.new
			response.each do |i|
				if i != "false" 
					str = i.to_s
					wordResponse << color_code[str]
				else 
					wordResponse << "false"
				end
			end
			# wordResponse = response.map { |i| i.to_s}
			# wordResponse = response.map { |i| color_code[i]}
			erb :game,:locals => {:code => session[:answer], :zero => color_code[params["0"]], :one => color_code[params["1"]], :two => color_code[params["2"]], :three => color_code[params["3"]], :guesses => guesses, :tries => tries, :exact => exact, :response => response, :wordResponse => wordResponse}
		end
	end
end

get '/guess' do
	erb :game,:locals => {:code => session[:answer], :zero => color_code[params["0"]], :one => color_code[params["1"]], :two => color_code[params["2"]], :three => color_code[params["3"]], :guesses => guesses, :tries => tries, :exact => exact, :response => response}
end

get '/' do
	if params["win"]
		session.delete(:answer)
	end
	codeClass = Code.new
	code = codeClass.generate_code
	session[:answer] = code
	erb :index
end



