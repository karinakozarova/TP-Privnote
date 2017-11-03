class MessagesController < ApplicationController
	 protect_from_forgery except: :mssg_as_json
	def new
	end

	def create
		@message = Message.new(params.require(:messages).permit(:text))
		@message.save
		string = "http://privnote.herokuapp.com/messages/" 
		@message.url = string + @message.id.to_s
		@message.save
	end
	
	def show
		id = params[:id]
		if Message.exists?(id)
			@message = Message.find(id)
			respond_to do |format|
	      		format.html # stays the same
	  			format.json { render json: @message.to_json }
	        	format.xml  { render :xml => @message.to_xml }
	    	end
	    	@message.destroy
	    else 
	    	# message is already destroyed
			# @message = Message.new(:text => "The message was destroyed! You can't view it.")
			# @message.save
			:error
		end
		
	end

	def mssg_as_json
		@message = Message.new
		@message.text = params.require(:messages)
		@message.save
		string = "http://privnote.herokuapp.com/messages/" 
		@message.url = string + @message.id.to_s
		@message.save
		render json: @message
	end

	def return_mssg_as_json
			id = params[:id].to_i
			@message = Message.find(id)
			render json: @message
	end

	def api
		return_mssg_as_json
	end
end
