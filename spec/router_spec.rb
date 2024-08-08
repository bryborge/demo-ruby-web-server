# frozen_string_literal: true

require 'spec_helper'

require_relative '../lib/web_server/router'

describe Router do
  let(:router) { Router.new }

  it 'initializes router correctly' do
    expect(router.instance_variable_get(:@routes)).to be_a(Hash)
  end

  describe '#add_route' do
    context 'when route is added successfully' do
      let(:path) { '/' }

      before do
        router.add_route(path) { "Hello World!" }
      end
    end
  end

  describe '#dispatch' do
    context 'when dispatching to existing route' do
      let(:path) { '/' }

      before do
        router.add_route(path) { "Hello World!" }
      end

      it 'calls the action for the matching path' do
        expect(router.dispatch(path)).to eq("Hello World!")
      end
    end

    context 'when dispatching to non-existent route' do
      let(:path) { '/non-existent-path' }

      before do
        router.add_route('/')
      end

      it 'calls the not found action for the non-matching path' do
        expect(router.dispatch(path)).to eq(["Resource '/non-existent-path' Not Found", "text/plain", 404])
      end
    end
  end
end
