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
			render :error
		end
		
	end

	def mssg_as_json
					
		respond_to do |format|
			@message = Message.new
			@message.text =  params.permit(:message)
			@message.save
			string = "http://privnote.herokuapp.com/messages/" 
			@message.url = string + @message.id.to_s
			@message.save
			format.json  { render json: { url: @message[:url] } }
			format.xml { 
				@message = Nokogiri::XML.fragment(request.body.read).content
				render plain: @message.text
			}
		end
	end

	def return_mssg_as_json
		# in browser
		if Message.exists?(params[:id])
			if @message == Message.find_by(id: params[:id])
			  render json: { message: @message[:text] }
			else
			  render json: {errors: :not_found}, status: :not_found
			end
			@message.destroy
		else 
		   render json: { error: "Error!Message was destroyed!" }
		end
	end

end
