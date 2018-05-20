class Image < ActiveRecord::Base

	require "shrine/storage/s3"

	# adds an `image` virtual attribute
	include ::PhotoUploader::Attachment.new(:image)
	
	s3_options = {
	  bucket:            "<YOUR BUCKET>",
	  access_key_id:     "<YOUR KEY>",
	  secret_access_key: "<YOUR SECRET>",
	  region:            "<REGION>",
	}

	Shrine.storages = {
	  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options),
	  store: Shrine::Storage::S3.new(**s3_options),
	}

end

