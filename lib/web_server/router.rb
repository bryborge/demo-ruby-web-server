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
    if @routes.key?(path)
      @routes[path].call
    else
      not_found
    end
  end

  private

  # Returns a 404 Not Found response.
  #
  # @return [Array] The 404 response body and content type.
  def not_found
    ["404 Not Found", "text/plain"]
  end
end
