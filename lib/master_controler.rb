require 'rubygems'
require 'bundler/setup'
require 'mechanize'
require_relative 'sa_scraper'
require 'pp'

a = SAScraper.new

a.login