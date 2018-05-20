class Image < ActiveRecord::Base

	# adds an `image` virtual attribute
	include ImageUploader::Attachment.new(:image)

end

