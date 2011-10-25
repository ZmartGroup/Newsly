module Newsly
  class NewslettersController < ApplicationController  

    respond_to :html, :json
    respond_to :text, :only => :preview
  

    before_filter :get_newsletter, :except => [:new, :index]
    
    def index
      @newsletters = Newsletter.order('created_at desc').all
    end

    def show
      if Resque.size(:newsletter) > 0 || Resque.size(:mail) > 0
        @queues_working = true
      end
    end

    def new
      @newsletter = Newsly::Newsletter.create(:title => "Nyhetsbrevs rubrik", :body => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.", :sent => false)
      redirect_to newsletter_url(@newsletter)
    end

    def update
      if @newsletter.update_attributes(params[:newsletter])
        render :text => "Last saved #{distance_of_time_in_words_to_now(Time.now, true)} ago"
      else
        render :text => "Kunde inte sparas"
      end
    end

    def send_test
      if Newsly::Mailer.build_newsletter(@newsletter.id, params[:to], Newsly.test_data).deliver
        render :text => "Okidoki"
      end
    end

    def deliver
      if params[:answer] == "DELIVER"
        Resque.enqueue(Newsly::NewsletterSender, @newsletter.id, params[:recipient_groups])
        @newsletter.sent = true
        @newsletter.save
        render :text => "NEWSLETTER DELIVERED"
      else
        render :text => "WARNING! Not sent, did you answer correctly?"
      end
    end

    def deliver_batch
      if params[:answer] == "BATCH"
        Resque.enqueue(Newsly::NewsletterBatchSender, @newsletter.id, params[:recipient_group], params[:batch_size])
        @newsletter.batch_sent = true
        @newsletter.save
        render :text => "BATCH DELIVERED"        
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
        @newsletter = Newsly::Newsletter.find(params[:id])
      end
  end
end