class LandingController < ApplicationController
    layout 'landing'

    def home; end

    def sign_in
      user_email = params[:email]
      if user_email.exclude? 'avispa.tech'
        return redirect_to root_path
      end
      cookies[:user_email] = user_email
      cookies[:user_name] = user_email.split('@')[0].capitalize
      redirect_to messages_path
    end
end
