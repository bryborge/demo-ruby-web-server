#!/usr/bin/ruby
# frozen_string_literal: true

require_relative 'response'
require_relative 'router'

# Builds an HTTP response message.
class ResponseBuilder
  def initialize
    @router = Router.new

    # Routes
    @router.add_route("/") { serve_file("public/index.html") }
    @router.add_route("/about") { serve_file("public/about.html") }
    @router.add_route("/contact") { serve_file("public/contact.html") }
  end

  # Prepares an HTTP response for the given request by dispatching the request path to the router and sending an OK
  # response with the response body and content type.
  #
  # @param request [Hash] the request hash containing the request path
  # @return [void]
  def prepare(request)
    path = request[:path]
    response_body, content_type, status = @router.dispatch(path)
    send_response(response_body, content_type, status)
  end

  # Serves a file from the specified filepath.
  #
  # @param filepath [String] The path to the file to be served.
  # @return [Array, nil] An array containing the file contents and the content type, or nil if file doesn't exist.
  def serve_file(filepath)
    [File.read(filepath), "text/html", 200] if File.exist?(filepath)
  end

  # Creates a new Response object with a status code of 200 (OK) and the provided data and content type.
  #
  # @param data [String] The data to be sent in the response.
  # @param content_type [String] The content type of the response.
  # @param status [Integer] The status code of the response.
  # @return [Response] A new Response object with the provided data and content type.
  def send_response(data, content_type, status)
    Response.new(code: status, data: data, content_type: content_type)
  end
end
