class MessagesController < ApplicationController
	puts "HEre"
	class Product < ApplicationRecord
		self.table_name = "testing"
		user = User.new do |u|
  			u.name = "David"
  			u.occupation = "Code Artist"
		end
		users = User.all
		users.save!
		puts users
	end
end
