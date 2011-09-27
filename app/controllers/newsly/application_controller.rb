module Newsly
  class ApplicationController < ActionController::Base
  	include ActionView::Helpers::DateHelper
  	Newsly.test_receiver = "kim.fransman@gmail.com"
  end
end
