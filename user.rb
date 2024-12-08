# frozen_string_literal: true

class User
 attr_accessor :name, :email

 def initialize(attributes = {})
  @first_name = attributes[:first_name]
  @last_name = attributes[:last_name]
  @email = attributes[:email]
 end

 def full_name
  "#{@first_name} #{@last_name}"
 end

 def formated_email
  "#{full_name} <#{@email}>"
 end
end
