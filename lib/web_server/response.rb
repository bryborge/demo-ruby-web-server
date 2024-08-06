#!/usr/bin/ruby
# frozen_string_literal: true

# An HTTP response message.
# 
# Resource: https://developer.mozilla.org/en-US/docs/Web/HTTP/Messages
class Response
  def initialize(code:, data: "")
    @response = "HTTP/1.1 #{code}\r\n" +
                "Content-Length: #{data.size}\r\n" +
                "\r\n" +
                "#{data}\r\n"
  end

  def send(client)
    client.write(@response)
  end
end
