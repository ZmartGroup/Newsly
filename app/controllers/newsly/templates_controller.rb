# encoding: UTF-8
module Newsly
  class TemplatesController < ApplicationController
	
  	def index
  		@templates = Newsly::Template.where(:draft => false).order('friendly_name')
      @template_types = Newsly::Template.all.map(&:template_type).uniq
  	end

  	def show
      @template = Newsly::Template.where(:parent_id => params[:id], :draft => true).first
      if @template.nil?
        @template = Newsly::Template.find(params[:id]).dup
        @template.draft = true
        @template.parent_id = params[:id]
        @template.save
      end
  	end

  	def update
      @template = Newsly::Template.find(params[:id])
      if @template.update_attributes(params[:template])
        render :text => "Last saved #{distance_of_time_in_words_to_now(Time.now, true)} ago"
      else
        render :text => "Kunde inte sparas"
      end
    end

    def send_test
      @template = Newsly::Template.find(params[:id])
      if Newsly::Mailer.build_mail(@template.id, params[:to], Newsly.test_data).deliver
        render :text => "Okidoki"
      end

    end


    def publish
      @draft = Newsly::Template.find(params[:id])
      @draft.publish
      render :text => "Published"
    end

  end
end