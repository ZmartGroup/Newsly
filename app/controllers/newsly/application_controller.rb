module Newsly
  class ApplicationController < ActionController::Base
  	include ActionView::Helpers::DateHelper
  	Newsly.test_receiver = "tester@domain.com"
  end
end
