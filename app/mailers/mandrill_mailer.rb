class MandrillMailer < ActionMailer::Base
  include MandrillHelper

  def basic email_address
    log_and_mandrill_metadata(nil, nil, {
      uri_test: "woop"
    })

    mail(to: email_address, subject: "Basic Test", from: "bot@urigorelik.com") do |format|
      format.html do
        render text: "test"
      end
    end
  end

  def broadcast
    patients = Patient.all
    log patients, "bot@urigorelik.com"

    patient_emails = patients.map(&:email)

    mail(to: patient_emails, subject: "Basic Test", from: "bot@urigorelik.com") do |format|
      format.html do
        render text: "MASS EMAIL"
      end
    end
  end
end