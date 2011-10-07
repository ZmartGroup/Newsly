require 'spec_helper'

describe Newsly::Template do
  it "parses a hash of options and renders a string" do
    @template = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
    @template.render("name" => "Kim", "email" => "kim@email.com").should == "Hello Kim is kim@email.com correct?"
  end

  it "publishes a draft" do
    @parent = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
    @draft  = Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} wrong or not?", :subject => "Changed subject", :draft => true, :parent_id => @parent.id})
    @draft.publish
    @parent.reload
    @parent.subject.should == "Changed subject"
    @parent.body.should == "Hello {{name}} is {{email}} wrong or not?"
  end
end
