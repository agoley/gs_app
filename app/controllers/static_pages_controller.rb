require "net/http"
require 'net/https'
require "uri"

class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def twitter_signin
    uri = URI.parse("https://api.twitter.com/oauth/request_token")
    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.path)
  end

    def current_user
      remember_token = User.digest(cookies[:remember_token])
      @current_user ||= User.find_by(remember_token: remember_token)
    end

    def current_user?(user)
      user == current_user
    end
end
