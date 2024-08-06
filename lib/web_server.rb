#!/usr/bin/ruby
# frozen_string_literal: true

require 'socket'

require_relative 'web_server/request_parser'
require_relative 'web_server/response_builder'

# A simple web server implementation.
#
# @example
#   WebServer.new('127.0.0.1', 1234).start
class WebServer
  def initialize(host = '127.0.0.1', port = 1337)
    # While you can simply use TCPServer here, I chose to build from a generic
    # Socket to illustrate the concept a bit more thoroughly.
    #   - Resource: https://docs.ruby-lang.org/en/3.2/TCPServer.html
    @server = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
    @server.bind(Addrinfo.tcp(host, port))
    @server.listen(5)

    @host     = host
    @port     = port
    @shutdown = false

    puts "Listening on #{@host}:#{@port}"
  end

  # Starts the server and listens for connections.
  #
  # @return [void]
  def start
    loop do
      break if @shutdown

      begin
        client, _client_addr_info = @server.accept_nonblock
      
        Thread.new do
          process(client)
          client.close
        end
      rescue IO::WaitReadable, Errno::EINTR
        retry unless @shutdown
      end
    end
  end

  # Stops the server.
  # 
  # @return [void]
  def stop
    @shutdown = true
    @server.close
  end

  private

  # Processes a single client connection.
  # 
  # @param [Socket] client The client connection.
  # @return [void]
  def process(client)
    request  = RequestParser.new.parse(client.readpartial(2048))
    response = ResponseBuilder.new.prepare(request)

    # TODO: Add logging
    puts "Started #{request[:method]} '#{request[:path]}' for #{client.local_address.ip_address} at #{Time.now}"

    response.send(client)
    client.close
  end
end
