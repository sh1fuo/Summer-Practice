# frozen_string_literal: true

require_relative 'config/requirements'
include TextTranslation


require "cgi"
cgi = CGI.new("html3")  # add HTML generation methods
cgi.out{
  cgi.html{
    cgi.head{ "\n"+cgi.title{"This Is a Test"} } +
    cgi.body{ "\n"+
      cgi.form{"\n"+
        cgi.hr +
        cgi.h1 { "A Form: " } + "\n"+
        cgi.textarea("get_text") +"\n"+
        cgi.br +
        cgi.submit
      }
    }
  }
}

TextTranslation.available_languages
puts I18n.t('Welcome').colorize(:black).on_blue
start_menu = StartMenu.new
start_menu.call

