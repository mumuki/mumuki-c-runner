require 'mumukit'

Mumukit.configure do |config|
  config.docker_image = 'mumuki/mumuki-cspec-worker'
  config.runner_name = 'cspec-server'

end

require_relative './test_hook'
require_relative './metadata_hook'