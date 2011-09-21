# encoding: UTF-8
module Newsly
  class TemplatesController < ApplicationController

    before_filter :get_template, :except => [:index]
  	
  	def index
  		@templates = Newsly::Template.all
  	end

  	def show
  	end

  	def update
      if @template.update_attributes(params[:template])
        render :text => "Sparad"
      else
        render :text => "Kunde inte sparas"
      end
    end

    def send_test
      if Newsly::Mailer.notification(
          @template.name, 
          {
            :template_type => @template.template_type,
            :from => "info@baraspara.se", 
            :to => "kim.fransman@gmail.com", 
            "name" => "Kim",
            :headers => {}
          }
        ).deliver
        render :text => "Okidoki"
      end
    end


  	protected
  		def get_template
  			@template = Newsly::Template.find(params[:id])
  		end

  end
end
