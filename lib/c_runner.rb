require 'mumukit'

Mumukit.runner_name = 'c'
Mumukit.configure do |config|
  config.docker_image = 'mumuki/mumuki-cspec-worker:2.0'

end

require_relative './version'
require_relative './test_hook'
require_relative './metadata_hook'
