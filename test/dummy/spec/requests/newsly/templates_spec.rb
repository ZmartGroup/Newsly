# encoding: UTF-8

require 'spec_helper'

describe "Newsly::Templates" do

  before do
    Newsly::Template.create({:name => "cc_welcome", :template_type => "Person", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
    Newsly::Template.create({:name => "cc_welcome", :template_type => "Company", :body => "Hello {{name}} is {{email}} correct?", :subject => "Welcome", :draft => false})
  end

  context "editing templates" do

    it "should be published when wanted", :js => true do
      visit '/templates'
      click_link "cc_welcome"
      within("mercury-iframe") do
        click_link "publish"
        page.should have_content("Published")
      end
    end

  end

end
