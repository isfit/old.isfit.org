class WhoAmIController < ApplicationController

	def index
    
      @func_array = WhoAmI.get_random_functionaries  
    	@fasit = @func_array[rand(@func_array.size)]
      
      if request.post?  
  	    guess_form = params[:guess]
		    correct_func_id = guess_form[:answer_id]
		    selected_func = guess_form[:user]
		    @correct_func = LdapUser.get_by_id(correct_func_id)
		    @answer_correct = (@correct_func.username == selected_func)
                 
        @who_am_i = WhoAmI.new
        @who_am_i.guesser_id = current_user.id
        @who_am_i.guessed_on_id = correct_func_id
        @who_am_i.correct = @answer_correct
        @who_am_i.save 
      
		  end		
  end

  def highscore
    @best_guessers = WhoAmI.find_by_sql("SELECT *, COUNT(id) AS count, SUM(correct) AS sum_correct, (SUM(correct)/COUNT(id)*100) AS rating
                                          FROM `who_am_is` GROUP BY guesser_id HAVING count>100 ORDER BY rating DESC, count DESC LIMIT 10")
    @most_guesses = WhoAmI.find_by_sql("SELECT *, COUNT(id) AS count, SUM(correct) AS sum_correct 
                                          FROM `who_am_is` GROUP BY guesser_id ORDER BY sum_correct DESC LIMIT 10")
    @best_guessed_on = WhoAmI.find_by_sql("SELECT *, COUNT(id) AS count, SUM(correct) AS sum_correct, (SUM(correct)/COUNT(id)*100) AS rating 
                                          FROM `who_am_is` GROUP BY guessed_on_id ORDER BY rating DESC, count DESC LIMIT 5")
    @most_guessed_on = WhoAmI.find_by_sql("SELECT *,COUNT(id) AS count FROM `who_am_is` GROUP BY guessed_on_id 
                                                              ORDER BY count DESC 
                                                              LIMIT 5")
  end
	
end
