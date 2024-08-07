#!/usr/bin/ruby
# frozen_string_literal: true

# An HTTP response message.
# 
# Resource: https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages
class Response
  def initialize(code:, data: "", content_type:)
    @response = "HTTP/1.1 #{code}\r\n" +
                "Content-Type: #{content_type}\r\n" +
                "Content-Length: #{data.bytesize}\r\n" +
                "\r\n" +
                "#{data}\r\n"
  end

  # Sends the HTTP response message to the client.
  #
  # @param client [Socket] The client socket to write the response to.
  # @return [void]
  def send(client)
    client.write(@response)
  end
end
