begin
  require File.expand_path('../../.bundle/environment', __FILE__)

rescue LoadError
  require 'rubygems'
  if File.exist?(File.expand_path('../../Gemfile', __FILE__))
    require 'bundler'
    Bundler.setup
  end
end

