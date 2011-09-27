module Newsly
  class NewslettersController < ApplicationController
  

    respond_to :html, :json
    respond_to :text, :only => :preview
  

    before_filter :get_newsletter, :except => [:index]
    
    def index
      @newsletters = Newsletter.all
    end

    def show
    end

    def new
      render :show
    end

    def update
      if @newsletter.update_attributes(params[:newsletter])
        render :text => "Last saved #{distance_of_time_in_words_to_now(Time.now, true)} ago"
      else
        render :text => "Kunde inte sparas"
      end
    end

    def send_test
      if Newsly::Mailer.send_newsletter(@newsletter.id, Newsly.test_receiver, Newsly.test_data).deliver
        render :text => "Okidoki"
      end
    end

    def deliver
      if params[:answer] == "DELIVER"
        #Newsly::NewsletterSender.perform(@newsletter.id, params[:recipient_groups])
        Resque.enqueue(Newsly::NewsletterSender, @newsletter.id, params[:recipient_groups])
        @newsletter.sent = true
        @newsletter.save
        render :text => "Sent"
      else
        render :text => "WARNING! Not sent, did you answer correctly?"
      end
    end

    def destroy
      @newsletter.destroy
      redirect_to newsletters_url
    end

    protected
      def get_newsletter
        @newsletter = params[:id] ? Newsly::Newsletter.find(params[:id]) : Newsly::Newsletter.create(:title => "Nyhetsbrevs rubrik", :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.", :sent => false)
      end
  end
end