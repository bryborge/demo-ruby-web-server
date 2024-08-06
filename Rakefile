#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'lib/web_server'

task default: %w[serve]

task :serve do
  server = WebServer.new('127.0.0.1', 1234)
  
  trap('INT') do
    puts "\nShutting down gracefully ..."
    server.stop
  end

  server.start
end
