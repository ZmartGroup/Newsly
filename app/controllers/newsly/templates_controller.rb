# encoding: UTF-8
module Newsly
  class TemplatesController < ApplicationController
	
  	def index
  		@templates = Newsly::Template.where(:draft => false)
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
        render :text => "Sparad"
      else
        render :text => "Kunde inte sparas"
      end
    end

    def send_test
      @template = Newsly::Template.find(params[:id])
      Newsly.test_data =  {"kund" => { 
      "namn"          =>  "Kim Fransman",
      "foretagsnamn"  =>  "Kims Firma",
      "fornamn"       =>  "Kim",
      "efternamn"     =>  "Fransman",
      "idnummer"      =>  "3",
      "epost"         =>  "kimpa@mail.se", 
      "mobil"         =>  "098765",
      "losenord"      =>  "09876ysad",
      "typ"           =>  "Person",
      "agent"         =>  {"namn" =>  "Niklas"},
      "gata"          =>  "Valthornsvägen",
      "telefon"       =>  "085999999",
      "ort"           =>  "Ösmo",
      "postnummer"    =>  "14856"},
    "el" => {
      "bindningstid"      =>  "2012-01-01",
      "forbrukning"       =>  "2000",
      "anlaggnings_id"    =>  "300",
      "omrades_id"        =>  "300",
      "nuvarand_el_lev"   =>  "God EL",
      "nuvarande_nat_lev" =>  "Nynäshamns Energie",
      "agent"             =>  {"namn" => "Niklas L"},
      "valt_avtal"        =>  "Rörligt",
      "total_pris"        =>  "200",
      "pris"              =>  "100",
      "paslag"            =>  "12",
      "moms"              =>  "25",
      "gata"              =>  "Valthornsvägen 7A",
      "ort"               =>  "Nynäshamn",
      "postnummer"        =>  "14950"}}

      Newsly.test_receiver = "kim.fransman@gmail.com"

      if Newsly::Mailer.send_mail(@template.id, Newsly.test_receiver, Newsly.test_data).deliver
        render :text => "Okidoki"
      end

    end


    def publish
      @draft = Newsly::Template.find(params[:id])
      @original = Newsly::Template.find(@draft.parent_id)
      @original.subject = @draft.subject
      @original.body = @draft.body
      @original.save
      render :text => "Published"
    end

  end
end