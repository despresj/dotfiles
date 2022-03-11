#!/usr/bin/env ruby
# frozen_string_literal: true

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

APP_NAMES = {
  "safari" => "Safari",
  "chrome" => "Google Chrome",
  "brave" => "Brave Browser"
}.freeze

require "cgi"

browser = ARGV[0]
app_name = APP_NAMES[browser]

exit unless File.exist?("/Applications/#{app_name}.app")

output = `osascript "#{__dir__}/#{browser}.scpt"`.chomp

exit if output == ""

title, url = output.split("---separator---")
formatted = "#{title} ~ #{url}"

puts <<~XML
  <?xml version="1.0" encoding="utf-8"?>
    <items>
      <item uid="#{browser}" arg="#{CGI.escapeHTML(formatted)}" valid="yes" autocomplete="url">
        <title>Copy URL from #{browser.capitalize}</title>
        <subtitle>#{CGI.escapeHTML(title)} ~ #{CGI.escapeHTML(url)}</subtitle>
        <icon>#{__dir__}/icons/#{browser}.png</icon>
      </item>
    </items>
XML
