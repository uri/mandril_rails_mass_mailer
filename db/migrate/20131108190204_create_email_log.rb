class CreateEmailLog < ActiveRecord::Migration
  def change
    create_table :email_logs do |t|
      t.string :to
      t.string :from
      t.references :sendable, polymorphic: true
      t.references :receivable, polymorphic: true
      t.string :mailer_name
      t.string :mailer_action
      t.string :delivery_state
      t.timestamps
    end
  end
end
