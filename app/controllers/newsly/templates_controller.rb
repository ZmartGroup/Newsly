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

      if Newsly::Mailer.notification(@template.name, @template.template_type, "info@baraspara.se", "kim.fransman@gmail.com", Newsly.test_data, {}).deliver
        render :text => "Okidoki"
      end
    end


  	protected
  		def get_template
  			@template = Newsly::Template.find(params[:id])
  		end

  end
end