# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

config.assets.paths << Rails.root.join('node_modules')
run Rails.application
Rails.application.load_server
