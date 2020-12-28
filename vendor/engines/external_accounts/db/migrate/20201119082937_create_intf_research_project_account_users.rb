class CreateIntfResearchProjectAccountUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :intf_research_project_account_users, id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8"  do |t|
      t.text :description, null: false
      t.datetime :expires_at
      t.string :account_number, limit: 50
      t.string :username, null: false, limit: 255
      t.string :user_role, null: false, limit: 50
      t.boolean :is_left_project
      t.datetime :left_project_date
      t.index ["account_number", "username"], name: "index_external_accounts_on_account_number_and_username"
    end
  end
end
