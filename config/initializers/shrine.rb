require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

Shrine.plugin :activerecord
Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :validation_helpers
Shrine.plugin :cached_attachment_data # for forms

s3_options = {
	access_key_id:  		ENV['S3_KEY'],
	secret_access_key:  	ENV['S3_SECRET'],
	region:  				ENV['S3_REGION'],
	bucket:  				ENV['S3_BUCKET']
}


Shrine.storages = {
  # temporary storage
  cache: Shrine::Storage::FileSystem.new("public", prefix: "upload"),

  # permanent storage
  store: Shrine::Storage::S3.new(s3_options),
}
