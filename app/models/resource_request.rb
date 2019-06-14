class ResourceRequest
	include ActiveModel::Conversion
	extend  ActiveModel::Naming
   	attr_accessor :email

   def initialize(email)
      @email = email
   end
   def persisted?
    false
  end
end