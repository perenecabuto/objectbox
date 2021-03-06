# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:url]  = "http://lukazupareli.net/objectbox/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Your account has been activated!'
    @body[:url]  = "http://lukazupareli.net/objectbox/"
  end

  protected
    def setup_email(user)
      @recipients  = "#{user.email}"
      @from        = "no.reply@lukazupareli.net"
      @subject     = "[Lukazupareli] "
      @sent_on     = Time.now
      @body[:user] = user
    end
end
