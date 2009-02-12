
module Kompetansesok
  class RapportMailer
    def self.send_rapport(rapport)
      send_email(Udir::SEND_MAIL_FRA,
        Udir::SEND_MAIL_FRA_ALIAS,
        Udir::SEND_MAIL_TIL,
        Udir::MAIL_SUBJECT,
        rapport)
    end

    private
    
    def self.send_email(from, from_alias, to, subject, message)
      msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to}
Subject: #{subject}
Date: #{Time.now}

#{message}
END_OF_MESSAGE

      Net::SMTP.start(Udir::SMTP_SERVER, Udir::SMTP_PORT, Udir::DOMAIN,
        Udir::SMTP_USERNAME, Udir::SMTP_PASSWORD, :login) do |smtp|
        smtp.send_message msg, from, to
      end

    end
  end
end
