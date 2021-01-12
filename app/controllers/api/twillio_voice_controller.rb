require 'rubygems'
require 'twilio-ruby'

class Api::TwillioVoiceController < ApplicationController




  def voice
    account_sid = "ACf1f3b514a9fda42909b2867a9842914f" #ENV['TWILIO_ACCOUNT_SID']
    auth_token = "f4338fff8b1b07269637622a7df36267" #ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    call = @client.calls.create(url: 'http://demo.twilio.com/docs/voice.xml', to: '+923337725039', from: '+12565405751')
  end
end
