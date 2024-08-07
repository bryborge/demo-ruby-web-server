#!/usr/bin/ruby
# frozen_string_literal: true

# An HTTP response message.
# 
# Resource: https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages
class Response
  STATUS_MESSAGES = {
    200 => "OK",
    404 => "Not Found",
    500 => "Internal Server Error",
  }.freeze

  def initialize(code:, data: "", content_type:)
    message  = STATUS_MESSAGES[code] || "Unknown Status"
    @response = "HTTP/1.1 #{code} #{message}\r\n" +
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
