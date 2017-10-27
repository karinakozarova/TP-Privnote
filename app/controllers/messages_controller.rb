class MessagesController < ApplicationController
	def new
	end

	def create
		@message = Message.new(params.require(:messages).permit(:text))
		@message.save
		redirect_to @message
	end
	def show
		render plain: params[:id]
	end
end
