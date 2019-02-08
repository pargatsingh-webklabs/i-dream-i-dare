require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/s3'

Shrine.plugin :activerecord
Shrine.plugin :logging, logger: Rails.logger
Shrine.plugin :validation_helpers
Shrine.plugin :cached_attachment_data # for forms

s3_options = {
	access_key_id:  		'AKIAJ4IXYHKOFJY4EP6A',
	secret_access_key:  	'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',
	region:  				 'us-east-1',
	bucket:  				'logimodoc'
}

Shrine.storages = {
  # temporary storage
  cache: Shrine::Storage::FileSystem.new("public", prefix: "upload"),

  # permanent storage
  store: Shrine::Storage::S3.new(s3_options),
}
