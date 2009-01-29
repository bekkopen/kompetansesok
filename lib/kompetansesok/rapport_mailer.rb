
module Kompetansesok
  class RapportMailer
    
    def send_rapport(rapport)
      send_email(Udir::KOMPETANSESOK_ADMIN_EMAIL,
         "Udir kompetansesøk admin",
         Udir::RAPPORT_EMAILER,
         "Rapport fra importjoben",
         rapport)
    end

    private
    def send_email(from, from_alias, to, subject, message)
      msg = <<END_OF_MESSAGE
From: #{from_alias} <#{from}>
To: #{to}>
Subject: #{subject}

#{message}
END_OF_MESSAGE

      Net::SMTP.start(Udir::SMTP_SERVER, Udir::SMTP_PORT, nil,
                    Udir::SMTP_USERNAME, Udir::SMTP_PASSWORD, :login)  do |smtp|
        smtp.send_message msg, from, to
      end
    end
  end
end
