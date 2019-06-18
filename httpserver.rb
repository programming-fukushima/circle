#!/usr/bin/env ruby

require 'optparse'
require 'webrick'
include WEBrick

# WEBrickを起動する際のオプションのデフォルト値
WebrickOptions = {
  :Port => 8000,
  :DocumentRoot => Dir::pwd,
}

OptionParser.new do |opt|
  # パース方法を設定する
  # オプションが指定されていた場合にブロックが評価される
  opt.on('-p', '--Port N', Integer) { |v| WebrickOptions[:Port] = v }
  opt.on('-d', '--DocumentRoot PATH') { |v| WebrickOptions[:DocumentRoot] = v }
  
  # 実際にパースを行う
  opt.parse!(ARGV)
end

# WEBrickを起動する
s = HTTPServer.new(WebrickOptions)
trap("INT") { s.shutdown }
s.start
