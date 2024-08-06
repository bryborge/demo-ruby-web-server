#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'response'

# Builds an HTTP response message.
class ResponseBuilder
  def prepare(request)
    # TODO: Do something more interesting
    send_ok_response("Hello World!")
  end

  def send_ok_response(data)
    Response.new(code: 200, data: data)
  end
end
