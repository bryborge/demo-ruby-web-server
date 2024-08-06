#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/web_server'

task default: %w[serve]

task :serve do
  server = WebServer.new
  
  trap('INT') do
    puts "\nShutting down gracefully ..."
    server.stop
  end

  server.start
end
