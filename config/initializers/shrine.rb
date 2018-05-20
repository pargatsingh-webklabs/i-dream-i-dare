require 'shrine'
require 'shrine/storage/s3'

Shrine.plugin :activerecord
Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :validation_helpers
 
s3_options = {
	access_key_id:  		ENV['S3_KEY'],
	secret_access_key:  	ENV['S3_REGION'],
	region:  				ENV['S3_REGION'],
	bucket:  				ENV['S3_BUCKET'],
}

Shrine.storages = {
  # temporary storage
  cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),

  # permanent storage
  store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'),
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data # for forms
