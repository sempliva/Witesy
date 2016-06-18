=begin
Copyright (C) 2016 Witesy Contributors

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end
module TokensHelper
  def generate_and_save_token(email, user_id)
    Token.transaction do
      token = Token.find_by(user_id: user_id)
      if token
        Token.destroy(token.id)
      end
      @token_string = Digest::SHA1.hexdigest(SecureRandom.hex(32) + email + DateTime.now.to_s + SecureRandom.hex(32))
      @token = Token.new
      @token.user_id = user_id
      @token.token = @token_string
      @token.save
      return @token_string
    end
  end
end
