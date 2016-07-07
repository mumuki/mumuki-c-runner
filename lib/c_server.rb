require 'mumukit'

Mumukit.runner_name = 'c'
Mumukit.configure do |config|
  config.docker_image = 'mumuki/mumuki-cspec-worker'

end

require_relative './test_hook'
require_relative './metadata_hook'