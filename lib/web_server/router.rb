# frozen_string_literal: true

class Router
  def initialize
    @routes = {}
  end

  # Adds a route to the router.
  #
  # @param [String] path The request path to match.
  # @param [Proc] action The action to call when the route matches.
  # @return [void]
  def add_route(path, &action)
    @routes[path] = action
  end

  # Dispatches a request to the appropriate action based on the path.
  #
  # @param [String] path The request path.
  # @return [String] The response body.
  def dispatch(path)
    begin
      if @routes.key?(path)
        @routes[path].call
      else
        not_found(path)
      end
    rescue StandardError => e
      puts "Internal Server Error: #{e.message}"
      internal_server_error
    end
  end

  private

  # Returns a 404 Not Found response.
  #
  # @return [Array] The 404 response body, content type, and status code.
  def not_found(path)
    ["Resource '#{path}' Not Found", "text/plain", 404]
  end

  # Returns a 500 Internal Server Error response.
  #
  # @return [Array] The 500 response body, content type, and status code.
  def internal_server_error
    ["Internal Server Error", "text/plain", 500]
  end
end
