require 'rubygems'
require 'bundler/setup'
require 'mechanize'
require_relative 'sa_scraper'
require 'pp'

a = SAScraper.new

a.main_logic("http://forums.somethingawful.com/showthread.php?threadid=3793023")

#a.main_logic('http://forums.somethingawful.com/showthread.php?threadid=3550307&userid=0&perpage=40&pagenumber=1')