# frozen_string_literal: true

require 'socket'
require 'spec_helper'

require_relative '../lib/web_server/response'

RSpec.describe Response do
  let(:client) { instance_double('Socket', write: nil, close: nil) }

  it 'has a status message for 200 code' do
    expect(Response.new(code: 200).instance_variable_get(:@response)).to match(/OK/)
  end

  it 'has a status message for 404 code' do
    expect(Response.new(code: 404).instance_variable_get(:@response)).to match(/Not Found/)
  end

  it 'has a status message for 500 code' do
    expect(Response.new(code: 500).instance_variable_get(:@response)).to match(/Internal Server Error/)
  end

  it 'has an unknown status message for unknown code' do
    expect(Response.new(code: 123).instance_variable_get(:@response)).to match(/Unknown Status/)
  end

  it 'sets Content-Type header correctly' do
    response = Response.new(code: 200, content_type: 'text/html')
    expect(response.instance_variable_get(:@response)).to include("Content-Type: text/html")
  end

  it 'sets Content-Length header correctly' do
    data = "Hello World"
    response = Response.new(code: 200, data: data)
    expect(response.instance_variable_get(:@response)).to include("Content-Length: #{data.bytesize}")
  end

  it 'returns the HTTP response message with correct format' do
    data = "Hello World"
    expected_message = "HTTP/1.1 200 OK\r\n" +
                       "Content-Type: text/plain\r\n" +
                       "Content-Length: #{data.bytesize}\r\n" +
                       "\r\n" +
                       "#{data}" +
                       "\r\n"
    response = Response.new(code: 200, data: data, content_type: 'text/plain')
    expect(response.instance_variable_get(:@response)).to eq(expected_message)
  end

  it 'sends the HTTP response message to the client' do
    response = Response.new(code: 200)
    expect { response.send(client) }.not_to raise_error
  end
end
