# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/web_server/request_parser'

RSpec.describe RequestParser do
  let(:request) { "GET / HTTP/1.1\r\nHost: localhost\r\n\r\n" }

  it 'parses the request method' do
    expect(RequestParser.new.parse(request)).to have_key(:method)
    expect(RequestParser.new.parse(request)[:method]).to eq('GET')
  end

  it 'parses the request path' do
    expect(RequestParser.new.parse(request)).to have_key(:path)
    expect(RequestParser.new.parse(request)[:path]).to eq('/')
  end

  it 'parses the request headers' do
    expect(RequestParser.new.parse(request)).to have_key(:headers)
    expect(RequestParser.new.parse(request)[:headers]).to be_a(Hash)
    expect(RequestParser.new.parse(request)[:headers].keys).to include('Host')
    expect(RequestParser.new.parse(request)[:headers]['Host']).to eq('localhost')
  end
end
