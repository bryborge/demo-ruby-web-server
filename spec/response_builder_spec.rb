# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/web_server/response_builder'
require_relative '../lib/web_server'

describe ResponseBuilder do
  let(:builder) { ResponseBuilder.new }

  it 'initializes router correctly' do
    expect(builder.instance_variable_get(:@router)).to be_a(Router)
  end

  describe '#prepare' do
    context 'when request path matches a route' do
      let(:request) { Hash[:path => '/'] }
      let(:response) { builder.prepare(request) }

      it 'sends an OK response with the response body and content type' do
        expect(response.instance_variable_get(:@response)).to match(File.read('public/index.html'))
        expect(response.instance_variable_get(:@response)).to match('text/html')
        expect(response.instance_variable_get(:@response)).to match('200')
      end
    end

    context 'when request path does not match a route' do
      let(:request) { Hash[:path => '/unknown'] }
      let(:response) { builder.prepare(request) }

      it 'raises error' do
        expect(response.instance_variable_get(:@response)).to match(/Not Found/)
      end
    end
  end

  describe '#serve_file' do
    context 'when file exists' do
      let(:filepath) { 'public/index.html' }

      before do
        @file = builder.serve_file(filepath)
      end

      it 'serves the file contents and content type' do
        expect(@file).to eq([File.read('public/index.html'), "text/html", 200])
      end
    end

    context 'when file does not exist' do
      let(:filepath) { 'non-existent-file.txt' }

      before do
        @file = builder.serve_file(filepath)
      end

      it 'returns nil' do
        expect(@file).to be_nil
      end
    end
  end

  describe '#send_response' do
    context 'when data and content type are provided' do
      let(:data) { "Hello World!" }
      let(:content_type) { "text/html" }
      let(:status) { 200 }
      let(:response) { builder.send_response(data, content_type, status) }

      it 'creates a new Response object with the provided data and content type' do
        expect(response.instance_variable_get(:@response)).to match(/Hello World!/)
        expect(response.instance_variable_get(:@response)).to match(/text\/html/)
        expect(response.instance_variable_get(:@response)).to match(/200/)
      end
    end
  end
end
