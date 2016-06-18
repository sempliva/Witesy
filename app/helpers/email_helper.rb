=begin
Copyright (C) 2014  Witesy Contributors

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
module EmailHelper
  def confirm_registration_email(token_string)
    Token.transaction do
      begin
      @time_range = (Time.now - 1.day)..Time.now
      @token = Token.where(token: token_string, created_at: @time_range).first
      if @token.present?
        user = User.find(@token.user_id)
        if Token.destroy(@token.id)
          user.confirmed_email = true
          user.save
          flash[:success] = "Nicely done! Your email address is now confirmed."
        end
      else
        flash[:warning] = "Ouch! Something went wrong while confirming your email address; try again."
      end
      rescue Exception
        flash[:warning] = "Ouch! Something went wrong while confirming your email address; try again."
      end
    end
  end

  def send_email_confirmation(email, token)
    UtilityMailer.confirmation_email(email, token).deliver_now
  end
end
