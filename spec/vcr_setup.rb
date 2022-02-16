require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock

  # Avoid conflict with Selenium
  config.ignore_localhost = true

  # Allow downloading webdrivers for Selenium
  driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }
  # Downloading the Firefox driver involves a redirect
  driver_hosts += ["github-releases.githubusercontent.com"]
  config.ignore_hosts(*driver_hosts)

  config.configure_rspec_metadata!
end
