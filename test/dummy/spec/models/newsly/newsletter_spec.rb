require 'spec_helper'

describe Newsly::Newsletter do
  before :each do
    @newsletter = Newsly::Newsletter.create({:title => "Nyhetsbrev", :body => "Hello {{name}} is {{email}} correct?"})
  end

  it "parses a hash of options and renders a string" do
    @newsletter.render("name" => "Kim", "email" => "kim@email.com").should == "Hello Kim is kim@email.com correct?"
  end

  it "should be a draft until it is sent to anyone" do
    @newsletter.draft?.should ==  true
    @newsletter.status.should == "draft"
  end

  context "sent" do
    before do
      @newsletter.sent = true
      @newsletter.save
    end
    it "should not be draft when sent" do
      @newsletter.draft?.should == false
      @newsletter.status.should == "sent"
    end
  end

  context "batch_sent" do
    before do
      @newsletter.batch_sent = true
      @newsletter.save
    end
    it "should not be draft when batch_sent" do
      @newsletter.draft?.should == false
      @newsletter.status.should == "batch"
    end
  end

end
