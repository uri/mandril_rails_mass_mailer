class Patient < ActiveRecord::Base
  has_many :sent_emails, as: :sendable, class_name: "EmailLog"
  has_many :received_emails, as: :receivable, class_name: "EmailLog"
end