#!/usr/bin/ruby
# frozen_string_literal: true

# Parses an HTTP request message.
class RequestParser
  def parse(request)
    method, path, _version = request.lines[0].split(' ')

    {
      method: method,
      path: path,
      headers: parse_headers(request)
    }
  end

  private

  def parse_headers(request)
    headers = {}

    request.lines[1..-1].each do |line|
      return headers if line == "\r\n"

      key, value   = line.split(':')
      headers[key] = value.strip
    end

    headers
  end 
end
