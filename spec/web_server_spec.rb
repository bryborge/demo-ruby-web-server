# frozen_string_literal: true

require 'socket'
require 'spec_helper'

require_relative '../lib/web_server'

RSpec.describe WebServer do
  let(:server) { WebServer.new('127.0.0.1', 1337) }

  before do
    # Suppress output when running tests
    @original_stdout = $stdout
    @original_stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  after do
    # Restore output after running tests
    $stdout = @original_stdout
    $stderr = @original_stderr
    @original_stdout = nil
    @original_stderr = nil

    # Stop the server if it's running
    server.stop if server
  end

  ## Tests #####################################################################

  describe '#initialize' do
    it 'sets up a new socket' do
      expect(server.instance_variable_get(:@server)).to be_instance_of(Socket)
    end

    it 'binds the socket to the specified host and port' do
      expect(server.instance_variable_get(:@host)).to eq('127.0.0.1')
      expect(server.instance_variable_get(:@port)).to eq(1337)
    end

    it 'sets @shutdown to false' do
      expect(server.instance_variable_get(:@shutdown)).to be(false)
    end
  end

  describe '#start' do
    # Can't start the server otherwise we won't be able to stop it while tests are running
  end

  describe '#stop' do
    it 'stops the server by setting @shutdown to true and closing the socket' do
      server.stop
      expect(server.instance_variable_get(:@shutdown)).to be(true)
      expect(server.instance_variable_get(:@server).closed?).to be(true)
    end
  end
end
