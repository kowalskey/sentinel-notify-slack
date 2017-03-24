#!/usr/bin/env ruby

require 'bundler/setup'
require 'yaml'
require 'optparse'
require 'socket'
require 'slack-ruby-client'

class SentinelSlackNotifier

  # Exit codes for sentinel
  EXIT_OK = 0
  EXIT_FAIL_RETRY = 1
  EXIT_FAIL_NORETRY = 2

  def parse_opts
    OptionParser.new do |parser|
      parser.banner = 'Usage: sentinel-notify-slack-rb [options]'
      parser.on('-c','--config CONFIG_FILE',"Configuration path") {|cfg| @config_path = cfg }
    end.parse!
  end

  def initialize
    @hostname = Socket.gethostbyname(Socket.gethostname).first
  end

  def load_config
    begin
      @config = YAML.load_file(@config_path)
    rescue => e
      raise "Failed to load config: #{@config_path}"
    end
  end

  def setup_client
    Slack.configure do |config|
      config.token = @config['slack']['token']
    end
    @client = Slack::Web::Client.new
  end

  def format_msg(type,description)
      "redis-sentinel [#{@hostname}] notification (type=#{type}): #{description}"
  end

  def msg(type,description)
      @client.chat_postMessage(channel: @config['slack']['channel'],text: format_msg(type,description))
  end

  def run!
    parse_opts
    load_config
    setup_client
    msg(ARGV[0],ARGV[1])
  end

end

SentinelSlackNotifier.new.run!
