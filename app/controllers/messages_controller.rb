class MessagesController < ApplicationController
	def new
	end

	def create
		@message = Message.new(params.require(:messages).permit(:text))
		@message.save
	end
	
	def show
		@message = Message.find(params[:id])

		respond_to do |format|
      		format.html # stays the same
  			format.json { render json: @message.to_json }
        	format.xml { render :xml => @message.to_xml }
    	end
	end
end
