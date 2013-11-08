class EmailLog < ActiveRecord::Base
  belongs_to :sendable, polymorphic: true  
  belongs_to :receivable, polymorphic: true  
end