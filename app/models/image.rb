class Image < ActiveRecord::Base

	require "shrine/storage/s3"

	# adds an `image` virtual attribute
	include ImageUploader::Attachment.new(:image)

end

