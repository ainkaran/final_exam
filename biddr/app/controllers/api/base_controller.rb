class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token


# fetch(
#   'http://localhost:3000/api/v1/auctions',
#   {
#     headers: {
#       'Authorization' : '011ce894ec73ba4768769ef4a8ccd051b185b735429d21b88a5667551b251357'
#     }
#   }
# )

  # def current_user
  #   @user ||= User.find_by(api_key: api_key) unless api_key.nil?
  # end

  def current_user
    if token.present?
      # byebug
      case token_type
      when 'api_key', 'apikey'
        @user ||= User.find_by(api_key: token)
      when 'jwt'
        # byebug
        @user ||= User.find_by(id: payload[:id])
      end
    end
  end

  private
  # 'Authorization' : 'ApiKey AHJdJHDA898231jhlkAJDSLKa'
  # 'Authorization' : 'JWT    AHJdJHDA898231jhlkAJDSLKa.KAJLSDal9e9q.dJALJDAiIoqiuo_'
  def authorization_header
      request.headers['AUTHORIZATION']
  end

  def token
    authorization_header&.split(/\s+/)&.last
  end

  def token_type
    #APIKEY, apikey, ApiKey
    authorization_header&.split(/\s+/)&.first&.downcase
  end

  def decode_token(token)
    JWT.decode(token, Rails.application.secrets.secret_key_base)
  end

  def payload
    begin
      payload = HashWithIndifferentAccess.new decode_token(token)&.first

      return nil if Time.at(payload[:exp]) < Time.now
      payload
    end
  end

  def authenticate_user!
    head :unauthorized unless current_user.present?
  end
end
