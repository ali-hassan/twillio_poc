require 'rubygems'
require 'twilio-ruby'

class Api::TwillioVoiceController < ApplicationController




  def voice
    require 'rubygems'
    require 'twilio-ruby'
    account_sid = "AC03a2a422c3065af15d703cc441da3a90" #ENV['TWILIO_ACCOUNT_SID']
    auth_token = "ee72889865964d7501df0eb8344e91f5" #ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    call = @client.calls.create(url: 'http://demo.twilio.com/docs/voice.xml', to: '+923212587768', from: '+13236151937')
  end

  def create_room
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    room = @client.video.rooms.create(unique_name: 'DailyStandup')

    puts room.sid
  end

  def peer_to_peer_room
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    room = @client.video.rooms.create(
        enable_turn: true,
        status_callback: 'http://example.org',
        type: 'peer-to-peer',
        unique_name: 'DailyStandup'
    )

    puts room.sid
  end

  def group_room
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    room = @client.video.rooms.create(
        record_participants_on_connect: true,
        status_callback: 'http://example.org',
        type: 'group',
        unique_name: 'DailyStandup'
    )
  end
  def small_group_room
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    room = @client.video.rooms.create(
        record_participants_on_connect: true,
        status_callback: 'http://example.org',
        start_date: Date.tomorrow,
        type: 'group-small',
        unique_name: 'DailyStandup'
    )
  end
  def retrtive_list_of_rooms
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    rooms = @client.video.rooms.list(unique_name: 'DailyStandup', limit: 20)

    rooms.each do |record|
      puts record.sid
    end
  end
  def reterive_list_of_room_by_status
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    rooms = @client.video.rooms.list(status: 'completed', limit: 20)

    rooms.each do |record|
      puts record.sid
    end
  end

  def rooms_with_status_completed
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    rooms = @client.video.rooms.list(
        status: 'completed',
        unique_name: 'DailyStandup',
        limit: 20
    )
  end
  def get_a_room_instance
    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.video.rooms('DailyStandup').fetch
  end

  def create_access_token
    ACCOUNT_SID = 'AC03a2a422c3065af15d703cc441da3a90'
    API_KEY_SID = 'SK5e7ca9d65304761226e37ff3be161b8d'
    API_KEY_SECRET = '7ScYo4w101g4Bgk8r6udGHPu7XFoPBmu'

# Create an Access Token
    token = Twilio::JWT::AccessToken.new ACCOUNT_SID, API_KEY_SID, API_KEY_SECRET,
                                         ttl: 3600,
                                         identity: 'ali-hassan'

# Grant access to Video
    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = 'cool room'
    token.add_grant grant

# Serialize the token as a JWT
    puts token.to_jwt
  end

  def create_access_token
    ACCOUNT_SID = 'AC03a2a422c3065af15d703cc441da3a90'
    API_KEY_SID = 'SK5e7ca9d65304761226e37ff3be161b8d'
    API_KEY_SECRET = '7ScYo4w101g4Bgk8r6udGHPu7XFoPBmu'

    identity = 'ali'

    video_grant = Twilio::JWT::AccessToken::VideoGrant.new
    video_grant.room = 'DailyStandup'

    token = Twilio::JWT::AccessToken.new(
        ACCOUNT_SID,
        API_KEY_SID,
        API_KEY_SECRET,
        [video_grant],
        identity: identity
    )

    puts token.to_jwt
  end
end
