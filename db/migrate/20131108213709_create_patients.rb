class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :email
    end
  end
end
