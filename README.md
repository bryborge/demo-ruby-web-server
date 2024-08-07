# Demo: A Simple Web Server in Ruby

A web (HTTP) server is essentially composed of the following:

*   A (TCP) socket
*   A request handler
*   A response formatter
*   A router (to handle different request methods)

This project attempts to demonstrate how these different pieces work together.

It's worth noting that Ruby already ships with a capable library called [WEBrick](https://github.com/ruby/webrick).
[Rack](https://github.com/rack/rack) is also a great library to use for this purpose.

**Note:** Because this is a project designed for educational purposes, it would _NOT_ be wise to use this in any
production-like environments.

## Helpful Commands

For testing (w/o a browser):

```sh
curl -H "Host: localhost" -H "Accept: */*" -X GET http://localhost:1337
curl -H "Host: localhost" -H "Accept: */*" -X GET http://localhost:1337/about
curl -H "Host: localhost" -H "Accept: */*" -X GET http://localhost:1337/contact
```
