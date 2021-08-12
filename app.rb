# Copyright 2015 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'sinatra'
require 'googleauth'
require 'googleauth/stores/redis_token_store'
require "googleauth/stores/file_token_store"
require "google/apis/youtube_v3"
require 'google-id-token'
require 'dotenv'
require 'pry'

CREDENTIALS_PATH = "credentials.json".freeze
TOKEN_PATH = "token.yaml".freeze
OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
SCOPE = "https://www.googleapis.com/auth/youtube.force-ssl"

configure do
  enable :cross_origin
end

def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = 'default'
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts 'Open the following URL in the browser and enter the ' \
         'resulting code after authorization:\n' + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
      user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end

get('/youtube/:video_id') do
  @video_id = params[:video_id]
  client = Google::Apis::YoutubeV3::YouTubeService.new
  client.authorization = authorize
  result = client.list_captions("id", @video_id)
  p result
  @caption_id = result.items[0].id
  
  captions_string = client.download_caption(@caption_id)
  captions_lines = captions_string.split("\n\n")
  @captions = captions_lines.map do |line| 
    line_array = line.split("\n")
    {
      start: line_array[0].split(",")[0],
      end: line_array[0].split(",")[1],
      text: line_array[1]
    }
  end
  erb :youtube
end

