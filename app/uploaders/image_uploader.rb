class ImageUploader < CarrierWave::Uploader::Base
  require 'carrierwave/storage/abstract'
  require 'carrierwave/storage/file'
  require 'carrierwave/storage/fog'
  
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  if Rails.env.production?
    storage :fog
    CarrierWave.configure do |config|
      config.fog_credentials = {
        # Amazon S3用の設定
        :provider              => 'AWS',
        :region                => ENV['S3_REGION'],  # S3に設定したリージョン。
        :aws_access_key_id     => ENV['S3_ACCESS_KEY'],
        :aws_secret_access_key => ENV['S3_SECRET_KEY']
      }
      config.fog_directory     =  ENV['S3_BUCKET_KEY']
      config.fog_public = false
    end
  else
    storage :file
  end
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
   "/images/" + [version_name, "default.png"].compact.join('_')
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [200, 150]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_allowlist
   %w(jpg jpeg png)
  end
  
  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end
  
  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
