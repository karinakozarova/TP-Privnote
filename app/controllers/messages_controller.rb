class MessagesController < ApplicationController
	def new
	end

	def create
		@message = Message.new(params.require(:messages).permit(:text))
		@message.save
	end
	
	def show
		id = params[:id]
		if Message.exists?(id)
			@message = Message.find(id)
			respond_to do |format|
	      		format.html # stays the same
	  			format.json { render json: @message.to_json }
	        	format.xml  {  render :xml => @message.to_xml }
	    	end
	    	@message.destroy
	    else 
	    	# message is already destroyed
			# @message = Message.new(:text => "The message was destroyed! You can't view it.")
			# @message.save
			render :error
		end
		
	end
end
