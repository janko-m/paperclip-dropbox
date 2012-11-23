require 'vcr'
require 'yaml'
require 'erb'
require 'rest_client'
require 'active_support/core_ext/hash/except'
require 'active_support/core_ext/hash/keys'

RSPEC_DIR = File.expand_path(File.dirname(__FILE__))
Dir[File.join(RSPEC_DIR, "support/**/*.rb")].each { |f| require f }

CREDENTIAL_FILES = {
  dropbox: "#{RSPEC_DIR}/dropbox.yml",
  app_folder: "#{RSPEC_DIR}/app_folder.yml"
}

if CREDENTIAL_FILES.all? { |_, file| File.exists?(file) }
  CREDENTIALS = Hash[CREDENTIAL_FILES.map do |key, file|
    [key, YAML.load(ERB.new(File.read(file)).result).symbolize_keys]
  end]

  if not CREDENTIALS.all? { |mode, keys| keys[:access_level].to_sym == mode }
    puts error_message_wrong_access_levels
    exit
  end
else
  puts error_message_credentials_not_found
  exit
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :fakeweb
  CREDENTIALS.each do |mode, keys|
    keys.except(:access_level).each do |key, value|
      config.filter_sensitive_data("<#{mode.to_s.upcase}_#{key.to_s.upcase}>") { value }
    end
  end
  config.default_cassette_options = {
    serialize_with: :syck,
    record: :new_episodes
  }
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end
