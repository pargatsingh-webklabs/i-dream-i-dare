class UserEmailer < ApplicationMailer

  def send_book_resources(email)
  	binding.pry
  	# Look for the email in User records
  	@user = User.where(:email.downcase => email.downcase).first

  	@password = ""

  	if @user == nil 
  		# Produce a random password for the new user, save it , and put it into a variable to display in the message. 
  		@password = (0...8).map { (65 + rand(26)).chr }.join

  		u = User.new
  		u.email = email.downcase
  		u.password = @password
  		u.is_active = true
  		u.is_deleted = false
  		u.company_id = 1
  		u.first_name = "New User"
  		u.save
  	end

  	# Identify our book resources

    active_book_resources = BookResource.where(active: true)

    # Create a zipfile
    filename = 'Dream_Dare_Resources.zip'
    temp_file = Tempfile.new(filename)
 
    begin

      #Initialize the temp file as a zip file
      Zip::OutputStream.open(temp_file) { |zos| }
     
      #Add files to the zip file as usual
      Zip::File.open(temp_file.path, Zip::File::CREATE) do |zip|

        active_book_resources.each do |res|
        
        # Adding static files (Examples)
        # zip.add("Compelling Vision Worksheet PDF.pdf", "app/assets/bookresources/Compelling Vision Worksheet PDF.pdf")
        # zip.add("Coaching Contract (with tips) PDF.pdf", "app/assets/bookresources/Coaching Contract (with tips) PDF.pdf")

        zip.add(res.file_name, res.path + res.file_name)
        
        end

      end
     
    # attachments['filename.jpg'] = File.read('/path/to/filename.jpg')
    attachments['Dream_Dare_Resources.zip'] = File.read(temp_file.path)

  	mail( :to => email,
    :subject => 'Your requested resources from I Dream I Dare' )

  	ensure
      #Close and delete the temp file
      temp_file.close
      temp_file.unlink
    end
end

end
